---
title: Task Detail's More menu and delete
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./tasks-list-screen-interactions.md", "../assets/santian-hifi-export.html", "../decisions/0004-clone-google-tasks-interactions.md"]
tags: [artifact]
---

## Question
[Tasks List screen interactions](./tasks-list-screen-interactions.md) left
delete as a fully open question — no swipe, long-press, or trash icon is
drawn anywhere. Asked directly, the owner ruled out all three: delete lives
behind the `more-vertical` icon (labelled `More` in the export) already
drawn in Task Detail's `Top Bar`, next to `Star`. What does tapping it
actually do?

## Short answer
- **Delete only lives in Task Detail**, behind `More` — never on the Tasks
  List row itself. Confirmed by the owner (2026-09-18, in conversation):
  slower to reach on purpose, so it can't be triggered by an accidental
  swipe or long-press.
- `More` opens a small anchored menu at the icon (native overflow-menu
  pattern), not a bottom sheet — a one-item menu doesn't need the real
  estate a sheet is for. **Delete** is the only item; nothing else is
  designed to live there yet.
- Selecting Delete removes the Task immediately and shows an undo toast —
  **no confirm dialog, yes undo toast**, both confirmed by the owner
  (2026-09-18, in conversation). The two aren't redundant: skipping confirm
  keeps the intentional path frictionless (More → Delete is already the
  accident-guard); undo protects the rare genuine mis-tap after the fact.

## Detail

### What's already drawn
Task Detail's `Top Bar` (`arrow-left` Back, then `Right Icons`: `Star`,
`More`) already includes the `more-vertical` icon in both light and dark,
keyboard-hidden and keyboard-visible frames. Its tap behaviour was simply
never specified — this note fills that in, it doesn't add a new element.

### The menu
Recommend a small anchored dropdown/overflow menu opening from the `More`
icon's position — the standard native pattern that icon already signals
(three vertical dots = overflow menu, on both Android and iOS). Reject a
bottom sheet for this: sheets in this app (`Create Task`, `Task Detail`
itself) are reserved for contexts that need real vertical space — a
one-item menu doesn't, and using a sheet for it would make sheets mean two
different things (compose/detail vs. a menu).

Right now the menu has exactly one item: **Delete**. No other action is
designed or requested. If a second action is added later (duplicate,
share, move to list), it joins this same menu rather than getting its own
icon — that's the point of putting it behind `More` instead of a second
top-bar icon.

### Deleting
Tapping **Delete**:
1. Immediately removes the Task (and its Subtasks, per
   [the data model](../hacker/task-list-subtask-data-model.md#subtask) —
   a Subtask belongs to exactly one Task, so it has nowhere to exist once
   its parent is gone). No confirm dialog — per
   [decision 0003](../decisions/0003-personal-tool-not-a-product.md), this
   is a single-user tool, and the More → Delete tap-through (open Task
   Detail → tap More → tap Delete) is already the accident-guard a confirm
   dialog would otherwise exist for.
2. Closes the `Task Detail` sheet and returns to the Tasks List, with the
   row gone.
3. Shows an undo toast — confirmed 2026-09-18. Not redundant with skipping
   the confirm dialog: it protects against a genuine mis-tap after the fact
   instead of adding friction to the intentional path before it. Tapping
   **Undo** restores the Task and its Subtasks exactly as they were.
   Letting the toast expire (or dismissing it) makes the delete final.
   Exact duration isn't specified here — a few seconds, standard toast
   length, is a reasonable default, not a hard requirement of this note.

## What would change my mind
If the owner deletes a Task by accident even once and the undo toast has
already expired or been missed, that's the signal this flow needs either a
longer toast, a confirm dialog after all, or both.

## Open questions
- Exact undo-toast duration — left as an implementation default, not
  specified precisely here.
- What else eventually joins the `More` menu, if anything.

---
Part of [Santian](../README.md)
