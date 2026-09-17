---
title: Rethink the Focus aggregate
idea: santian
lens: intelligence
kind: decision
status: adopted
source: me
evidence: weak
created: 2026-09-16
updated: 2026-09-16
inputs: ["../hacker/day-versus-routine.md"]
tags: [artifact, decision]
---

## Decision

Santian moves away from the `timez_core` model, where `Focus` is the aggregate
root and recurrence is purely weekly and dateless. The product needs **both** a
repeating weekly pattern and real calendar dates the user can adjust. `Focus`
cannot express the second one.

## Context

The `timez_core` model was locked in an earlier grilling session: `Focus` as
aggregate root with weekly dateless recurrence over `repeat_day`; `TimeBlock` as
a value object ordered by `start_at`, with `end_at <= start_at` meaning it
crosses midnight; no overlapping blocks, enforced by a stateless
`OverlapChecker` over a `DayOfWeek` read-model; `Schedule` retired in favour of
`Focus`.

That model has no notion of a specific date. You can describe a typical Tuesday
and nothing else. The owner wants a typical Tuesday **and** the ability to change
this particular Tuesday without changing every Tuesday.

## What each lens said

- **Hound:** nothing. Still no real user input on either model.
- **Hipster:** the wireframe has a Clockface and a list, and neither says
  anything about repetition. It does not decide this.
- **Hacker:** template-plus-override is meaningfully harder than pure weekly
  recurrence. It is where most planner apps break.
- **Hustler:** pure weekly recurrence with no dates is a narrower product than
  Google Tasks, which does both. This widens the gap in the right direction.

## Options rejected

- **Keep `Focus` as-is.** Cheapest, and the model is already locked and tested.
  Rejected because it cannot represent "this Tuesday only", which the owner says
  the product needs.
- **Drop recurrence entirely and plan one real day at a time.** Simplest of all,
  and briefly the stated direction in this vault. Rejected for the same reason
  in reverse: the repeating pattern is the thing that saves the user work.

## What this does not decide

The replacement. This note records that `Focus` is retired, not what stands in
its place. That is
[how does a Day differ from its Routine?](../hacker/day-versus-routine.md), and
it is unanswered.

## How we will know we were wrong

If, after building it, the override machinery is never used — the user edits the
Routine nearly every time instead of adjusting a single Day — then dateless
weekly recurrence was right and this added complexity for nothing.

## Note added 2026-09-16

The repeating weekly plan was unnamed when this decision was written. It is now
called a **Routine**. That word had been removed from the project earlier the
same day, on the belief that nothing repeated; it came back because it is the
right English word for the concept. The repo folder name `RoutineApp` is
unrelated and predates the term.

---
Part of [Santian](../README.md)
