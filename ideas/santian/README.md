---
title: Santian
idea: santian
stage: idea
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

`stage: idea`. No code exists yet, so this is still thinking only. It becomes a
`project` the day a repository is started — that is the owner's call and needs
its own decision note. See [Arcbyte's glossary](../../CONTEXT.md) for what the
two words mean here.

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
| [Hipster](../../lenses/hipster.md) | A hi-fi mockup now exists for the 8 core Tasks screens, light and dark. It reads as a close Google Tasks clone on a generic, partly-unedited theme — see open questions. [Add-list method](./hipster/add-list-method.md) designs the not-yet-drawn "create a list" flow. |
| [Hacker](../../lenses/hacker.md) | Task/List/Subtask fields now read off the hi-fi mockup — see [data model](./hacker/task-list-subtask-data-model.md). [Decision 0005](./decisions/0005-clockface-questions-dont-block-tasks-build.md) says the two Clockface questions don't gate a Tasks-only build. [Decision 0006](./decisions/0006-isar-for-tasks-storage.md) picks Isar for the Tasks data layer; the Clockface's own storage question is still open. |
| [Hustler](../../lenses/hustler.md) | Mostly closed for this idea — no market, no pricing, no channel. See decision 0003. |

## Next question to answer

**Repeat's actual shape** — the "Repeat" row on Task Detail opens something
not included in the hi-fi export. Along with what `deadline` actually does
(still open in [the data model note](./hacker/task-list-subtask-data-model.md)),
this is what's left before the Task schema is final. Subtask's fields are now
settled — see that note.

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

**Hacker**
- [Offline task module architecture](./hacker/offline-task-module-architecture.md) — model's Flutter stack sketch
- [Task, List and Subtask fields, read off the hi-fi mockup](./hacker/task-list-subtask-data-model.md) — data model inventory, flags an unresolved Deadline-vs-DateTime split and one interval-shaped task row
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

## Health check

Three of six artifacts are open questions, and every filled artifact has
`evidence: none` or `weak`. That is normal this early. It stops being normal once
code exists.
