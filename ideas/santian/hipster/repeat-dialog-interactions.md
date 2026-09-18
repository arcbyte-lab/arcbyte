---
title: Repeat dialog — Every N unit, weekday chips, no Starts/Ends
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: weak
created: 2026-09-18
updated: 2026-09-18
inputs: ["./date-time-picker-interactions.md", "../hacker/task-list-subtask-data-model.md", "../assets/repeat-dialog-ui-reference.jpeg"]
tags: [artifact]
---

## Question
[The date/time picker spec](./date-time-picker-interactions.md) found the
`Repeat` row had no dialog drawn behind it anywhere in the export, and
flagged its own proposal as too large to fully resolve inline. The owner
supplied a real reference screenshot — Google's own Repeat dialog (dark
mode: Back / "Repeats" / Done, "Every [N] week", weekday chips, "Set time",
"Starts", "Ends": Never/On/After). What does Santian's version look like,
built from it but checked against what's already locked in?

## Short answer
- Reuses most of the reference directly: top bar (Back / title / Done),
  the **"Every [N] [unit]"** stepper+dropdown, and the **weekday chips**
  (multi-select, shown only when unit is week).
- **Two rows from the reference are dropped, not copied blindly:**
  - **"Starts"** — redundant. The start date is whatever was already picked
    in the outer Date & Time Picker's calendar before the user ever tapped
    "Repeat."
  - **"Set time"** — also redundant, for the same reason: `reminderAt`'s
    time is already set (or defaulted) in the outer picker, and every
    future occurrence inherits that same time-of-day. A second time field
    here would let the user set two different times with no clear rule for
    which wins.
  - The entire **"Ends" section** (Never / On / After) is dropped —
    [the data model](../hacker/task-list-subtask-data-model.md#task)
    already confirmed Repeat has **no end condition**; a Task repeats
    indefinitely until the user turns Repeat off. Copying this section from
    the reference would directly contradict an already-adopted decision.
- The reference is evidence of *shape* (how Google lays out a working
  repeat picker), not a spec to trace exactly — Santian's version is
  smaller because Santian's data model is smaller.

## Detail

### Kept from the reference
- **Top bar:** Back arrow, title (singular **"Repeat,"** not "Repeats" —
  matches this app's existing singular field naming, e.g. `Task`, not
  `Tasks`, in the data model), and a **Done** button in the same accent
  color already used for "Done" in the outer Date & Time Picker's
  `Button Row` — visual consistency between the two dialogs in one flow.
- **"Every [N] [unit]":** numeric stepper/input for `interval`, dropdown for
  `unit` (day / week / month / year). Maps directly onto
  [the confirmed fields](../hacker/task-list-subtask-data-model.md#task).
- **Weekday chips:** row of 7 circular toggles (M T W T F S S),
  **multi-select** — the reference shows only one selected ("F"), but
  Santian's `weekdays` field is explicitly a *set*, so the UI needs to
  support picking several (e.g. Monday **and** Thursday). Shown only when
  `unit` is `week`; hidden for day/month/year, since `weekdays` only
  applies to weekly-shaped repeats per the data model.

### Dropped from the reference
- **"Starts"** — not needed. Whatever date the user picked in the outer
  calendar (per
  [the date/time picker spec](./date-time-picker-interactions.md)) is the
  start; asking again inside Repeat would be asking the same question
  twice.
- **"Set time"** — not needed, same reasoning. `reminderAt` already carries
  a time (or the recommended 9:00 AM default from the date-only case); every
  repeated occurrence uses that same time-of-day. Not addressed anywhere
  before now — this is a real judgment call resolving a gap the reference
  exposed, not a copy of it.
- **"Ends" (Never/On/After):** dropped entirely — already decided, not
  re-litigated here. See
  [the data model](../hacker/task-list-subtask-data-model.md#task):
  "No end condition (`endDate` / `endCount`). Repeats indefinitely until the
  user turns Repeat off on the Task."

### Field mapping: `frequency`, `interval`, `unit`
Not shown in the reference — this is how "Every [N] [unit]" plus the
weekday chips resolve into
[the four Repeat fields](../hacker/task-list-subtask-data-model.md#task):
- `N = 1` → `frequency` is `daily` / `weekly` / `monthly` / `yearly`,
  matching whichever `unit` is selected. `interval` and `unit` stay
  unset (implied by `frequency`, per the data model: "1 otherwise").
- `N ≠ 1` → `frequency: custom`, with `interval: N` and `unit` set
  explicitly to whatever was picked.
- `weekdays` is only ever populated when `unit` is `week` — whether via
  plain `weekly` (`N = 1`) or `custom, unit: weeks` (`N ≠ 1`).

### Month / year: not shown in the reference either
The screenshot only shows `unit: week` selected, so it doesn't show what a
month or year repeat looks like beyond the dropdown itself (real Google
Calendar typically adds something like "on day 18" or "on the third
Friday" for monthly repeats). **Recommendation, not a ruling:** add no
extra UI for month/year — repeat implicitly on the same day-of-month (or
day-of-year) as the Task's `reminderAt` date. Simplest option, consistent
with this dialog already being smaller than the reference by design; a
day-of-month/ordinal-weekday picker can be added later if the owner finds
the implicit behavior insufficient.

## What would change my mind
If dropping "Set time" turns out to be wrong in practice — e.g. the owner
wants a repeating Task's time to be editable independently of the
non-repeating case's `reminderAt` — that's the signal to add it back as its
own field, not a sign this reasoning was careless; it was a real call, not
an oversight.

## Open questions
- Month/year repeat's exact day-selection behavior — recommended above
  (implicit, same day-of-month/year as `reminderAt`), not confirmed.

---
Part of [Santian](../README.md)
