---
title: Detail tabs and workload strip build tickets — H11 and H12
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: weak
created: 2026-11-10
updated: 2026-11-10
inputs: ["../hipster/hifi-mockup-tickets-for-pen-dev.md", "../decisions/0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md", "../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md", "./flutter-app-as-built.md", "./my-tasks-build-tickets.md"]
tags: [artifact]
---

## Question
What are the build tickets for the task-detail tabs and quick actions
([H11](../hipster/hifi-mockup-tickets-for-pen-dev.md)) and the workload strip
on home (H12)?

## Short answer
- 2 app tickets, **B20** (detail) and **B21** (strip), and 1 API ticket,
  **A1**: send each task's `creatorId`. The database already stores
  `creator_id`; the task JSON does not carry it, and B21's "to review" needs it.
- B20 turns the detail panel's single scroll into three tabs, swaps the ⋮ menu
  for quick-action circles, and makes the action bar a pill. B20 builds only
  what exists today: activity, extension, archive. Pencil (edit) and
  file-up (proof list) wait for the H13 tickets.
- B21 adds the black strip above the calendar. It does not minimize.
- Order: A1 before B21. B20 is independent.

## Detail
Read against Tasko-Flutter `main` at `cb40900` (2026-10-29), before the
rails PR #41. Drawings: H11 and H12 in `pencil-new.pen`, PNGs
`hifi ! detail ! team-top.png`, and `hifi ! home ! default.png`. Status lives on the issues and PRs
([0015](../decisions/0015-github-holds-ticket-status-arcbyte-holds-the-why.md)):
API [#44](https://github.com/arcbyte-lab/Tasko-API/issues/44) (A1), app
[#42](https://github.com/arcbyte-lab/Tasko-Flutter/issues/42) (B20) and
[#43](https://github.com/arcbyte-lab/Tasko-Flutter/issues/43) (B21).

### Rules
| Rule | Value |
|---|---|
| Detail tabs | Brief (property rows), Sub tasks, Discussion. A private task has no Discussion tab. Section labels inside tabs are hidden |
| Quick actions | 45px #F7F9FA circles, gap 8, right-aligned at the panel's top. History first for leads, then extension (members), archive (author). A private task shows only archive (edit comes with H13) |
| Action bar | A 382×44 pill, buttons inside are pills |
| Strip counts | Over the `my tasks` set ([0017](../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md)), whatever tab is active ([0018](../decisions/0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md) item 3) |
| In progress | status `inProgress` and `assigneeId == me` |
| To review | status `review`, `creatorId == me` and `assigneeId != me` (tasks I made and assigned to someone else). Owner confirmed 2026-11-10 |
| Due soon | open task due within the next 48 hours, not yet overdue |
| Overdue | `isOverdue(task, now)` |
| Totals | None: a task may count twice |
| Hidden | On `calendar-fullscreen`, as in the mockup |

### App (Tasko-Flutter)
Each ticket is done when `flutter analyze` and `flutter test` pass.

**B20 — Detail tabs and quick actions**
- `task_detail_sheet.dart`:
  - Under the note, a tab bar (reuse the home `TabStrip` look: 13 medium,
    active #333333 with a 2px #3B82F6 underline) over Brief / Sub tasks /
    Discussion. State is the selected index; Discussion hidden when
    `!team`. Brief holds `_PropRow`s, `_Subtasks` and `_Discussion` move
    into their own tab.
  - `_Header`: drop the `PopupMenuButton`; a `_QuickActions` row of
    `Tooltip`'d circle buttons with the same visibility rules as the menu
    items today (`onActivity`, `canExtend`, `canArchive`). Archive keeps the
    existing `onArchive` and confirmation behaviour; its wording is still
    the API's call (0018 item 4).
  - `_ActionBar`: pill shape, same buttons and rules.
  - Panel geometry (9, 121, radius 18, scrim blur 4px; stays at y 121 with
    the keyboard on) follows the mockup.
- Tests: tabs switch; a private task has no Discussion tab; each quick
  action shows only for its role; the menu tests (`task_detail_flow_test.dart`,
  "a member asks for an extension from the menu") now tap the circle instead.

**A1 — Send `creatorId` (API)**
- Tasko-API `src/tasks.ts`: add `creatorId` to the task JSON on every
  endpoint that returns tasks (it already selects `creator_id`).
- Tasko-Flutter: `Task.creatorId` (nullable `int`), parsed in
  `http_tasks_api.dart`, set in `FakeTasksApi`.
- Tests: the API test for task JSON; the HTTP client parses it.

**B21 — Workload strip**
- `task_rules.dart`: `Workload workload(Iterable<(Task, TaskTab)>, int meId,
  DateTime now)` returning `inProgress`, `toReview`, `dueSoon`, `overdue`.
  Unit tests for each count, a task counting twice (in progress and
  overdue), and the 48-hour edge.
- `HomeState`: `workload` computed from every tab's tasks via `isMine`,
  independent of `activeTab`.
- `widgets/stats_strip.dart`: the strip (80 tall, black; MY WORK and
  DEADLINES labels 11 medium #9CA3AF, four stats as count 18 semibold, 6px
  dot, 12 label). Blue in progress, orange to review, yellow due soon, red
  overdue, as in `hifi ! home ! default.png`.
- `HomeView`: strip between the top bar and calendar, always full size.
  Hidden when `calendarExpanded`.
- Tests: counts follow the data not the tab; hidden on the full-screen
  calendar.

### Not in these tickets
- Edit mode, proof list sheet, archive confirm, extension-pending pill:
  H13, separate tickets.
- Tapping a stat to filter the list. Not drawn.

## What would change my mind
- If the strip should count more than the user's own tasks, the
  "my tasks" rule in 0017 changes first.

## Open questions
- None for B21. The strip does not minimize and the colour pairing matches
  the drawing. The calendar fold and the My Workspace pull (H13) are other
  gestures with their own tickets.

---
Part of [Tasko](../README.md)
