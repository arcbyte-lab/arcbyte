---
title: Repeating view build tickets — leads list, follow, change, create, stop and delete repeating tasks
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-19
updated: 2026-10-19
inputs: ["../decisions/0012-division-leads-run-repeats-from-a-repeating-view.md", "../decisions/0009-workspace-tasks-repeat-on-completion.md", "./tasko-api-as-built.md", "./flutter-app-as-built.md", "./project-and-member-build-tickets.md"]
tags: [artifact]
---

## Question
What are the build tickets, for the API and for the app, for the division
leads' "repeating" view in
[0012](../decisions/0012-division-leads-run-repeats-from-a-repeating-view.md)?

## Short answer
- 3 API tickets (**A13–A15**) and 3 app tickets (**B11–B13**). Do them in
  order. A13 adds `series_id` and the lead-only rule. Everything else
  depends on it.
- No scheduled job and no new table. One column, `tasks.series_id`, plus
  three routes: list the series, list one series' history, and delete.
- The icon is `repeat` (`Icons.repeat`), placed left of search in the
  pinned toolbar. It shows on division tabs where the viewer is a lead.

## Detail
Not built yet. Issues: API [#29](https://github.com/arcbyte-lab/Tasko-API/issues/29)–[#31](https://github.com/arcbyte-lab/Tasko-API/issues/31)
(A13–A15), app [#14](https://github.com/arcbyte-lab/Tasko-Flutter/issues/14)–[#16](https://github.com/arcbyte-lab/Tasko-Flutter/issues/16)
(B11–B13), opened 2026-10-19. API PRs, stacked in order:
[#32](https://github.com/arcbyte-lab/Tasko-API/pull/32),
[#33](https://github.com/arcbyte-lab/Tasko-API/pull/33),
[#34](https://github.com/arcbyte-lab/Tasko-API/pull/34); 140 tests pass.
App PRs, stacked in order:
[#17](https://github.com/arcbyte-lab/Tasko-Flutter/pull/17),
[#18](https://github.com/arcbyte-lab/Tasko-Flutter/pull/18),
[#19](https://github.com/arcbyte-lab/Tasko-Flutter/pull/19); 119 tests pass.
**The API is merged and deployed** (2026-10-19, version `306ffe54`,
migration `0004_series` applied): checked live, Ana gets the list, Mira
gets 403. The app PRs are merged into `main` (119 tests pass). The phone
walkthrough passes all 24 steps on a Xiaomi phone against a local API,
including three new repeating steps
([#20](https://github.com/arcbyte-lab/Tasko-Flutter/pull/20), merged).

**Ended repeats stay** ([0013](../decisions/0013-ended-repeats-stay-until-deleted.md)):
API [#35](https://github.com/arcbyte-lab/Tasko-API/pull/35) (143 tests,
migration `0005_repeat_ended`) and app
[#21](https://github.com/arcbyte-lab/Tasko-Flutter/pull/21) (121 tests),
both merged; the API is deployed (version `fbdbbbc1`, migration applied).

Changes from the tickets, made while building:
- Task Detail gains `canRepeat`, set by the server (in #34). Its `tab`
  has no role, so the app can't tell a lead from a member there.
- The app sends `repeat` with every edit, so only a **changed** rule
  needs a lead; members can still edit their repeating tasks.
- `RepeatingSeries.recent` is a list of on-time flags, not occurrences.
- The fake API now repeats tasks as the server does.

### Rules
| Rule | Value |
|---|---|
| Who is a lead | An `admin` or `supervisor` of the task's division. For a workspace task these are exactly its reviewers, so `isReviewer` is the check. |
| Who sets, changes or removes `repeat` | Leads only. 403 for everyone else, both on create and on `PATCH /tasks/:id`. |
| Who ticks a repeating task | No change (0004): the assignee ticks, and a reviewer approves when a proof is needed |
| Series | `series_id` = the first task's id. Set when a task first gets a rule. Copied to every next task. Kept when the rule is removed, so turning it back on continues the same series. |
| A live series | A series whose open task has `repeat is not null` |
| On time | Finished at `coalesce(review_date, completed_date)` ≤ `due_date`. A task that needed a proof counts from when it was sent for review, not when it was approved. |
| Delete | Removes the rule and deletes the open task, only if it is `waiting`. Otherwise 409 "Already started — stop repeating instead". Finished occurrences stay. |

The server enforces every rule. The app only hides what a user can't use.

### API (tasko-api)
Same shape as today: Hono routers, `HTTPException` with a plain message,
tests in `test/` using `login()` and `api()`. Each ticket is done when
`npm test` passes and the change is deployed.

**A13 — `series_id` and lead-only repeat**
- Migration `0004_series.sql`:
  `alter table tasks add column series_id integer;`
  `update tasks set series_id = id where repeat is not null;`
- Add `series_id` to `TEAM_TASK_COLUMNS` (null for personal tasks) and
  `seriesId` to the task JSON.
- Create with `repeat`: 403 unless the viewer is a lead of the division.
  After the insert, `update tasks set series_id = id where id = ?`, in the
  same batch.
- `PATCH /tasks/:id` with `repeat` in the body: 403 unless `isReviewer`.
  When the rule is turned on, `series_id = coalesce(series_id, id)`.
- `createNextOccurrence` copies `coalesce(series_id, id)` into the new task.
- Tests: an assignee or creator who isn't a lead gets 403 on create and on
  patch. The next task has the same `seriesId`. Off then on again keeps it.

**A14 — `GET /divisions/:id/repeating` and `GET /series/:id`**
- Both: 403 unless the viewer is a lead of that division (or of the
  series' division).
- `GET /divisions/:id/repeating`: one row per live series, ordered by next
  due date:
  `{task, recent: [{dueDate, finishedAt, onTime}]}`. `task` is the
  open task in the usual shape; its `repeat` is the rule. `recent` is the
  last 5 finished occurrences, newest first.
- `GET /series/:id`: every occurrence, newest first:
  `{task, finishedAt, onTime, proofUrl}`. `proofUrl` is the latest proof's
  link, or null. `onTime` is null while a task is open.
- Tests: the 403s, an ended series disappears from the list, history
  order, on time against late, and a proof task counted from `review_date`.

**A15 — `DELETE /series/:id`**
- 403 unless a lead. Deletes the open task if it is `waiting`; the rule
  lives on that row, so it goes with it. 409 if the open task has been
  started. Returns 204.
- "Stop repeating" needs no new route. It is
  `PATCH /tasks/:id {repeat: null}`, now lead-only (A13).
- Tests: delete of a `waiting` task, 409 on `in_progress` and `review`,
  done occurrences are still there afterwards.

### App (Tasko-Flutter)
Same shape as now: a pure `*View`, a thin `*Screen` or `*Sheet`, and
Cubits behind the `TasksApi` seam. Each ticket is done when
`flutter analyze` and `flutter test` pass.

**B11 — Seam, models and rules**
- `Task` gains `final int? seriesId`.
- New models: `RepeatingSeries {Task task, List<Occurrence> recent}` and
  `Occurrence {Task task, DateTime? finishedAt, bool? onTime, String?
  proofUrl}`.
- `TasksApi` gains `repeatingFor(TaskTab division)`,
  `seriesHistory(int seriesId)` and `deleteSeries(int seriesId)`. Build them
  in `HttpTasksApi` and `FakeTasksApi`. The fake enforces the lead and
  `waiting` rules.
- `task_rules.dart`: `canManageRepeats(TaskTab tab)` (a division tab with
  role admin or supervisor), with unit tests. Task Detail shows the repeat
  row as editable only when this passes. Others see it read-only.

**B12 — Toolbar icon and the repeating view**
- `_Toolbar` in `home_view.dart` gains `onRepeating`. The `IconButton`
  (`Icons.repeat`, tooltip "Repeating", muted colour) sits between members
  and search. It is shown only when `canManageRepeats(tab)`.
- `RepeatingScreen` (full screen, like Members): header "repeating" plus a
  "+" text button. Rows show name, `repeatSummary(rule)`, next due,
  assignee avatar, and up to 5 dots for `recent` (on time in the primary
  colour, late in the overdue colour). Empty state: "No repeating tasks
  yet."
- "+" opens the create sheet for this division with the repeat chip
  showing (B13).
- Closing the screen refreshes the tab in `HomeCubit`, as Members does.

**B13 — Series history, its actions, and the create sheet's repeat chip**
- Tapping a row opens `SeriesScreen`: the rule summary at the top, then the
  occurrences from `seriesHistory`. Each row shows due date, assignee,
  status, an "on time" or "late" label, and a link icon when there is a
  proof. Tapping one opens the existing Task Detail sheet.
- Its menu: **edit repeat** (pushes the existing `RepeatScreen` and saves
  with `updateTask`), **stop repeating** (`repeat: null`), and **delete**.
  Delete asks for confirmation first. A 409 shows as a toast, as other
  server errors do.
- Create sheet: a **repeat** chip, shown when `canManageRepeats(tab)`. It
  pushes `RepeatScreen`. While a rule is set, the due-date chip is required
  and "create" stays disabled without one.

### Not in these tickets
- Ended series in the list, and stats beyond the last 5 occurrences.
  Add them when leads ask for them.
- Hiding a task until it's near its due date (rejected in 0012).
- The hifi frames. They are drawn as
  [H8](../hipster/hifi-mockup-tickets-for-pen-dev.md) (2026-10-19).

## What would change my mind
- Leads ask "who missed it" rather than "who was late". With no catch-up,
  a skipped week leaves no row, so "missed" would need a schedule.
- The list is slow on a big division. Then add an index on
  `tasks(series_id)`.

## Open questions
- Should members see the repeat rule on their task read-only, or not at
  all? B11 shows it read-only.

---
Part of [Tasko](../README.md)
