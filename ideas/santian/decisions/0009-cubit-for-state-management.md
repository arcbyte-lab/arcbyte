---
title: Cubit for the Tasks module's state management
idea: santian
lens: intelligence
kind: decision
status: adopted
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/cubit-or-bloc.md", "../hacker/isar-schema.md", "./0003-personal-tool-not-a-product.md", "../hipster/tasks-list-screen-interactions.md"]
tags: [artifact, decision]
---

## Decision

Use **Cubit** (via `flutter_bloc`'s `Cubit` class), not full BLoC, for
Santian's Tasks-module state management — one Cubit per screen/feature area
(e.g. `TasksListCubit`, `TaskDetailCubit`), each subscribing to an
[Isar `watch()` stream](../hacker/isar-schema.md) and emitting state
directly from method calls.

## Context

[The architecture note](../hacker/offline-task-module-architecture.md)
named "BLoC or Cubit" without choosing — an unvalidated model default, the
same situation [Isar or sqflite?](../hacker/isar-or-sqflite.md) was in
before decision 0006. Asked to settle it now that every Tasks-module screen
has a resolved interaction spec and [the Isar schema](../hacker/isar-schema.md)
exists to build against.

## What each lens said

- **Hound:** not applicable — no real user has an opinion on state
  management.
- **Hipster:** every resolved Tasks-module interaction — tab switch,
  checkbox tap, FAB, Create Task submit, delete, star toggle — is a single
  direct user action producing one state change. None of the spec'd screens
  have a multi-step workflow that would benefit from an explicit,
  inspectable event trail.
- **Hacker:** this is the lens the decision lives in. Full BLoC's
  event-class-plus-`on<Event>`-handler ceremony buys auditability and
  testability that pays off across larger apps or teams with several
  contributors touching the same state machine. Cubit's direct-method-call
  model gets the same `flutter_bloc` widget integration (`BlocProvider`,
  `BlocBuilder`) and the same compatibility with
  [Isar's `watch()` streams](../hacker/isar-schema.md) (subscribe once in
  the Cubit's constructor, `emit()` on each stream event) without the event
  layer in between.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Full BLoC.** Rejected — its event-sourcing ceremony is built for teams
  needing a strict, replayable audit trail across many contributors.
  [Decision 0003](./0003-personal-tool-not-a-product.md) already settled
  that Santian has an audience of one developer; the ceremony has no
  payoff here.
- **Riverpod.** Considered, not chosen. Arguably even less boilerplate than
  Cubit for a solo developer, and a real contender in the abstract — but it
  wasn't one of the two options [the original architecture
  sketch](../hacker/offline-task-module-architecture.md) named, and
  switching frameworks entirely is a bigger unforced change than choosing
  between two options already on the table. Not ruled out permanently — see
  "How we will know we were wrong."
- **Plain `setState`/`ChangeNotifier`.** Rejected — doesn't compose cleanly
  once multiple screens need to react to the same underlying Isar
  collection (e.g. every List tab's task count needs to update when any
  screen writes a Task), which is exactly the shared-reactive-state problem
  Cubit plus `watch()` solves directly.

## How we will know we were wrong

If building the first real screen (Tasks List) with Cubit feels like
fighting the pattern — the `BlocProvider` tree adding real friction for a
one-developer app with no team to coordinate — that's the signal to try
Riverpod or a simpler direct `StreamBuilder` approach instead, not a sign
this decision was made carelessly.

---
Part of [Santian](../README.md)
