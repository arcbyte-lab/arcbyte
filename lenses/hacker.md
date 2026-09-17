---
title: Hacker
lens: hacker
kind: brief
tags: [lens]
updated: 2026-09-16
---

# Hacker — the builder

**Owns:** whether it can be built, and how.

The hacker is the one who knows what is cheap and what is expensive. Bring it in
early, not at the end — a five-minute "that costs three weeks" saves a month of
designing the wrong thing.

## What to ask it

- What is the smallest version that proves the risky part works?
- Which part of this have I never built before? That is the spike.
- What does the data model look like? What are the entities, really?
- What breaks at 100 users? At 10,000? Do I care yet?
- What am I locking myself into if I choose this?

## What you can expect back

An estimate you should double, a list of unknowns, and usually one suggestion
that quietly changes the product. Listen to that one.

## What it must not do

Decide what to build. Decide it is not worth building because it is hard — that
is a trade-off for the intelligence lens, not a technical verdict.

## Artifact kinds here

`spike`, `architecture`, `data-model`, `risk`, `spec`, `analysis`

## Working with AI here

Models are strong at architecture sketches and terrible at knowing what your
codebase actually looks like. Two habits help. Give it real file names and real
constraints, not a general description. And treat every generated plan as a first
draft that you check against the code before you file it as `reviewed`.

When a spike is done, write down what it *proved*, in one line. That line is the
artifact. The code was just the experiment. Use
[templates/spike.md](../templates/spike.md).

## Where the code lives

Once the Flutter project exists, it sits at the repo root, not in here. Code
vocabulary belongs in a root `CONTEXT.md`. A hacker note links to those files
rather than copying them.

## Open questions

-

---
All hacker artifacts are listed in [INDEX.md](../INDEX.md).
