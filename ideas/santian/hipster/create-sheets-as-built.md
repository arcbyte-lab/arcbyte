---
title: Create Task and Create List sheets, as built
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hipster/create-task-sheet-interactions.md", "../../../archive/santian/hipster/add-list-method.md", "../decisions/0017-lists-are-name-only.md"]
tags: [artifact]
---

## Question
What do the two create sheets, Create Task (from the FAB) and Create List
(from the `+` tab), do today?

## Short answer
- **Create Task:** a title field with the keyboard already up. Below it is
  an optional notes field, then three icons: notes, date/time, star.
  Enter saves it and closes the sheet. A blank title does nothing.
- **Create List:** one big name field with the keyboard already up. Enter
  saves it, closes the sheet, and selects the new tab. A blank name does
  nothing.
- Both are bottom sheets that are already open when they appear, with
  radius 28, a light dim (`#00000040`), a drag handle, and padding 28. They
  sit above the keyboard.

## Detail

Code: `lib/tasks/screens/create_task_sheet.dart`, `create_task_form.dart`,
`create_list_sheet.dart`, `create_list_form.dart`, and the matching cubits.

### Create Task
| Part | Behaviour |
|---|---|
| Title | Autofocused. Hint "What needs to be done?" at 16 px. Sentence case. The keyboard's Done key submits. |
| Notes | Hidden until the notes icon is tapped. Then it shows below the title, takes focus, and has hint "Add details" at 14 px. Multi-line. |
| Notes icon | Toggles the notes field. Hiding it **discards** what was typed. Only visible notes are saved. |
| Date/time icon | Opens the [reminder picker](./date-pickers-and-repeat-as-built.md). A Repeat can be set inside it. The icon turns `primary` once a reminder is set. |
| Star icon | Toggles star. Shows `star` in `primary` when on. |

Icons are 24 px, 16 px apart, `mutedForeground` when off and `primary` when
on. The compose circle the mockup drew was removed (`90a7d98`).

- **Submit:** only Done on the keyboard. There is no Save button. A blank
  title is a no-op, and the keyboard stays open with no error. On success
  the sheet closes, and one sheet can never create two Tasks.
- **Cannot be set here:** deadline and subtasks. Those are in
  [Task Detail](./task-detail-as-built.md).
- **Dismiss:** drag down or tap the dim. Everything typed is lost, with no
  confirmation.
- **Target List:** see the FAB rule in
  [Tasks List](./tasks-list-screen-as-built.md#fab).

### Create List
- One field: hint "List name", DM Sans bold 22 px, word case, autofocused.
- Done on the keyboard creates the List, closes the sheet, and makes the
  new tab active. A blank name is a no-op.
- No icon picker and no color picker
  ([decision 0017](../decisions/0017-lists-are-name-only.md)).
- Duplicate names are allowed.

## What would change my mind
- Missing a visible Save button in real use, for example by tapping away
  and losing a typed Task.

## Open questions
- Dismissing Create Task drops what was typed without asking. Should it
  keep a draft? Check what Google Tasks does before changing it.

---
Part of [Santian](../README.md)
