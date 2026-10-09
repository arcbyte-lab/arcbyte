---
title: "Start working" in Task Detail moves a task to in progress
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-09
updated: 2026-10-09
inputs: ["./0004-checkbox-goes-to-review-only-when-needed.md", "./0007-server-rules-settled-in-the-api-review.md", "../hacker/tasko-api-as-built.md", "../hacker/flutter-app-as-built.md"]
tags: [artifact, decision]
---

## Decision
Task Detail's **start working** button moves a task that hasn't been
started to in progress: `waiting → in_progress` for a team task,
`todo → in_progress` for a personal one. Whoever may tick the task may
start it (its assignee, or anyone in the tab when it has no assignee). A
team task's `start_date` is set the first time. The checkbox still never
sets `in_progress` ([0004](./0004-checkbox-goes-to-review-only-when-needed.md)).

## Context
0004 left this open: "Starting work is a separate action, probably in Task
Detail." The app had the button, but the
[API](../hacker/tasko-api-as-built.md) refused the move, so on a phone it
showed "Cannot move a task from waiting to in_progress" (found in the device
test on 2026-10-09). The owner chose to allow the move on the server rather
than drop the button.

## What each lens said
- **Hound:** no user input.
- **Hipster:** the action bar already offers "start working", then "mark
  done" or "submit proof" (lofi T9). Nothing changes on screen.
- **Hacker:** the server can't tell the checkbox from the button; the app
  keeps the checkbox rule (`statusAfterTick` never returns in progress).
  `tasks.start_date` already exists.
- **Hustler:** not consulted.

## Options rejected
- **Drop the button.** Then nothing ever sets `in_progress`, and "in
  progress" exists only in seed data.
- **Let any member start any task.** Same reason as 0007's "who edits":
  starting work is the assignee's call.

## How we will know we were wrong
People start tasks by accident and need to undo it: there is no
`in_progress → waiting` yet.

---
Part of [Tasko](../README.md)
