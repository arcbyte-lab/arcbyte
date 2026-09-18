---
title: Date & time picker — month grid, Set Time, Repeat, Cancel/Done
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "../decisions/0004-clone-google-tasks-interactions.md", "../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "../assets/santian-hifi-export.html", "./create-task-sheet-interactions.md", "./repeat-dialog-interactions.md"]
tags: [artifact]
---

## Question
The `HiFi — Date Time Picker` frame draws a month-grid calendar, a "Set
time" row, and a "Repeat" row under one Cancel/Done dialog. What's the
interaction, and does it also cover `deadline`, or only `reminderAt`?

## Short answer
- One dialog does three things at once: pick a date (month grid), open
  time-setting from a "Set time" row, and open repeat-setting from a
  "Repeat" row. **Cancel** discards everything; **Done** commits date, time,
  and repeat together.
- This is confirmed as the dialog behind Create Task's clock icon. Task
  Detail's `Deadline Field` gets its own **calendar-only variant** —
  resolved 2026-09-18, confirmed by the owner: no `Set Time` row, no
  `Repeat` row.
- "Set time" opens the native system time picker (recommended). "Repeat"
  opens [its own resolved dialog](./repeat-dialog-interactions.md), built
  from a real reference the owner supplied.
- A date-only `reminderAt` is valid (recommended default time, not forced).
  The one time-range Tasks List row was a mockup slip, resolved.

## Detail

### Date: month grid
Matches [decision 0004](../decisions/0004-clone-google-tasks-interactions.md)'s
committed "month-grid date picker" pattern exactly: `Month Nav`
(chevron-left/right around a `Month Label`), a `Weekday Header` (M–S), and a
`Calendar Grid` of `Day Cell`s, one marked `Selected Day`. Tapping a cell
selects that date — single date only, no range-selection UI, which is
correct: [the data model note](../hacker/task-list-subtask-data-model.md)
flagged one Tasks List row ("Deep work: API migration") showing a time
**range** ("11:00 AM – 1:00 PM") where every other row shows a point in
time, but the owner confirmed 2026-09-18 that row was a mockup slip, not
real scope — `reminderAt` stays a single point in time. That row gets
rebuilt with a single time once the screen is implemented.

### Set Time
`Set Time Row` (clock icon + "Set time" label). Tapping it isn't drawn
anywhere — no time-picker UI exists in this export, native or custom.
**Recommendation, not a ruling:** open the platform's native time picker
(iOS wheel / Android Material dial), per
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md)'s
"native-feeling" direction — cheapest to build, matches what users already
know, no new component to design. Once set, the `Set Time Label` updates
from "Set time" to the chosen time (e.g. "7:00 AM") — this part isn't
really a design choice, an unlabeled "Set time" row after a time's already
been picked would just be a bug, so treat it as settled rather than open.

### Repeat
`Repeat Row` (repeat icon + "Repeat" label). **Resolved 2026-09-18** — see
[the Repeat dialog spec](./repeat-dialog-interactions.md), built from a real
reference screenshot the owner supplied (Google's own Repeat dialog):
"Every [N] [unit]" stepper+dropdown, weekday chips when unit is week, no
Starts/Set Time/Ends rows (all redundant with this outer picker or already
ruled out by the data model's no-end-condition decision).

### Cancel / Done
`Button Row`: **Cancel** (`#57534e`, muted) discards date/time/repeat
selections made in this dialog session and returns to wherever it was
opened from, unchanged. **Done** (`#0284c7`, accent) commits: sets
`reminderAt` from the picked date + time, and `repeat` if configured.
**Recommendation, not a ruling:** a date-only selection (Set Time never
tapped) is a valid `reminderAt` — defaults to a fixed time of day (e.g.
9:00 AM) rather than blocking Done or forcing the picker to require a time.
Every drawn Tasks List row happens to show a time, but nothing about the
data model requires one, and forcing a time on every reminder adds friction
for a task that's really just "sometime that day."

### `deadline`'s picker: calendar-only, resolved
Only one `Date Time Picker` frame exists in the whole export — there's no
second, deadline-specific picker drawn, so this variant isn't drawn either;
it's a new, smaller dialog to build, not a redraw of the existing one.
**Resolved 2026-09-18**, confirmed by the owner: Task Detail's `Deadline
Field` (per
[the deadline badge spec](./deadline-badge-and-overdue-styling.md)) opens a
**calendar-only** dialog — `Month Nav`, `Weekday Header`, `Calendar Grid`,
`Button Row` (Cancel/Done), with no `Set Time` row and no `Repeat` row.
Reasoning confirmed: `repeat` is a single whole-Task field already set once
from the `reminderAt` picker, so a second `Repeat` entry point on the
deadline picker would let the user try to set it twice from two places for
one Task; and `deadline` per
[decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md)
is a target date, not a time-of-day commitment the way `reminderAt`'s
"7:00 AM" is, so it doesn't need `Set Time` either. `deadline` therefore
stores a date only, no time component.

## What would change my mind
If the owner later wants `deadline` to carry a specific time of day (e.g.
"due by 5 PM," not just "due Sep 20"), that's the signal to revisit the
calendar-only decision and add `Set Time` back — a real product need
outgrowing this call, not a mistake in it.

## Open questions
- The default time used when `reminderAt` is set date-only (proposed 9:00
  AM above, not confirmed by the owner).

---
Part of [Santian](../README.md)
