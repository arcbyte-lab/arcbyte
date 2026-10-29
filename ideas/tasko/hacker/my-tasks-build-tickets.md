---
title: My tasks build tickets — a first tab that gathers the user's tasks and reviews
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-29
updated: 2026-10-29
inputs: ["../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "./flutter-app-as-built.md", "./calendar-revamp-build-tickets.md"]
tags: [artifact]
---

## Question
What are the build tickets for the "my tasks" tab in
[0017](../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md)?

## Short answer
- 2 app tickets, **B18–B19**, in order. **No API ticket**: `HomeCubit`
  already loads every tab's tasks (`tasksByTab`) and the user's role in each
  tab (`TaskTab.role`), so "my tasks" is worked out in the app.
- B18 adds the tab: a new `TabKind.myTasks`, first in the strip, opened on
  start, its list and dots built from the other tabs, and the tab name on
  each row.
- B19 lets the + button create from "my tasks": the create sheet gets a tab
  picker, starting on `private`.

## Detail
Read against Tasko-Flutter `main` at `c4a39d2` (2026-10-29). The drawing is
[H10](../hipster/hifi-mockup-tickets-for-pen-dev.md):
`hifi / my tasks / default` and `hifi / my tasks / day-selected` in
`pencil-new.pen`, PNGs in `assets/hi-fi snapshoots/`. Status lives on the
issues and their PRs once they are opened
([0015](../decisions/0015-github-holds-ticket-status-arcbyte-holds-the-why.md)).

### Rules
| Rule | Value |
|---|---|
| Which tasks | Every task in `private`; from each division or project tab, tasks with `assigneeId == me`, plus tasks in `review` when the user can review in that tab |
| Who can review in a tab | Division: role `admin` or `supervisor` (`canCreateProject`). Project: role `owner` or `person-in-charge` (`canManageMembers`). Same as 0004 |
| Duplicates | None: a task lives in one tab, and is added at most once from it |
| Calendar dots | The same tasks, and a task in `review` counts (it's open for its reviewer). Anywhere else, `review` still doesn't count |
| Row | The meta line ends with " · <tab name>", in the meta colour, also on overdue rows |
| Toolbar | Search and view options. Members, repeat and activity stay hidden: their rules are false for this tab |
| Opening the app | On "my tasks". After `reloadTabs`, if the active tab is gone, back to "my tasks" |
| Selected day | Kept across tabs, as now (0016 rule 6) |
| + button | The create sheet with a tab picker, starting on `private` (B19) |

### App (Tasko-Flutter)
Same shape as now: a pure `*View`, a thin `*Screen`, Cubits behind the
`TasksApi` seam. Each ticket is done when `flutter analyze` and
`flutter test` pass.

**B18 — The "my tasks" tab**
- `models.dart`: `TabKind.myTasks`, and `TaskTab.myTasks =
  TaskTab(TabKind.myTasks, 0, 'my tasks')`. It never goes to the API.
- `task_rules.dart`:
  - `canReview(TaskTab tab)`: `canCreateProject(tab) ||
    canManageMembers(tab)`.
  - `isMine(Task t, TaskTab tab, int meId)`: true for every task in
    `private`; elsewhere `t.assigneeId == meId || (t.status ==
    TaskStatus.review && canReview(tab))`.
  - `dueByDate` takes an optional `counts` test, default `isOpen`, so
    "my tasks" can pass `isOpen(t) || t.status == TaskStatus.review`.
  - Unit tests for `canReview` and `isMine`, including a review in a tab
    where the user is a plain member (not mine) and an unassigned team
    task (not mine).
- `HomeState`:
  - `tasks` for `TaskTab.myTasks` is gathered from `tasksByTab` with
    `isMine`; for any other tab it stays `tasksByTab[activeTab]`.
  - `tabOf(Task t)`: the tab a task lives in (match on `id` and
    `personal`), for the row label and for ticking.
  - `members` for "my tasks": every tab's members, one per user, so the
    assignee names and the assignee filter work.
  - `dueOn` uses the review-counting test when "my tasks" is active.
- `HomeCubit`:
  - `load()` and `reloadTabs()` put `TaskTab.myTasks` first, and `load()`
    makes it active. `tasksByTab` has no entry for it.
  - `_refresh(tab)` for "my tasks" fetches every real tab again (the same
    `Future.wait` as `load`). `reload()` follows.
  - `tick` puts the updated task back in `tabOf(task)`'s list, not the
    active tab's.
- `TabStrip`: "my tasks" first, before WORKSPACES, in its own group whose
  label is hidden but keeps its height, so the tab lines up with the
  others. `workspaces` must leave it out.
- `TaskRow` gains an optional `tabName`; `HomeView._page` passes
  `page.tabOf(t).name` when the page is "my tasks".
- Tests:
  - `home_cubit_test.dart`: the tab list now starts with "my tasks", and
    the start tab is "my tasks" (the test "loads private first" and
    `members_test.dart`'s `activeTab` check change). New: "my tasks" holds
    the user's private tasks, their assigned team tasks and their reviews,
    and not a teammate's task; ticking from "my tasks" updates the owning
    tab; the dots count a review.
  - `home_view_test.dart`: rows in "my tasks" end with their tab name; the
    members, repeat and activity buttons don't show.
  - `integration_test/live_test.dart`: the step "Mira logs in and sees her
    eight tabs" now expects "my tasks" first.

**B19 — Create from "my tasks"**
- `showCreateTaskSheet` takes `tabs` (the real tabs) when opened from
  "my tasks"; `tab` is then `private`.
- `CreateTaskCubit`: `tab` becomes state, with `setTab(TaskTab)`. Picking
  a team tab loads its members (as `load` does now) and picks the first
  as assignee; picking `private` clears assignee, proof and repeat.
  `isTeam` reads the state's tab.
- The sheet shows a tab chip first in its chip row ("private ▾"), the same
  chip look as the others. It opens a picker listing the tabs under
  WORKSPACES and PROJECTS. The chip shows only when `tabs` was given.
- After creating, `HomePanel` reloads as it does now; from "my tasks" that
  refreshes every tab (B18).
- Tests: create a team task from "my tasks" with the picker; switching
  back to `private` drops the assignee; the chip doesn't show from a
  normal tab.

### Not in these tickets
- An unassigned team task showing for its tab's leads. Open in 0017.
- Starting the create sheet on the last tab used instead of `private`.
  Open in 0017.
- A hifi frame for the create sheet's tab picker. B19 reuses the chip and
  picker looks already drawn (H3).

## What would change my mind
- If gathering "my tasks" on every build is slow for users in many tabs,
  work it out once per load or refresh and keep it in the state.
- If a person's role in a tab is not enough to know they can review (for
  example a project creator who left the owner role), the server should
  send `canReview` per task, as Task Detail already does.

## Open questions
- Should ticking a task in someone else's review from "my tasks" approve
  it? Today the checkbox on a task in review does nothing, and approving
  is done in Task Detail. The tickets keep that.

---
Part of [Tasko](../README.md)
