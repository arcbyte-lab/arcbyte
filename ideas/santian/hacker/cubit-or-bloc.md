---
title: Cubit or full BLoC?
idea: santian
lens: hacker
kind: question
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./offline-task-module-architecture.md", "./isar-schema.md", "../decisions/0003-personal-tool-not-a-product.md", "../hipster/tasks-list-screen-interactions.md"]
tags: [artifact, question]
---

## The question
Cubit or full BLoC for the Tasks module's state management?

## Blocked by
Nothing — unlike the Clockface's open hacker questions, this is answerable
from what's already resolved: every Tasks-module screen has a settled
interaction spec, and [the Isar schema](./isar-schema.md) exists to build
against.

## Why it matters
[The architecture note](./offline-task-module-architecture.md) named "BLoC
or Cubit" without choosing — the same unvalidated-default situation
[Isar or sqflite?](./isar-or-sqflite.md) was in before decision 0006. State
management shapes how every screen wires to Isar's `watch()` streams, and
it's expensive to swap after real screens are built on top of it.

## How I could answer it
- Cheapest way: check what each pattern actually costs to wire up for the
  screens already spec'd — reactive per-list counts, checkbox toggle with
  reorder-to-bottom, a compose sheet, an undo toast — and see which fits
  with less ceremony.
- Best way: build Tasks List both ways and compare directly. Real
  implementation effort for what amounts to a boilerplate question on a
  personal tool — not worth it before writing any code at all.

## Answer
**Cubit** — see [decision 0009](../decisions/0009-cubit-for-state-management.md)
for the full reasoning. Short version: full BLoC's event-class-plus-handler
ceremony solves a problem — an auditable event trail across many
contributors — that [decision 0003](../decisions/0003-personal-tool-not-a-product.md)
already ruled out: one developer, personal tool. Every resolved Tasks
interaction (tab switch, checkbox tap, FAB, sheet submit, delete, star
toggle) is a single direct user action producing one state change — Cubit's
shape exactly, not a stream of named events needing replay or audit. Cubit
still subscribes to Isar's `watch()` stream the same way BLoC would; it just
skips the event layer in between.

---
Part of [Santian](../README.md)
