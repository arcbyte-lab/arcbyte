---
title: Isar or sqflite?
idea: santian
lens: hacker
kind: question
status: draft
source: claude-opus-5 (cowork)
evidence: none
created: 2026-09-16
updated: 2026-09-18
inputs: ["./offline-task-module-architecture.md", "./task-list-subtask-data-model.md", "../decisions/0005-clockface-questions-dont-block-tasks-build.md"]
tags: [artifact, question]
---

## The question
Which local store for the offline task data: Isar or sqflite?

## Blocked by
~~[Is the Clockface or the list the source of truth?](./clockface-or-list-source-of-truth.md).
You cannot choose a store before you know what shape the data is.~~ That block
holds for the Clockface's own storage. It does not hold for a Tasks-only
build — see
[decision 0005](../decisions/0005-clockface-questions-dont-block-tasks-build.md).
This note answers the Tasks-only question.

## Why it matters
It is the first thing that is expensive to change later, and
[offline task module architecture](./offline-task-module-architecture.md) names
both without choosing. A model listed the options; nobody has checked either one
against this app's real queries or against the current state of both packages.

## How I could answer it
- Cheapest way: write down the three queries the clockface actually needs, then
  see which store expresses them more simply.
- Best way: a one-day spike on each, storing a week of real blocks, and measure.
  Then file the result with `templates/spike.md`.

## Answer
**Isar**, scoped to Tasks only — see
[decision 0006](../decisions/0006-isar-for-tasks-storage.md) for the full
reasoning. Short version: the three queries Tasks needs (by list, by star, by
day) are plain indexed lookups either store handles fine, so the tiebreaker is
fit, not speed. [The data model](./task-list-subtask-data-model.md) shows
Subtask only ever belonging to one Task, never queried on its own — that is
Isar's embedded-object shape with no join required. Isar's built-in
`watch()` also pairs directly with the Cubit/BLoC pattern named in
[the architecture note](./offline-task-module-architecture.md) without a
manual re-query-and-emit step. sqflite remains the fallback if Subtasks ever
need independent querying, which nothing in the mockup shows today.

---
Part of [Santian](../README.md)
