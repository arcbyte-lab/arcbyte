---
title: Santian's task concepts mapped onto Tasko's schema — what fits, what has no column
idea: tasko
lens: hacker
kind: analysis
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-06
updated: 2026-10-06
inputs: ["../assets/sqlite-schema.sql", "../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0001-adopt-sqlite-schema-over-schema-zero.md", "../../santian/hacker/tasks-data-model-as-built.md", "../../santian/hacker/tasks-behaviour-rules-as-built.md"]
tags: [artifact]
---

## Question
The owner wants Santian's Google-Tasks-style behaviour to become Tasko's
whole task UX, team tasks included. Which Santian concepts already have a
home in [Tasko's schema](../assets/sqlite-schema.sql), and which need new
columns or tables?

## Short answer
- **These fit directly:** title → `name`, description, deadline →
  `due_date`, subtasks → `parent_id`, completion → `status` plus
  `completed_date`. Tasko also has the timestamps Santian lacks.
- **List is settled:** a tab is `private` (`personal_tasks`), a division, or
  a project ([0002](../decisions/0002-tabs-are-workspaces-then-projects.md)).
  **Still no home:** star, the personal reminder, and a repeat on a single
  Task. Star and reminder are per user, so they need their own tables, not
  columns on `tasks`. The wireframe has no Star tab.
- **Same idea, different shape:** repeat. Tasko uses `recurring_tasks`, a
  template that creates new Task rows. Santian moves one row forward when
  it is completed. See
  [the rules note](./santian-rules-that-change-in-a-team-app.md).

## Detail

Evidence is `weak`. The Tasko side comes from the schema file only: no
code, no API, and no notes on how columns are used. Anything about intent
below is a guess, and is marked as one.

### Concept by concept
| Santian | Tasko today | Fit | What it would take |
|---|---|---|---|
| **List** (a tab) | `private` → `personal_tasks`; a division → `tasks` with no project; a project → `tasks` in it | ✅ | Decided in [0002](../decisions/0002-tabs-are-workspaces-then-projects.md). No new table. |
| Task `title` | `tasks.name` | ✅ | Rename only. |
| `description` | `tasks.description` | ✅ | — |
| `deadline` (date only) | `tasks.due_date` (datetime) | ✅ mostly | Tasko stores a time. Santian's "overdue = calendar day before today" only holds if the time is ignored, or set to end of day. |
| `reminderAt` | none. `reminder_notified_at` looks like a server flag for a reminder *derived from* `due_date` (guess) | ❌ | Per-user `task_reminders(user_id, task_id, remind_at)`, or drop personal reminders and keep only the server's due-soon reminder. |
| `repeat` | `recurring_tasks` (`frequency`, `schedule_day(s)`, `due_time`, `next_run_at`, `Active/Paused`) → `tasks.recurring_task_id` | ⚠️ different model | See the rules note. Santian's Repeat dialog would edit a `recurring_tasks` row, not a field on the Task. |
| `isStarred` | none | ❓ | The wireframe has no Star tab. If stars stay at all, use `task_stars(user_id, task_id)`, unique on the pair, not a `tasks` column. |
| `isCompleted` | `tasks.status` (default `waiting`, **no check constraint**, values unknown) + `completed_date`, `review_date`, `cancelled_date` | ⚠️ | Pick which status means "checked". A required proof or a review can stand between "tick" and "done". |
| Subtask | `tasks.parent_id` (a full Task: own status, assignee, due date; cascades on delete) | ⚠️ richer | Santian's subtask is title + done + order only. Tasko has **no `position` on `tasks`**, so subtask drag-to-reorder needs one. |
| Subtask `order` | none on `tasks`. `personal_tasks.position` exists | ❌ for team tasks | Add `tasks.position`, or drop reordering. |
| Task order (by reminder, then id) | `due_date` and `created_at` available | ✅ | Sort by `due_date`. That also settles Santian's open question about grouping by deadline. |
| Completed sort | `completed_date` | ✅ better | Most recently completed first becomes possible. |
| Delete + undo | hard delete. Cascades proofs, attachments, comments, reviews, subtasks, dependencies | ⚠️ | Undo by re-inserting cannot bring the cascaded rows back. See the rules note. |
| First-launch "My Tasks" | the `private` tab, which is `personal_tasks` | ✅ | Always there, so no default to create. Its status is `todo/in_progress/done`, three values, not a boolean. |
| — (not in Santian) | `assignee_id`, `priority_level`, `code`, `project_id`, `required_proof_type`, comments, attachments, dependencies, deadline requests | ➕ | New UI. See [hipster note](../hipster/santian-screens-in-a-team-app.md). |

### Required on create, which Santian never asks for
`tasks.code` (unique), `division_id`, and `creator_id` are `not null`.
Santian's Create Task only asks for a title. The server has to fill these
in: division from the active tab's project, creator from the session, and
`code` generated (probably `divisions.prefix` + a number; guess).

### Two task tables
`tasks` (team) and `personal_tasks` (one user) both stay. `private` shows
one and every other tab shows the other ([0002](../decisions/0002-tabs-are-workspaces-then-projects.md)).
Every shared rule (ordering, overdue, calendar counts) therefore has to work
on both. Their fields differ: `name`/`title`, `description`/`note`,
`completed_date`/`completed_at`, and only `personal_tasks` has `position`.

## What would change my mind
- Tasko's code or API already exposes stars, reminders or Lists in some
  form this schema dump does not show.

## Open questions
- Which `tasks.status` values exist, and which one does the checkbox set?
- Does `reminder_notified_at` mean a personal reminder exists somewhere, or
  only a server-derived "due soon" reminder?
- Does the star survive without a Star tab?

---
Part of [Tasko](../README.md)
