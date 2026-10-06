---
title: Reminder picker, deadline picker, and Repeat dialog, as built
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hipster/date-time-picker-interactions.md", "../../../archive/santian/hipster/repeat-dialog-interactions.md", "../assets/repeat-dialog-ui-reference.jpeg"]
tags: [artifact]
---

## Question
What do the three date dialogs do today: the reminder picker, the deadline
picker, and the Repeat dialog?

## Short answer
- **Reminder picker:** a month grid, then "Set time" (opens the system time
  picker), then "Repeat" (opens the Repeat dialog), then Cancel/Done. If no
  time is picked, it uses 9:00 AM.
- **Deadline picker:** the same month grid with Cancel/Done only. Date
  only, no time, no repeat.
- **Repeat dialog:** "Every [−N+] [day|week|month|year]". Weekday chips
  appear for weeks. There is no start date and no end condition.

## Detail

Code: `lib/tasks/widgets/date_time_picker_dialog.dart`,
`deadline_picker_dialog.dart`, `repeat_dialog.dart`, `month_grid.dart`,
`picker_button_row.dart`.

All three are centered dialogs with radius 24 on `surface`.

### Month grid (shared)
- The header is ‹ "September 2026" ›, DM Sans semibold 16. The arrows move
  one month.
- Weekday letters start on Monday: M T W T F S S.
- Day cells are 34 px circles. The selected day is filled `primary`. There
  is no special mark for today.
- It opens on the current value's month, or this month if there is none.
  The selected day defaults to the current value, or today.
- There are no limits: past dates can be picked.

### Reminder picker
Used by Create Task and Task Detail.

1. The month grid.
2. **Set time** row (🕘): shows "Set time" until a time is picked, then
   "9:30 AM". Tapping it opens the platform's own time picker, starting at
   the current time value or 9:00.
3. **Repeat** row (↻): "Repeat" until one is set, then a summary such as
   "Every 2 weeks". The summary leaves weekdays out. An ✕ next to it clears
   the repeat.
4. **Cancel / Done.** Cancel throws away every change made in the dialog.
   Done returns date + time, with 9:00 AM if no time was picked, plus the
   repeat.

The dialog scrolls, because it can open while the keyboard is still
closing.

### Deadline picker
Used by Task Detail only. The month grid, then Cancel / Done. It returns a
date with no time. It has no Repeat row. A repeating Task's deadline moves
with the same rule as the reminder (see
[behaviour rules](../hacker/tasks-behaviour-rules-as-built.md#completing-a-task)).

### Repeat dialog
Built from [the owner's reference screenshot](../assets/repeat-dialog-ui-reference.jpeg).

- **Header:** ← Back (throws away this dialog's changes), the title
  "Repeat", and **Done** in `primary`.
- **Every row:** "Every", then a stepper − N + (minimum 1, − is greyed out
  at 1), then a unit dropdown: day / week / month / year. The unit label
  becomes plural when N > 1.
- **Weekday chips:** only when the unit is week. Seven 32 px circles,
  M T W T F S S, each toggled on its own. Selected chips are filled
  `primary`. None selected means "same weekday as the reminder".
- **No "off" state inside it.** Done always returns a repeat. Clearing is
  the ✕ in the reminder picker.
- New repeats start at "Every 1 day".
- There are no Starts or Ends rows. The start is the reminder's date, and a
  repeat never ends.

## What would change my mind
- Needing an end date, or "repeat after completion" rather than on a fixed
  schedule, in real use.

## Open questions
- Monthly repeats always use the reminder's day of the month. There is no
  "every 2nd Tuesday" option. Is that enough?

---
Part of [Santian](../README.md)
