---
title: Color palette for the add-list picker row
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-22
updated: 2026-09-22
inputs: ["../hipster/add-list-method.md", "../assets/exodus.css", "./0011-blue-by-day-orange-by-night.md"]
tags: [artifact, decision]
---

## Decision

Proposed, not yet adopted — see status. The add-list sheet's color row ships
with 8 fixed, distinct-hue dot colors, the same value in light and dark mode
(the `List Dot` is a user choice, not a theme token, so it does not need a
light/dark pair):

```
#dc2626 red, #ea580c orange, #d97706 amber, #16a34a green,
#0d9488 teal, #2563eb blue, #7c3aed purple, #db2777 pink
```

## Context

[Add-list method](../hipster/add-list-method.md) specifies the color row's
shape (a row of dots, same as the existing `List Dot`) but names no actual
colors. Santian issue
[#8](https://github.com/arcbyte-lab/Santian/issues/8) is blocked on this for
the same reason as [decision 0012](./0012-add-list-icon-set.md): nothing to
build the picker from.

## What each lens said

- **Hound:** not applicable — reasonable-default proposal, no user research.
- **Hipster:** the concrete question. 8 distinct hues fit one row without
  wrapping and give enough contrast to tell Lists apart at a glance — the
  actual job a list color does (per
  [the deadline styling note](../hipster/deadline-badge-and-overdue-styling.md)'s
  same "one color per distinct meaning" restraint).
- **Hacker:** `TaskList.color` already stores a plain ARGB int
  (`Color(value)`), so any 8 values work with no schema change.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Reuse `exodus.css`'s `--chart-1`..`--chart-5` tokens** (a 5-step teal
  gradient, currently unused anywhere in the mockup). Rejected even though
  reusing an existing token would resolve one more instance of
  [the unused-theme-tokens critique](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md) —
  they're all the same hue at different lightness, which is the wrong shape
  for a palette whose whole job is letting the owner tell Lists apart by
  color. A real accessibility/legibility need overrides the reuse instinct.
- **Reuse `--primary`/`--secondary`** for two of the eight dots. Rejected —
  those already mean "the app's own accent" (see
  [decision 0011](./0011-blue-by-day-orange-by-night.md)); a List using the
  same color as active-state UI chrome would be confusing, not helpful.

## How we will know we were wrong

If the owner finds two Lists visually hard to tell apart in daily use, or
wants a color not in this set — that's the signal to revise the palette, not
a sign the 8-dot-row shape is wrong.

---
Part of [Santian](../README.md)
