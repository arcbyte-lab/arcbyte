---
title: Icon set for the add-list picker grid
idea: santian
lens: intelligence
kind: decision
status: superseded
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-22
updated: 2026-10-06
inputs: ["../hipster/add-list-method.md", "../hacker/task-list-subtask-data-model.md"]
tags: [artifact, decision]
---

> **Superseded 2026-10-06** by [0017-lists-are-name-only](../../../ideas/santian/decisions/0017-lists-are-name-only.md). This describes the mockup-era plan, not the app as built. See [decision 0016](../../../ideas/santian/decisions/0016-follow-google-tasks-mobile-over-the-mockup.md).

## Decision

Proposed, not yet adopted — see status. The add-list sheet's icon grid ships
with a curated set of 16 lucide icons, not the full lucide set and not just
the 3 already drawn:

```
rocket, footprints, hammer, home, briefcase, book-open, heart, dumbbell,
shopping-cart, dollar-sign, graduation-cap, plane, music, coffee, star, folder
```

The first three keep the icons already in use for the existing seeded Lists
(Personal Interest, My Tasks, Building); the rest cover common personal
list themes (home, work, reading, health, fitness, errands, money, school,
travel, hobbies, breaks, favorites, misc).

## Context

[Add-list method](../hipster/add-list-method.md) says the icon picker uses
"the same lucide icon set already in use," but only three icons are actually
drawn anywhere in the mockup (rocket, footprints, hammer) — not enough to
populate a picker grid. Santian issue
[#8](https://github.com/arcbyte-lab/Santian/issues/8) is blocked on this: an
agent cannot build the grid without knowing what belongs in it, and inventing
an icon set in code would be a product decision made outside Arcbyte.

## What each lens said

- **Hound:** not applicable — no real person has been asked; this is a
  reasonable-default proposal, not user research.
- **Hipster:** the concrete question this note answers. 16 keeps the grid at
  roughly a 4×4 layout, scannable without scrolling on a phone-sized sheet.
- **Hacker:** `TaskList.icon` already stores a string key, so any icon set
  works without a schema change — [#8](https://github.com/arcbyte-lab/Santian/issues/8)
  still needs to pick a maintained Flutter Lucide package or bundle the SVGs
  for whichever keys are chosen here.
- **Hustler:** not applicable, per
  [decision 0003](../../../ideas/santian/decisions/0003-personal-tool-not-a-product.md).

## Options rejected

- **The full lucide set (~1500 icons).** Rejected — unwieldy in a picker
  grid, and nearly all of it is irrelevant to a personal task-list app.
- **Only the 3 icons already drawn.** Rejected — too restrictive once the
  owner has more than three Lists in real use.

## How we will know we were wrong

If the owner regularly wants an icon that isn't in this set once using the
app day to day, that's the signal to expand it — not a sign the picker
itself is wrong.

---
Part of [Santian](../../../ideas/santian/README.md)
