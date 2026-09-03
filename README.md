# player-one
The interactive screen for an unstaffed Lightdash booth at Big Data LDN, 23–24 September 2026.
Play it: https://theferreres-sys.github.io/player-one/
A visitor steps into a small black cabinet, the curtain closes, and two questions later
the screen has drawn their company as a grid of dots — with only the licensed few lit up.
It then shows what letting everyone in would cost on the BI tool they actually named,
using that vendor’s own published UK list price.
The booth has nobody standing in it. That is the argument, not a constraint.
# Running it
One self-contained HTML file. No build step, no dependencies, no backend, no tracking.
The fonts are embedded, so it runs correctly with no network at all — which matters on a
trade-show floor.
On the booth machine: open index.html in a browser and press F11 for full screen.
The page locks itself to a 1600×900 stage and scales to fit, so it letterboxes rather
than reflows. What you see on a laptop is what the booth screen shows.
# Controls
|Input            |Does                                 |
|-----------------|-------------------------------------|
|`1` `2` `3` `4`  |The arcade buttons. Also clickable.  |
|`Backspace` / `←`|Back — retraces the actual path taken|
|`Esc` / `R`      |Restart, without counting as a player|
On the physical console, three buttons cover the questions and the tool question needs a
fourth. Back would want a fifth — cheaper to specify now than to retrofit.

# Idle reset
Each screen returns to the attract loop after a period with no input, with a twelve-second
on-screen warning first. Any keypress, click, mouse move or keystroke in the email field
cancels it. Timings live in the IDLE block near the bottom of index.html, one line per
screen, in seconds — sized to reading time, and worth retuning after watching real people
use it.
A timeout ends at GAME OVER rather than jumping to attract, so the argument still lands for
whoever is watching, and the next person walks into a clean screen.
# What it does not do
The email field is a prop. Nothing is sent, stored or transmitted anywhere — there is no
backend and no database. On the stand the capture is an NFC badge reader; the on-screen
field is the fallback for anyone without a scannable badge, and wiring it up is a separate
job.
The player counter only increments on a completed run. Abandoned runs don’t inflate it,
because that number appears on the fascia outside and is reported as a success measure.
# Prices on screen
Every figure is a published list price, in GBP, checked 3 September 2026.
|Input            |Does                                 |
|-----------------|-------------------------------------|
|`1` `2` `3` `4`  |The arcade buttons. Also clickable.  |
|`Backspace` / `←`|Back — retraces the actual path taken|
|`Esc` / `R`      |Restart, without counting as a player|

Microsoft’s rule is quoted verbatim on screen: “On F SKUs smaller than F64, each user
viewing Power BI content must have Pro, PPU, or an individual trial.”

Nothing is modelled and nothing is “up to”. If any of these change, they change in the
TOOLS object in index.html, along with the source line shown underneath the table.

Pol Ferreres · September 2026
