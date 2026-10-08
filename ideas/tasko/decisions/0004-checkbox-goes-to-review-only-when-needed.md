---
title: The task checkbox sends a team task to review only when it needs one; otherwise straight to done
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-06
updated: 2026-10-07
inputs: ["../assets/sqlite-schema.sql", "../hacker/santian-rules-that-change-in-a-team-app.md", "../hipster/santian-screens-in-a-team-app.md", "./0003-calendar-is-a-due-date-heatmap-that-filters.md"]
tags: [artifact, decision]
---

## Decision

What ticking a task's checkbox does depends on what kind of task it is:

| Task | Ticking it sets | And |
|---|---|---|
| Team task that **needs review** | `status = review` | `review_date = now`. If a proof is required and none is attached yet, the user is asked for it first. |
| Team task that does **not** need review | `status = done` | `completed_date = now` |
| Personal task (`private` tab) | `status = done` | `completed_at = now` |

A reviewer then **approves** the task (`done`, `completed_date = now`) or
**rejects** it (back to `in_progress`). Each outcome is a `task_reviews`
row with a `decision` and a `reason`.

**What "needs review" means:** `required_proof_type` is set. The owner
confirmed this on 2026-10-06 for both project and division tasks.

**Who reviews** (also confirmed by the owner, 2026-10-06):

| Task | Reviewer |
|---|---|
| In a project (`project_id` set) | that project's person-in-charge (`project_members.role = 'person-in-charge'`), **and** its author (`projects.creator_id`) |
| In a division only (`project_id` null) | that division's management (`division_members.role_type` in `admin`, `supervisor`) |

Both roles can have more than one member. Any of them can review, and the
first decision wins. That rule is an assumption the owner has not confirmed.

Because the author always counts, **every project has a reviewer**. An
assignee who is also a person-in-charge **may review their own task**
(owner, 2026-10-06).

## Context

On 2026-10-06 the owner gave the `tasks.status` values: `waiting` (the
default), `in_progress`, `review` and `done`. The schema does not enforce
them (see [0001](./0001-adopt-sqlite-schema-over-schema-zero.md) finding 4).
Santian's checkbox flips one boolean. In Tasko it has to choose between
`review` and `done`. There were three options. The owner chose this one in
chat. It stays `draft` until the owner promotes it.

### What follows from it
- **"Open"** means `waiting` or `in_progress`, and `todo` or `in_progress`
  for personal tasks. Only open tasks count in the calendar
  ([0003](./0003-calendar-is-a-due-date-heatmap-that-filters.md)) and only
  open tasks can be overdue. A task in `review` is waiting on the reviewer,
  not on the assignee.
- **The checkbox has three looks:** open (empty circle), in review (a
  pending mark), and done (filled with ✓). `waiting` and `in_progress` look
  the same on the row.
- **The checkbox never sets `in_progress`.** Starting work is a separate
  action, probably in Task Detail.
- **Personal tasks keep Santian's two-state checkbox.** `personal_tasks` has
  no `review`.

## What each lens said

- **Hound:** no user input. This is the owner's choice.
- **Hipster:** most ticks still feel like Google Tasks: tap it and it's
  done. Review appears only on tasks that ask for proof, so the extra state
  is not on every row.
- **Hacker:** no new columns, as long as the trigger is
  `required_proof_type`. A separate "needs review" flag would need one.
- **Hustler:** not consulted.

## Options rejected

- **Always `review`.** Rejected. Every task would need a reviewer, which
  goes far from Google Tasks.
- **Always `done`, with review as a separate optional step.** Rejected.
  `review_date` and `task_reviews` would be hard to reach from the main
  flow.

## How we will know we were wrong

Reviewers want to check tasks that have no proof attached. Or assignees
skip review by clearing `required_proof_type`. Either means review needs
its own flag.

## Open questions

- ~~Is `required_proof_type` the right trigger?~~ Yes, confirmed.
- ~~Who reviews?~~ Confirmed, see the table above.
- ~~Self-review?~~ Allowed for a person-in-charge. Not yet confirmed for
  a division admin or supervisor reviewing their own division task.
- ~~No reviewer?~~ Cannot happen: the project's author always reviews.
- ~~Unticking?~~ `done` goes back to `waiting`. Withdrawing from `review`
  is not in v1. See [0005](./0005-v1-build-defaults.md).
- ~~How is a task cancelled?~~ Not in v1 ([0005](./0005-v1-build-defaults.md)).

---
Part of [Tasko](../README.md)
