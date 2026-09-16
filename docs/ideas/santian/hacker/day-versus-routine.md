---
title: How does a Day differ from its Routine?
idea: santian
lens: hacker
kind: question
status: draft
source: claude-opus-5 (cowork)
evidence: none
created: 2026-09-16
updated: 2026-09-16
inputs: ["../decisions/0001-rethink-the-focus-aggregate.md"]
tags: [artifact, question]
---

## The question

A Routine says what a typical Tuesday looks like. A Day is one real Tuesday the
user can change. When the user moves this Tuesday's 09:00 Block to 10:00, what
is actually stored?

## Why it matters

[Decision 0001](../decisions/0001-rethink-the-focus-aggregate.md) retired the
`Focus` aggregate but did not name a replacement. This is the replacement. It is
also the single place where planner apps of this shape go wrong.

## The two shapes

**Override.** The Routine stays clean. The change is stored as an adjustment
attached to that date. A Day is computed: take the Routine for its DayOfWeek,
apply any overrides.

- Cheap to store. Empty days cost nothing.
- Every read is a computation. The Clockface has to resolve before it can draw.
- "Delete this one Block, just today" needs a tombstone — an override that
  represents an absence. Easy to forget, and the usual source of ghost blocks.

**Materialise.** The first time a Day is touched, it is copied out of the Routine
into real records. From then on the Day is independent.

- Simple to read and simple to draw.
- Storage grows with every day the user opens.
- Creates a hard question: a Day materialised in the past is now frozen.

## The scenario that separates them

You change the Routine: Tuesday gym moves from 09:00 to 07:00, permanently.

- What happens to **next** Tuesday, which you already adjusted by hand?
- What happens to **last** Tuesday, which has already been lived?

Almost every user expects the past to stay as it was lived and the future to
follow the new Routine. Under override, that means the Routine needs an
effective-from date, or history rewrites itself the moment you edit it. Under
materialise, the past is safe for free, but you must decide how far ahead to
materialise — and every unmaterialised future day still changes.

That "effective-from" requirement is the part that is easy to miss and expensive
to retrofit.

## A third possibility worth naming

Materialise the past and today, compute the future. The boundary moves forward
each night. It gets both properties, at the cost of a background job and a
harder mental model.

## How I could answer it

- Cheapest way: answer the two bullets in the scenario above on paper. What
  *should* happen to last Tuesday and next Tuesday? Ten minutes.
- Best way: a throwaway prototype that edits a Routine after a Day has been
  adjusted, and see which behaviour feels wrong.

## Answer

Empty. When answered, this becomes decision 0002 — it is hard to reverse and
worth recording why.

---
Part of [Santian](../README.md)
