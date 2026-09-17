---
title: The Vision
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

# The Vision

> Synthesis document. Written from the thinking vault under `ideas/santian/`
> and the root glossary [`CONTEXT.md`](../CONTEXT.md). Every claim below
> traces to one of those artifacts; see the links inline. Part of
> [The Product Narrative](./product-narrative.md).

## What the creator wanted to bring into existence

Santian starts from one idea stated plainly in the root glossary: a day is made
of **Blocks** — spans of time with a start and a duration, "the core unit of the
whole product" — and a Block is "an interval, never a point in time"
([CONTEXT.md](../CONTEXT.md)). That single sentence is the whole vision in
miniature. Most planning tools, Google Tasks included, store a point: a due
date, a checkbox. Santian's glossary deliberately rules that shape out for its
core entity and commits to the interval instead.

The product pairs two views of the same day: a **Clockface**, where time runs
around a dial, and a **Block list**, where the same Blocks stack top to bottom
([CONTEXT.md](../CONTEXT.md)). The Clockface is present in every version of
the wireframe from the earliest exploratory frames onward
([wireframe geometry spec](../hipster/wireframe-geometry-spec.md)),
which is the strongest evidence in the repository that the radial, time-as-a-
circle view is not a late addition — it was part of the idea from the first
drawing.

## The standard the creator wanted

Two more pieces of the glossary describe the standard being aimed for:

- A **Routine** — what a typical day of the week looks like, with no dates
  attached — so a repeating pattern does not have to be re-entered by hand.
- A **Day** — one real calendar date, which starts from its Routine and can be
  changed without disturbing the pattern.

([CONTEXT.md](../CONTEXT.md)) The owner wants both a plan that repeats *and*
the freedom to change one day without rewriting the whole week —
[decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)
states this directly: "The owner wants a typical Tuesday **and** the ability to
change this particular Tuesday without changing every Tuesday." Nothing in the
vault explains this as solving somebody else's problem; it is stated as what
the product itself needs to be true, for its own sake.

## What the creator felt was missing from existing approaches

The vault never argues that Google Tasks is bad at its own job. What it argues,
implicitly, is that Google Tasks is the wrong *shape* for this idea: a flat
list of items with a due date has no way to draw an arc on a dial, because "you
cannot draw an arc from a point"
([is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md)).
That single line is the clearest statement in the repository of what the
creator believes existing task apps are missing: a notion of time as a shape
you can see, not just a deadline you can miss.

The gap is framed as a personal one, not a market one. When a hustler-lens
question asked what Santian does that would make someone leave Google Tasks
for it, the answer on file is that the question does not apply — see
[decision 0003](../decisions/0003-personal-tool-not-a-product.md).
The vision was never "the market needs a clock-shaped planner." The evidence
in this repository supports only a narrower, honest claim: **the creator wanted
one, for himself.**

## The perspective that motivated the project

Underneath the vocabulary work sits an earlier, discarded model. Before Santian,
the same problem was modelled as `timez_core`: a `Focus` aggregate with purely
weekly, dateless recurrence
([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
That model was "locked in an earlier grilling session" and then found wanting —
it could describe a typical Tuesday and nothing else, with no way to say "not
this Tuesday." The project's vision, in other words, was refined once already
before this vault existed: the creator tried a purely repeating model, found it
insufficient for how he actually wants to plan, and rebuilt the vocabulary
around Block, Routine, and Day to fix that gap.

This has not yet been validated. It has not been tested with a single other
person — see
[who plans their day by the clock?](../hound/who-plans-their-day-by-the-clock.md),
still unanswered, and the vault's own admission that "the whole idea rests on
one developer's own habit." What follows in this documentation treats the
vision as exactly that: a personal standard the creator is building toward, not
a validated market insight.

---
Part of [The Product Narrative](./product-narrative.md)
