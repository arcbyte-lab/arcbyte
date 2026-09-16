---
title: Santian
idea: santian
lens: intelligence
kind: brief
status: draft
source: me
evidence: none
created: 2026-09-16
updated: 2026-09-16
tags: [anchor]
---

# Santian

> The anchor note. The only note here that must stay current. Blank sections are
> blank on purpose — nobody has answered them yet. Do not fill them with guesses.

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
adjust. Vocabulary lives in [CONTEXT.md](../../../CONTEXT.md).

## Status by lens

| lens | where it stands |
|---|---|
| [Hound](../../lenses/hound.md) | Nothing. No real person has been asked anything. One open question. |
| [Hipster](../../lenses/hipster.md) | A wireframe exists and has been described precisely. The interactions are intentions, not drawings. |
| [Hacker](../../lenses/hacker.md) | One model-generated stack sketch, now out of date. Old aggregate retired, replacement undecided. |
| [Hustler](../../lenses/hustler.md) | Nothing. One open question. |

## Next question to answer

[How does a Day differ from its Routine?](./hacker/day-versus-routine.md)
Decision 0001 retired the old aggregate without naming a replacement. This is
the replacement, and nothing else can be modelled until it is answered.

## Artifacts

**Hound**
- [Who plans their day by the clock?](./hound/who-plans-their-day-by-the-clock.md) — question, unanswered

**Hipster**
- [Wireframe geometry spec](./hipster/wireframe-geometry-spec.md) — what is actually drawn in the Penpot file
- [Google Tasks UX playbook](./hipster/google-tasks-ux-playbook.md) — patterns to copy

**Hacker**
- [Offline task module architecture](./hacker/offline-task-module-architecture.md) — model's Flutter stack sketch
- [How does a Day differ from its Routine?](./hacker/day-versus-routine.md) — question, unanswered, blocks everything else
- [Is the Clockface or the list the source of truth?](./hacker/clockface-or-list-source-of-truth.md) — question, unanswered
- [Isar or sqflite?](./hacker/isar-or-sqflite.md) — question, unanswered, blocked by both of the above

**Hustler**
- [Why would anyone switch from Google Tasks?](./hustler/why-switch-from-google-tasks.md) — question, unanswered

**Assets**
- [Wireframe snapshot](./assets/santian-wireframe-snapshot.png)

## Decisions

- [0001 — Rethink the Focus aggregate](./decisions/0001-rethink-the-focus-aggregate.md) — 2026-09-16

## Health check

Three of six artifacts are open questions, and every filled artifact has
`evidence: none` or `weak`. That is normal this early. It stops being normal once
code exists.
