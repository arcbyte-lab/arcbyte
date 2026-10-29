---
title: A "my tasks" tab, first and opened on start, gathers the user's tasks and reviews from every tab
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-29
updated: 2026-10-29
inputs: ["./0002-tabs-are-workspaces-then-projects.md", "./0003-calendar-is-a-due-date-heatmap-that-filters.md", "./0004-checkbox-goes-to-review-only-when-needed.md", "./0016-calendar-follows-the-iphone-calendar.md"]
tags: [artifact, decision]
---

## Decision

A new tab, **`my tasks`**, sits first in the tab strip, before the workspaces,
with no group label. The app opens on it. It shows, from every tab the
user is in:

| Shown in `my tasks` | From |
|---|---|
| Every personal task | `private` |
| Team tasks assigned to the user | every division and project tab |
| Tasks in `review` that the user can review | division tabs where they are admin or supervisor; project tabs where they are owner or person-in-charge ([0004](./0004-checkbox-goes-to-review-only-when-needed.md)) |

- The calendar counts these same tasks, so its dots show the user's load
  across all their work. A task waiting for the user's review counts too,
  although a task in `review` isn't "open" anywhere else ([0003](./0003-calendar-is-a-due-date-heatmap-that-filters.md)).
  With the selected day kept across tabs ([0016](./0016-calendar-follows-the-iphone-calendar.md)
  rule 6), picking a day answers "what do I have to do that day?"
- Each row's meta line ends with the tab the task lives in, e.g.
  "high · waiting · Oct 14 · tasko-web".
- Ticking, opening a task, search and view options work as in any tab.
  The members, repeat and activity buttons don't show: they belong to one
  tab.
- The + button opens the create sheet with a tab picker, starting on
  `private`.
- Drawn as [H10](../hipster/hifi-mockup-tickets-for-pen-dev.md):
  `hifi / my tasks / default` and `hifi / my tasks / day-selected`.

`my tasks` is a view, not a place. A task still lives in exactly one workspace
or project tab ([0002](./0002-tabs-are-workspaces-then-projects.md)); `my tasks`
shows some of those tasks a second time.

## Context

The tabs show one workspace or project at a time. The owner wants to see
what they have to do on a selected day, across everything (2026-10-29).
Claude suggested an extra tab that gathers the user's own tasks; the owner
chose to include reviews, to open the app on it, and the name `my tasks` (first `mine`, then renamed), in
chat the same day. It stays `draft` until the owner promotes it.

## What each lens said

- **Hound:** no user input. "What do I have to do today" is the owner's
  own need.
- **Hipster:** a tab, because the tab strip is already where the user picks
  which tasks they see. A swipe to `my tasks` is one move, and the calendar
  stays tied to the active tab. The tab name on each row says where a task
  lives without opening it.
- **Hacker:** no API change. The app already loads every tab's tasks
  (`HomeCubit.tasksByTab`) and knows the user's role in each tab
  (`TaskTab.role`), so `my tasks` is built in the app from what it has.
  Within a tab a task appears once, so `my tasks` has no duplicates.
- **Hustler:** not consulted.

## Options rejected

- **An "all" tab with every task from every tab.** Rejected: for a lead in
  busy projects it's mostly other people's work, and it doesn't answer
  "what do I have to do".
- **A switch on the calendar for "all tabs" or "this tab".** Rejected: it
  is a second way of choosing tasks next to the tab strip, and harder to
  find.
- **The existing "assignee: me" filter in view options.** Rejected: it
  only filters one tab.
- **Leaving reviews out.** Rejected by the owner: reviewing is work the
  user has to do.

## How we will know we were wrong

- Users still go tab by tab to plan their day. Then `my tasks` isn't trusted;
  check whether tasks are missing from it.
- Leads find `my tasks` crowded by reviews. Then reviews move under their own
  header, or behind a filter.

## Open questions

- Which tab does the create sheet start on when `my tasks` is active and a day
  is selected: `private`, or the last tab used?
- Should an unassigned team task show in `my tasks` for the leads of its tab?
  Not included for now.

---
Part of [Tasko](../README.md)
