---
title: Task Detail — Star, List Selector, Title, Description, and Mark Completed
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "../decisions/0004-clone-google-tasks-interactions.md", "../assets/santian-hifi-export.html", "./tasks-list-screen-interactions.md", "./task-detail-more-menu-and-delete.md", "./create-task-sheet-interactions.md"]
tags: [artifact]
---

## Question
Task Detail's `Top Bar`, `List Selector`, `Title Wrap`, `Description Field`,
and `Mark Completed` pill are all fully drawn — but static. What happens
when each is touched?

## Short answer
- **Star** (Top Bar) toggles `isStarred` — same action as Create Task's now-
  resolved third icon, just reachable from Detail too.
- **List Selector** (dot + name + chevron) changes `listId` — the exact
  picker UI isn't drawn; recommendation below, not a ruling.
- **Title** and **Description** are both tap-to-edit inline text — but the
  `+ Keyboard` frame is identical to the non-keyboard frame for both, so
  which one the keyboard belongs to in that drawn state is genuinely
  ambiguous, not just unspecified.
- **Mark Completed** is Task Detail's *only* completion control — there's no
  checkbox inside the sheet. It's the same action as the Tasks List row's
  checkbox, reached from a different screen.

## Detail

### Star
`Top Bar`'s `Right Icons` are `Star` then `More` (`More` already spec'd in
[Task Detail's More menu and delete](./task-detail-more-menu-and-delete.md)).
`Star` toggles `Task.isStarred` — the same field
[Create Task's third icon](./create-task-sheet-interactions.md) now sets at
creation time. No new behavior; this is that field's second entry point.
Whether the icon fills solid when `isStarred: true` (vs. an outline when
false) isn't drawn — every screen shows the same outline `star` glyph,
never a filled variant — so that visual state is undecided, same category as
the completed-task visual already flagged in
[Tasks List interactions](./tasks-list-screen-interactions.md).

### List Selector
`List Dot` (color swatch) + `List Name` + `Dropdown` (`chevron-down`) sits
just below the Top Bar. Tapping it should let the user reassign the Task to
a different List (`listId`), but no picker UI is drawn anywhere in the
export — the chevron only signals "this opens something."

**Recommendation, not a ruling:** reuse the `List Tab Bar` itself as the
picker — a small dropdown or inline list showing the same
icon+name(+count) rows already used on Tasks List, since that's the only
"pick a list" UI vocabulary this app has, per
[the add-list spec](./add-list-method.md) reusing existing patterns rather
than inventing new ones. A full-screen picker or a bottom sheet are both
plausible alternatives; nothing here rules them out.

### Title
`Title Wrap` → `Task Title` (24px, bold DM Sans) sits directly under the
List Selector. It's presumably a tap-to-edit inline text field (this is a
Task that already exists — the equivalent of Create Task's compose row,
just pre-filled). Not confirmed: the `Task Detail + Keyboard` frame's
`Title Wrap` content is byte-for-byte identical to the non-keyboard frame
(same text, no cursor, no focus outline) — so nothing in the export actually
shows title-editing in progress. This spec assumes tap-to-edit because
there's no other drawn way to change a Task's title, not because it's shown
happening.

### Description
`Description Field` (`menu`-icon — note: a different icon than Create
Task's `align-left` toggle for the same concept, another small mockup
inconsistency worth being aware of, not worth fixing here) shows the full
description text once set. Same situation as Title: presumably tap-to-edit,
but the `+ Keyboard` frame doesn't visually distinguish "editing the
description" from "editing the title" from "not editing anything" — all
three frames show identical field content. **Which field the keyboard in
that frame belongs to is not determinable from the export.** Treat both
Title-edit and Description-edit as tap-to-edit by inference, not as
confirmed behavior.

### Mark Completed
The `Mark Completed` pill (`180×48`, accent fill, bottom-center) is the
**only** completion control inside Task Detail — there is no `Checkbox`
element anywhere in the `Detail Sheet`. Tapping it does the same thing as
tapping a Task's checkbox on Tasks List (per
[Tasks List interactions](./tasks-list-screen-interactions.md)): toggles
`isCompleted` for a non-repeating Task, or advances to the next occurrence
for a repeating one. What the pill looks like or says once a Task *is*
completed (still "Mark completed"? does it become "Completed" / "Mark
incomplete"?) is undrawn — every screen shows an incomplete Task, same gap
as the checkbox's undrawn checked state.

## What would change my mind
Building the List Selector as a reused tab-bar dropdown and finding it
awkward at this sheet's width (`396px` content area is narrower than the
full-screen Tasks List) — that's the signal to design a dedicated picker
instead of reusing the tab bar as-is.

## Open questions
- List Selector's actual picker UI — recommended above (reuse the tab bar
  row), not settled.
- Whether Star shows a filled vs. outline state when `isStarred: true`.
- Title-edit and Description-edit behavior (save on blur? explicit
  done button? multi-line for description?) — assumed tap-to-edit, nothing
  beyond that is drawn or decided.
- Mark Completed's completed-state appearance — same open gap as the
  Tasks List checkbox's checked state.

---
Part of [Santian](../README.md)
