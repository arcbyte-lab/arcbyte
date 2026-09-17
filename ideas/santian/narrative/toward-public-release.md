---
title: Toward Public Release
idea: santian
lens: intelligence
evidence: weak
created: 2026-09-17
kind: narrative
status: draft
source: claude-sonnet-5 (cowork)
updated: 2026-09-17
tags: [product-narrative]
---

# Toward Public Release

> Synthesis document. Part of [The Product Narrative](./product-narrative.md).
> There is no community, invitation system, beta program, or audience strategy
> in this repository, and none is invented here. This document describes where
> the experiment stands and what stands between it and being usable at all —
> for its one intended user first.

## The current state of the product

No app exists. The root `README.md` says so directly: "The app code does not
exist yet." What exists is a settled vocabulary, one retired domain model, a
confirmed two-view design pairing (Clockface and Block list), a confirmed
choice to clone Google Tasks' interaction model for the Tasks module
specifically
([decision 0004](../decisions/0004-clone-google-tasks-interactions.md)),
and a confirmed build order that puts the Tasks module first
([decision 0002](../decisions/0002-build-tasks-before-clockface.md)).
See [The Core Identity](./core-identity.md) for the full breakdown of what is
settled versus still open.

## What has already been established

- A domain model that survived being rethought once: Block, Routine, Day,
  Clockface, Block list ([CONTEXT.md](../CONTEXT.md)), replacing the earlier
  `timez_core` / `Focus` model
  ([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
- A scope decision that removes an entire category of work — positioning,
  pricing, channel — for as long as it stands
  ([decision 0003](../decisions/0003-personal-tool-not-a-product.md)).
- A design direction for the Tasks module's interactions, validated end to end
  in a working hi-fi mockup covering compose, detail, date picking, and
  starring, in light and dark
  ([hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)).
- A discipline for how decisions get made and recorded: every adopted decision
  in `decisions/` states what was rejected and how the project will know if it
  was wrong. That is present in all four decisions on file to date.

## What still needs to be explored

Three hacker-lens questions are open and explicitly chained by blocking
relationships:

1. [How does a Day differ from its Routine?](../hacker/day-versus-routine.md) —
   override, materialise, or a hybrid boundary. Named as blocking everything
   else that touches the data model.
2. [Is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md) —
   has a concrete test attached (two Blocks both at 14:00–15:00) that has not
   been run yet.
3. [Isar or sqflite?](../hacker/isar-or-sqflite.md) — explicitly
   blocked by both of the above; cannot be answered first.

Separately, the entire premise behind the Clockface — that time-as-a-dial beats
a flat list for planning a day — has one open, unanswered hound question behind
it: [who plans their day by the clock?](../hound/who-plans-their-day-by-the-clock.md).
Under [decision 0003](../decisions/0003-personal-tool-not-a-product.md)
this no longer needs to hold for a market; it still needs to hold for the
owner, and nothing in the repository records that it has been checked even at
that scale.

## What still needs refinement

- The visual theme under the hi-fi mockup is flagged as generic and only
  partly exploited — "riding an unused generic theme" — separately from the
  interaction-model question decision 0004 already settled
  ([hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)).
- The pasted architecture sketch
  ([offline task module architecture](../hacker/offline-task-module-architecture.md))
  is filed `evidence: none` and is, by its own note, "a model's default
  Flutter stack, not a decision." It has not been checked against a real
  build, and its `Task(ID, Title, Notes, DueDate, IsCompleted)` shape is the
  same point-in-time shape that the Clockface question found incompatible with
  drawing a dial. It needs to be revised once the Day/Routine and
  source-of-truth questions are answered, not built as-is.

## What must happen before the product is usable at all

Reading the vault's own stated blocking order: the Day-versus-Routine storage
question must be answered before the data model can be finished; the
Clockface-versus-list source-of-truth question must be answered before Isar or
sqflite can be chosen; and only then does
[decision 0002](../decisions/0002-build-tasks-before-clockface.md)'s
build order — Tasks module first, Clockface after — become buildable rather than
theoretical. None of this requires anything beyond the owner's own decision-
making; it is not blocked on outside input, because there is no outside input
in this project's plan.

## The direction the project is currently taking

Two things are true about the current direction at once, and the vault does
not resolve the tension between them, so this document does not either. First,
the project has deliberately postponed its own differentiator — the decision
to build Tasks before Clockface accepts, in its own words, the risk that "if
the Tasks module ships and the owner still cannot answer why anyone would
switch from Google Tasks, then building Tasks first bought nothing." Second,
under decision 0003 that question no longer needs an answer for a stranger —
only, eventually, for the owner himself, through continued use. The project
is, right now, building the less-differentiated half of itself first, on the
belief that the harder half — the Clockface, and the storage model underneath
both views — is worth getting right rather than getting fast.

This is where the experiment stands today, and this is where it is heading:
toward settling the data model next, because three separate artifacts in this
vault independently point at the same unresolved question as the one that
blocks the rest.

---
Part of [The Product Narrative](./product-narrative.md)
