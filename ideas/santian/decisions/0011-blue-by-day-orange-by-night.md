---
title: Keep the light/dark hue swap — blue by day, orange by night
idea: santian
lens: intelligence
kind: decision
status: adopted
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md", "../assets/exodus.css"]
tags: [artifact, decision]
---

## Decision

Santian's theme keeps **two different primary hues on purpose**: blue
(`#0284c7`) in light mode, orange (`#f97316`) in dark mode — not a single
brand color adjusted for contrast between modes.

## Context

Writing the exodus.css → Flutter theming spec found this hue swap is
already fully consistent across every screen in the hi-fi export — all 67
uses of blue are confined to the light-mode screens, every orange use to
the dark-mode screens, no mixing. That consistency meant it wasn't obviously
a mockup bug, but nothing had ever named it as an intentional identity
choice either, versus an accidental relic of the "generic, partly-unedited
theme" the anchor note's health check already flagged. Asked directly, the
owner chose to keep it.

## What each lens said

- **Hound:** not applicable.
- **Hipster:** this is the lens the decision lives in. A light mode and
  dark mode with genuinely distinct character — not just an inverted
  palette — is a real, slightly unusual identity choice, especially set
  against [decision 0004](./0004-clone-google-tasks-interactions.md)'s
  otherwise restrained, Google-Tasks-cloned interaction model. It's a
  deliberate point of difference in an app that's deliberately
  unoriginal everywhere else.
- **Hacker:** means the Flutter `ThemeData` needs two independently
  authored `ColorScheme`s (light, dark) with different `primary` values,
  not one `ColorScheme.fromSeed()` call varying only by `Brightness`. Small
  but real — covered in the theming spec.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Unify to blue in both modes.** Rejected — the owner chose to keep the
  split.
- **Unify to orange in both modes.** Rejected — same.

## How we will know we were wrong

If the color swap feels disorienting in daily use on a real device — e.g.
the FAB reading as a visually different button depending on which mode is
active, rather than a consistent element that happens to change color —
that's the signal to revisit and unify after all.

---
Part of [Santian](../README.md)
