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
inputs: ["../assets/sqlite-schema.sql", "../decisions/0001-adopt-sqlite-schema-over-schema-zero.md", "../../santian/hacker/tasks-data-model-as-built.md", "../../santian/hacker/tasks-behaviour-rules-as-built.md"]
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
- **No home yet:** List (the tab), star, the personal reminder, and a
  repeat on a single Task. Star and reminder are **per user** in a team
  app, so they need their own tables, not columns on `tasks`.
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
| **List** (a tab) | `projects` (user is in `project_members`), `divisions`, or nothing | ❓ | Pick one. See open questions. A new `task_lists` table only makes sense if Lists stay personal. |
| Task `title` | `tasks.name` | ✅ | Rename only. |
| `description` | `tasks.description` | ✅ | — |
| `deadline` (date only) | `tasks.due_date` (datetime) | ✅ mostly | Tasko stores a time. Santian's "overdue = calendar day before today" only holds if the time is ignored, or set to end of day. |
| `reminderAt` | none. `reminder_notified_at` looks like a server flag for a reminder *derived from* `due_date` (guess) | ❌ | Per-user `task_reminders(user_id, task_id, remind_at)`, or drop personal reminders and keep only the server's due-soon reminder. |
| `repeat` | `recurring_tasks` (`frequency`, `schedule_day(s)`, `due_time`, `next_run_at`, `Active/Paused`) → `tasks.recurring_task_id` | ⚠️ different model | See the rules note. Santian's Repeat dialog would edit a `recurring_tasks` row, not a field on the Task. |
| `isStarred` | none | ❌ | `task_stars(user_id, task_id)`, unique on the pair. Not a `tasks` column: one person's star must not show up for the assignee. |
| `isCompleted` | `tasks.status` (default `waiting`, **no check constraint**, values unknown) + `completed_date`, `review_date`, `cancelled_date` | ⚠️ | Pick which status means "checked". A required proof or a review can stand between "tick" and "done". |
| Subtask | `tasks.parent_id` (a full Task: own status, assignee, due date; cascades on delete) | ⚠️ richer | Santian's subtask is title + done + order only. Tasko has **no `position` on `tasks`**, so subtask drag-to-reorder needs one. |
| Subtask `order` | none on `tasks`. `personal_tasks.position` exists | ❌ for team tasks | Add `tasks.position`, or drop reordering. |
| Task order (by reminder, then id) | `due_date` and `created_at` available | ✅ | Sort by `due_date`. That also settles Santian's open question about grouping by deadline. |
| Completed sort | `completed_date` | ✅ better | Most recently completed first becomes possible. |
| Delete + undo | hard delete. Cascades proofs, attachments, comments, reviews, subtasks, dependencies | ⚠️ | Undo by re-inserting cannot bring the cascaded rows back. See the rules note. |
| First-launch "My Tasks" | `personal_tasks` (per user: title, note, `todo/in_progress/done`, priority, due_date, parent_id, position) | ❓ | Could be the user's own List tab. Guess, see open questions. |
| — (not in Santian) | `assignee_id`, `priority_level`, `code`, `project_id`, `required_proof_type`, comments, attachments, dependencies, deadline requests | ➕ | New UI. See [hipster note](../hipster/santian-screens-in-a-team-app.md). |

### Required on create, which Santian never asks for
`tasks.code` (unique), `division_id`, and `creator_id` are `not null`.
Santian's Create Task only asks for a title. The server has to fill these
in: division from the active tab's project, creator from the session, and
`code` generated (probably `divisions.prefix` + a number; guess).

### Two task tables
`tasks` (team) and `personal_tasks` (one user) overlap heavily. If the whole
UX is Santian's, they will be shown side by side, maybe as tabs. Every rule
then has to work on both, or one table has to be folded into the other.
That is a decision, not something this note can settle.

## What would change my mind
- Tasko's code or API already exposes stars, reminders or Lists in some
  form this schema dump does not show.

## Open questions
- **What is a List tab in Tasko?** A project, a division, the user's
  `personal_tasks`, or a saved filter ("Assigned to me")? Every screen
  depends on this answer.
- Which `tasks.status` values exist, and which one does the checkbox set?
- Does `reminder_notified_at` mean a personal reminder exists somewhere, or
  only a server-derived "due soon" reminder?
- Keep `personal_tasks` separate, or merge it into `tasks`?

---
Part of [Tasko](../README.md)
