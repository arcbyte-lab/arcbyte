---
title: Is the Clockface or the list the source of truth?
idea: santian
lens: hacker
kind: question
status: draft
source: claude-opus-5 (cowork)
evidence: none
created: 2026-09-16
updated: 2026-09-16
inputs: ["./offline-task-module-architecture.md", "../hipster/wireframe-geometry-spec.md"]
tags: [artifact, question]
---

## The question
The wireframe has a `Clockface` tab and a `Tasks` tab. Are they two views of the
same data, two genuinely different entities, or is one of them a projection of
the other?

## Why it matters

Two artifacts in this vault already disagree, and neither one knows it.

[Offline task module architecture](./offline-task-module-architecture.md) defines
the Task as `(ID, Title, Notes, DueDate, IsCompleted)`. That is the Google Tasks
shape. A `DueDate` is a **point** in time.

[Wireframe geometry spec](../hipster/wireframe-geometry-spec.md) puts a
`Clockface` at the top of every frame. A wedge on a dial needs a **start and a
duration** — an interval.

You cannot draw an arc from a point. So either that Task model is wrong, or the
Clockface is not showing Tasks. Every data-layer decision, including
[Isar or sqflite](./isar-or-sqflite.md), is downstream of this and cannot be
made first.

## The test that settles it

Two things both sit at 14:00–15:00.

A list holds both quite happily. A dial physically cannot draw them without
collision. **Whichever view refuses the overlap is the source of truth; the
other one is a projection.** If neither refuses, the Clockface is decoration and
this is a list app.

## Two more scenarios that sharpen it

- **The untimed thing.** "Buy milk", no time. Does it exist? If yes, a Task and a
  slot of time are different entities. If no, there is no task list — only a
  schedule.
- **The overrun.** A 09:00–10:00 block, still going at 10:30. If the wedge
  stretches, a slot has a *planned* interval and an *actual* interval. That is
  two intervals, and it changes the whole store.

## How I could answer it
- Cheapest way: answer the overlap test above on paper. Ten minutes.
- Best way: a throwaway prototype of the dial with two overlapping entries, and
  see which behaviour feels wrong.

## Answer
Empty. When answered, this becomes a decision note in `../decisions/` — it is
hard to reverse and worth recording why.

---
Part of [Santian](../README.md)
