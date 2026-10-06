---
title: Task Detail, as built — top bar, List selector, fields, subtasks, Mark completed, delete
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hipster/task-detail-identity-and-fields.md", "../../../archive/santian/hipster/task-detail-more-menu-and-delete.md", "../../../archive/santian/hipster/task-detail-subtasks.md", "../../../archive/santian/hipster/deadline-badge-and-overdue-styling.md"]
tags: [artifact]
---

## Question
What does Task Detail show, and how does each field edit and save today?

## Short answer
- It is a modal bottom sheet with a dark dim (`#00000080`). From top to
  bottom: Back, Star, `⋮`. Then the List selector, the title, the
  description, the deadline, the reminder, the subtasks, and the Mark
  completed pill.
- Every edit saves straight away. There is no Save button. Text fields save
  when they lose focus, and a blank title or subtask edit is dropped.
- Delete is in `⋮`. There is no confirmation, but a "Task deleted / Undo"
  snackbar appears after the sheet closes.

## Detail

Code: `lib/tasks/screens/task_detail_sheet.dart`, `task_detail_view.dart`,
`cubits/task_detail_cubit.dart`. It opens from a row tap or a notification
tap.

### Layout, top to bottom
Horizontal padding is 28 (24 on the top bar). The whole sheet scrolls as
one piece and lifts above the keyboard.

1. **Top bar:** Back (←, closes) on the left. On the right, Star (toggles,
   `primary` when on) and `⋮` with a single item, **Delete**.
2. **List selector:** the List's name in `primary` (14 px, weight 500) with
   a ⌄. Tapping it opens a sheet listing every List by name, with the
   current one highlighted. Picking one moves the Task. No color dot
   ([0017](../decisions/0017-lists-are-name-only.md)).
3. **Title:** DM Sans bold 24 px, multi-line, edited in place.
4. **Description:** a ☰ icon, then a multi-line field with hint "Add
   description" (15 px).
5. **Deadline:** a 📅 icon, then "Add deadline" in muted text until one is
   set. Once set it becomes a chip on a neutral `muted` background showing
   "Wed 30 Sept" (no time), with an ✕. Tapping the chip text opens the
   [deadline picker](./date-pickers-and-repeat-as-built.md#deadline-picker).
   The ✕ clears it. When overdue, the icon and the chip text turn `error`.
6. **Reminder:** a 🕘 icon, then "Add reminder" until one is set. Once set
   it becomes a chip on a light `primary` tint (10%) showing "Today · 9:00
   AM" or "Wed 30 Sept · 9:00 AM", with an ✕. Tapping it opens the
   [reminder picker](./date-pickers-and-repeat-as-built.md#reminder-picker).
   The ✕ clears the reminder **and its repeat**.
7. **Subtasks:** see below.
8. **Mark completed pill:** 180×48, fully rounded. Open Task: `primary`
   fill with "Mark completed". Completed: `muted` fill with "Mark
   incomplete". It does the same thing as the row checkbox.

Repeat has no row of its own. It is set and seen only inside the reminder
picker.

### Saving
| Field | Saves when | Rule |
|---|---|---|
| Title | it loses focus | trimmed. A blank result is ignored and the old title stays |
| Description | it loses focus | trimmed. Blank saves as "no description" |
| Star, List, deadline, reminder, completion | straight away | — |

### Subtasks
- **Input:** a ☑ icon, then an always-editable field. The hint is "Add
  subtasks" until the first one exists, then "Add subtask". Enter adds the
  subtask to the bottom, clears the field, and keeps focus there for the
  next one. Blank is ignored.
- **Each subtask row:** a 16 px circle checkbox, then a title you edit in
  place (saves when it loses focus, blank ignored), then ✕ to delete (no
  undo), then a drag handle. Completed: the title is muted **and struck
  through**. Task rows are not struck through.
- **Reorder:** drag the handle. The new order is saved straight away.
- **Independent:** finishing every subtask does not complete the Task, and
  completing the Task does not touch its subtasks.
- Subtasks are not shown on the Tasks List row.

### Delete
`⋮` → Delete removes the Task straight away and closes the sheet. A
snackbar "Task deleted" with **Undo** appears on the Tasks List. Undo puts
the Task back exactly as it was, same id and same notifications. When the
snackbar times out, the delete is final.

### Known defect
Tapping **Mark completed** on a *repeating* Task here leaves the sheet
showing "Mark incomplete" and the old dates. The stored Task has really
moved to its next date. Another tap, or any later edit in the same sheet,
can move it forward twice or write the old dates back. The row checkbox
does not have this problem. See
[behaviour rules](../hacker/tasks-behaviour-rules-as-built.md#known-defects).

## What would change my mind
- Losing edits because a field never lost focus, for example when the sheet
  is dragged closed while typing.

## Open questions
- After Mark completed, should the sheet close? Santian keeps it open.
  Check what Google Tasks does before changing it.
- Should the deadline sit below the reminder? Santian puts it above.

---
Part of [Santian](../README.md)
