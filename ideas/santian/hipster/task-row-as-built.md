---
title: Task row, as built — checkbox, wrapping title, description, date line, star
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hipster/tasks-list-screen-interactions.md", "../../../archive/santian/hipster/deadline-badge-and-overdue-styling.md", "./tasks-list-screen-as-built.md"]
tags: [artifact]
---

## Question
What does one Task row on the Tasks List look like, and what does tapping
each part of it do?

## Short answer
- The row has a circle checkbox, then the title (wraps), up to 2 lines of
  description, and one date line. A star sits on the right.
- The date line puts the reminder and the deadline side by side, with
  relative labels: "Yesterday, 9:00 AM", "Due in 3 days". Each one turns
  `error` once its day has passed.
- There are three tap zones. The left edge completes the Task, the right
  edge stars it, and anywhere else opens Task Detail.

## Detail

Code: `lib/tasks/widgets/task_row.dart`, `widgets/month_grid.dart`
(`relativeDayLabel`, `formatShortDate`), `deadline_status.dart`.

### Anatomy
Padding is 24 horizontal and 14 vertical. Content sits at the top, so a
long title grows the row downward and the checkbox stays next to its first
line.

| Part | Look |
|---|---|
| Checkbox | 21 px circle. Open: 1.5 px `outline` ring. Done: `primary` fill with a white ✓. |
| Title | 15 px, `onSurface`, or `mutedForeground` when completed. Wraps, never cut off. No strikethrough. |
| Description | 12 px, `mutedForeground`, at most 2 lines with an ellipsis. Hidden when blank. |
| Date line | 12 px with 14 px icons. Hidden when the Task has neither a reminder nor a deadline. |
| Star | 20 px. `star` filled in `primary`, or `star_border` in `mutedForeground`. |

### Date line
- **Reminder:** a clock icon, then "&lt;relative day&gt;, &lt;time&gt;". For
  example "Today, 9:00 AM" or "2 days ago, 6:30 PM".
- **Deadline:** a calendar icon, then "Due &lt;relative day&gt;". For example
  "Due today", "Due tomorrow" or "Due in 1 week 2 days".
- They sit on one line, 12 px apart, and wrap only if the row is too
  narrow.
- **Relative day:** Today / Yesterday / Tomorrow. Otherwise "N days ago" or
  "in N days". From 7 days on it counts in weeks plus days: "1 week 1 day
  ago". Weeks are the largest unit, so a year away reads "52 weeks …". Days
  are counted on calendar dates, not 24 h spans.
- **Overdue color:** a part turns `error` (icon and text) when its date's
  calendar day is before today and the Task is not completed. A deadline of
  today is **not** overdue. Reminders follow the same rule as deadlines.
  The color is computed each time it is drawn, never stored.

### Tap zones
- **Checkbox zone:** from the left edge to where the title starts (59 px),
  over the full row height. It toggles completion. For a repeating Task
  this moves it to the next date instead (see
  [behaviour rules](../hacker/tasks-behaviour-rules-as-built.md#completing-a-task)).
- **Star zone:** from where the title ends to the right edge (58 px), over
  the full row height. It toggles `isStarred` straight away, with no sheet.
- **Everything else:** opens [Task Detail](./task-detail-as-built.md).
- **Screen reader:** the checkbox is the row's labelled control ("&lt;title&gt;,
  checkbox, checked"), and the star is a separate toggle button ("Star
  &lt;title&gt;").

### Not on the row
- No swipe to complete or delete. Delete lives only in Task Detail.
- No subtask count, no repeat icon, no List name on Star rows.

## What would change my mind
- Long titles that wrap make the list hard to scan in real use. Google
  Tasks wraps too, so this is a guess, not a known problem.

## Open questions
- Should a repeating Task's row show that it repeats? Today nothing on the
  row says so.
- Should a Star row show which List the Task belongs to? Today it does not.

---
Part of [Santian](../README.md)
