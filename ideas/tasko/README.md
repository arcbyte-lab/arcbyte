---
title: Tasko
idea: tasko
stage: idea
lens: intelligence
kind: brief
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-05
updated: 2026-10-06
tags: [anchor]
---

# Tasko

> The anchor note. The only note here that must stay current. Blank sections are
> blank on purpose — nobody has answered them yet. Do not fill them with guesses.

## Stage
`stage: idea` — thinking only, no code yet. It becomes a `project` the day a
repository is started: change the field, add a `repo:` line, and write the
decision that says why.

## One line


## The problem


## Current bet


## Status by lens
- **Hound:** not started
- **Hipster:** one proposal for how [Santian's screens](../santian/README.md#artifacts) adapt to a team app — blocked on what a tab is.
- **Hacker:** schema adopted ([0001](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)). Santian's behaviour mapped onto it: concepts and missing columns, and the rules that break in a team app.
- **Hustler:** not started

## Next question to answer

Proposed, from the Santian mapping: **what is a List tab in Tasko** — a
project, a division, the user's `personal_tasks`, or a filter such as
"Assigned to me"? Every screen depends on it. Close behind: which
`tasks.status` values exist, and what the checkbox sets.


## Artifacts

**Hipster**
- [Santian's screens in a team app](./hipster/santian-screens-in-a-team-app.md) — what each screen keeps and adds

**Hacker**
- [Santian's concepts mapped onto Tasko's schema](./hacker/santian-concepts-mapped-to-tasko-schema.md) — what fits, what has no column (List, star, reminder)
- [Santian's rules that change in a team app](./hacker/santian-rules-that-change-in-a-team-app.md) — completion, repeat, undo, notifications, permissions

## Decisions
- [0001 — Adopt sqlite-schema.sql over schema-zero](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)
