---
title: Santian's behaviour rules that change once tasks are shared, reviewed, and server-side
idea: tasko
lens: hacker
kind: analysis
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../santian/hacker/tasks-behaviour-rules-as-built.md", "../../santian/hacker/notifications-as-built.md", "../assets/sqlite-schema.sql", "./santian-concepts-mapped-to-tasko-schema.md"]
tags: [artifact]
---

## Question
Which of [Santian's behaviour rules](../../santian/hacker/tasks-behaviour-rules-as-built.md)
carry over to Tasko unchanged, and which break because Tasko is a
multi-user, server-backed app with reviews and proofs?

## Short answer
- **Carry over as-is:** ordering, day grouping, date text, the overdue
  rule, trimming and blank rules, save on blur, subtasks independent of
  their parent.
- **Break:** completing (status, proof, review), repeat (template creates
  new rows instead of moving one row forward), delete with undo (cascades),
  notifications (server, not on the device), and List options (team
  permissions).
- **New in Tasko:** permissions. Santian has one user who can do anything.

## Detail

Tasko intent below is read from the schema only (`evidence: weak`).

### Carry over unchanged
| Rule | Note |
|---|---|
| Order by date, empty last, ties by id | Use `due_date` instead of `reminderAt`. |
| Day headers Past / Today / Tomorrow / date / No date | Group on `due_date`. |
| Short date and relative day text | Pure formatting. |
| Overdue = not done and calendar day before today | Ignore the time part of `due_date`, or the rule shifts during the day. |
| Title and name trimmed, never blank; description blank → null | — |
| Edits save at once, text fields on blur | Needs network handling. Santian writes to the device and never fails. |
| Subtask completion independent of its parent | Tasko subtasks are full Tasks, so this holds naturally. |

### Completing a Task
Santian flips one boolean. Tasko has `status` (values unknown, default
`waiting`), `required_proof_type` plus `proofs`, and `task_reviews` plus
`review_date`. A guess at the flow:

1. Checkbox tapped. If a proof is required and none exists, ask for one
   before anything else.
2. Status moves to a "submitted for review" value if the Task is reviewed,
   otherwise straight to done. Set `completed_date`.
3. A reviewer approves or rejects. If rejected, the Task becomes open again.

So the row's checkbox needs at least **three looks**: open, waiting for
review, and done. Santian has two. Un-completing is probably not free
either: who is allowed to reopen a reviewed Task?

### Repeat
| | Santian | Tasko (from schema) |
|---|---|---|
| Where it lives | `repeat` embedded in the Task | `recurring_tasks` template, `Active/Paused` |
| What moves time forward | **the user completing it**, one step, no catch-up | **a schedule** (`next_run_at`, `last_run_at`), probably a server job (guess) |
| Result | the same row, new dates | a **new** `tasks` row per run, linked by `recurring_task_id` |
| Assignee | — | fixed on the template (`assignee_id not null`) |

So "tick a repeating Task and it jumps to next week" does not exist in
Tasko. Either the UI shows each occurrence as its own Task, or Tasko adds a
"create the next one on completion" mode. That decision belongs to the owner.

### Delete with undo
Santian deletes, then writes the copy held in memory back on Undo. In Tasko,
deleting a Task cascades its proofs, attachments, comments, reviews,
subtasks and dependencies, and writes to `activity_logs`. Re-inserting the
row would bring back none of those. Options:
- **Delay the delete:** hide the Task while the snackbar is up, and send
  the delete only when it expires. Simplest, but the Task may still
  briefly appear on other devices.
- **Soft delete:** add `tasks.deleted_at`, the same pattern `comments`
  already uses.

### List options
- Rename List → rename project. Needs owner or person-in-charge role.
- Delete List → `tasks.project_id` is `on delete set null`, so the Tasks
  would survive without a project. Tasko already has `projects.status =
  archived`. "Archive" fits better than delete.
- Delete all completed → bulk-deleting team Tasks is risky. Hiding
  completed Tasks is safer.

### Notifications
Santian schedules local notifications on the device. Tasko has a Laravel
`notifications` table, plus `due_soon_notified_at`, `reminder_notified_at`
and `overdue_notified_at` on `tasks`. That looks like server-sent
notifications, sent once per kind. There is no device-token table, so
mobile push is not designed yet. Santian's tap-to-open rule (payload =
task id) still applies.

### Offline
Santian works fully offline with Isar. Tasko's source of truth is the
server (`personal_access_tokens` suggests Sanctum API tokens). Offline
support would need a sync design that does not exist.

## What would change my mind
- Tasko's actual code does completion or recurrence differently from what
  the schema suggests.

## Open questions
- Which status values exist, and which transitions can the checkbox
  trigger?
- Repeat: show each occurrence as its own Task, or add "next one on
  completion"?
- Undo: delay the delete, or add soft delete?
- Offline: required, or online-only is fine?

---
Part of [Tasko](../README.md)
