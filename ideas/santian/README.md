---
title: Santian
idea: santian
stage: project
repo: https://github.com/arcbyte-lab/Santian
lens: intelligence
kind: brief
status: draft
source: me
evidence: none
created: 2026-09-16
updated: 2026-09-18
tags: [anchor]
---

# Santian

> The anchor note. The only note here that must stay current. Blank sections are
> blank on purpose — nobody has answered them yet. Do not fill them with guesses.

## Stage

`stage: project`. Code has started, at
[github.com/arcbyte-lab/Santian](https://github.com/arcbyte-lab/Santian)
(local checkout: `~/Projects/Dev/Santian`) — separate from this repo, per
[AGENTS.md](../../AGENTS.md). Promoted on 2026-09-18 by the owner; see
[decision 0008](./decisions/0008-promote-santian-to-project.md). See
[Arcbyte's glossary](../../CONTEXT.md) for what `idea` and `project` mean
here, and its **Domain model** entry (proposed, not yet confirmed) for who
owns vocabulary now that both this vault and the code repo are real.

## Vision-led documentation

A separate synthesis of this idea as a whole — vision, experimentation, current
identity, the personal dimension, and the path toward public release — lives in
[`narrative/`](./narrative/product-narrative.md), starting with
[the product narrative](./narrative/product-narrative.md). It is written from the
artifacts below and does not replace them.

## One line
_What it is, for whom, in one sentence._

## The problem
_Whose pain, and how they cope today._

## Current bet
_What I currently believe is true. Change this line when the bet changes, and add
a note in `decisions/` saying why._

What the vault currently shows, as a starting point to correct: the app has a
**Clockface** view and a **Tasks** view, and the task side is meant to feel like
Google Tasks, offline-first, built in Flutter.

Renamed from "Routine App" to **Santian** on 2026-09-16. This is a deliberate
rethink of the `timez_core` model — see
[decision 0001](./decisions/0001-rethink-the-focus-aggregate.md). The product
needs both a repeating weekly **Routine** and real calendar **Days** the user can
adjust. Vocabulary lives in [CONTEXT.md](./CONTEXT.md), beside this note.

Build order: Tasks module first. Clockface does not start until Tasks is
settled — see
[decision 0002](./decisions/0002-build-tasks-before-clockface.md).

This is a personal tool for the owner, not a product aimed at strangers — see
[decision 0003](./decisions/0003-personal-tool-not-a-product.md).

## Status by lens

| lens | where it stands |
|---|---|
| [Hound](../../lenses/hound.md) | Nothing. No real person has been asked anything. One open question. |
| [Hipster](../../lenses/hipster.md) | A hi-fi mockup now exists for the 8 core Tasks screens, light and dark. It reads as a close Google Tasks clone on a generic, partly-unedited theme — see open questions. [Add-list method](./hipster/add-list-method.md) and [deadline badge/overdue styling](./hipster/deadline-badge-and-overdue-styling.md) design the affordances the mockup never drew. all 8 core Tasks screens now have a hipster spec: [Tasks List](./hipster/tasks-list-screen-interactions.md), [Create Task](./hipster/create-task-sheet-interactions.md), [the date/time picker](./hipster/date-time-picker-interactions.md), and [Task Detail](./hipster/task-detail-identity-and-fields.md) (plus its [More menu/delete](./hipster/task-detail-more-menu-and-delete.md) and [subtasks](./hipster/task-detail-subtasks.md), the least-drawn piece of the whole mockup). Several fields still have real open questions — see each note. |
| [Hacker](../../lenses/hacker.md) | Task/List/Subtask fields are now fully settled — see [data model](./hacker/task-list-subtask-data-model.md). [Decision 0005](./decisions/0005-clockface-questions-dont-block-tasks-build.md) says the two Clockface questions don't gate a Tasks-only build. [Decision 0006](./decisions/0006-isar-for-tasks-storage.md) picks Isar for the Tasks data layer; the Clockface's own storage question is still open. [Decision 0007](./decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md) confirms Deadline is intentional scope beyond Google Tasks parity. |
| [Hustler](../../lenses/hustler.md) | Mostly closed for this idea — no market, no pricing, no channel. See decision 0003. |

## Next question to answer

The Task/List/Subtask field-level questions are now settled — see
[the data model note](./hacker/task-list-subtask-data-model.md),
[decision 0007](./decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md),
and [the deadline badge/overdue-styling design](./hipster/deadline-badge-and-overdue-styling.md).
Nothing is currently naming a next open question — the remaining unanswered
items ([Day vs Routine](./hacker/day-versus-routine.md),
[Clockface-or-list source of truth](./hacker/clockface-or-list-source-of-truth.md))
block Clockface only, not the Tasks build, per decision 0005.

[How does a Day differ from its Routine?](./hacker/day-versus-routine.md) is
also still open and still unblocks Clockface modelling — decision 0001
retired the old aggregate without naming a replacement — but per decision
0005 it does not block the Tasks build that is happening first.

## Artifacts

**Hound**
- [Who plans their day by the clock?](./hound/who-plans-their-day-by-the-clock.md) — question, unanswered

**Hipster**
- [Wireframe geometry spec](./hipster/wireframe-geometry-spec.md) — what is actually drawn in the Penpot file
- [Google Tasks UX playbook](./hipster/google-tasks-ux-playbook.md) — patterns to copy
- [Hi-fi mockup is a Google Tasks clone riding an unused generic theme](./hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md) — critique of the new hi-fi export
- [Add-list method for the scrollable List Tab Bar](./hipster/add-list-method.md) — design for the not-yet-drawn "create a list" affordance
- [Deadline list-row badge and overdue styling](./hipster/deadline-badge-and-overdue-styling.md) — design for decision 0007's not-yet-drawn behaviour
- [Tasks List screen — tab switching, row tap, checkbox, and FAB behaviour](./hipster/tasks-list-screen-interactions.md) — spec for the primary screen's interactions; flags the completed-task visual and the empty state as genuinely undecided
- [Task Detail's More menu and delete](./hipster/task-detail-more-menu-and-delete.md) — resolves delete: lives behind Task Detail's `More` icon, never a Tasks List gesture; no confirm dialog, yes undo toast
- [Create Task sheet — compose row, notes toggle, and the mislabeled third icon](./hipster/create-task-sheet-interactions.md) — spec for opening the sheet and its action icons; flags a genuinely mislabeled icon layer rather than guessing its function
- [Date & time picker — month grid, Set Time, Repeat, Cancel/Done](./hipster/date-time-picker-interactions.md) — spec for the shared date/time dialog; `deadline` gets a calendar-only variant, `reminderAt` gets the full dialog
- [Task Detail — Star, List Selector, Title, Description, and Mark Completed](./hipster/task-detail-identity-and-fields.md) — spec for Detail's identity fields; flags that the `+ Keyboard` frame doesn't show which field is actually focused
- [Task Detail's Subtask Field — add, reorder, and independent completion](./hipster/task-detail-subtasks.md) — the one field with zero populated-state drawing anywhere in the mockup; a proposal, not a reconstruction

**Hacker**
- [Offline task module architecture](./hacker/offline-task-module-architecture.md) — model's Flutter stack sketch
- [Task, List and Subtask fields, read off the hi-fi mockup](./hacker/task-list-subtask-data-model.md) — data model inventory; fields fully settled, one open question remains (the interval-shaped task row)
- [How does a Day differ from its Routine?](./hacker/day-versus-routine.md) — question, unanswered, blocks Clockface modelling — see decision 0005
- [Is the Clockface or the list the source of truth?](./hacker/clockface-or-list-source-of-truth.md) — question, unanswered, blocks Clockface modelling — see decision 0005
- [Isar or sqflite?](./hacker/isar-or-sqflite.md) — answered: Isar, for Tasks only — see decision 0006

**Hustler**
- [Why would anyone switch from Google Tasks?](./hustler/why-switch-from-google-tasks.md) — answered: it doesn't apply, this is a personal tool

**Narrative** — long-form synthesis, written from the artifacts above
- [Product narrative](./narrative/product-narrative.md) — the entry point
- [The Vision](./narrative/vision.md)
- [The Experiment](./narrative/experiment-synthesis.md)
- [The Core Identity](./narrative/core-identity.md)
- [The Personal Dimension](./narrative/personal-dimension.md)
- [Toward Public Release](./narrative/toward-public-release.md)

**Assets**
- [Wireframe snapshot](./assets/santian-wireframe-snapshot.png)
- [Hi-fi mockup snapshot](./assets/santian-hifi-snapshot.png)
- [Hi-fi export (HTML)](./assets/santian-hifi-export.html)
- [Theme CSS](./assets/exodus.css)
- [Tailwind config](./assets/tailwind.config.ts)

## Decisions

- [0001 — Rethink the Focus aggregate](./decisions/0001-rethink-the-focus-aggregate.md) — 2026-09-16
- [0002 — Build Tasks before Clockface](./decisions/0002-build-tasks-before-clockface.md) — 2026-09-17
- [0003 — Santian is a personal tool, not a product](./decisions/0003-personal-tool-not-a-product.md) — 2026-09-17
- [0004 — Clone Google Tasks' interaction model, only change the visual skin](./decisions/0004-clone-google-tasks-interactions.md) — 2026-09-17
- [0005 — The open Clockface hacker questions don't block starting the Tasks data layer](./decisions/0005-clockface-questions-dont-block-tasks-build.md) — 2026-09-18
- [0006 — Isar for the Tasks data layer](./decisions/0006-isar-for-tasks-storage.md) — 2026-09-18
- [0007 — Deadline is intentional scope beyond Google Tasks parity](./decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md) — 2026-09-18
- [0008 — Promote Santian from idea to project](./decisions/0008-promote-santian-to-project.md) — 2026-09-18

## Health check

Three of six artifacts are open questions, and every filled artifact has
`evidence: none` or `weak`. That is normal this early. It stops being normal once
code exists.
