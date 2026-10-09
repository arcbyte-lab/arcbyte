---
title: Tasko Flutter app, as built — screens, Cubits, one API seam on Tasko-API, folders
idea: tasko
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-07
updated: 2026-10-09
inputs: ["./v1-home-build-tickets.md", "../decisions/0005-v1-build-defaults.md", "../decisions/0007-server-rules-settled-in-the-api-review.md", "./tasko-api-as-built.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../../santian/hacker/tasks-architecture-as-built.md"]
tags: [artifact]
---

## Question
What does the code in
[Tasko-Flutter](https://github.com/arcbyte-lab/Tasko-Flutter) look like
today, and where does each concern live?

## Short answer
- Every screen in the hifi mockups is built except the Repeat screen (cut
  by [0005](../decisions/0005-v1-build-defaults.md)). Since
  [PR #1](https://github.com/arcbyte-lab/Tasko-Flutter/pull/1) (open on
  2026-10-09) the app logs in and runs on the
  [Tasko API](./tasko-api-as-built.md). `FakeTasksApi` only runs the tests.
- Same shape as [Santian](../../santian/hacker/tasks-architecture-as-built.md):
  a pure `*View` plus a thin `*Panel`/`*Sheet` for wiring, Cubits, and pure
  rule files with unit tests. The one seam is `TasksApi`.
- 81 tests (rules, Cubits, widget flows, the HTTP client). CI runs
  `flutter analyze` and then `flutter test`.
- **"start working" fails on the real API.** The server never moves a task
  to `in_progress` ([0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md)),
  so Task Detail's button gets a 422. Not decided yet.

## Detail
Stack: Flutter 3.41.4 (Dart 3.11), `flutter_bloc` (Cubit only), `http`,
`flutter_secure_storage` for the login token. Fonts are
Inter and JetBrains Mono. Light theme only, using the hifi hex tokens.

### Folders (`lib/`)
```
main.dart                  stored token? LoginScreen : HttpTasksApi → HomeCubit → HomePanel
auth/login_screen.dart     email and password
core/theme/app_theme.dart  AppColors (hifi tokens), groupLabelStyle, ThemeData
core/toast.dart            snackbar-looking message above every route
tasks/models.dart          Task (team + personal in one), TaskTab, User, Member,
                           Comment, Proof, TaskDetail, AppNotification
tasks/tasks_api.dart       TasksApi (the seam) + FakeTasksApi (test data)
tasks/http_tasks_api.dart  HttpTasksApi, login(), ApiException, JSON mapping
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
| Login | Email and password. The token (30 days) is kept in secure storage. |
| Home | Header with an unread dot and an account menu. Monthly heatmap (0003): swipe changes month, tapping a day filters the list, and a full-screen mode. Tabs (0002) as a `PageView`: the list follows the finger and the tab underline moves with it. Pinned toolbar: "N open", search, view options. Grouped list. Checkbox (0004/0005). A task that needs a proof asks for a link first (0007). |
| Create sheet | Title, note, chips for due date, priority, assignee and proof, each with a picker. Personal tasks get only date and priority. |
| Task detail | Editable title and note, property rows, sub-tasks, discussion. The action bar follows status and viewer (`actionFor`). Menu items: extension request, archive. The proof row shows the latest proof link; "submit proof" asks for one. Review buttons: approve, reject. |
| Notifications | NEW / EARLIER sections, "mark all read". |

### How state flows
- `HomeCubit` loads **every tab's tasks and members** at start
  (`tasksByTab`), so a swipe never waits on the network. Choosing a tab
  shows the cached list, then refreshes that tab. `HomeState.pageFor(tab)`
  is what a neighbouring page shows mid-swipe.
- Task Detail keeps title and note edits as drafts and saves them before
  the sheet returns, so the list reloads with them.
- **Talking to the server:** `HttpTasksApi` calls the deployed API, or a
  local one with `--dart-define=API_URL=…`. A 401 clears the token and
  returns to login. Any other refused change shows the server's message
  as a toast.
- The server decides permissions. `TaskDetail` carries `canReview`,
  `canArchive` and `canRequestExtension`, so the app does not repeat the
  reviewer rules from 0004.

### Placeholders (an "action: …" message, per lofi T12)
The proof chip (choosing a proof type), archive task, account settings.
Log out and submit proof are built.

## What would change my mind
- The real API returned every shape `TasksApi` needed (checked against a
  local seeded server on 2026-10-09). If a later route doesn't fit, the
  seam moves, not the screens.

## Open questions
- "start working": should the server allow `→ in_progress` from Task
  Detail, or should the app drop the button?
- Run on fake data without a server (a `--dart-define=FAKE=true`)? Not
  built.
- See [choices made while building](./build-choices-to-confirm.md) for
  the calls the owner should confirm.

---
Part of [Tasko](../README.md)
