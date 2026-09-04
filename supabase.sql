-- Player One — booth capture
-- Already applied to the project; kept here so the schema is reviewable
-- and reproducible. Run once in Supabase → SQL Editor → New query.

create table if not exists public.booth_sessions (
  id          uuid primary key default gen_random_uuid(),
  player_no   int,
  headcount   int,
  seats       int,
  tool        text,
  status      text not null default 'live',   -- live | captured | abandoned | done
  name        text,
  email       text,
  role        text,
  created_at  timestamptz not null default now(),
  captured_at timestamptz
);

create index if not exists booth_sessions_live_idx
  on public.booth_sessions (status, created_at desc);

alter table public.booth_sessions enable row level security;

-- The booth screen and the visitor's phone both talk to Supabase as the
-- anonymous role. Two things protect the data: policies decide which ROWS
-- that role may touch, column grants decide which COLUMNS it may see.

-- 1. The booth may open a run.
create policy "anon can open a session"
  on public.booth_sessions for insert to anon
  with check (status = 'live');

-- 2. Reads are open at the row level and closed at the column level.
--    The booth has to keep watching its own row after the phone flips it
--    to 'captured', so the row cannot disappear at that moment. What is
--    readable is the run's shape, never anyone's contact details.
create policy "anon can read a run, minus the contact details"
  on public.booth_sessions for select to anon
  using (true);

-- 3. A row may only be edited while it is still live, and the write that
--    ends the run is allowed. (Without the WITH CHECK, Postgres reuses the
--    USING clause and the phone can never mark the run captured.)
create policy "anon can write only the live session"
  on public.booth_sessions for update to anon
  using (status = 'live')
  with check (status in ('live','captured','abandoned','done'));

-- Column grants. anon can read six harmless columns and write eight.
-- name, email and role are writable once, then frozen by policy 3, and
-- are not readable from a browser at all — not even by the person who
-- typed them. Leads are read in the Supabase table editor.
revoke all on public.booth_sessions from anon;
grant insert on public.booth_sessions to anon;
grant select (id, player_no, headcount, seats, status, created_at)
  on public.booth_sessions to anon;
grant update (headcount, seats, tool, status, name, email, role, captured_at)
  on public.booth_sessions to anon;

-- Your leads:
--   select created_at, player_no, headcount, seats, tool, name, email, role
--   from public.booth_sessions where status = 'captured' order by created_at desc;
