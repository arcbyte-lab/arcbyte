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
updated: 2026-10-07
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
- **Hipster:** the owner's [home wireframe](./hipster/home-screen-wireframe.md) settles the tabs ([0002](./decisions/0002-tabs-are-workspaces-then-projects.md)) and the calendar ([0003](./decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md)). The task row and Task Detail are not drawn yet; [Santian's screens in a team app](./hipster/santian-screens-in-a-team-app.md) is the starting proposal. The [lofi mockup tickets](./hipster/lofi-mockup-tickets-for-pen-dev.md) are ready to hand to pen.dev, and the [hifi mockup tickets](./hipster/hifi-mockup-tickets-for-pen-dev.md) restyle them with `modern-minimal.css`.
- **Hacker:** schema adopted ([0001](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)). Santian's behaviour mapped onto it: concepts and missing columns, and the rules that break in a team app.
- **Hustler:** not started

## Next question to answer

**What does unticking a task do, and how is a task cancelled?** The rest of
[0004](./decisions/0004-checkbox-goes-to-review-only-when-needed.md) is settled: review happens when
`required_proof_type` is set. A project's person-in-charge reviews project
tasks, and division admins or supervisors review division tasks. After that: does the star
survive without a Star tab, and what is the slider icon in the header?


## Artifacts

**Hipster**
- [Home screen wireframe](./hipster/home-screen-wireframe.md) — header, monthly due-date calendar, workspace and project tabs
- [Santian's screens in a team app](./hipster/santian-screens-in-a-team-app.md) — what each screen keeps and adds
- [Lofi mockup tickets for pen.dev](./hipster/lofi-mockup-tickets-for-pen-dev.md) — 13 prompts that draw every blueprint screen in `pencil-new.pen`
- [Hifi mockup tickets for pen.dev](./hipster/hifi-mockup-tickets-for-pen-dev.md) — 7 prompts that restyle the lofi frames with `modern-minimal.css`

**Hacker**
- [Santian's concepts mapped onto Tasko's schema](./hacker/santian-concepts-mapped-to-tasko-schema.md) — what fits, what has no column (List, star, reminder)
- [Santian's rules that change in a team app](./hacker/santian-rules-that-change-in-a-team-app.md) — completion, repeat, undo, notifications, permissions

## Decisions
- [0001 — Adopt sqlite-schema.sql over schema-zero](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)
- [0002 — Tabs are workspaces, then projects; each task in exactly one tab](./decisions/0002-tabs-are-workspaces-then-projects.md) — 2026-10-06 (draft, owner approved in chat)
- [0003 — The calendar is a due-date heatmap that filters the list](./decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md) — 2026-10-06 (draft, owner approved in chat)
- [0004 — The checkbox goes to review only when needed, otherwise done](./decisions/0004-checkbox-goes-to-review-only-when-needed.md) — 2026-10-06 (draft, owner approved in chat)
