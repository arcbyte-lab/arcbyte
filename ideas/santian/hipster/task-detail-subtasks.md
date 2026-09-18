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
- Each Subtask needs its own checkbox and drag handle for
  [its confirmed `order` field](../hacker/task-list-subtask-data-model.md#subtask)
  — **none of this is drawn anywhere**, so the row's visual shape below is
  a proposal, not a reconstruction.

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
Proposed row shape, using only components this app already has elsewhere:
- A small `Checkbox` (same circular style as the Tasks List row's, likely
  smaller given subtasks render indented and lighter-weight in every real
  Google Tasks-style app) — toggles that Subtask's own `isCompleted`,
  independent of the parent Task in both directions, exactly as
  [the data model](../hacker/task-list-subtask-data-model.md#subtask)
  confirmed.
- The Subtask's `title`, indented under the parent (the `corner-down-right`
  icon already signals "belongs to the thing above it" — reasonable to keep
  using it, or a plain indent once several rows stack, since repeating the
  icon on every row may be visually heavier than necessary. Not decided.
- Below the last Subtask, the "Add subtask" row persists (not "Add
  subtasks" plural — becomes singular once at least one exists), same tap-
  to-focus behavior as the first one.

Reordering (`order` is explicitly manual/drag per the data model, not
insertion order) needs some drag affordance — a drag handle, or long-press-
and-drag on the row itself. Neither is drawn or decided here.

### What this note does not invent
- The checkbox's exact size/style for a Subtask row.
- Whether editing a Subtask's title after creation is tap-to-edit (matching
  Title/Description) or requires a separate action (e.g. swipe, long-press
  menu — though [delete already ruled out swipe/long-press](./task-detail-more-menu-and-delete.md)
  for Tasks, so a Subtask following that same precedent is more likely than
  not, but not confirmed).
- Whether a Subtask can be deleted, and if so, how (mirroring
  [Task's More-menu delete](./task-detail-more-menu-and-delete.md), or
  something lighter given Subtasks are meant to be lightweight per the data
  model).
- Drag-to-reorder's actual mechanics.

## What would change my mind
The owner opening the actual Penpot file and finding subtask rows drawn
somewhere this review missed — in which case this note's proposal gets
replaced with a reconstruction, the same way every other spec in this batch
was built from real geometry instead of a guess.

## Open questions
- Subtask row's exact visual shape (checkbox size, indent vs. icon-per-row).
- Whether Subtask title is tap-to-edit after creation.
- Whether a Subtask can be deleted, and how.
- Drag-to-reorder's actual interaction (handle vs. long-press-drag).

---
Part of [Santian](../README.md)
