---
title: v1 build tickets — the home screen and the checkbox, Flutter + Cubit on a fake API
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-07
inputs: ["../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md", "../decisions/0004-checkbox-goes-to-review-only-when-needed.md", "../decisions/0005-v1-build-defaults.md", "../assets/sqlite-schema.sql", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../../santian/hacker/tasks-architecture-as-built.md"]
tags: [artifact]
---

## Question
What are the first build tickets for the Tasko app, so that someone
(the owner or an agent) can pick them up one at a time?

**Done:** everything below, and the screens after it, is built. See
[the app as built](./flutter-app-as-built.md).

## Short answer
- There are 7 tickets, **B0 to B6, in order**. Together they give a working
  home screen: header, calendar heatmap, workspace and project tabs, the
  task list, and the checkbox.
- Everything runs on a **fake in-memory API** with seed data. The real
  Laravel API, login, Task Detail, Create Task and reviews come in later
  tickets.
- The rules come from [0002](../decisions/0002-tabs-are-workspaces-then-projects.md),
  [0003](../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md),
  [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md) and
  [0005](../decisions/0005-v1-build-defaults.md). When a ticket and a
  decision disagree, the decision wins.

## Detail
Copy Santian's shape ([architecture as built](../../santian/hacker/tasks-architecture-as-built.md)):
stateless `*View` widgets, thin `*Panel` wiring, Cubits, and pure rule
files with unit tests. There are no domain layers and no interface per
repository. The one seam is `TasksApi`, because it has two
implementations: the fake one now, and HTTP later.

Every ticket is done when `flutter analyze` and `flutter test` pass.

### B0 — Project skeleton
- New Flutter app in [Tasko-Flutter](https://github.com/arcbyte-lab/Tasko-Flutter),
  with `flutter_bloc` as its only state package.
- `core/theme/`: the light-theme tokens from the
  [hifi tickets' table](../hipster/hifi-mockup-tickets-for-pen-dev.md#theme-tokens-in-hex),
  Inter and JetBrains Mono, radius 6.
- CI runs `flutter analyze` and then `flutter test`.
- Done when: the app opens to an empty `HomePanel` that uses the theme.

### B1 — Models and the fake API
- Models, with names as in the schema: `User`, `Division`, `Project`,
  `Task` (from `tasks`), `PersonalTask` (from `personal_tasks`). Each model
  has only the fields that B2 to B6 read. Do not copy every column.
- `TasksApi` has these methods: `me()`, `myDivisions()`, `myProjects()`,
  `tasksForDivision(id)` (only `project_id == null`), `tasksForProject(id)`,
  `myPersonalTasks()`, `setTaskStatus(id, status)` and
  `setPersonalTaskStatus(id, status)`.
- `FakeTasksApi` keeps everything in memory, seeded with one user, the
  divisions `tech`, the projects `tasko-app` and `tasko-web`, and about 20
  tasks. The seed covers each status, overdue and no-date tasks, and one
  task with `required_proof_type` set.
- Done when: unit tests show that each method returns the right scope.

### B2 — Pure rules (no Flutter)
Put each rule in its own file and give it unit tests. Each rule works on
both `Task` and `PersonalTask`.
- `isOpen`: `waiting` or `in_progress` for a Task; `todo` or
  `in_progress` for a PersonalTask.
- `checkLook`: open, review or done (three looks; `waiting` and
  `in_progress` look the same).
- `isOverdue`: open, and `due_date`'s **calendar day** is before today.
  Ignore the time.
- `taskOrder`: by `due_date`, empty dates last, ties broken by id.
- `dayGroup`: Past, Today, Tomorrow, a date, or No date.
- `dueCounts(tasks, month)`: the number of open tasks per calendar day.
- Done when: every rule has tests, including the edge at midnight.

### B3 — `HomeCubit`
- Loads the user, then the tabs in this order: `private`, then each
  division, then each project ([0002](../decisions/0002-tabs-are-workspaces-then-projects.md)).
- Its state is: the tabs, the active tab, the active tab's tasks, the
  shown month, and the selected day (or none).
- Actions: `selectTab`, `selectDay` (tapping the same day again clears it),
  `nextMonth` and `prevMonth`.
- Done when: Cubit tests cover changing tabs, filtering by day and
  clearing the filter, all on `FakeTasksApi`.

### B4 — Header and calendar heatmap
- Header: "welcome, {name}", a bell with a red dot (hardcoded off for now),
  and the avatar. **The slider icon is left out**, because its meaning is
  still open.
- `MonthGrid`: Monday first. Each cell is shaded by `dueCounts` for the
  **active tab** (0 = `heatmap-empty`, any other count = `chart-4`, as in
  the hifi frames). Swipe or arrows change the month. Tapping a cell calls
  `selectDay`.
- Done when: widget tests on hand-built states check the shading and the
  tap.

### B5 — Tabs and task list
- The tab bar scrolls sideways and shows two small group labels,
  *workspaces* and *projects*. The active tab has an underline.
- The list is grouped by `dayGroup` and sorted by `taskOrder`. When a day
  is selected, only that day's tasks show.
- Row: the checkbox, then the title, then the priority, status and due
  date (the [blueprint](../assets/blueprint.md) row). The due date is red
  when the task is overdue.
- Done when: widget tests cover the grouping, the day filter and the
  overdue colour.

### B6 — The checkbox
The rules come from [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md)
and [0005](../decisions/0005-v1-build-defaults.md).

| Row | Tap does |
|---|---|
| Personal task, open | `done` |
| Personal task, done | `todo` |
| Team task, open, no `required_proof_type` | `done` |
| Team task, open, `required_proof_type` set | `review`. Uploading a proof is not built yet, so for now show a snackbar, "Needs a proof — coming soon", and do not change the status. |
| Team task in `review` | nothing (it has a pending look and is not tappable) |
| Team task, done | `waiting` |

- The server sets the dates (`completed_date`, `review_date`). The fake
  API sets them too, so the tests can check them.
- The calendar counts update straight away, because a ticked task stops
  being open.
- Done when: Cubit tests cover every row of the table.

### Later, not ticketed yet
Login (Sanctum token), the HTTP `TasksApi`, Create Task (the FAB), Task
Detail, proof upload, approving or rejecting a review, and the bell's
notification list. Each one needs its own ticket note once the server API
is known.

## What would change my mind
- The Laravel app already has an API with a different shape. Then B1's
  method list should copy that API instead.

## Open questions
- Does the Laravel app expose a JSON API today, or does one have to be
  written? Login and the HTTP `TasksApi` are blocked on this.
- What is the slider icon in the header?
- Heatmap shading: is "any or none" enough, or should it step by count?

---
Part of [Tasko](../README.md)
