---
title: Create Task sheet — compose row, notes toggle, and the mislabeled third icon
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "../decisions/0004-clone-google-tasks-interactions.md", "../assets/santian-hifi-export.html", "./tasks-list-screen-interactions.md", "./hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md"]
tags: [artifact]
---

## Question
The Create Task bottom sheet exists in three drawn variants (base, +Keyboard,
+Note), but geometry alone doesn't say what opens it, what its icons do, or
what submitting does. What's the spec?

## Short answer
- FAB tap opens the sheet already risen with the title field keyboard-focused
  — the `Create Task + Keyboard` frame is the entry state, not the collapsed
  base frame.
- Two of the three `Actions Row` icons are confirmed by what's actually
  drawn: the leftmost toggles the Notes/description field open; the middle
  one opens the Date & Time Picker (its own spec, linked below).
- The **third icon is `isStarred`**, resolved 2026-09-18. Its layer is named
  `Subtask` in the mockup, but that's a leftover/copy-paste labeling
  mistake — the icon itself (`star`) is correct. Create Task has no subtask
  entry point; that stays exclusive to Task Detail.
- Submitting creates the Task with `title` as the only required field;
  everything else starts empty, per
  [the data model](../hacker/task-list-subtask-data-model.md#task).

## Detail

### Opening the sheet
Tapping the `FAB` on Tasks List should go straight to the risen,
keyboard-focused state — the `Create Task + Keyboard` frame, not
`Create Task` (which shows the sheet lower, keyboard hidden). Nothing in the
export suggests a two-step open (collapsed, then rising); Google Tasks'
real behavior, which [decision 0004](../decisions/0004-clone-google-tasks-interactions.md)
commits to, opens straight into a focused compose field. Treat the collapsed
frame as a transitional/dismissing state, not a resting one the user is
meant to see and tap again.

### The compose row
`Checkbox` (disabled-looking outline, `#e7e5e4`) + `Placeholder`
("What needs to be done?", `#57534e80`) becomes `Checkbox` (active outline,
`#0284c7`) + `Input Text` once typing starts — confirmed by comparing the
base and `+ Note` frames. The checkbox here is decorative during compose
(a new Task can't be completed before it exists); it likely just previews
the same checkbox styling the Tasks List row will use.

### Notes toggle (Actions Row icon 1)
This icon's `data-pencil-name` says `calendar Icon`, but the actual
`data-icon-name` is `align-left`, and in the `Create Task + Note` frame it's
the one with an accent-tinted background (`bg-[#0284c71a]`) — active state.
Tapping it reveals the `Notes Field` row (placeholder "Add details" with a
blinking-cursor treatment) directly below the compose row. This matches
what [the data model](../hacker/task-list-subtask-data-model.md#task)
already confirmed: `description` starts hidden, one tap reveals it. Nothing
new here — this section just ties the drawn icon to that already-confirmed
behavior.

### Date & time icon (Actions Row icon 2)
Opens the Date & Time Picker dialog — see
[its own spec](./date-time-picker-interactions.md) for the full breakdown
(month grid, Set Time, Repeat, Cancel/Done).

### Third icon — resolved: `isStarred`
**Resolved 2026-09-18**, confirmed by the owner. The third `Actions Row`
icon has `data-pencil-name="Subtask"` but renders the `star` icon (same SVG
as `Star Tab` and every other `isStarred` indicator in this export) — the
icon is correct, the layer name is a copy-paste leftover, consistent with
[the "unused theme tokens" critique](./hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)
already finding sloppiness elsewhere in this export. Tapping it toggles
`isStarred` on the Task being composed. Create Task has no subtask entry
point — that stays exclusive to `Task Detail`'s "Add subtasks" field
(`corner-down-right` icon), per
[the data model](../hacker/task-list-subtask-data-model.md#subtask).

### Submitting
Not explicitly drawn (no visible "Add" button — presumably keyboard
Enter/Done submits, matching the icon-driven, button-light feel
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md)
commits to). Creates a Task with:
- `title` — required, from the compose row.
- `listId` — the currently active List tab, per
  [Tasks List interactions](./tasks-list-screen-interactions.md) (same open
  question there about what happens if Star is active).
- everything else (`description`, `reminderAt`, `deadline`, `repeat`,
  `isStarred`, `subtasks`) — empty/null/false, set later from Task Detail.

Whether the sheet closes after one submission or stays open to quickly add
another (a common Google Tasks pattern) is not drawn either way.

## What would change my mind
Nothing left open on the third icon. If a real subtask-at-creation need
shows up later, that's a new field/flow to design, not a reinterpretation of
this icon.

## Open questions
- Whether the sheet closes or stays open after creating a Task.
- Whether an empty title on submit does nothing, or is disallowed some other
  way (disabled submit, no-op on Enter) — not drawn.

---
Part of [Santian](../README.md)
