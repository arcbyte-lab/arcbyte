---
title: The open Clockface hacker questions don't block starting the Tasks data layer
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../decisions/0002-build-tasks-before-clockface.md", "../hacker/day-versus-routine.md", "../hacker/clockface-or-list-source-of-truth.md", "../hacker/task-list-subtask-data-model.md"]
tags: [artifact, decision]
---

## Decision

[Decision 0002](./0002-build-tasks-before-clockface.md)'s Tasks-before-Clockface
build order also means the two open hacker questions about the Clockface —
[Day vs Routine](../hacker/day-versus-routine.md) and
[Clockface-or-list source of truth](../hacker/clockface-or-list-source-of-truth.md)
— do not block starting the Tasks data layer. They block Clockface, which isn't
being built yet.

## Context

The anchor note says Day-vs-Routine "blocks everything else." That line was
written 2026-09-16, before decision 0002 was made on 2026-09-17. Nobody went
back and corrected it once Clockface was scoped out of v1, so it was sitting
there ready to stall a Tasks-only start it no longer applies to.

## What each lens said

- **Hound:** unaffected — no real user asked about sequencing.
- **Hipster:** not applicable — this is a hacker/intelligence scoping call, not
  a design one.
- **Hacker:** [Isar or sqflite](../hacker/isar-or-sqflite.md) was blocked on
  "is the Clockface or the list the source of truth" because a point-in-time
  Task can't be drawn as a Clockface wedge, and the store choice depends on
  the shape of the data. That dependency is real for Clockface, but not for a
  Tasks-only build: the Tasks data layer only has to be internally
  consistent with itself. [The Task/List/Subtask data model](../hacker/task-list-subtask-data-model.md)
  read off the hi-fi mockup is enough to write the three queries Tasks
  actually needs (by list, by star, by day) and pick a store from that —
  without first reconciling Task's `scheduledAt` against a Clockface wedge
  that isn't being built yet.
- **Hustler:** not applicable, per [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Leave the anchor note's "blocks everything else" claim standing.**
  Rejected — it predates decision 0002 by a day and was never revisited. Left
  alone, it reads as a live blocker on a build decision 0002 already scoped
  around.
- **Force-answer Day-vs-Routine and Clockface-or-list-source-of-truth before
  writing any Tasks code.** Rejected — that is exactly the work decision 0002
  postponed by putting Clockface second. Forcing it now defeats the point of
  that ordering.

## How we will know we were wrong

If, once the Tasks data layer exists, adding Clockface later turns out to need
a breaking change to the Task schema — not an additive Clockface-side model —
that means these questions did block Tasks after all. The concrete tripwire:
[the data-model note](../hacker/task-list-subtask-data-model.md) flags one
mockup row ("Deep work: API migration", 11:00 AM – 1:00 PM) that already looks
like an interval, not a point. If that turns out to be real and common rather
than a one-off, this decision should be reversed before, not after, the store
is picked.

---
Part of [Santian](../README.md)
