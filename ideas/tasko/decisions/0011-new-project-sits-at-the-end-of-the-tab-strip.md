---
title: "New project" sits at the end of the tab strip, not in the account menu or behind the FAB
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-19
updated: 2026-10-19
inputs: ["./0010-adding-a-project-member-needs-no-invitation.md", "./0002-tabs-are-workspaces-then-projects.md", "../../santian/decisions/0016-follow-google-tasks-mobile-over-the-mockup.md", "../hacker/project-and-member-build-tickets.md"]
tags: [artifact, decision]
---

## Decision
- **"+ new project" is the last item in the tab strip**, after the last
  project tab, under the PROJECTS label. Tapping it opens the same new
  project sheet as before.
- **It shows only for division admins and supervisors** (`canCreateProject`),
  as before. For them, the PROJECTS group shows even when they have no
  projects yet, so they can create the first one.
- **The account menu loses "new project".** It goes back to name, email,
  account settings and log out.
- **The FAB stays one tap to create a task.** There is no chooser.

## Context
On 2026-10-19 the owner proposed moving "new project" from the account
menu to the FAB. The FAB would open a chooser (new task or new project),
and the chosen sheet would open after that. Claude advised against it and
suggested the tab strip instead. The owner chose the tab strip.
This answers the open question in the
[build tickets](../hacker/project-and-member-build-tickets.md) about where
"new project" lives.

## What each lens said
- **Hound:** no user input.
- **Hipster:** a project *is* a tab ([0002](./0002-tabs-are-workspaces-then-projects.md)),
  so the button sits where the new tab will appear. Google Tasks mobile
  puts "+ New list" at the end of its tabs. Santian already follows Google
  Tasks mobile ([Santian 0016](../../santian/decisions/0016-follow-google-tasks-mobile-over-the-mockup.md)).
  The H7 frame `hifi / home / account-menu-lead` was redrawn as
  `hifi / home / new-project-tab` on 2026-10-19.
- **Hacker:** a view-only change. `TabStrip` takes an optional
  `onNewProject`. The panel wiring, the sheet, `POST /projects` and the
  rules don't change.
- **Hustler:** not consulted.

## Options rejected
- **A chooser behind the FAB.** It adds a tap to every new task, which is
  the most common action, to make room for a rare one. Most users can't
  create projects, so for them the chooser would have one option. If it
  comes back, show it only to leads.
- **Keep it in the account menu.** It is hard to find, and creating a
  project has nothing to do with the account.

## How we will know we were wrong
- Leads don't find it because the tab strip is long and the button is off
  screen to the right.
- Other create actions arrive (a division, a template), and the FAB
  becomes the natural place for all of them.

---
Part of [Tasko](../README.md)
