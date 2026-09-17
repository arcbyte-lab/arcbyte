---
title: Product Narrative
idea: santian
lens: intelligence
evidence: weak
created: 2026-09-17
kind: narrative
status: draft
source: claude-sonnet-5 (cowork)
updated: 2026-09-17
tags: [product-narrative, entry-point]
---

# Product Narrative

> The entry point for anyone new to Santian. This document stands on its own;
> the five files beside it — [The Vision](./vision.md),
> [The Experiment](./experiment-synthesis.md),
> [The Core Identity](./core-identity.md),
> [The Personal Dimension](./personal-dimension.md), and
> [Toward Public Release](./toward-public-release.md) — go deeper on each
> section below, with links back to the underlying artifacts in
> [`ideas/santian/`](../README.md) and the root glossary,
> [`CONTEXT.md`](../CONTEXT.md). Everything here traces to one of those
> sources; nothing is invented for this document. Written from the vault as it
> stood on 2026-09-17.

## The Vision

Santian's root glossary defines its core entity, a **Block**, as "a span of
time with a start and a duration... an interval, never a point in time"
([CONTEXT.md](../CONTEXT.md)). That one line rules out the shape most task
apps use — a due date, a checkbox — because a point in time cannot be drawn as
a wedge on a clock. The product pairs a **Clockface** (time drawn around a
dial) with a **Block list** (the same day, stacked top to bottom), a pairing
present in the wireframe from its very first exploratory frame. It also pairs a
repeating **Routine** (what a typical Tuesday looks like) with a specific
**Day** (this Tuesday, adjustable without touching the pattern) — the owner
wanted both a plan that repeats and the freedom to break the pattern for one
date. See [The Vision](./vision.md) for the full account.

## The Experiment

Before this vocabulary existed, the same idea was modelled as `Focus`, an
aggregate with purely weekly, dateless recurrence. That model was retired
because it could describe a typical Tuesday and nothing else — it had no way
to say "not this Tuesday"
([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
A separate experiment — laying a pasted, unvetted architecture sketch next to
the Clockface wireframe — surfaced a second, sharper conflict: the sketch's
`Task` model used a due date (a point), but a dial needs an interval; "you
cannot draw an arc from a point"
([is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md)).
A high-fidelity mockup of the Tasks module was then built and reviewed, and
found to read as a near-literal Google Tasks clone — which became a named,
deliberate choice
([decision 0004](../decisions/0004-clone-google-tasks-interactions.md))
rather than an accident. See [The Experiment](./experiment-synthesis.md) for
the full sequence.

## The Core Identity

With no app built yet, "current identity" means what has moved from open
question to settled decision: the Block/Routine/Day/Clockface/Block-list
vocabulary; the two-view pairing; and the choice to clone Google Tasks'
interaction model for the Tasks module specifically, so design effort stays on
"the Clockface pairing and being offline-first," which decision 0004 calls the
actual reason Santian exists. Still open, and named in the vault as blocking
everything past it: how a Day diverges from its Routine, and whether the
Clockface or the Block list is the source of truth for the data — with the
local storage choice (Isar or sqflite) explicitly blocked behind both. See
[The Core Identity](./core-identity.md) for what is settled, what is
experimental, and what has been ruled out.

## The Personal Dimension

Santian is being built for its own creator, not for strangers. This was not
the project's starting premise — it followed from a hustler-lens question,
"why would anyone switch from Google Tasks?", whose honest answer was "nobody
needs to. This is for him"
([decision 0003](../decisions/0003-personal-tool-not-a-product.md)).
That decision closes off pricing, positioning, and channel work, and reframes
the open question of who plans their day by a clock as self-knowledge rather
than market research — without marking it answered. It does not lower the
design bar: the same decision states the product "still has to work for one
real person using it daily." See
[The Personal Dimension](./personal-dimension.md) for where this shaped actual
decisions, and where it deliberately did not.

## What Has Been Learned

The most consequential finding in the record is a modelling conflict: a
due-date-shaped Task cannot be the source of a Clockface, because an interval
cannot be drawn from a point. This single finding invalidated the pasted
architecture sketch's core data shape and is the reason the Day-versus-Routine
and source-of-truth questions remain open rather than quietly assumed. A
second finding, from the hi-fi mockup review, is that the Tasks module's
interaction design had drifted into a near-exact Google Tasks clone without
anyone deciding that on purpose — naming it turned a silent drift into
[an explicit, defensible decision](../decisions/0004-clone-google-tasks-interactions.md).
A third, unresolved finding: no real person, including the owner in any
documented way, has yet confirmed the premise that planning by a clock beats a
list. That question has been open since the idea's first day and stays open.

## Toward Public Release

There is no community, invitation system, or audience plan for Santian, and
this document does not invent one. What exists is a settled vocabulary, a
confirmed design direction for one module, and three explicitly chained open
questions — Day-versus-Routine storage, Clockface-versus-list source of truth,
and Isar-versus-sqflite — that the vault itself says must be answered in that
order before the data model, and therefore the build, can proceed. The project
has also made a named trade-off: it is building the less-differentiated Tasks
module first, accepting the stated risk that if it ships without answering why
anyone would switch from Google Tasks, "building Tasks first bought nothing"
([decision 0002](../decisions/0002-build-tasks-before-clockface.md)).
See [Toward Public Release](./toward-public-release.md) for the full picture.

## Current State

What is true about Santian today, as this repository records it:

- **No app code exists.** The root `README.md` states this directly.
- **The domain model has been rethought once** — from `Focus` (pure weekly
  recurrence) to Block / Routine / Day — and the replacement is only partly
  specified.
- **Four decisions are on record**, each stating what it rejected and how the
  project would know if it were wrong: retire `Focus`
  ([0001](../decisions/0001-rethink-the-focus-aggregate.md),
  adopted); build Tasks before Clockface
  ([0002](../decisions/0002-build-tasks-before-clockface.md),
  draft); Santian is a personal tool, not a product
  ([0003](../decisions/0003-personal-tool-not-a-product.md),
  draft); clone Google Tasks' interaction model, change only the visual skin
  ([0004](../decisions/0004-clone-google-tasks-interactions.md),
  adopted).
- **Three chained questions block further modelling**: Day-versus-Routine
  storage, Clockface-versus-list source of truth, and Isar-versus-sqflite.
- **No real-person research exists.** The one hound-lens question on file —
  who plans their day by a clock — has been open since the idea's first day
  and remains unanswered, reframed by decision 0003 as a question about the
  owner rather than a market, but not closed.

---
Part of [Santian](../README.md) · Part of [Arcbyte](../../../README.md)
