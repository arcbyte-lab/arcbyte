---
title: Tasks behaviour rules, as built — order, grouping, overdue, completion, repeat, delete
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["./tasks-data-model-as-built.md", "./repeat-advance-algorithm.md", "../hipster/tasks-list-screen-as-built.md", "../hipster/task-row-as-built.md", "../hipster/task-detail-as-built.md"]
tags: [artifact]
---

## Question
Which rules does the app follow, independent of any screen? Written so
another codebase (Tasko) can reproduce them.

## Short answer
- **Order:** by `reminderAt` ascending, no reminder last, ties by id.
  Completion does not change a Task's position. Completed Tasks get their
  own section instead.
- **Completing a repeating Task** moves `reminderAt` (and `deadline`)
  forward by one step and leaves it open. It never stays checked. There is
  no catch-up.
- **Deleting a Task** has undo. Deleting a List or its completed Tasks asks
  for confirmation and has no undo. The last List can never be deleted.

## Detail

Code is in `lib/tasks/`. Each rule names the file it lives in.

### Ordering (`task_order.dart`)
1. Tasks with a `reminderAt` come first, earliest first.
2. Then Tasks with no `reminderAt`.
3. Ties are broken by `id`, which is creation order.

The same order is used on every tab. `isCompleted` is ignored when
sorting. This replaced the older "completed last" rule in `3d0f44c`.

### Grouping (`tasks_list_view.dart`, `dayHeaderLabel`)
On a List tab only. Open Tasks are split into runs that share a header
label, worked out from `reminderAt` against today's date:

| calendar days from today | label |
|---|---|
| no reminder | No date |
| &lt; 0 | Past |
| 0 | Today |
| 1 | Tomorrow |
| ≥ 2 | short date, e.g. "Wed 30 Sept" |

Completed Tasks go to one "Completed (N)" group below everything else. The
Star tab is not grouped.

### Date text (`month_grid.dart`)
- **Short date:** "Wed 30 Sept" in the current year. Otherwise "Fri, 1 Jan
  2027". September is the only month cut to 4 letters ("Sept").
- **Relative day:** Today / Yesterday / Tomorrow / "N days ago" / "in N
  days". From 7 days on: "N weeks M days". Counted on calendar dates, so a
  daylight-saving change cannot shift it.
- **Reminder chip:** "Today · 9:00 AM", or "&lt;short date&gt; · &lt;time&gt;".
- **Time:** the platform's 12 h or 24 h format.

### Overdue (`deadline_status.dart`)
`overdue = !isCompleted && date != null && day(date) < day(now)`.

- Compared on **calendar days**, so a deadline of today is not overdue.
- Used for both the deadline and the reminder on the row. Task Detail uses
  it for the deadline chip only.
- Never stored. It is worked out on each draw, so completing the Task or
  clearing the date removes the red at once.

### Completing a Task
All entry points (the row checkbox, Mark completed) call
`TaskRepository.toggleCompleted`, which works on the **stored** record.

| Task | Action | Result |
|---|---|---|
| no repeat | complete | `isCompleted = true`, notifications cancelled |
| no repeat | un-complete | `isCompleted = false`, notifications rescheduled |
| repeating | complete | `reminderAt = next(reminderAt)`, and `deadline = next(deadline)` if set. `isCompleted` stays false. Notifications are rescheduled to the new dates. |

`next()` is [the repeat-advance algorithm](./repeat-advance-algorithm.md),
applied to each date separately. As built, it uses calendar arithmetic
(`DateTime(y, m, d + n, …)`), not `Duration`, so the time of day survives
daylight-saving changes. The note's sketch used `Duration`. Month and year
steps clamp to the last day of the month (Jan 31 + 1 month = Feb 28/29).
**No catch-up:** a date three weeks overdue moves forward by exactly one
step.

### Editing
- Title, List name, and Subtask title are trimmed. A blank result is
  ignored on edit and blocks submit on create.
- Description is trimmed. Blank is stored as null.
- Create Task notes are saved only while the notes field is showing.
- Clearing `reminderAt` also clears `repeat`.
- A Task's List can be changed from Task Detail.

### Deleting
| What | Confirm | Undo | Effect |
|---|---|---|---|
| One Task | no | yes, snackbar | Hard delete. Subtasks go with it. Both notifications cancelled. Undo writes the copy back with the same id and reschedules. |
| One Subtask | no | no | Removed from the Task. |
| A List | yes, dialog | no | Its Tasks are deleted first, then the List. The first List becomes active. Disabled when only one List exists. |
| A List's completed Tasks | yes, dialog | no | Every `isCompleted` Task in that List is deleted. Disabled when there are none. |

### Lists
- **First launch:** when no List exists, one called "My Tasks" is created
  ([0014](../decisions/0014-first-launch-default-list.md), draft, but
  already built). Debug builds instead seed three sample Lists.
- There is always at least one List.
- **Create target:** the active List. On Star, the last List that was
  active, or the first List.
- Starring is a flag, not a List. "Starred" is a filtered view across every
  List.

### Known defects
- **Completing a repeating Task from Task Detail.** `TaskDetailCubit`
  flips `isCompleted` locally after the repository has advanced the dates.
  The sheet then shows stale state, and the next edit or tap writes it
  back, which can move the Task forward twice or restore the old dates.
  Logged as a separate fix for the Santian repo, not fixed here.

## What would change my mind
- Tasko needs server-side ordering or due-date grouping. Then these rules
  are a starting point, not something to copy one-to-one.

## Open questions
- Group by `deadline` when a Task has no `reminderAt`? Today such a Task
  goes under "No date".

---
Part of [Santian](../README.md)
