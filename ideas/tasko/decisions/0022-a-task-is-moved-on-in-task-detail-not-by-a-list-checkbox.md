---
title: A task is moved on in Task Detail, not by a checkbox in the list
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-10
updated: 2026-11-10
inputs: ["./0004-checkbox-goes-to-review-only-when-needed.md", "./0008-start-working-moves-a-task-to-in-progress.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../assets/pencil-new.pen"]
tags: [artifact, decision]
---

## Decision

Amends [0004](./0004-checkbox-goes-to-review-only-when-needed.md) and
[0005](./0005-v1-build-defaults.md)
where they put a checkbox on every row of the list.

1. **The task list has no checkbox.** A row is the assignee's avatar, the
   title and date, the task code and the priority and status badges, as in the
   pen file's `hifi / Task Row` (and the dark `hifi / My Workspace / Task Row`)
   and as H1 already said ("no checkbox", owner, 2026-11-04). Tapping a row
   opens Task Detail.
2. **What the checkbox did now lives in Task Detail's action bar.** Start
   working (`waiting` to `in_progress`), then mark done, or submit a proof for
   a task that needs one (0004's rules for review, proof and reviewers are
   unchanged). A personal task goes through the same two steps, where it was
   one tick. Sub-tasks keep their 16px checkbox inside Task Detail.
3. **The rows stay in the app's own order and groups.** Nothing about the
   OVERDUE, TODAY, TOMORROW and LATER groups changes.

## Context

The pen file's task row has no checkbox, and the owner asked for the app to
be "what is on the .pen" on 2026-11-10. The cost is a longer path to finish
a task, from one tap to two (open it, then the action bar). If that proves
too slow for personal tasks, a swipe on the row is the next thing to try; it
is not drawn. Stays `draft` until the owner promotes it.

---
Part of [Tasko](../README.md)
