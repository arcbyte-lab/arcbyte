---
title: Tabs are workspaces (private, then divisions), then projects; each task is in exactly one tab
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-06
updated: 2026-10-06
inputs: ["../assets/home-wireframe-snapshot.png", "../hipster/home-screen-wireframe.md", "../hacker/santian-concepts-mapped-to-tasko-schema.md"]
tags: [artifact, decision]
---

## Decision

Santian's List tab becomes two kinds of tab in Tasko, in this order:

1. **Workspaces:** `private` first, then each division the user is a
   member of.
2. **Projects:** each project the user is a member of.

Every task is in **exactly one** tab:

| Tab | Shows |
|---|---|
| `private` | the user's `personal_tasks` |
| a division | that division's `tasks` **with no project** (`project_id` is null) |
| a project | that project's `tasks` |

There is no Star tab and no `+` tab.

## Context

[The concept mapping](../hacker/santian-concepts-mapped-to-tasko-schema.md)
asked what a List tab means in Tasko, because every screen depends on it.
The owner answered with [a home wireframe](../hipster/home-screen-wireframe.md),
and in chat on 2026-10-06 confirmed two things: a workspace like `tech` is a
`divisions` row, and a division tab shows only tasks without a project. The
owner approved this. It stays `draft` until the owner promotes it, because
only the owner changes a note's status.

## What each lens said

- **Hound:** no user input. This is the owner's design.
- **Hipster:** it keeps Santian's Google Tasks feel, where each task lives
  in one place. Showing a project's tasks under its division as well would
  list the same task twice.
- **Hacker:** it fits the schema with no new tables. `personal_tasks` has
  no division or project, so `private` cannot overlap with anything. A task
  with `division_id` set and no `project_id` is only reachable from its
  division tab, so that tab has to exist. Membership comes from
  `division_members` and `project_members`.
- **Hustler:** not consulted.

## Options rejected

- **A division tab shows all of its tasks, project ones included.**
  Rejected. The same task would appear in two tabs.
- **Personal Lists, as in Santian (a new `task_lists` table).** Rejected.
  It ignores the divisions and projects Tasko is built around.

## How we will know we were wrong

Users look for a project's tasks under its division and do not find them.
Or a supervisor needs "everything in my division" in one view. Either one
would justify a combined view, as a filter rather than another tab.

## Vocabulary this sets (for a future Tasko `CONTEXT.md`)

- **Workspace:** a tab in the first group. Either `private` or a division.
  "Workspace" is the word the UI uses. `divisions` is the table name.
- **Project:** a tab in the second group, which is a `projects` row.

---
Part of [Tasko](../README.md)
