---
title: v1 build defaults — Flutter + Cubit client, online only, and the open task rules closed the simple way
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-07
inputs: ["./0004-checkbox-goes-to-review-only-when-needed.md", "../hacker/santian-concepts-mapped-to-tasko-schema.md", "../hacker/santian-rules-that-change-in-a-team-app.md", "../../santian/hacker/tasks-architecture-as-built.md"]
tags: [artifact, decision]
---

## Decision
The Tasko mobile app is a **new Flutter build, with Cubits the way Santian
does it**. For v1, every open question that blocked the build tickets is
closed with the simplest option:

| Question | v1 answer |
|---|---|
| Stack | Flutter, `flutter_bloc` (Cubit only). Same folder and screen pattern as [Santian](../../santian/hacker/tasks-architecture-as-built.md). |
| Server | The Laravel app behind `sqlite-schema.sql`, reached over HTTP with a Sanctum token. Until its API is known, the app runs on an in-memory fake API with seeded data. |
| Offline | Online only. No local database, no sync. |
| Unticking `done` | Goes back to `waiting`, and clears `completed_date`. |
| Withdrawing from `review` | Not in v1. Only a reviewer can move it, by approving or rejecting. |
| Cancelling | Not in v1. `cancelled_date` is left alone. |
| `tasks.status` values | `waiting`, `in_progress`, `review`, `done`. The server should enforce them with a check constraint. That is server work, not an app ticket. |
| Two reviewers at once | The first decision wins. The server enforces it. |
| Star | Cut. |
| Personal reminder | Cut. Only the server's due-soon, reminder and overdue notifications remain. |
| Repeat on a single task | Cut. Each occurrence that `recurring_tasks` creates is just a Task. There is no Repeat UI in v1. |
| Subtask reordering | Cut. Subtasks sort by `created_at`. |
| Delete | Hard delete, after a confirm dialog. No undo. |

## Context
On 2026-10-07 the owner was asked these questions before the build tickets
were written. The owner answered "new build, flutter + bloc/cubit like
santian; take your defaults". The defaults were the ones offered in chat,
and this note writes them down. It stays `draft` until the owner promotes
it.

## What each lens said
- **Hound:** no user input.
- **Hipster:** the home screen and checkbox keep the Google Tasks feel.
  Star and the Repeat dialog disappear from the mockups' Task Detail for
  now.
- **Hacker:** no new tables or columns are needed. The fake API lets the
  app be built and tested before the server API exists.
- **Hustler:** not consulted.

## Options rejected
- **Soft delete with undo** (`tasks.deleted_at`). It needs a new column and
  server work. It can come back later.
- **A local database with sync.** That is a whole sync design, for a
  feature nobody has asked for.
- **Star and reminder tables now.** They are per-user tables that no
  screen in v1 needs.

## How we will know we were wrong
Someone deletes a task by accident and loses its proofs. Or users miss the
star or a personal reminder. Or the app has to be used where there is no
network.

---
Part of [Tasko](../README.md)
