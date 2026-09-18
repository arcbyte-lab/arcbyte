---
title: Task, List and Subtask fields, read off the hi-fi mockup
idea: santian
lens: hacker
kind: data-model
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../assets/santian-hifi-export.html", "../decisions/0004-clone-google-tasks-interactions.md"]
tags: [artifact, data-model]
---

## Question
What fields does a Task, a List, and a Subtask actually need, based on what the
hi-fi export already draws across its 8 screens?

## Short answer
- The mockup implies three entities: **List**, **Task**, **Subtask** — plus a
  **Starred** view that is a filter over Task, not its own entity.
- Two things don't match a plain Google Tasks clone: a Task appears to carry
  **two separate date concepts** (Deadline and a removable DateTime chip), and
  one task row shows a **time range** where every other row shows a single
  point in time.
- Subtasks are drawn only as an empty "Add subtasks" entry point. No screen
  shows a populated subtask, so their shape (fields, nesting, completion
  rules) is inferred from one icon, not observed.

## Detail

### List
Read from the `List Tab Bar` (appears on every screen) and the `List Selector`
in Task Detail:

- `id`
- `name` — e.g. "Personal Interest", "My Tasks", "Building"
- `icon` — one lucide icon per list (rocket, footprints, hammer)
- `color` — an accent color per list; shown as the `List Dot` next to the name
  in Task Detail and as the tab's active-state color
- `taskCount` — shown as a `Count Badge`; almost certainly derived (count of
  non-completed Tasks in that list), not stored

No "add list" affordance appears anywhere in the 8 screens. The three lists
above may be a fixed starter set or the mockup just never drew list creation.

**Starred** is a fourth tab, always first, with its own icon (star) and no
count badge. Its own screen ("HiFi — Starred") groups tasks under a "Starred
recently" header with no per-list grouping shown. Everything about it points
to a filtered view over `Task.isStarred`, not a real list — but check: it also
never shows how a Starred task is dated, so hold that not confirmed.

### Task
Read from `Tasks List` rows and the `Task Detail` sheet:

- `id`
- `listId` — which List it belongs to (shown via `List Selector` in Detail)
- `title`
- `description` / `notes` — see open question below, might be one field wearing
  two names
- `scheduledAt` — the removable `Date Chip` ("Wed, Sep 17 · 7:00 AM"), shown in
  the list row as `Task Time`. Optional: "Morning workout" has one, nothing in
  the mockup shows a task with no time set.
- `deadline` — a **separate** field, its own row below Description, currently
  empty ("Add deadline") on every screen shown. Google Tasks itself has no such
  field — see open question.
- `repeat` — a single row, opens something not included in this export
- `isStarred` — boolean, drives the Starred tab
- `isCompleted` — boolean, the round checkbox
- `subtasks` — see below

### Subtask
Every one of the four `Subtask Field` instances in this export is the same
empty state: a `corner-down-right` icon and the text "Add subtasks". None is
populated. What can be read directly:

- Subtasks belong to exactly one Task (`taskId`)
- The icon implies they render indented under the parent

Everything else — `title`, whether they have their own `isCompleted`, ordering,
whether completing all subtasks affects the parent — is not drawn anywhere and
would be invented, not read off this file.

## What would change my mind
A hi-fi screen (or a real screenshot from the owner's actual Google Tasks
usage) showing a populated subtask row, or the owner answering the Deadline
vs. DateTime question directly.

## Open questions
- **Description vs. Notes.** Task Detail's `Description Field` shows body text
  ("30 min cardio + stretching routine"); the separate "Create Task + Note"
  screen has its own `Notes Field`. Same field shown two ways, or two real
  fields? This changes whether Task has one text column or two.
- **Deadline vs. DateTime — is this scope creep past decision 0004?**
  [Decision 0004](../decisions/0004-clone-google-tasks-interactions.md) commits
  to Google Tasks' interaction model, and real Google Tasks has one date
  field. This mockup draws two: an always-empty "Add deadline" row and a
  populated, removable date/time chip. Either this is a deliberate addition
  the owner wants, or it's an artifact of an unedited pasted design (the same
  hipster critique already raised about the theme tokens) and Task should
  only have one date field.
- **The one time-range row.** "Deep work: API migration" shows
  "11:00 AM – 1:00 PM" where every other task shows a single time. If
  `scheduledAt` can hold an end time, Task already has an interval sometimes —
  which bears directly on
  [Is the Clockface or the list the source of truth?](./clockface-or-list-source-of-truth.md).
  That question assumed the Task model was point-only; this mockup says
  otherwise in at least one row. Worth checking with the owner whether that
  row is meaningful or a mockup slip.
- **Is the three-list set fixed or user-creatable?** No creation flow is
  drawn.
- **Repeat's actual shape.** Not drawn beyond the single row.
- **Subtask fields.** Entirely inferred, not observed — see above.

---
Part of [Santian](../README.md)
