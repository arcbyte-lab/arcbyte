---
title: Clone Google Tasks' interaction model, only change the visual skin
idea: santian
lens: intelligence
kind: decision
status: adopted
source: me
evidence: weak
created: 2026-09-17
updated: 2026-09-17
inputs: ["../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md", "../hipster/google-tasks-ux-playbook.md"]
tags: [artifact, decision]
---

## Decision

Santian's Tasks module deliberately reuses Google Tasks' interaction model —
bottom-sheet compose, list/clock/star icon row for date/subtasks/star, pill
"Mark completed" button, month-grid date picker — and only changes the visual
skin (color, type, corner radius). This is a choice, not accidental drift.

## Context

[The hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)
flagged that the new hi-fi export reads as a near-literal Google Tasks clone
closely enough that a side-by-side screenshot would need labels, and asked
whether that was intentional or something the design drifted into. Asked
directly, the answer is: intentional.

## What each lens said

- **Hound:** unaffected directly — no real user has weighed in either way —
  but it removes one unknown. If the interaction model is a known-good
  pattern the owner already uses daily in the real Google Tasks app, there is
  less risk of building something a daily driver turns out to dislike.
- **Hipster:** this is the lens the decision lives in. The mockup already
  demonstrates the pattern works end to end (compose, detail, date, star).
  Nothing about the visual skin — color tokens, type, radius — is
  constrained by this decision; only the interaction shapes are fixed.
- **Hacker:** favorable. A known interaction model is easier to scope: the
  Task model, subtask relationship, and date/time fields can follow a
  pattern that already has a working real-world implementation, instead of
  inventing a novel one.
- **Hustler:** not applicable — see
  [decision 0003](./0003-personal-tool-not-a-product.md). Cloning a
  competitor's interaction model would matter for positioning if this were a
  product; it does not matter for a personal tool with an audience of one.

## Options rejected

- **Design an original interaction model.** Rejected — there is no user
  problem with Google Tasks' interactions that Santian is trying to solve.
  The reason Santian exists is the Clockface pairing and being offline-first,
  not a better way to compose a task. Inventing new interaction patterns here
  would spend effort on a part of the app that isn't the point.
- **Leave it unresolved and let the resemblance be incidental.** Rejected —
  that was the state before this decision, and it left the hi-fi mockup's
  main finding as an open question instead of a settled scope boundary.

## How we will know we were wrong

If a real daily-use friction shows up that traces back to a Google Tasks
pattern specifically (not a Santian-specific bug) — for example, the
bottom-sheet compose feels wrong once the Clockface view is also in play —
that's the signal to stop treating this as a settled boundary and design
something Santian-specific instead.

---
Part of [Santian](../README.md)
