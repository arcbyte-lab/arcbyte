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
inputs: ["../hacker/task-list-subtask-data-model.md", "../decisions/0004-clone-google-tasks-interactions.md", "../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "../assets/santian-hifi-export.html", "./create-task-sheet-interactions.md"]
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
- "Set time" and "Repeat" are both entry rows only — neither shows what
  happens after tapping them. Not invented here.

## Detail

### Date: month grid
Matches [decision 0004](../decisions/0004-clone-google-tasks-interactions.md)'s
committed "month-grid date picker" pattern exactly: `Month Nav`
(chevron-left/right around a `Month Label`), a `Weekday Header` (M–S), and a
`Calendar Grid` of `Day Cell`s, one marked `Selected Day`. Tapping a cell
selects that date — single date only, no drawn range-selection UI. Worth
flagging: [the data model note](../hacker/task-list-subtask-data-model.md)
found one Tasks List row ("Deep work: API migration") showing a time
**range** ("11:00 AM – 1:00 PM") where every other row shows a point in
time — that open question isn't resolved by anything drawn in this picker
either; this dialog only supports picking one date.

### Set Time
`Set Time Row` (clock icon + "Set time" label). Tapping it isn't drawn
anywhere — no time-picker UI exists in this export, native or custom. Two
things aren't decided: what UI actually appears (a native time picker is
the natural assumption per
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md)'s
"native-feeling" direction, but that's an assumption, not a drawn fact), and
whether the "Set time" label updates to show the chosen time (e.g. "7:00
AM") once set — the export only shows the untouched default state.

### Repeat
`Repeat Row` (repeat icon + "Repeat" label). Same situation as Set Time:
tapping it presumably opens the Repeat configuration
([frequency/interval/unit/weekdays](../hacker/task-list-subtask-data-model.md#task)),
but **no Repeat dialog UI is drawn anywhere in the export** — only this
entry row exists. This is the least-specified part of the whole picker.

### Cancel / Done
`Button Row`: **Cancel** (`#57534e`, muted) discards date/time/repeat
selections made in this dialog session and returns to wherever it was
opened from, unchanged. **Done** (`#0284c7`, accent) commits: sets
`reminderAt` from the picked date + time, and `repeat` if configured. Not
decided: whether Done requires a time to be set, or a date-only selection is
a valid `reminderAt` (every drawn Tasks List row has a time, none show a
bare date).

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
- Set Time's actual UI (native system picker vs. something custom) — not
  drawn, applies to the `reminderAt` picker only now that `deadline` is
  calendar-only.
- Whether "Set time" updates to reflect a chosen time.
- The Repeat dialog's UI — entirely undrawn beyond its entry row.
- Whether Done requires both date and time, or date alone is valid, for the
  `reminderAt` picker.
- The one time-range Tasks List row ("11:00 AM – 1:00 PM") — this picker
  offers no way to select a range; cross-references
  [the data model's open question](../hacker/task-list-subtask-data-model.md)
  on the same point.

---
Part of [Santian](../README.md)
