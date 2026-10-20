---
title: Activity log build tickets — write every team action, read it as four logs
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-20
updated: 2026-10-20
inputs: ["../decisions/0014-activity-logs-for-task-project-division-and-user.md", "./tasko-api-as-built.md", "./flutter-app-as-built.md", "./repeating-view-build-tickets.md"]
tags: [artifact]
---

## Question
What are the build tickets, for the API and for the app, for the four
activity logs in
[0014](../decisions/0014-activity-logs-for-task-project-division-and-user.md)?

## Short answer
- 3 API tickets (**A16–A18**) and 2 app tickets (**B14–B15**). Do them in
  order. A16 adds the table and the write helper, and everything else
  depends on it.
- One new table, `activity_logs`, plus four read routes. Each log row is
  written in the same D1 batch as its change.
- One app screen, `ActivityScreen`, serves all four logs. It's opened from
  the tab toolbar (`Icons.history`), Task Detail's menu, the account menu,
  and by tapping a person's name in any log.

## Detail
Not built yet. Issues: API [#36](https://github.com/arcbyte-lab/Tasko-API/issues/36)–[#38](https://github.com/arcbyte-lab/Tasko-API/issues/38)
(A16–A18), app [#22](https://github.com/arcbyte-lab/Tasko-Flutter/issues/22)–[#23](https://github.com/arcbyte-lab/Tasko-Flutter/issues/23)
(B14–B15), opened 2026-10-20. API PRs, stacked in order:
[#39](https://github.com/arcbyte-lab/Tasko-API/pull/39) (A16),
[#40](https://github.com/arcbyte-lab/Tasko-API/pull/40) (A17),
[#41](https://github.com/arcbyte-lab/Tasko-API/pull/41) (A18); 179 tests
pass. Not merged or deployed yet. `sqlite-schema.sql` is updated to match.

Changes from the tickets, made while building:
- A removal reads the tasks it will unassign just before its batch, not
  inside it, so `logRow` stays the only writer. A task assigned in that
  gap is unassigned without a log row.
- `logRow` takes an id the batch is still creating (`NewId`), because a
  new project's owner row is inserted after it.
- A tab the viewer isn't in answers 403, as everywhere else, not 404.

### Rules
| Rule | Value |
|---|---|
| What is logged | Every team-task, repeat, project and member change, listed in 0014. Private-tab tasks, logging in or out, and reading notifications are not logged. |
| When | In the same D1 batch as the change. A guarded update writes its log row with `select … where changes() = 1`, the pattern the proof and review inserts already use. |
| One row per field | `PATCH /tasks/:id` diffs the body against the stored task and writes one row per changed field. Nothing changed, no row. |
| `changes` | JSON. An edit is `{"field": [before, after]}`. Other actions carry their own keys: `proofUrl`, `reason`, `assigneeName`, `role`, `unassignedTaskIds`. |
| `target_user_id` | The person the action lands on: the new or old assignee, the assignee of a reviewed or commented task, the next repeat's assignee, or the member. A comment by the assignee on their own task has no target. |
| Who opens the division log, or a division task's log | Its admin or supervisor |
| Who opens the project log, or a project task's log | Its owner or person-in-charge only. Being a division lead isn't enough. |
| Who opens a user log | The user themselves, or a lead of a division they are in. A lead sees only the rows a log they can open would show. |
| Paging | Newest first, 50 rows per page, `?before=<id>` for the next page |

The server enforces every rule. The app only hides what a user can't use.

### API (tasko-api)
Same shape as today: Hono routers, `HTTPException` with a plain message,
tests in `test/` using `login()` and `api()`. Each ticket is done when
`npm test` passes and the change is deployed.

**A16 — The table, the write helper, and task edits**
- Migration `0006_activity_logs.sql`: create `activity_logs` with the
  columns in `sqlite-schema.sql`, plus `target_user_id integer references
  users(id) on delete set null`. Indexes: `(division_id, created_at)`,
  `(project_id, created_at)`, `(actor_id, created_at)`,
  `(target_user_id, created_at)` and `(subject_type, subject_id)`.
  `project_activities` was never migrated into D1, so there's nothing to
  drop.
- `src/activity.ts`: `logRow(db, {actor, action, subject, divisionId,
  projectId, targetUserId, changes}, guarded = false)` returns a
  `D1PreparedStatement` to add to a batch. `actor_name` and
  `subject_label` are copied in at write time. With `guarded`, the insert
  runs only `where changes() = 1`.
- Log these actions: `task.created`, `subtask.added` (its subject is the
  parent task), `comment.added`, `deadline.requested`, and the
  `PATCH /tasks/:id` field rows: `task.renamed`,
  `task.description_changed`, `task.priority_changed`, `task.due_changed`,
  `task.assigned`, `task.unassigned`, `repeat.set`, `repeat.changed`,
  `repeat.stopped`. Routes that run one statement today become batches.
- In arcbyte, update `ideas/tasko/assets/sqlite-schema.sql` to match: add
  the column and the indexes, and drop `project_activities`.
- Tests: one row per changed field, no row for a no-op save, a failed
  guarded update writes no row, and the personal routes write nothing.

**A17 — Status, reviews, repeats, projects and members**
- `PATCH /tasks/:id/status`: `task.started`, `task.completed`,
  `task.sent_to_review` (with `proofUrl`) and `task.reopened`, each
  guarded by the update.
- `POST /tasks/:id/reviews`: `task.approved` and `task.rejected` (with
  `reason`), guarded. The target is the assignee.
- `createNextOccurrence`: `repeat.next_created` on the new task, in its own
  batch. The actor is whoever finished the last one, and the target is the
  new assignee.
- `DELETE /series/:id`: `series.deleted`. The subject is the series and
  its label is the task name.
- `POST /projects`: `project.created`. Members: `member.added`,
  `member.role_changed`, `member.removed` and `member.left`. A removal or a
  leave puts `unassignedTaskIds` in `changes` (a `json_group_array`
  subquery written right after the delete, so `changes()` still refers to
  the delete). It also writes one `task.unassigned` row per task, placed
  before the unassign update.
- Tests: one per action, including that a 409 or a lost race writes
  nothing.

**A18 — The four read routes**
- `GET /tasks/:id/activity`, `GET /projects/:id/activity`,
  `GET /divisions/:id/activity`, `GET /users/:id/activity`. Each returns
  `{items: [{id, action, actor: {id, name}, subject: {type, id, label},
  target: {id, name} | null, tab: {kind, id, name}, changes, createdAt}],
  next: id | null}`.
- Filters:
  - task: `subject_type = 'task' and subject_id = ?`
  - project: `project_id = ?`
  - division: `division_id = ? and (project_id is null or action like
    'project.%' or action like 'member.%')`
  - user: `actor_id = ? or target_user_id = ?`, keeping only rows a log
    the viewer can open would show (`canSeeRow` in SQL)
- 403 by the access rules above, 404 for a tab the viewer can't see.
- Task Detail gains `canViewLog`, set by the server. Its `tab` has no
  role, as with `canRepeat`.
- Tests:
  - a division lead gets the division log but a 403 on a project log
    unless they're its owner or person-in-charge;
  - a member gets 403 everywhere except on their own user log;
  - a lead's view of a user log drops rows from projects the lead doesn't
    manage;
  - paging with `before`.

### App (Tasko-Flutter)
Same shape as now: a pure `*View`, a thin `*Screen`, and Cubits behind the
`TasksApi` seam. Each ticket is done when `flutter analyze` and
`flutter test` pass.

**B14 — Seam, model and sentences**
- Models: `ActivityEntry {int id, String action, User? actor, String
  actorName, ActivitySubject subject, User? target, TaskTab tab,
  Map<String, dynamic> changes, DateTime createdAt}`, and
  `ActivityScope` (`task(Task)`, `project(TaskTab)`, `division(TaskTab)`,
  `user(User)`). `TaskDetail` gains `canViewLog`.
- `TasksApi.activity(ActivityScope scope, {int? before})` returns
  `(List<ActivityEntry>, int? next)`. Build it in `HttpTasksApi` and
  `FakeTasksApi`. The fake returns a seeded list covering every action,
  and doesn't record its own changes.
- `activity_text.dart`: `sentence(ActivityEntry e, ActivityScope scope)`
  builds the line from `action` and `changes`. In a task log it leaves out
  the task name ("Budi started working"); elsewhere it names it. An
  unknown action falls back to the action name. Unit tests cover every
  action.
- `task_rules.dart`: `canViewDivisionLog(tab)` (same as
  `canCreateProject`) and `canViewProjectLog(tab)` (same as
  `canManageMembers`), with unit tests.

**B15 — The activity screen and its entry points**
- `ActivityScreen(scope)` (full screen, like Members):
  - the header is "activity" plus the scope's name;
  - rows are grouped by day, each showing the actor's avatar, the sentence
    and the time, plus the tab name in the user log;
  - "load more" at the bottom while `next` isn't null;
  - empty state: "No activity yet."
- Tapping a row opens Task Detail when its subject is a task. Tapping a
  name opens that person's user log; a 403 shows as a toast.
- Entry points:
  - `_Toolbar` gains `onActivity`, an `Icons.history` button (tooltip
    "Activity", muted colour) to the left of search. It shows when
    `canViewDivisionLog(tab)` or `canViewProjectLog(tab)` is true.
  - Task Detail's "More" menu gets "activity" when `detail.canViewLog` is
    true. The menu now also shows when that's the only item.
  - The account menu gets "my activity", above "account settings".

### Not in these tickets
- Logs for deleting a task, deciding a deadline request, editing or
  archiving a project, and editing or deleting a comment. Those routes
  don't exist yet; each adds its action when built.
- Filters by action or person inside a log. Add them when leads ask.
- Retention or clean-up of old rows.
- The hifi frame. It needs drawing as H9 before B15 is styled for good.

## What would change my mind
- The write batches make status changes noticeably slower. Then measure
  first; one extra insert per batch shouldn't do it.
- Leads want to open a user log from a list of people, not by tapping a
  name. Then add the members screen to division tabs.

## Open questions
- Can the user log's visibility check be one SQL `exists` per row, or
  will it be slow on a big division? Measure it in A18.

---
Part of [Tasko](../README.md)
