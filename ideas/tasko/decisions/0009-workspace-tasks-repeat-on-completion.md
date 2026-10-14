---
title: Workspace tasks repeat the Santian way — finishing one creates the next
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-14
updated: 2026-10-14
inputs: ["./0005-v1-build-defaults.md", "./0002-tabs-are-workspaces-then-projects.md", "../hacker/santian-rules-that-change-in-a-team-app.md", "../../santian/hacker/repeat-advance-algorithm.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md"]
tags: [artifact, decision]
---

## Decision
A **workspace task can repeat**. This brings back the repeat that
[0005](./0005-v1-build-defaults.md) cut, but only for workspace tasks.

- **Only workspace tasks repeat.** That means a division tab's own
  top-level tasks ([0002](./0002-tabs-are-workspaces-then-projects.md)).
  Project tasks, sub-tasks and personal tasks cannot repeat. The server
  refuses them.
- **The rule lives on the task**, as in Santian. It is stored in a new
  `tasks.repeat` column as JSON: every N days, weeks, months or years;
  weekdays for weekly; and an end, which is never, on a date, or after
  N occurrences.
- **Finishing the task creates the next one.** "Finishing" means `done`,
  either from the checkbox or when a reviewer approves. The next task is
  a new row with the same name, note, priority, proof rule and assignee
  (if the assignee is still a member). Its due date is one step later. The
  rule moves onto the new task, so unticking and ticking again never
  creates a second one.
- **No catch-up**, as in Santian. A task finished late still moves only
  one step.
- **The due date sets the time and the start.** A repeating task needs a
  due date. The repeat screen has no "at" or "starts" rows.

## Context
The owner asked on 2026-10-14: "implement repeat … use 'repeat' from
santian as inspiration … only for … workspaces". That answers the open
question in
[Santian's rules that change](../hacker/santian-rules-that-change-in-a-team-app.md):
the next task is created on completion, so no schedule is needed.

## What each lens said
- **Hound:** no user input.
- **Hipster:** the hifi repeat frames (H5) show "creates a new task
  every week…". The screen keeps every / weekdays / ends and the summary
  box. It drops "at", "starts" and "on day", because the due date
  already sets them. The summary says the next task comes "when this task
  is done".
- **Hacker:** no cron job and no `recurring_tasks` table. The schema's
  `recurring_tasks` is a schedule that a server job runs, which Tasko
  doesn't have. The date maths runs on the team's fixed UTC+7, the same
  as the seed data.
- **Hustler:** not consulted.

## Options rejected
- **`recurring_tasks` template plus a cron job** (the schema's model).
  This needs a scheduled worker and would create tasks nobody has
  finished. It also doesn't fit Tasko's tasks, because its `assignee_id`
  is required.
- **One row moving forward**, exactly like Santian. A done team task
  keeps its proof, review and comments, so it has to stay as its own row.

## How we will know we were wrong
- A team wants the next task on a fixed date even when the last one isn't
  finished, for example a weekly report that is due whether or not last
  week's was done.
- Someone needs a project task to repeat.
- Monthly tasks drift: Jan 31 → Feb 28 → Mar 28. "On day 31" would need
  its own field.

---
Part of [Tasko](../README.md)
