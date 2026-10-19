---
title: An ended repeat stays in the repeating view until a lead deletes it
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-19
updated: 2026-10-19
inputs: ["./0012-division-leads-run-repeats-from-a-repeating-view.md", "./0009-workspace-tasks-repeat-on-completion.md", "../hacker/repeating-view-build-tickets.md"]
tags: [artifact, decision]
---

## Decision
This changes [0012](./0012-division-leads-run-repeats-from-a-repeating-view.md),
which listed only live repeats.

- **An ended repeat stays listed.** A repeat ends when a lead stops it, or
  when it runs out (its "after N times" or "until" date is reached). It
  stays in the repeating view, marked "ended", with its rule and its
  history.
- **Only a lead's delete removes it.** Delete works on live and ended
  repeats:
  - **Live:** the open task is deleted if nobody has started it. A
    started one must be stopped first (409, as before).
  - **Both:** the repeat and its history leave the view.
- **Deleting never deletes finished tasks.** They stay in the tab's
  completed list, with their proofs, reviews and comments. They only stop
  being linked as a series.
- **An ended repeat can't be restarted from the view.** Turning the rule
  on again on its last task (Task Detail) continues the same series, as
  before.

## Context
On 2026-10-19 the owner said: "keep the history and the setup. let the
user delete it manually". Asked what delete does to finished tasks, the
owner chose to keep them.

While planning this, Claude found a bug in the 0012 build. A repeat that
runs out keeps its rule on its last, finished task. The view then listed
it as live, and delete answered 409. This decision fixes it: running out
ends the repeat like a stop does.

## What each lens said
- **Hound:** no user input.
- **Hipster:** an ended row says "ended" where the next due date was, and
  its name is greyed. Its history screen says "ended" above the rule, and
  its menu has only "delete".
- **Hacker:** one column, `tasks.repeat_ended`. When a repeat ends, its
  last rule moves there, on its latest task, so `repeat` keeps meaning
  "live". Delete clears `series_id` and `repeat_ended` on the series'
  tasks. A migration moves the rule off finished tasks that ran out. No
  new table.
- **Hustler:** not consulted.

## Options rejected
- **A `series` table that owns the rule.** It is cleaner on paper, but it
  moves the rule off the task, where 0009 put it, and touches every
  repeat path.
- **Delete the finished tasks too.** The owner chose to keep them.

## How we will know we were wrong
- The list fills up with ended repeats nobody deletes. Then hide them
  behind an "ended" filter.
- A lead wants to restart an ended repeat from the view.

---
Part of [Tasko](../README.md)
