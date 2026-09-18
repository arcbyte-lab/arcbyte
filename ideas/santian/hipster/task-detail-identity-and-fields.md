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
- **List Selector** (dot + name + chevron) changes `listId`. Resolved: opens
  its **own dedicated bottom sheet**, not a reuse of the tab bar.
- **Title** and **Description** are both tap-to-edit inline text, saved on
  blur — but the `+ Keyboard` frame is identical to the non-keyboard frame
  for both, so which one the keyboard belongs to in that drawn state is
  genuinely ambiguous, not just unspecified.
- **Mark Completed** is Task Detail's *only* completion control — there's no
  checkbox inside the sheet. It's the same action as the Tasks List row's
  checkbox (now resolved: dims and demotes on Tasks List; here, becomes a
  muted "Mark incomplete" pill), reached from a different screen.

## Detail

### Star
`Top Bar`'s `Right Icons` are `Star` then `More` (`More` already spec'd in
[Task Detail's More menu and delete](./task-detail-more-menu-and-delete.md)).
`Star` toggles `Task.isStarred` — the same field
[Create Task's third icon](./create-task-sheet-interactions.md) now sets at
creation time. No new behavior; this is that field's second entry point.
**Recommendation, not a ruling:** fill the star solid (`#0284c7`) when
`isStarred: true`, keep the outline glyph already drawn when `false` — the
standard filled/outline pairing for a toggle like this, and consistent with
solid-accent fills already used elsewhere (`FAB`, `Mark Completed`). Not
confirmed by the owner.

### List Selector
`List Dot` (color swatch) + `List Name` + `Dropdown` (`chevron-down`) sits
just below the Top Bar. **Resolved 2026-09-18**, confirmed by the owner:
tapping it opens a **dedicated bottom sheet** — its own sheet, same shape as
Create Task's, listing every List to reassign `listId` to. Not a reuse of
the `List Tab Bar` row; this is a new sheet instance of the pattern.

### Title
`Title Wrap` → `Task Title` (24px, bold DM Sans) sits directly under the
List Selector. **Resolved 2026-09-18**, confirmed by the owner: tap-to-edit
inline text, saved on blur (tapping away from the field commits the change,
no separate save button). Not confirmed: the `Task Detail + Keyboard`
frame's `Title Wrap` content is byte-for-byte identical to the non-keyboard
frame (same text, no cursor, no focus outline) — nothing in the export
actually shows title-editing in progress, this is the owner's stated
behavior, not a reconstruction of a drawn state.

### Description
`Description Field` (`menu`-icon — note: a different icon than Create
Task's `align-left` toggle for the same concept, another small mockup
inconsistency worth being aware of, not worth fixing here) shows the full
description text once set. Same resolved behavior as Title: tap-to-edit,
save on blur — plus multi-line, since description is meant to hold more
than a single line of text (unlike Title). The `+ Keyboard` frame still
doesn't visually distinguish "editing the description" from "editing the
title" from "not editing anything" — all three frames show identical field
content — but that ambiguity no longer matters for the *behavior*, since
both fields now resolve to the same tap-to-edit/save-on-blur pattern.

### Mark Completed
The `Mark Completed` pill (`180×48`, accent fill, bottom-center) is the
**only** completion control inside Task Detail — there is no `Checkbox`
element anywhere in the `Detail Sheet`. Tapping it does the same thing as
tapping a Task's checkbox on Tasks List (per
[Tasks List interactions](./tasks-list-screen-interactions.md)): toggles
`isCompleted` for a non-repeating Task, or advances to the next occurrence
for a repeating one. Now that the checkbox's completed visual is resolved
(dim + move to bottom), **recommendation for this pill, not a ruling:**
once completed, it switches from accent-filled "Mark completed" to a muted
outline/secondary style reading "Mark incomplete" — same shape, inverted
emphasis, still tappable to undo. Not confirmed by the owner.

## What would change my mind
If the List Selector sheet feels heavyweight for what's usually a two- or
three-list choice, that's the signal to reconsider a lighter inline
dropdown instead — but that's a build-time judgment call now, not an open
spec question.

## Open questions
- Star's filled/outline toggle state — recommended above, not confirmed.
- Mark Completed's completed-state appearance — recommended above ("Mark
  incomplete", muted), not confirmed.

---
Part of [Santian](../README.md)
