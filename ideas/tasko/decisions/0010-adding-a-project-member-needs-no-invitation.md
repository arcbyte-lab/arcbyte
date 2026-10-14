---
title: Adding a project member needs no invitation — division leads create projects, anyone active can be added
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-14
updated: 2026-10-14
inputs: ["./0002-tabs-are-workspaces-then-projects.md", "./0007-server-rules-settled-in-the-api-review.md", "../hacker/tasko-api-as-built.md", "../hacker/project-and-member-build-tickets.md", "../assets/sqlite-schema.sql"]
tags: [artifact, decision]
---

## Decision
- **No invitation step.** Adding someone writes their `project_members`
  row right away, with `invited_by`, and sends a notification. There is no
  pending state, no accept or decline step, and no email.
- **Who creates a project:** an `admin` or `supervisor` of the division.
  The creator becomes the project's `owner`. A new project starts as
  `planning`.
- **Who manages members:** `owner` and `person-in-charge`. Only an owner
  can make someone an owner or take that role away. A project always
  keeps at least one owner. Any member can leave, unless they are the
  last owner.
- **Who can be added:** any active user, from any division.
- **A removed member's tasks:** their `todo` / `waiting` / `in_progress`
  tasks in the project lose their assignee. Tasks in `review` keep it.
- **Divisions and division members** come from the seed script, not
  from a screen.

## Context
The [API as built](../hacker/tasko-api-as-built.md) listed an open
question: who creates divisions, projects and memberships, and how?
Nothing did it. On 2026-10-14 the owner asked how to handle project
creation and inviting members. In chat, the owner said "yes to both" to
the two open calls: adding people from any division, and unassigning a
removed member's open tasks. The build tickets are in
[project and member build tickets](../hacker/project-and-member-build-tickets.md).

## What each lens said
- **Hound:** no user input.
- **Hipster:** this needs a "new project" entry and a members screen. The
  [build tickets](../hacker/project-and-member-build-tickets.md) suggest
  the account menu and a members icon in the project toolbar. Neither is
  in the hifi mockups yet.
- **Hacker:** no new tables. `project_members` already has the roles and
  `invited_by`. Membership still comes only from the member tables
  ([0002](./0002-tabs-are-workspaces-then-projects.md)), so a new row
  makes the tab appear. A creator who leaves stops being a reviewer
  ([0007](./0007-server-rules-settled-in-the-api-review.md)).
- **Hustler:** not consulted.

## Options rejected
- **Invitations with accept or decline.** Every user is added by the
  admin, so everyone is already a colleague with an account. An accept
  step would add a state machine and protect against nothing.
- **Only the project's own division can be added.** Projects often
  involve people from more than one division.
- **A removed member keeps their tasks.** Those tasks would be assigned
  to someone who can no longer open the tab. Nobody would work on them,
  and nobody would notice.
- **A screen for managing divisions.** There are only a few divisions,
  and they rarely change. The seed script covers it.

## How we will know we were wrong
- People want to turn down a project they were added to.
- Someone outside the company, such as a client or contractor, needs to
  join a project. That needs invitation links and accounts made on
  signup.
- Division leads object to people from other divisions in their
  projects.
- A removed member's work in progress gets lost because nobody picked up
  the unassigned task.

---
Part of [Tasko](../README.md)
