---
title: First launch seeds one default List
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-22
updated: 2026-09-22
inputs: ["../../../archive/santian/hipster/add-list-method.md", "../../../archive/santian/hipster/tasks-list-screen-interactions.md"]
tags: [artifact, decision]
---

## Decision

Proposed, not yet adopted — see status. A fresh install with zero Lists
seeds exactly one List on first launch — name "My Tasks", icon
`footprints` (already used for that name throughout the mockup), a color
from [decision 0013](../../../archive/santian/decisions/0013-add-list-color-palette.md)'s palette — so the
Tasks List screen, the FAB, and Task creation always have somewhere to land.
No other onboarding UI is added.

## Context

[Add-list method](../../../archive/santian/hipster/add-list-method.md) flags this as unaddressed:
nothing says what a Lists-empty first run shows, or which List the FAB
creates a Task into when none exist yet. Santian issue
[#8](https://github.com/arcbyte-lab/Santian/issues/8) names this as a real
release blocker — development has been using
[#3](https://github.com/arcbyte-lab/Santian/issues/3)'s debug seed as a
stand-in, which is fine for building but was never meant to ship.

## What each lens said

- **Hound:** not applicable — no real person has been asked; this is a
  reasonable-default proposal.
- **Hipster:** [Tasks List interactions](../../../archive/santian/hipster/tasks-list-screen-interactions.md)
  already flags the true empty state (a List that exists but has zero
  Tasks) as genuinely undecided. Seeding one List on first launch sidesteps
  a *harder*, still-open question — "what does the Lists-tab-bar-is-itself-empty
  state look like" — rather than answering it, which keeps this decision small.
- **Hacker:** a plain `ListRepository.create()` call at first-launch
  detection (no Lists exist yet), same write path `#8`'s add-list sheet
  already needs.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Show a genuinely empty Tasks List screen with no Lists at all.**
  Rejected — the FAB (per
  [Tasks List interactions](../../../archive/santian/hipster/tasks-list-screen-interactions.md))
  needs an active List to create into; a Lists-less first run has no answer
  for what tapping it does, and this app has no separate "create your first
  list" onboarding flow drawn or specified anywhere.
- **A first-run wizard/onboarding screen.** Rejected — nothing in the
  mockup or any spec draws one, and per
  [decision 0003](./0003-personal-tool-not-a-product.md) this is a
  single-user personal tool, not a product that needs to sell itself on
  first open.

## How we will know we were wrong

If the owner would rather pick the first List's name/icon/color himself
than have one auto-created — that's the signal this needs to become a real
onboarding step instead of a silent seed.

---
Part of [Santian](../README.md)
