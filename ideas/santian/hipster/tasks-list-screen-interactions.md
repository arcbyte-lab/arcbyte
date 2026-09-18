---
title: Tasks List screen — tab switching, row tap, checkbox, and FAB behaviour
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "../decisions/0004-clone-google-tasks-interactions.md", "../assets/santian-hifi-export.html", "./add-list-method.md", "./deadline-badge-and-overdue-styling.md", "./google-tasks-ux-playbook.md", "./task-detail-more-menu-and-delete.md"]
tags: [artifact]
---

## Question
The hi-fi export draws the Tasks List screen's static geometry — tab bar,
rows, FAB — but the `.pen` file is geometry only. What happens when the user
actually touches it: switches tabs, taps a row, taps a checkbox, taps the FAB?

## Short answer
- Tapping a `List Tab Bar` tab filters `Task List` to that list (or, for
  Star, the `isStarred` filter). Exactly one tab active at a time.
- The row splits into two tap zones: the `Checkbox` toggles completion only;
  anywhere else on the row opens `Task Detail` for that Task.
- The FAB always creates a task in whichever list tab is currently active —
  except when Star is active, which is unresolved (see Open questions).
- The completed-task visual, the empty state, and a repeating Task's
  on-screen behaviour mid-recompute are still **not drawn anywhere** in the
  8 exported screens. This spec does not invent them. Delete is resolved —
  see below.

## Detail

### Tab switching
`List Tab Bar` (Star / Personal Interest / My Tasks / Building, plus the
trailing `+` from [the add-list spec](./add-list-method.md)) sits above
`Task List` inside the same `Tasks Panel`. The export's active-tab styling
(`My Tasks`, in the drawn frame) is: bold `#1c1917` label, `#0284c7`-tinted
icon, and a `2px` bottom border in `#0284c7` on the tab itself — separate
from the `Tab Indicator` bar above (that one marks `Tasks` vs. `Clockface`,
a different level of navigation). Tapping any other tab moves that active
styling to it and re-filters `Task List` below to:
- a named list (`Personal Interest`, `My Tasks`, `Building`, …) — tasks
  where `listId` matches, per [the data model](../hacker/task-list-subtask-data-model.md#list);
- **Star** — tasks where `isStarred: true`, across all lists, per the same
  note. This is the one tab that isn't a `listId` filter.

Only one tab is active at a time; there's no drawn multi-select or "all
lists" view.

### Row tap vs. checkbox tap
Each row (`Checkbox` + `Text Group` in a single flex-row) is one visual hit
area but two separate tap targets:
- **Checkbox** (`21×21`, circular outline) — toggles completion only. Does
  not open `Task Detail`.
- **Anywhere else on the row** (title, time, or the row's remaining empty
  space) — opens `Task Detail` as the modal sheet already drawn: dim overlay
  `#00000080`, white sheet sliding up over the `Tasks List` screen. There is
  no separate expand/collapse state; `Task Detail` is the only way to see a
  Task's description, deadline, repeat, or subtasks.

### Checkbox / completion behaviour
- **Non-repeating Task:** tap toggles `isCompleted` true/false. Nothing in
  the 8 screens draws a "checked" state — no strikethrough, no dimming, no
  reorder-to-bottom. That visual is genuinely undecided, not just omitted
  here (see Open questions).
- **Repeating Task:** per [the data model](../hacker/task-list-subtask-data-model.md#task),
  tapping the checkbox marks the current occurrence done, advances
  `reminderAt`/`deadline` to the next occurrence per the repeat rule, and
  resets `isCompleted` back to `false`. So a repeating Task's checkbox never
  stays visually checked — it flips, then reverts once the next occurrence
  is computed. What the user sees in between (an instant flip-back, a brief
  animated check, a disabled state during recompute) isn't drawn or decided.

### FAB
Single global `FAB`, bottom-right, `52×52`, `#0284c7` fill, visible on the
Tasks List screen regardless of which tab is active. Tap opens the
`Create Task` bottom sheet already drawn: dim overlay `#00000026`, sheet
rising from the bottom, keyboard focused immediately on the title field (the
`Create Task + Keyboard` frame shows this risen state).

The new Task's `listId` is whichever named-list tab is currently active.
**When Star is the active tab**, there is no list to default to — Star is a
filter, not a `listId` — and this isn't resolved anywhere in the mockup or
the data model note. Flagged, not invented.

### Empty state
Not drawn. Every list shown in the export has tasks (Personal Interest: 20,
My Tasks: 1, Building: unspecified count). No empty-list treatment exists
yet.

### Delete
**Resolved 2026-09-18** — there is no delete affordance on the Tasks List
row at all, by design. The owner confirmed delete lives only in Task
Detail, behind the `more-vertical` (`More`) icon already drawn in its
`Top Bar` — see
[Task Detail's More menu and delete](./task-detail-more-menu-and-delete.md).
This rules out the swipe-to-delete pattern [the pasted Google Tasks UX
playbook](./google-tasks-ux-playbook.md) suggested — that note was
`evidence: none`, describing real Google Tasks in general, never checked
against what this app's screens actually draw or decide.

### Starred tab
Per the data model, Starred is a filter over `Task.isStarred`, rendered on
its own screen ("Starred recently" header, no per-list grouping) but reusing
the same row component (`Checkbox` + `Text Group`) as every other list.
Because Starred mixes tasks from multiple lists in one view, whether a row
needs some indicator of which list it belongs to (the `List Dot` color, an
icon) is a real question the export doesn't answer — no such indicator is
drawn on the Starred screen.

## What would change my mind
Seeing these interactions next to the built screen and finding the two-tap-
zone row (checkbox vs. row body) awkward on a real device — small touch
targets are the most likely place this breaks down, particularly the
`21×21` checkbox next to a full-row tap target with no visible boundary
between them.

## Open questions
- **Completed-task visual** — strikethrough, dimming, reorder-to-bottom, or
  something else. Undrawn for both the non-repeating checked state and the
  repeating-Task mid-recompute moment.
- **FAB target when Star is active** — which `listId` does a new task get?
- **Empty state** — no treatment exists once a list has zero tasks.
- **Starred rows and list identity** — not drawn whether/how the source list
  is indicated when rows from multiple lists are mixed together.

---
Part of [Santian](../README.md)
