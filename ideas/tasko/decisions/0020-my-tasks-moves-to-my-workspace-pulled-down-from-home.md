---
title: "My tasks" moves to My Workspace, pulled down from home; the Actions rail follows it
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-10
updated: 2026-11-10
inputs: ["./0017-a-my-tasks-tab-gathers-the-users-tasks.md", "./0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md"]
tags: [artifact, decision]
---

## Decision

Amends [0017](./0017-a-my-tasks-tab-gathers-the-users-tasks.md): what "my
tasks" shows is unchanged, but where it lives is not.

1. **Home no longer has a "my tasks" tab.** Its tab strip is the workspaces
   (`private`, divisions) and the projects, as `hifi / home / default` draws
   it. The app opens on the first of them.
2. **"My tasks" lives on My Workspace**, a dark screen pulled down over home
   by swiping down on the open month calendar. Its tab bar has `my tasks`
   (opened first) and `private`. A white strip with a grabber stays at the
   bottom; a tap or a swipe up on it returns to home, on the tab it left.
   `private` is on both screens.
3. **My Workspace has the Actions rail** (New project, New task), not the
   Navigations rail, so a task can still be created from "my tasks" with
   0017's tab picker. The drawing `hifi / My Workspace / default` has no
   rails; the pen file needs the Actions rail added.
4. The rest of 0017 stands: the same tasks, the same dots, rows that name
   their tab.

## Context

The hifi frames drew home without "my tasks" and My Workspace with it, which
contradicted 0017's "first tab, opened on start". The owner chose, on
2026-11-10, to follow the drawings and move it. Item 3 was the owner's call
the same day, after the app lost its only way to create from "my tasks".
Item 2's `private` on both screens follows the drawings; the owner's first
answer said both would live only on My Workspace, so this is worth a glance.
Built in app PR #56. Stays `draft` until the owner promotes it.

---
Part of [Tasko](../README.md)
