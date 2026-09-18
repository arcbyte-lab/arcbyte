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
- Subtasks are drawn only as an empty "Add subtasks" entry point in the
  mockup, but the owner confirmed their shape directly: `title` +
  `isCompleted`, manually reorderable, completion independent of the parent
  in both directions.

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

No "add list" affordance appears anywhere in the 8 screens, but the owner
confirmed (2026-09-18, in conversation) that lists are user-creatable: the
`List Tab Bar` scrolls horizontally, and a trailing action button at the end
of the scroll creates a new list. Not drawn in the current mockup — see
[the add-list method](../hipster/add-list-method.md) for the design of that
affordance.

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
- `description` — one field. Confirmed by the owner (2026-09-18, in
  conversation): on the "Create Task + Note" screen, the title and
  description are two separate text columns, but the second (description)
  column is hidden until the user taps the description icon — Create Task
  opens with only the title column shown. Task Detail's `Description Field`
  is the same field, just always visible once a task exists. `notes` was not
  a second field, just the other name this note used for the same thing.
- `reminderAt` — the removable `Date Chip` ("Wed, Sep 17 · 7:00 AM"), shown in
  the list row as `Task Time`. Confirmed by the owner (2026-09-18, in
  conversation): this is a reminder, not just a display time — the app fires a
  notification for the task at this datetime. Renamed from `scheduledAt` to
  say what it does. Optional: "Morning workout" has one, nothing in the
  mockup shows a task with no time set.
- `deadline` — a **separate** field, its own row below Description, currently
  empty ("Add deadline") on every screen shown. Behaviour confirmed by the
  owner (2026-09-18, in conversation) — see
  [decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md):
  shown on the Tasks List row alongside `reminderAt` (`Task Time`), fires its
  own notification independent of `reminderAt`'s, and drives overdue styling
  when `isCompleted: false` and now is past `deadline`.
- `repeat` — nullable. When set, matches real Google Tasks' Repeat dialog per
  [decision 0004](../decisions/0004-clone-google-tasks-interactions.md),
  confirmed by the owner (2026-09-18, in conversation):
  - `frequency` — `daily` | `weekly` | `monthly` | `yearly` | `custom`
  - `interval` — int, N for "every N days/weeks/months/years" (custom only;
    1 otherwise)
  - `unit` — `days` | `weeks` | `months` | `years`, custom only
  - `weekdays` — set of weekdays, used when `frequency: weekly` or
    `frequency: custom, unit: weeks`
  - No end condition (`endDate` / `endCount`). Repeats indefinitely until the
    user turns Repeat off on the Task.

  Completion mechanics: one Task row per repeating series, not a new Task
  generated per occurrence. Checking it off advances `reminderAt`/`deadline`
  to the next occurrence per the repeat rule and resets `isCompleted` back
  to `false` — so for a repeating Task, `isCompleted` is a transient "this
  occurrence is done" signal, not a durable completed state.
- `isStarred` — boolean, drives the Starred tab
- `isCompleted` — boolean, the round checkbox
- `subtasks` — see below

### Subtask
Every one of the four `Subtask Field` instances in this export is the same
empty state: a `corner-down-right` icon and the text "Add subtasks". None is
populated in the mockup. Fields confirmed by the owner (2026-09-18, in
conversation), matching real Google Tasks behaviour per
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md):

- `id`
- `taskId` — belongs to exactly one Task, renders indented under it
- `title`
- `isCompleted` — its own boolean, independent of the parent. Completing all
  subtasks does **not** auto-complete the parent Task, and completing the
  parent does **not** auto-complete its subtasks.
- `order` — manually reorderable (drag), so this is an explicit position
  field, not implicit insertion order.

Deliberately minimal: no `description`, no `reminderAt` of its own. Subtasks
are lightweight, same as real Google Tasks.

## What would change my mind
Nothing left open on Task, List, or Subtask right now — see Open questions
for what's still genuinely unresolved (none of it blocks the schema).

## Open questions
- **Description vs. Notes.** Resolved 2026-09-18 — one field, `description`.
  Create Task starts as a single title column; tapping the description icon
  reveals a second column for it. Task Detail always shows both because the
  task already exists.
- **Deadline vs. DateTime.** Resolved 2026-09-18: two real, different fields.
  `reminderAt` is a notification trigger; `deadline` is a target date with
  its own notification, its own list-row display, and overdue styling. This
  is genuine scope past Google Tasks parity, not a mockup artifact — see
  [decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md).
- **The one time-range row.** "Deep work: API migration" shows
  "11:00 AM – 1:00 PM" where every other task shows a single time. If
  `reminderAt` can hold an end time, Task already has an interval sometimes —
  which bears directly on
  [Is the Clockface or the list the source of truth?](./clockface-or-list-source-of-truth.md).
  That question assumed the Task model was point-only; this mockup says
  otherwise in at least one row. Worth checking with the owner whether that
  row is meaningful or a mockup slip.
- **Is the three-list set fixed or user-creatable?** Resolved 2026-09-18 —
  user-creatable, via a trailing action button on the scrollable
  `List Tab Bar`. See [the add-list method](../hipster/add-list-method.md).
- **Repeat's actual shape.** Resolved 2026-09-18 — see above.
- **Subtask fields.** Resolved 2026-09-18 — see above.

---
Part of [Santian](../README.md)
