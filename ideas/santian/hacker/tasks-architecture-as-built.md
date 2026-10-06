---
title: Tasks module architecture, as built — repositories, Cubits, one watched stream, folders
idea: santian
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hacker/flutter-module-structure.md", "../decisions/0009-cubit-for-state-management.md", "./notifications-as-built.md"]
tags: [artifact]
---

## Question
How is the Tasks module's code shaped today, and where does each concern
live?

## Short answer
- The layers are: screens (a pure `View` plus a wiring `Sheet`/`Panel`),
  then Cubits, then two repositories, then Isar. Only `TaskRepository`
  knows about notifications.
- The Tasks List watches **every Task once** (`watchAll`) and works out
  each tab's Tasks in memory, so the pages next to the current one are
  ready during a swipe.
- Writes act on the stored record, not the Task held on screen, so an
  out-of-date row cannot overwrite newer edits.

## Detail

Stack: Flutter (Dart ^3.11), `flutter_bloc` (Cubit only,
[0009](../decisions/0009-cubit-for-state-management.md)),
`isar_community` 3.3.2, `flutter_local_notifications`, `uuid`. Only
`main.dart` touches platform setup.

### Folders (`lib/`)
```
main.dart            open Isar, debug seed, notifications, repositories, cold-start tap
app.dart             MaterialApp: light + dark theme, navigator key
primary_view.dart    root screen; today it holds only TasksListPanel (f64e2c0)
core/theme/          AppTheme, AppColors (muted tokens), AppRadius, fabShadow
core/notifications/  NotificationService (seam), the flutter_local_notifications impl, sync rules
core/debug/          debug-only seed data
tasks/models/        Task, TaskList, Repeat, Subtask (+ .g.dart)
tasks/repository/    TaskRepository, ListRepository, watchQuery helper
tasks/cubits/        TasksList, TaskDetail, CreateTask, CreateList (+ TasksListState)
tasks/screens/       *View (pure UI), *Sheet / *Panel (wiring), *Form
tasks/widgets/       TaskRow, ListTabBar, MonthGrid, pickers, Repeat dialog, FAB, List selector
tasks/*.dart         pure rules: task_order, subtask_order, repeat_advance, deadline_status
```
There are no domain or use-case layers and no interface per repository.
The one exception is `NotificationService`, which exists so tests can fake
it.

### Repositories
- **`TaskRepository`**: `watchAll`, `watchByList`, `watchStarred`, `get`,
  `create`, `update`, `delete`, `deleteInList(completedOnly:)`,
  `toggleStarred`, `toggleCompleted`. Every write that affects
  notifications re-syncs them. `toggleCompleted` holds the repeat logic,
  so the checkbox and Mark completed both use it.
- **`ListRepository`**: `watchAll`, `create`, `rename`, `delete`,
  `createDefault`. It has no notification work.
- `watchQuery` turns Isar's `watchLazy` into "run the query again and
  emit". One broadcast stream per repository is created up front and kept
  for the repository's whole life.

### Cubits
| Cubit | Owns |
|---|---|
| `TasksListCubit` | Lists + all Tasks streams, active tab, `lastListId`, first-launch default List, list rename/delete |
| `TaskDetailCubit` | a clone of one Task. Each edit emits, then calls `update()` |
| `CreateTaskCubit` | draft title, notes, star, reminder, repeat. Submits once |
| `CreateListCubit` | draft name. Submits once |

`TasksListState.tasksFor(tab)` filters and sorts on each call. A
`ponytail:` comment marks this: cache it if it shows up in profiling.

### Screen pattern
Each screen is split into a stateless `*View`, which takes plain state and
callbacks and is tested with hand-built states, and a thin `*Sheet` or
`*Panel` that connects it to a Cubit. Sheets open through `show*Sheet()`
functions that pass the repositories into the modal's own route.

### Tests
There are widget and unit tests for every cubit, rule and screen, plus
round-trip tests on real Isar (`test/support/test_isar.dart`) and a fake
`NotificationService`. CI runs `build_runner` (and fails if the `.g.dart` files are out of date),
then `flutter analyze`, then `flutter test`.

## What would change my mind
- Clockface arrives and needs a different read model. `PrimaryView` is
  where it would plug in, but nothing about it is decided.

## Open questions
- What else is `PrimaryView` meant to hold? The commit message does not say.

---
Part of [Santian](../README.md)
