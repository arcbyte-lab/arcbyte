---
title: Adopt sqlite-schema.sql over schema-zero
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-05
updated: 2026-10-06
inputs: ["../assets/sqlite-schema-zero.sql", "../assets/sqlite-schema.sql"]
tags: [artifact, decision]
---

## Decision

[sqlite-schema.sql](../assets/sqlite-schema.sql) is the current schema.
[sqlite-schema-zero.sql](../assets/sqlite-schema-zero.sql) is the earlier
version, kept for comparison only.

## Context

The owner said the newer file is the latest decision. This note lists every
difference between the two files, plus the things that look unfinished. The
differences come straight from the files. The reasons behind them are my
guesses. The `evidence: weak` label is for those guesses.

## What changed

**Seven tables dropped**, with their indexes:

- `task_assignees` and `recurring_task_assignees`: replaced by a single
  `assignee_id` column (see below).
- `outlets`, `project_outlet_labels`, `project_user_labels`: the whole
  "outlet" concept and project labels are gone.
- `mood_checkins`, `page_visits`: mood check-in and visit tracking are gone.

**Tasks move from many assignees to one**

- `tasks.assignee_id` is new, nullable, `on delete set null`, and indexed with
  `status`.
- `recurring_tasks.assignee_id` is new, `not null`, `on delete no action`, and
  indexed.
- `tasks.on_hold_date` is removed.

**The project lifecycle shrinks to five statuses.** The SQL comments point to
"ADR 0005". That ADR is not in this vault, so I assume it lives in the code
repo.

- `projects.status` used to allow 11 values with default `active`. It now
  allows `planning`, `in_progress`, `completed`, `cancelled` and `archived`,
  with default `planning`.
- `projects.on_hold_at` is removed.
- `projects.deleted_at` is now just "when this project was last archived". It
  is no longer a soft-delete flag.

Every other table, column and index is the same in both files. The only
other differences are formatting: table order, and `IF NOT EXISTS`.

## Findings worth a look

1. **Existing data breaks the new check on project status.** Any row with
   `active`, `inactive`, `pending`, `on_hold`, `draft`, `todo` or `review`
   fails the new constraint. If real data exists, a migration has to map each
   old value to a new one. Neither file says what that mapping is.
2. **The two `assignee_id` columns don't match.** On a task, deleting the user
   clears the assignee. On a recurring task, deleting the user is blocked
   (when foreign keys are enforced). That may be on purpose, because users are
   normally deactivated with `is_active`, not deleted. Nothing in the files
   says so.
3. **`recurring_tasks.assignee_id` is `not null` with no default.** Adding it
   to a table that already has rows fails. Any recurring tasks that had
   several assignees also have to collapse to one.
4. **`tasks.status` still has no check constraint**, while `projects.status`
   now has one. With `on_hold_date` removed, an `on_hold` task status probably
   should not exist any more, but nothing stops it.
5. **The file was edited by hand.** The `projects` table has written comments,
   and `tasks` has two blank lines where `on_hold_date` used to be. So
   `sqlite-schema.sql` describes the target schema, not a dump of a live
   database. Migrations still have to produce it.
6. **Not changed, but noticed:** `activity_logs.project_id` has no foreign
   key in either version, while `division_id` does. Deleting a project leaves
   log rows pointing at it. This may be on purpose for an audit log.
7. **A live table may still be on schema-zero.** On 2026-10-06 the owner
   pasted a `tasks` table that still has `on_hold_date` and no
   `assignee_id`. That is the schema-zero shape. If it came from a running
   database, that database has not been migrated to this schema yet.
   Findings 1 and 3 then apply now, not later.

## What each lens said

- **Hacker:** this note, findings above.
- **Hound, Hipster, Hustler:** not consulted. Dropping mood check-ins, outlets
  and multiple assignees changes the product, not only the schema. If those
  cuts were not already decided somewhere, they need a decision of their own.

## Options rejected

- **Keep schema-zero:** the owner chose the newer file.

## How we will know we were wrong

A real team needs more than one assignee on a task, or someone asks for
mood check-ins or outlets back.

---
Part of [Tasko](../README.md)
