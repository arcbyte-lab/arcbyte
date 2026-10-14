---
title: Tasko API, as built — Hono on Cloudflare Workers with D1, deployed, 27 routes
idea: tasko
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-09
updated: 2026-10-14
inputs: ["../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0004-checkbox-goes-to-review-only-when-needed.md", "../decisions/0005-v1-build-defaults.md", "../decisions/0007-server-rules-settled-in-the-api-review.md", "./flutter-app-as-built.md", "../decisions/0010-adding-a-project-member-needs-no-invitation.md", "./project-and-member-build-tickets.md"]
tags: [artifact]
---

## Question
What does the code in
[Tasko-API](https://github.com/arcbyte-lab/Tasko-API) do today, and what
does the app have to change to use it?

## Short answer
- Every route the app's fake API stands in for is built, tested (130
  tests) and deployed at `https://tasko-api.vidtandjung.workers.dev`.
  The live database holds the seed test data (12 users, 4 divisions,
  password `password`), not real users.
- Since 2026-10-14 it also creates projects and manages their members
  ([0010](../decisions/0010-adding-a-project-member-needs-no-invitation.md)):
  A9–A12, merged and deployed.
- It is Hono on Cloudflare Workers with D1 (SQLite), not the Laravel app
  that [0005](../decisions/0005-v1-build-defaults.md) assumed. The tables
  are copied from `sqlite-schema.sql`.
- The app needs four changes before it can switch from `FakeTasksApi`:
  send `proofUrl` when ticking a proof task, read `priority` as 1–4,
  read `mustChangePassword`, and say "rejected", not "declined".

## Detail
Built as tickets A0–A8 (PRs #9–#17), merged into `master` on
2026-10-09. A9–A12 (PRs #25–#28) were merged and deployed on 2026-10-14
(version `af0dc712`), from the
[project and member tickets](./project-and-member-build-tickets.md).

| Area | Routes |
|---|---|
| Health and auth | `GET /` (public), `POST /auth/login`, `POST /auth/logout`, `GET /me` |
| Tabs (A2, A10) | `GET /tabs` (each tab carries the viewer's `role`), `GET /tabs/:kind/:id/tasks`, `GET /tabs/:kind/:id/members` |
| Create and edit (A4) | `POST /tabs/:kind/:id/tasks`, `PATCH /tasks/:id`, `PATCH /personal-tasks/:id`, `POST /tasks/:id/subtasks`, `POST /personal-tasks/:id/subtasks` |
| Checkbox (A3, A8) | `PATCH /tasks/:id/status`, `PATCH /personal-tasks/:id/status` |
| Task Detail (A5) | `GET /tasks/:id/detail`, `GET /personal-tasks/:id/detail`, `POST /tasks/:id/comments` |
| Review (A6) | `POST /tasks/:id/reviews`, `POST /tasks/:id/deadline-requests` |
| Notifications (A7) | `GET /notifications`, `POST /notifications/:id/read`, `POST /notifications/read-all` |
| Users (A10) | `GET /users?q=`: up to 20 active users, for the member picker |
| Projects (A11, A12) | `POST /projects`, `POST /projects/:id/members`, `PATCH /projects/:id/members/:userId`, `DELETE /projects/:id/members/:userId` |

How it works:
- **Login:** bearer tokens, stored as SHA-256 in `personal_access_tokens`;
  they expire after 30 days. Passwords are PBKDF2-SHA256.
- **Rules:** the server enforces the rules from
  [0002](../decisions/0002-tabs-are-workspaces-then-projects.md) (membership
  comes only from the member tables),
  [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md)
  (the checkbox never sets `in_progress`; review needs a proof),
  [0008](../decisions/0008-start-working-moves-a-task-to-in-progress.md)
  ("start working" moves `waiting`/`todo` to `in_progress`),
  [0005](../decisions/0005-v1-build-defaults.md) (the status check
  constraint; the first review decision wins) and
  [0010](../decisions/0010-adding-a-project-member-needs-no-invitation.md)
  (division leads create projects; owners and persons-in-charge manage
  members; a project keeps an owner; a removed member's open tasks lose
  their assignee).
- **Choices made in review:** the rules decided during the code review are
  in [0007](../decisions/0007-server-rules-settled-in-the-api-review.md).
- **Repeat** ([0009](../decisions/0009-workspace-tasks-repeat-on-completion.md)):
  a task carries `repeat` (`{every, unit, weekdays, until, count}` or
  null). It is set by create or `PATCH /tasks/:id`, for workspace tasks
  with a due date only. When the task reaches `done` (ticked or approved),
  the server creates the next task and moves the rule onto it. The date
  maths is in `src/repeat.ts`.
- **Schema:** three migrations: `0001_init` (12 tables), `0002_proofs`
  and `0003_repeat` (`tasks.repeat`).
  `attachments`, `recurring_tasks` and the activity tables are not copied,
  because no route reads them.
- **Notifications** are best-effort. They are written after the change,
  and a failed write is logged, not returned as an error.

What the app must change. Done in
[Tasko-Flutter PR #1](https://github.com/arcbyte-lab/Tasko-Flutter/pull/1),
see the [app as built](./flutter-app-as-built.md):
- **Proof:** ticking a task that needs proof sends
  `{status: 'review', proofUrl}` instead of throwing `ProofRequired`.
  Task Detail returns the latest `proof`.
- **Priority:** `priority` is the number 1–4. `Priority.fromLevel` already
  expects that.
- **Login:** the login and `/me` responses carry `mustChangePassword`. The
  server doesn't enforce it yet, because there is no change-password route.

Getting real users in: `scripts/users-sql.ts` turns a `users.json` into
`insert` SQL, with hashed passwords and `must_change_password = 1`. Since
A9 it also takes `{divisions, users}` and creates divisions and division
memberships. Projects and their members are made in the app. Running the
same file twice fails on the first user who already exists.

## What would change my mind
Not required for hacker notes.

## Open questions
- When do real users replace the seed test data in the live database?
- A change-password route, so `must_change_password` can be enforced.
- Due-soon, reminder and overdue notifications need a cron job. Not built.

---
Part of [Tasko](../README.md)
