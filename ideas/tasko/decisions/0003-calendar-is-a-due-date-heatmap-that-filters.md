---
title: The home calendar is a due-date heatmap for the active tab; tapping a day filters the list
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-06
updated: 2026-10-06
inputs: ["../assets/home-wireframe-snapshot.png", "../hipster/home-screen-wireframe.md", "./0002-tabs-are-workspaces-then-projects.md"]
tags: [artifact, decision]
---

## Decision

The calendar on the home screen shows each day of the month, shaded by how
many **open** tasks in the **active tab** are due that day. Tapping a day
filters the task list below to that day. Tapping it again clears the
filter.

## Context

[The wireframe](../hipster/home-screen-wireframe.md) draws a "monthly" grid
of day cells above the tabs but does not say what it does. Two readings
were possible. One is a dashboard of tasks done per day across everything.
The other is a due-date view that drives the list. The owner chose the
second in chat on 2026-10-06. It stays `draft` until the owner promotes it.

## What each lens said

- **Hound:** no user input.
- **Hipster:** the calendar gets a job instead of being decoration, and it
  stays tied to the tab the user is looking at. Santian's day headers
  (Past, Today, Tomorrow) can stay in the list. The calendar narrows the
  list, it does not replace the headers.
- **Hacker:** a count of `due_date` per day, for open tasks in the active
  tab's scope (see [0002](./0002-tabs-are-workspaces-then-projects.md)).
  Both `tasks` and `personal_tasks` have `due_date`. Because `due_date` is
  a datetime, days are counted on the calendar date, like Santian's
  overdue rule.
- **Hustler:** not consulted.

## Options rejected

- **A heatmap of tasks completed per day, across all tabs.** Rejected. It
  is a productivity view with no link to the list below it.

## How we will know we were wrong

Users ignore the calendar, or want "what did I finish" more than "what is
due". Then the completed-per-day view comes back as its own screen.

## Open questions

- ~~What counts as "open"?~~ Settled by [0004](./0004-checkbox-goes-to-review-only-when-needed.md):
  `waiting` or `in_progress` (`todo` or `in_progress` for personal tasks).
  Tasks in `review` are not counted.
- Shading scale: a count, or only empty versus some?
- Are overdue days (before today, with open tasks) shown differently?
- What does "monthly" switch to?

---
Part of [Tasko](../README.md)
