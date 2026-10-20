---
title: Tasks, projects, divisions and users each get an activity log, opened by leads
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-20
updated: 2026-10-20
inputs: ["./0001-adopt-sqlite-schema-over-schema-zero.md", "./0010-adding-a-project-member-needs-no-invitation.md", "./0012-division-leads-run-repeats-from-a-repeating-view.md", "../hacker/tasko-api-as-built.md"]
tags: [artifact, decision]
---

## Decision
- **One table, four logs.** The server writes every team action to
  `activity_logs`. Each log filters it:
  - **Task:** that task's rows. Subtasks and comments go in their parent
    task's log.
  - **Project:** rows with that `project_id`.
  - **Division:** its own tab's tasks (`project_id` empty), plus
    `project.created` and `member.*` rows for its projects. Tasks inside a
    project stay out.
  - **User:** rows they did (`actor_id`), plus rows done to them
    (`target_user_id`).
- **Only leads open logs.**
  - **Division log:** its admin or supervisor.
  - **Project log, and a project task's log:** the project's owner or
    person-in-charge. A division lead can't open them unless they also hold
    one of those roles.
  - **A division task's log:** the division's admin or supervisor.
  - **User log:** the user themselves, and their division leads. A lead
    sees only rows from tabs whose log they can open.
- **"Done to them"** means: assigned or unassigned, made the next repeat's
  assignee, their task approved or rejected, a comment on their task, and
  being added to a project, given a new role there, or removed from it.
- **Not logged:** private-tab tasks, logging in and out, reading
  notifications.

## Actions
- **Task:** `task.created`, `task.renamed`, `task.description_changed`,
  `task.priority_changed`, `task.due_changed`, `task.assigned`,
  `task.unassigned`, `subtask.added`, `comment.added`,
  `deadline.requested`.
- **Status:** `task.started`, `task.completed`, `task.sent_to_review` (with
  the proof link), `task.reopened`, `task.approved`, `task.rejected` (with
  the reason).
- **Repeat** (division tasks only): `repeat.set`, `repeat.changed`,
  `repeat.stopped`, `repeat.next_created`, `series.deleted`.
- **Project:** `project.created`, `member.added`, `member.role_changed`,
  `member.removed`, `member.left`. A removal or a leave also lists the
  tasks it unassigned.

One save that changes three fields writes three rows. `changes` holds
`[before, after]` per field. The app builds the sentence from `action` and
`changes`, so `description` stays empty.

## Context
On 2026-10-20 the owner asked for an activity log in each of four places:
user, division (not its projects), project and task. The owner then chose:
- a user's log shows what they did and what was done to them;
- leads only, and a division lead doesn't get a project's log unless they
  are its owner or person-in-charge;
- no private-tab tasks;
- project and member rows show in the division log too;
- comments on a user's task count as done to them.

No code reads or writes `activity_logs` yet. The API left the table out
because no route read it.

## What each lens said
- **Hound:** no user input.
- **Hipster:** not drawn yet. Each row reads as one line: "Rina rejected
  *Weekly stock count*: photo is blurry · 09:14".
- **Hacker:**
  - Schema: add `target_user_id` (foreign key, set null on delete) and
    indexes on `(project_id, created_at)`, `(actor_id, created_at)` and
    `(target_user_id, created_at)`. Drop `project_activities`: its rows are
    deleted along with their project or user, so it can't keep history.
  - The log row is written in the same D1 batch as the change, so a log
    can't miss an action. Notifications, by contrast, are best-effort.
- **Hustler:** not consulted.

## Options rejected
- **Keep `project_activities` for the project log.** It cascades on delete
  and would duplicate `activity_logs`.
- **One `task.updated` row per save.** Fewer rows, but a lead can't filter
  for "due date moved".
- **Show Task Detail's history from the existing tables.** That covers the
  task log only, not the other three.

## How we will know we were wrong
- Leads never open the logs. Then stop building screens for them and keep
  writing rows only.
- Staff ask to see their own task's history. Then open the task log to its
  assignee.
- The user log is too noisy because of comments. Then filter comments out
  of the "done to them" rows.

---
Part of [Tasko](../README.md)
