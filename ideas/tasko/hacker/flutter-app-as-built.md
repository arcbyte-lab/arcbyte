---
title: Tasko Flutter app, as built — screens, Cubits, one fake API seam, folders
idea: tasko
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-07
updated: 2026-10-07
inputs: ["./v1-home-build-tickets.md", "../decisions/0005-v1-build-defaults.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../../santian/hacker/tasks-architecture-as-built.md"]
tags: [artifact]
---

## Question
What does the code in
[Tasko-Flutter](https://github.com/arcbyte-lab/Tasko-Flutter) look like
today, and where does each concern live?

## Short answer
- Every screen in the hifi mockups is built except the Repeat screen (cut
  by [0005](../decisions/0005-v1-build-defaults.md)). Everything runs on
  `FakeTasksApi` seed data. The server API is not part of this repo.
- Same shape as [Santian](../../santian/hacker/tasks-architecture-as-built.md):
  a pure `*View` plus a thin `*Panel`/`*Sheet` for wiring, Cubits, and pure
  rule files with unit tests. The one seam is `TasksApi`.
- 76 tests (rules, Cubits, widget flows). CI runs `flutter analyze` and
  then `flutter test`.

## Detail
Stack: Flutter 3.41.4 (Dart 3.11), `flutter_bloc` (Cubit only). Fonts are
Inter and JetBrains Mono. Light theme only, using the hifi hex tokens.

### Folders (`lib/`)
```
main.dart                  FakeTasksApi → RepositoryProvider → HomeCubit → HomePanel
core/theme/app_theme.dart  AppColors (hifi tokens), groupLabelStyle, ThemeData
core/toast.dart            snackbar-looking message above every route
tasks/models.dart          Task (team + personal in one), TaskTab, User, Member,
                           Comment, TaskDetail, AppNotification
tasks/tasks_api.dart       TasksApi (the seam) + FakeTasksApi (seed data)
tasks/task_rules.dart      isOpen, isOverdue, taskOrder, dayGroup, dueCounts,
                           statusAfterTick, actionFor, relative times
tasks/view_options.dart    group / sort / filter for the list
tasks/*_cubit.dart         HomeCubit, CreateTaskCubit, TaskDetailCubit
tasks/screens/             home, create sheet, task detail sheet
tasks/widgets/             pulse panel, tab strip, tab pages, task row,
                           pickers, reason sheets, view-options sheet
notifications/             NotificationsCubit + screen
```

### Screens
| Screen | What works |
|---|---|
| Home | Header with an unread dot and an account menu. Monthly heatmap (0003): swipe changes month, tapping a day filters the list, and a full-screen mode. Tabs (0002) as a `PageView`: the list follows the finger and the tab underline moves with it. Pinned toolbar: "N open", search, view options. Grouped list. Checkbox (0004/0005). |
| Create sheet | Title, note, chips for due date, priority, assignee and proof, each with a picker. Personal tasks get only date and priority. |
| Task detail | Editable title and note, property rows, sub-tasks, discussion. The action bar follows status and viewer (`actionFor`). Menu items: extension request, archive. |
| Notifications | NEW / EARLIER sections, "mark all read". |

### How state flows
- `HomeCubit` loads **every tab's tasks and members** at start
  (`tasksByTab`), so a swipe never waits on the network. Choosing a tab
  shows the cached list, then refreshes that tab. `HomeState.pageFor(tab)`
  is what a neighbouring page shows mid-swipe.
- Task Detail keeps title and note edits as drafts and saves them before
  the sheet returns, so the list reloads with them.
- The server decides permissions. `TaskDetail` carries `canReview`,
  `canArchive` and `canRequestExtension`, so the app does not repeat the
  reviewer rules from 0004.

### Placeholders (an "action: …" message, per lofi T12)
Proof chip, submit proof, archive task, account settings, log out.

## What would change my mind
- The real API returns task lists or permissions in a shape that does not
  fit `TasksApi`. Then the seam moves, not the screens.

## Open questions
- How does the app reach the server, now that the API is not part of this
  repo? `FakeTasksApi` in `lib/main.dart` is the only thing to swap.
- See [choices made while building](./build-choices-to-confirm.md) for
  the calls the owner should confirm.

---
Part of [Tasko](../README.md)
