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
updated: 2026-10-06
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
| [Hipster](../../lenses/hipster.md) | The Tasks module is built. Its screens are described **as built** (Santian at `f64e2c0`, 2026-10-02): [Tasks List](./hipster/tasks-list-screen-as-built.md), [task row](./hipster/task-row-as-built.md), [create sheets](./hipster/create-sheets-as-built.md), [Task Detail](./hipster/task-detail-as-built.md), [date pickers and Repeat](./hipster/date-pickers-and-repeat-as-built.md). Where the app follows Google Tasks rather than the hi-fi mockup, the app wins — [decision 0016](./decisions/0016-follow-google-tasks-mobile-over-the-mockup.md). The mockup-era specs are in [`archive/santian/`](../../archive/santian/) as `superseded`. |
| [Hacker](../../lenses/hacker.md) | Described as built: [data model](./hacker/tasks-data-model-as-built.md), [behaviour rules](./hacker/tasks-behaviour-rules-as-built.md) (written to be portable to Tasko), [notifications](./hacker/notifications-as-built.md), [architecture](./hacker/tasks-architecture-as-built.md), [theme tokens](./hacker/theme-tokens-as-built.md). Stack decisions stand: Isar ([0006](./decisions/0006-isar-for-tasks-storage.md)), Cubit ([0009](./decisions/0009-cubit-for-state-management.md)), flutter_local_notifications ([0010](./decisions/0010-flutter-local-notifications-package.md)), blue by day / orange by night ([0011](./decisions/0011-blue-by-day-orange-by-night.md)). One known defect: completing a repeating Task from Task Detail. Clockface questions are still open and still don't block Tasks ([0005](./decisions/0005-clockface-questions-dont-block-tasks-build.md)). |
| [Hustler](../../lenses/hustler.md) | Mostly closed for this idea — no market, no pricing, no channel. See decision 0003. |

## Next question to answer

**For the owner to confirm (all `draft`):**
- [0016](./decisions/0016-follow-google-tasks-mobile-over-the-mockup.md) — the app, not the mockup, is the reference.
- [0017](./decisions/0017-lists-are-name-only.md) — Lists are name-only; supersedes the archived 0012/0013.
- [0014](./decisions/0014-first-launch-default-list.md) and
  [0015](./decisions/0015-deadline-notification-defaults-to-9am.md) — both
  already built; code comments say the owner confirmed them on 2026-09-22
  outside Arcbyte. Promote them if that is right.

**Then:** carry the as-built behaviour into [Tasko](../tasko/README.md). The
[behaviour rules](./hacker/tasks-behaviour-rules-as-built.md) and
[data model](./hacker/tasks-data-model-as-built.md) list what Tasko's schema
would need (Lists, star, reminder vs deadline, repeat) and what Santian lacks
(timestamps, manual order).

**Still open, Clockface only** (per decision 0005):
[Day vs Routine](./hacker/day-versus-routine.md) and
[Clockface-or-list source of truth](./hacker/clockface-or-list-source-of-truth.md).

## Artifacts

**Hound**
- [Who plans their day by the clock?](./hound/who-plans-their-day-by-the-clock.md) — question, unanswered

**Hipster** — as built (`evidence: strong`)
- [Tasks List screen](./hipster/tasks-list-screen-as-built.md) — card, tabs, swipe, day groups, Completed, List options menu
- [Task row](./hipster/task-row-as-built.md) — checkbox, wrapping title, relative date line, star, tap zones
- [Create Task and Create List sheets](./hipster/create-sheets-as-built.md) — compose, notes, reminder, star; name-only List
- [Task Detail](./hipster/task-detail-as-built.md) — fields, save-on-blur, subtasks, Mark completed, delete + undo
- [Reminder picker, deadline picker, Repeat dialog](./hipster/date-pickers-and-repeat-as-built.md)

**Hipster** — inputs and history
- [Wireframe geometry spec](./hipster/wireframe-geometry-spec.md) — what is actually drawn in the Penpot file
- [Google Tasks UX playbook](./hipster/google-tasks-ux-playbook.md) — patterns to copy
- [Hi-fi mockup is a Google Tasks clone riding an unused generic theme](./hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md) — critique of the hi-fi export

**Hacker** — as built (`evidence: strong`)
- [Tasks data model](./hacker/tasks-data-model-as-built.md) — TaskList, Task, Repeat, Subtask; what's deliberately absent
- [Tasks behaviour rules](./hacker/tasks-behaviour-rules-as-built.md) — order, grouping, date text, overdue, completion/repeat, delete; known defects
- [Notifications](./hacker/notifications-as-built.md) — ids, sync points, 9 AM deadline, lazy permission, tap-to-open
- [Tasks module architecture](./hacker/tasks-architecture-as-built.md) — folders, repositories, Cubits, View/Panel split
- [Theme tokens](./hacker/theme-tokens-as-built.md) — colors, fonts, −0.8 tracking, radii

**Hacker** — still current
- [Repeat-advance algorithm — next occurrence, and why there's no catch-up](./hacker/repeat-advance-algorithm.md) — the date math; as built it uses calendar arithmetic, not `Duration`
- [Offline task module architecture](./hacker/offline-task-module-architecture.md) — pasted model's Flutter stack sketch
- [Cubit or full BLoC?](./hacker/cubit-or-bloc.md) — answered: Cubit — see decision 0009
- [Which package schedules the reminder/deadline notifications?](./hacker/local-notifications-package.md) — answered: flutter_local_notifications — see decision 0010
- [Isar or sqflite?](./hacker/isar-or-sqflite.md) — answered: Isar, for Tasks only — see decision 0006
- [How does a Day differ from its Routine?](./hacker/day-versus-routine.md) — question, unanswered, blocks Clockface modelling — see decision 0005
- [Is the Clockface or the list the source of truth?](./hacker/clockface-or-list-source-of-truth.md) — question, unanswered, blocks Clockface modelling — see decision 0005

**Archived** — mockup-era specs, superseded 2026-10-06, kept in [`archive/santian/`](../../archive/santian/)

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
- [0009 — Cubit for the Tasks module's state management](./decisions/0009-cubit-for-state-management.md) — 2026-09-18
- [0010 — flutter_local_notifications for reminder and deadline notifications](./decisions/0010-flutter-local-notifications-package.md) — 2026-09-18
- [0011 — Keep the light/dark hue swap: blue by day, orange by night](./decisions/0011-blue-by-day-orange-by-night.md) — 2026-09-18
- ~~0012 — Icon set for the add-list picker grid~~ — [archived](../../archive/santian/decisions/0012-add-list-icon-set.md), superseded by 0017
- ~~0013 — Color palette for the add-list picker row~~ — [archived](../../archive/santian/decisions/0013-add-list-color-palette.md), superseded by 0017
- [0014 — First launch seeds one default List](./decisions/0014-first-launch-default-list.md) — 2026-09-22 (draft, awaiting the owner's confirmation; already built)
- [0015 — A deadline notification fires at 9:00 AM, same default as reminderAt](./decisions/0015-deadline-notification-defaults-to-9am.md) — 2026-09-22 (draft, awaiting the owner's confirmation; already built)
- [0016 — Follow the Google Tasks mobile app, not the hi-fi mockup](./decisions/0016-follow-google-tasks-mobile-over-the-mockup.md) — 2026-10-06 (draft)
- [0017 — Lists are name-only, managed from a More menu](./decisions/0017-lists-are-name-only.md) — 2026-10-06 (draft)

## Health check

Code exists now, so the bar has moved. The ten as-built notes are
`evidence: strong` because they describe shipped behaviour. Everything else
is still `none` or `weak`. The risk to watch is the one decision 0016 names:
behaviour changed in code without a note. If the app drifts again, re-read
the as-built notes against the Santian repo's `git log` before writing new
specs.
