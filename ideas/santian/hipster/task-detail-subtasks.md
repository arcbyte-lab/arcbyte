---
title: Task Detail's Subtask Field — add, reorder, and independent completion
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "../assets/santian-hifi-export.html", "./task-detail-identity-and-fields.md"]
tags: [artifact]
---

## Question
Every `Subtask Field` instance across all 8 exported screens is the same
empty state — `corner-down-right` icon + "Add subtasks" text. Nothing shows
what happens once a Subtask actually exists. What's the spec, given the
fields are already settled but the screen behavior isn't?

## Short answer
- Tapping the empty `Subtask Field` adds one new Subtask row, inline,
  keyboard-focused — same "tap the affordance, get a focused input"
  pattern as everything else in this app. Not drawn, but consistent with
  the rest of the interaction model.
- Once one Subtask exists, a persistent "Add subtask" row stays at the
  bottom of the list — the entry point doesn't disappear after first use.
- Each Subtask row gets a checkbox, its title, a small inline delete icon,
  and a drag handle for
  [its confirmed `order` field](../hacker/task-list-subtask-data-model.md#subtask)
  — **none of this is drawn anywhere**, so the row's visual shape below is
  a proposal, not a reconstruction. Delete is resolved (inline icon, not
  swipe or a menu); the rest is recommended, not confirmed.

## Detail

### Why this needs a proposal, not just a spec
Unlike every other note in this batch, there's no partial drawing to anchor
to — the mockup's `Subtask Field` is exclusively the empty "Add subtasks"
affordance, four times, never populated. [The data model
note](../hacker/task-list-subtask-data-model.md#subtask) already confirmed
the *fields* directly from the owner (title, isCompleted, order, independent
completion) — this note is about the screen behavior around those fields,
which has no drawn precedent at all.

### Adding the first Subtask
Tapping the empty `Subtask Field` ("Add subtasks", `corner-down-right`
icon) should turn it into a focused text input in place — same "tap,
keyboard opens, type" pattern as the Create Task compose row and (per [Task
Detail's identity spec](./task-detail-identity-and-fields.md)) Title and
Description. Pressing Enter/Done creates the Subtask and, per Google Tasks'
own behavior (which
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md)
commits this app to), immediately opens a new empty input below it — so
adding several subtasks in a row doesn't require re-tapping "Add subtasks"
each time.

### Once Subtasks exist
Proposed row shape, using only components this app already has elsewhere,
plus one resolved decision:
- A small `Checkbox` — smaller than the Tasks List row's `21×21` (recommend
  `16×16`, since subtasks render indented and lighter-weight) — toggles that
  Subtask's own `isCompleted`, independent of the parent Task in both
  directions, exactly as
  [the data model](../hacker/task-list-subtask-data-model.md#subtask)
  confirmed. Same dim-on-complete treatment as
  [the now-resolved Task checkbox visual](./tasks-list-screen-interactions.md),
  reused rather than invented fresh.
- The Subtask's `title`, plain-indented under the parent rather than
  repeating the `corner-down-right` icon on every row — once a checkbox and
  a delete icon (below) both sit on the row too, a third icon per row reads
  as clutter; the indent alone already signals "belongs to the Task above."
- **Delete: resolved 2026-09-18**, confirmed by the owner — a small inline
  delete icon (`x`, matching the `Remove` icon already used on the
  reminder's `Date Chip`) on each Subtask row, not swipe and not a menu.
  Deliberately different from
  [Task's More-menu delete](./task-detail-more-menu-and-delete.md): Subtasks
  are lightweight and low-stakes, so a visible, always-reachable icon fits
  better than the Task's extra tap-through, which exists specifically to
  guard against a *heavier* deletion.
- Title is tap-to-edit after creation, matching the resolved
  [Title/Description behavior](./task-detail-identity-and-fields.md):
  save on blur, no separate confirm step.
- Below the last Subtask, the "Add subtask" row persists (singular, once at
  least one exists — "Add subtasks" only shows in the fully-empty state),
  same tap-to-focus behavior as the first one.
- **Reordering:** a drag handle (`grip-vertical`-style icon) on each row,
  press-and-drag to reorder, writing the new `order` values on drop. Not
  confirmed by the owner — reasoned default, since `order` is explicitly
  manual per the data model and a visible handle is the most discoverable
  way to signal "this is draggable" without relying on an undiscoverable
  long-press gesture.

## What would change my mind
The owner opening the actual Penpot file and finding subtask rows drawn
somewhere this review missed — in which case this note's proposal gets
replaced with a reconstruction, the same way every other spec in this batch
was built from real geometry instead of a guess. Separately, if the
`16×16` checkbox or the plain-indent (vs. icon-per-row) reads as too subtle
next to the delete icon and drag handle once built, that's the signal to
revisit row density.

## Open questions
- Drag handle's exact icon/interaction — reasoned default above, not
  confirmed.
- Checkbox size (`16×16` proposed) — not confirmed.

---
Part of [Santian](../README.md)
