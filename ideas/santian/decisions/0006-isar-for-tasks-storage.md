---
title: Isar for the Tasks data layer
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/isar-or-sqflite.md", "../hacker/task-list-subtask-data-model.md", "../hacker/offline-task-module-architecture.md", "../decisions/0005-clockface-questions-dont-block-tasks-build.md"]
tags: [artifact, decision]
---

## Decision

Use **Isar** for the Tasks data layer, scoped to Tasks only. The Clockface's
own storage question stays open and unrelated to this decision — see
[decision 0005](./0005-clockface-questions-dont-block-tasks-build.md).

## Context

[Isar or sqflite?](../hacker/isar-or-sqflite.md) was blocked on "is the
Clockface or the list the source of truth" until decision 0005 narrowed it to
a Tasks-only question, answerable from the three queries Tasks actually needs:
by list, by star, by day. Those queries and the shape of the data are both
now on record in
[the Task/List/Subtask data model](../hacker/task-list-subtask-data-model.md),
so the question can be answered without waiting on the Clockface.

## What each lens said

- **Hound:** not applicable — no real user asked about storage.
- **Hipster:** not applicable — this is a hacker/intelligence choice.
- **Hacker:** all three required queries (`listId` equality, `isStarred`
  boolean, `scheduledAt` date match) are plain indexed lookups. Either store
  handles them fine at this scale, so speed is not the tiebreaker — fit to the
  data shape is. The data model shows Subtask belongs to exactly one Task and
  is never shown queried on its own; that is Isar's embedded-object model
  directly, with no join needed. sqflite would model the same relationship as
  a foreign key and require a join (or a second query) to reassemble a Task
  with its subtasks. Isar's `watch()` also gives the already-chosen
  Cubit/BLoC layer (named in
  [the architecture note](../hacker/offline-task-module-architecture.md))
  reactive updates for free; sqflite needs a manual re-query-and-emit after
  every write. Isar's tradeoff: it is a smaller, community-maintained
  package next to sqflite's long track record, and if Subtasks ever need
  independent querying (a cross-task subtask list, for instance), Isar's
  embedded-object choice would need revisiting.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **sqflite.** Rejected for this scope, not in general. It is the safer,
  better-documented choice and models Subtask-as-foreign-key more
  conventionally, but that conventionality costs a join (or a second query
  plus manual mapping) for a relationship the data model shows is always
  accessed through its parent Task. No query in scope needs SQL's join
  strength.
- **Answering this for Clockface too, right now.** Rejected — that is exactly
  what decision 0005 postponed. The Clockface's storage shape depends on
  [whether it or the list is the source of truth](../hacker/clockface-or-list-source-of-truth.md),
  which is still open.

## How we will know we were wrong

If a real build needs to query Subtasks independently of their parent Task —
a cross-task subtask list or search, for instance — that breaks the embedded-
object assumption this decision rests on and sqflite's relational model
should be reconsidered. Also watch Isar's package maintenance status before
committing it in code: this decision was made from general knowledge of the
package shape, not a current check of `pub.dev`, per
`evidence: none`.

---
Part of [Santian](../README.md)
