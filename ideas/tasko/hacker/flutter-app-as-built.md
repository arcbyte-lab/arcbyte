---
title: Tasko Flutter app, as built — screens, Cubits, one API seam on Tasko-API, folders
idea: tasko
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-07
updated: 2026-10-19
inputs: ["../decisions/0008-start-working-moves-a-task-to-in-progress.md", "./v1-home-build-tickets.md", "../decisions/0005-v1-build-defaults.md", "../decisions/0007-server-rules-settled-in-the-api-review.md", "./tasko-api-as-built.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../../santian/hacker/tasks-architecture-as-built.md", "../decisions/0010-adding-a-project-member-needs-no-invitation.md", "./project-and-member-build-tickets.md", "../decisions/0011-new-project-sits-at-the-end-of-the-tab-strip.md"]
tags: [artifact]
---

## Question
What does the code in
[Tasko-Flutter](https://github.com/arcbyte-lab/Tasko-Flutter) look like
today, and where does each concern live?

## Short answer
- Every screen in the hifi mockups is built. The Repeat screen is only
  for workspace tasks ([0009](../decisions/0009-workspace-tasks-repeat-on-completion.md)). Since
  [PR #1](https://github.com/arcbyte-lab/Tasko-Flutter/pull/1) (merged
  2026-10-09) the app logs in and runs on the
  [Tasko API](./tasko-api-as-built.md). `FakeTasksApi` only runs the tests.
- Same shape as [Santian](../../santian/hacker/tasks-architecture-as-built.md):
  a pure `*View` plus a thin `*Panel`/`*Sheet` for wiring, Cubits, and pure
  rule files with unit tests. The one seam is `TasksApi`.
- 103 tests (rules, Cubits, widget flows, the HTTP client). CI runs
  `flutter analyze` and then `flutter test`.
- Since 2026-10-14 (PRs #9–#12) a division lead creates projects, and a
  project's owner or person-in-charge manages its members
  ([0010](../decisions/0010-adding-a-project-member-needs-no-invitation.md)).
  The phone walkthrough, `integration_test/live_test.dart`, covers it and
  can run against a local API.
  Since [PR #13](https://github.com/arcbyte-lab/Tasko-Flutter/pull/13)
  (merged 2026-10-19), "+ new project" sits at the end of the tab strip
  ([0011](../decisions/0011-new-project-sits-at-the-end-of-the-tab-strip.md)).
  The walkthrough passed all 21 steps on the phone against a local API.
- Tested on an Android 16 phone against the live API on 2026-10-09: login,
  tabs, ticking, proof, review, comments, create, notifications and log out
  all work. "start working" was refused by the server then; the server now
  allows it ([0008](../decisions/0008-start-working-moves-a-task-to-in-progress.md)).

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
tasks/*_cubit.dart         HomeCubit, CreateTaskCubit, TaskDetailCubit,
                           MembersCubit
tasks/screens/             home, create sheet, task detail sheet,
                           new project sheet, members screen
tasks/widgets/             pulse panel, tab strip, tab pages, task row,
                           pickers, reason sheets, view-options sheet
notifications/             NotificationsCubit + screen
```

### Screens
| Screen | What works |
|---|---|
| Login | Email and password. The token (30 days) is kept in secure storage. |
| Home | Header with an unread dot and an account menu. Monthly heatmap (0003): swipe changes month, tapping a day filters the list, and a full-screen mode. Tabs (0002) as a `PageView`: the list follows the finger and the tab underline moves with it. Pinned toolbar: "N open", members (project tabs only), search, view options. The tab strip ends with "+ new project" for division admins and supervisors (0011). Grouped list. Checkbox (0004/0005). A task that needs a proof asks for a link first (0007). |
| Create sheet | Title, note, chips for due date, priority, assignee and proof, each with a picker. Personal tasks get only date and priority. |
| Task detail | Editable title and note, property rows, sub-tasks, discussion. The action bar follows status and viewer (`actionFor`). Menu items: extension request, archive. The proof row shows the latest proof link; "submit proof" asks for one. Review buttons: approve, reject. |
| Notifications | NEW / EARLIER sections, "mark all read". Closing it reloads the tabs, so a project the viewer was just added to shows. |
| New project | From "+ new project" at the end of the tab strip (0010, 0011). Name, a division chip when there is a choice, a due date. The new tab is added last and opened. |
| Members | From the project toolbar (0010). Owners and persons-in-charge add people from a server-side user search and change or remove roles; only owners touch the owner role. Anyone can leave, which drops the tab. |
| Repeat | From Task Detail's repeat row, workspace tasks only (0009). Every N unit, weekday chips, ends never / on / after N, "stop repeating". The time and the start come from the due date. Ticking a repeating task reloads the tab, so the next task shows. |

### How state flows
- `HomeCubit` loads **every tab's tasks and members** at start
  (`tasksByTab`), so a swipe never waits on the network. Choosing a tab
  shows the cached list, then refreshes that tab. `HomeState.pageFor(tab)`
  is what a neighbouring page shows mid-swipe.
- `HomeCubit.reloadTabs()` fetches the tab list again after the members
  or notifications screen closes. It keeps cached tasks, loads new tabs,
  and refreshes every tab's members and the viewer's role on each tab.
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
- Run on fake data without a server (a `--dart-define=FAKE=true`)? Not
  built.
- See [choices made while building](./build-choices-to-confirm.md) for
  the calls the owner should confirm.

---
Part of [Tasko](../README.md)
