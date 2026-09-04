# Player One — Big Data LDN booth

An unstaffed booth for Lightdash. One person goes in at a time, answers two
questions on three arcade buttons, and walks out knowing how many of their own
colleagues can open a dashboard — and what letting the rest in would cost on the
tool they already pay for.

Live: https://theferreres-sys.github.io/player-one/

## What is in here

| File | What it is |
|---|---|
| `index.html` | The booth screen. One page, no build step, no dependencies. Runs full screen in a browser in kiosk mode on the in-booth display. |
| `capture.html` | The page that opens on the visitor's phone when they tap or scan at the end of the run. Pre-filled with the numbers they just gave. |
| `video.html` | The concept film, in a player that matches the booth. |
| `supabase.sql` | The database schema, already applied. Here so it can be read and re-created. |

## How the screen and the phone stay in sync

There is only ever one person in the booth, so a run does not need a session
code. The booth opens a row marked `live`; the phone asks the database which run
is live and writes the visitor's details onto that row; the booth is polling its
own row and sees it flip to `captured`. No pairing, no QR that has to carry
state, nothing for a visitor to type.

Both pages talk to Supabase as the anonymous role. That key is public by design —
what protects the data is row-level security plus **column** grants: the browser
can write a name, email and job title, and can never read one back. Leads are
read in the Supabase table editor. See `supabase.sql`.

## Running it in the booth

Open `index.html` full screen in any modern browser. It locks itself to 16:9 and
scales to whatever display it is on, so the same page works on a phone, a laptop
and the booth screen.

- The number keys stand in for the arcade buttons, one per answer on screen.
- **Backspace** or **←** goes back a screen, **Esc** or **R** restarts.
- A run resets itself after a period of inactivity that varies by screen, so a
  visitor who walks off mid-run does not leave their answers up for the next one.

## Configuration

Everything tunable sits at the top of the script in `index.html`:

- `CFG` — the Supabase URL, the publishable key, and the table name.
- `AVG` — the share of staff a company licenses. Currently **25%**, from BARC's
  2022 study of 214 companies, which is the most recent properly attributed
  figure available. Change this one number and every band, every dot grid and
  every price on the screen follows.
- `SIZES` — the headcount bands and how many seats each is assumed to hold.
- `IDLE` — seconds of inactivity allowed on each screen before the run resets.

Prices are UK list, checked 3 September 2026.

## Adding the film

Drop `player-one.mp4` (and optionally `video-poster.jpg`) into the repository
root. `video.html` picks it up with no other change; until then it says the film
is not uploaded yet rather than showing a broken player.
