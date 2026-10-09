---
title: Tasko API, as built — Hono on Cloudflare Workers with D1, deployed, 22 routes
idea: tasko
lens: hacker
kind: architecture
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-09
updated: 2026-10-09
inputs: ["../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0004-checkbox-goes-to-review-only-when-needed.md", "../decisions/0005-v1-build-defaults.md", "../decisions/0007-server-rules-settled-in-the-api-review.md", "./flutter-app-as-built.md"]
tags: [artifact]
---

## Question
What does the code in
[Tasko-API](https://github.com/arcbyte-lab/Tasko-API) do today, and what
does the app have to change to use it?

## Short answer
- Every route the app's fake API stands in for is built, tested (94
  tests) and deployed at `https://tasko-api.vidtandjung.workers.dev`.
  The live database has the tables but **no users yet**.
- It is Hono on Cloudflare Workers with D1 (SQLite), not the Laravel app
  that [0005](../decisions/0005-v1-build-defaults.md) assumed. The tables
  are copied from `sqlite-schema.sql`.
- The app needs four changes before it can switch from `FakeTasksApi`:
  send `proofUrl` when ticking a proof task, read `priority` as 1–4,
  read `mustChangePassword`, and say "rejected", not "declined".

## Detail
Built as tickets A0–A8 (PRs #9–#17), all merged into `master` on
2026-10-09.

| Area | Routes |
|---|---|
| Health and auth | `GET /` (public), `POST /auth/login`, `POST /auth/logout`, `GET /me` |
| Tabs (A2) | `GET /tabs`, `GET /tabs/:kind/:id/tasks`, `GET /tabs/:kind/:id/members` |
| Create and edit (A4) | `POST /tabs/:kind/:id/tasks`, `PATCH /tasks/:id`, `PATCH /personal-tasks/:id`, `POST /tasks/:id/subtasks`, `POST /personal-tasks/:id/subtasks` |
| Checkbox (A3, A8) | `PATCH /tasks/:id/status`, `PATCH /personal-tasks/:id/status` |
| Task Detail (A5) | `GET /tasks/:id/detail`, `GET /personal-tasks/:id/detail`, `POST /tasks/:id/comments` |
| Review (A6) | `POST /tasks/:id/reviews`, `POST /tasks/:id/deadline-requests` |
| Notifications (A7) | `GET /notifications`, `POST /notifications/:id/read`, `POST /notifications/read-all` |

How it works:
- **Login:** bearer tokens, stored as SHA-256 in `personal_access_tokens`;
  they expire after 30 days. Passwords are PBKDF2-SHA256.
- **Rules:** the server enforces the rules from
  [0002](../decisions/0002-tabs-are-workspaces-then-projects.md) (membership
  comes only from the member tables),
  [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md)
  (the checkbox never sets `in_progress`; review needs a proof),
  [0008](../decisions/0008-start-working-moves-a-task-to-in-progress.md)
  ("start working" moves `waiting`/`todo` to `in_progress`) and
  [0005](../decisions/0005-v1-build-defaults.md) (the status check
  constraint; the first review decision wins).
- **Choices made in review:** the rules decided during the code review are
  in [0007](../decisions/0007-server-rules-settled-in-the-api-review.md).
- **Schema:** two migrations: `0001_init` (12 tables) and `0002_proofs`.
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
`insert` SQL, with hashed passwords and `must_change_password = 1`. It does
not create divisions, projects or memberships yet, so a new user sees only
the private tab.

## What would change my mind
Not required for hacker notes.

## Open questions
- Who creates divisions, projects and memberships in the live database, and
  how? Nothing does it yet.
- A change-password route, so `must_change_password` can be enforced.
- Due-soon, reminder and overdue notifications need a cron job. Not built.

---
Part of [Tasko](../README.md)
