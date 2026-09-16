---
title: Intelligence
lens: intelligence
kind: brief
tags: [lens]
updated: 2026-09-16
---

# Intelligence — the synthesis lens

**Owns:** deciding.

This lens is not in the original article. It exists because you are one person
playing four roles, and somebody has to hold the four views together and choose.
That is a different job from any of the four, and it is the one that goes missing
when you work alone — which is usually why the thinking feels like it is going in
circles.

## What to ask it

- What do the four lenses disagree about right now?
- What is the single next question that would unblock the most work?
- What am I avoiding because it is boring or scary?
- Which artifacts are still `draft` that I keep pretending I have read?
- Has the bet in the anchor note changed since I wrote it?

## What you can expect back

A decision note, or a shorter list. Its main output is removal: killing
questions that no longer matter.

## Artifact kinds here

`decision`, `digest`, `brief`

## The rule for this lens

A decision note is only finished when it says how you will know it was wrong.
Without that line it is not a decision, it is a mood.

## Open questions

- 

## Everything still in draft

```dataview
TABLE idea, lens, kind, source, created
FROM #artifact
WHERE status = "draft"
SORT created ASC
```

## All decisions

```dataview
TABLE idea, created
FROM #decision
SORT created DESC
```
