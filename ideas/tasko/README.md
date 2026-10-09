---
title: Tasko
idea: tasko
stage: project
repo: [https://github.com/arcbyte-lab/Tasko-Flutter, https://github.com/arcbyte-lab/Tasko-API]
lens: intelligence
kind: brief
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-05
updated: 2026-10-09
tags: [anchor]
---

# Tasko

> The anchor note. The only note here that must stay current. Blank sections are
> blank on purpose — nobody has answered them yet. Do not fill them with guesses.

## Stage
`stage: project`. Code lives at
[github.com/arcbyte-lab/Tasko-Flutter](https://github.com/arcbyte-lab/Tasko-Flutter),
separate from this repo. The owner promoted it on 2026-10-07; see
[0006](./decisions/0006-promote-tasko-to-project.md). The server API is a
second repo,
[github.com/arcbyte-lab/Tasko-API](https://github.com/arcbyte-lab/Tasko-API),
checked out locally at `~/Projects/Dev/tasko-api`: Hono on Cloudflare
Workers with D1, every route built and deployed at
`https://tasko-api.vidtandjung.workers.dev` ([as built](./hacker/tasko-api-as-built.md)).
The live database has no users yet.

## One line


## The problem


## Current bet


## Status by lens
- **Hound:** not started
- **Hipster:** the owner's [home wireframe](./hipster/home-screen-wireframe.md) settles the tabs ([0002](./decisions/0002-tabs-are-workspaces-then-projects.md)) and the calendar ([0003](./decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md)). The task row and Task Detail are not drawn yet; [Santian's screens in a team app](./hipster/santian-screens-in-a-team-app.md) is the starting proposal. The [lofi mockup tickets](./hipster/lofi-mockup-tickets-for-pen-dev.md) are ready to hand to pen.dev, and the [hifi mockup tickets](./hipster/hifi-mockup-tickets-for-pen-dev.md) restyle them with `modern-minimal.css`.
- **Hacker:** schema adopted ([0001](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)). Santian's behaviour mapped onto it: concepts and missing columns, and the rules that break in a team app. v1 defaults set ([0005](./decisions/0005-v1-build-defaults.md)): Flutter + Cubit, online only. The app is built: every hifi screen except Repeat, on a fake API ([as built](./hacker/flutter-app-as-built.md)). The server API is built and deployed in `tasko-api` ([as built](./hacker/tasko-api-as-built.md)); the rules settled while reviewing it, including "a proof is a link", are in [0007](./decisions/0007-server-rules-settled-in-the-api-review.md). The app runs on it, tested on a phone against the live API; "start working" is allowed by [0008](./decisions/0008-start-working-moves-a-task-to-in-progress.md).
- **Hustler:** not started

## Next question to answer

The proof question is answered by
[0007](./decisions/0007-server-rules-settled-in-the-api-review.md): a proof
is a link. The calls still open are listed in
[choices to confirm](./hacker/build-choices-to-confirm.md) and in the
[API's open questions](./hacker/tasko-api-as-built.md).


## Artifacts

**Hipster**
- [Home screen wireframe](./hipster/home-screen-wireframe.md) — header, monthly due-date calendar, workspace and project tabs
- [Santian's screens in a team app](./hipster/santian-screens-in-a-team-app.md) — what each screen keeps and adds
- [Lofi mockup tickets for pen.dev](./hipster/lofi-mockup-tickets-for-pen-dev.md) — 13 prompts that draw every blueprint screen in `pencil-new.pen`
- [Hifi mockup tickets for pen.dev](./hipster/hifi-mockup-tickets-for-pen-dev.md) — 7 prompts that restyle the lofi frames with `modern-minimal.css`

**Hacker**
- [Santian's concepts mapped onto Tasko's schema](./hacker/santian-concepts-mapped-to-tasko-schema.md) — what fits, what has no column (List, star, reminder)
- [Santian's rules that change in a team app](./hacker/santian-rules-that-change-in-a-team-app.md) — completion, repeat, undo, notifications, permissions
- [v1 home build tickets](./hacker/v1-home-build-tickets.md) — B0–B6: home screen and checkbox, Flutter + Cubit on a fake API
- [Flutter app, as built](./hacker/flutter-app-as-built.md) — screens, Cubits, the fake API seam, folders
- [Choices to confirm](./hacker/build-choices-to-confirm.md) — calls made while building, and the placeholders still open
- [Tasko API, as built](./hacker/tasko-api-as-built.md) — Hono + D1 on Workers, 22 routes, deployed; what the app must change to use it

## Decisions
- [0001 — Adopt sqlite-schema.sql over schema-zero](./decisions/0001-adopt-sqlite-schema-over-schema-zero.md)
- [0002 — Tabs are workspaces, then projects; each task in exactly one tab](./decisions/0002-tabs-are-workspaces-then-projects.md) — 2026-10-06 (draft, owner approved in chat)
- [0003 — The calendar is a due-date heatmap that filters the list](./decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md) — 2026-10-06 (draft, owner approved in chat)
- [0004 — The checkbox goes to review only when needed, otherwise done](./decisions/0004-checkbox-goes-to-review-only-when-needed.md) — 2026-10-06 (draft, owner approved in chat)
- [0005 — v1 build defaults](./decisions/0005-v1-build-defaults.md) — 2026-10-07 (draft, owner said "take your defaults" in chat)
- [0006 — Promote Tasko to project](./decisions/0006-promote-tasko-to-project.md) — 2026-10-07 (draft, owner changed `stage` by hand)
- [0007 — Server rules settled in the API review](./decisions/0007-server-rules-settled-in-the-api-review.md) — 2026-10-09 (draft, owner chose proof-as-link and no Laravel; accepted the rest in chat)
- [0008 — "Start working" moves a task to in progress](./decisions/0008-start-working-moves-a-task-to-in-progress.md) — 2026-10-09 (draft, owner chose to allow it on the server)
