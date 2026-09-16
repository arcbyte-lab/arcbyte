---
title: Hipster
lens: hipster
kind: brief
tags: [lens]
updated: 2026-09-16
---

# Hipster — the designer

**Owns:** what the thing feels like to use.

The hipster turns an insight into a working shape. It is the bridge between what
the hound found and what the hacker builds. Its natural failure mode is making
something beautiful that solves a problem nobody has, so a hipster note should
always name the hound insight it is serving.

## What to ask it

- What is the one screen this product lives or dies on?
- What can I remove? What is the version with half the features?
- Where does the user hesitate, and why?
- What does the empty state look like? What does the failure state look like?
- Is this interaction familiar, or am I asking people to learn something new?

## What you can expect back

A flow, a sketch, or a sharp critique of an existing screen. Also a lot of
opinions about spacing. Take the structure seriously and the decoration lightly.

## What it must not do

Decide feasibility. Decide pricing. Invent user needs — those come from the
hound.

## Artifact kinds here

`flow`, `wireframe`, `critique`, `spec`, `analysis`

## Working with AI here

This is where models are genuinely useful, in two ways. First, give it a
screenshot and ask for a critique — a model is a fast, tireless, slightly dumb
reviewer. Second, ask for three different layouts for the same screen, then
throw away two. Ask for options, not for the answer.

Put images in the idea's `assets/` folder and link them from the note, so the
note that analyses a screen always sits next to the screen itself.

## Open questions

- 

## All hipster artifacts

```dataview
TABLE idea, kind, status, source
FROM #artifact
WHERE lens = "hipster"
SORT updated DESC
```
