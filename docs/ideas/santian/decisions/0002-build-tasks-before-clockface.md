---
title: Build order — Tasks module first, Clockface after
idea: santian
lens: intelligence
kind: decision
status: draft
source: me
evidence: weak
created: 2026-09-17
updated: 2026-09-17
inputs: ["../hustler/why-switch-from-google-tasks.md", "../hacker/offline-task-module-architecture.md", "../hacker/clockface-or-list-source-of-truth.md"]
tags: [artifact, decision]
---

## Decision

Santian builds the **Tasks module** first. The **Clockface** does not start
until Tasks is settled.

## Context

[Why would anyone switch from Google Tasks?](../hustler/why-switch-from-google-tasks.md)
raised the possibility that this order was backwards — that if the Clockface is
the real reason to switch, building Tasks first builds the scaffolding and
delays the bet. The owner has now settled the order directly: Tasks first,
regardless of how that hustler question resolves.

## What each lens said

- **Hound:** nothing. No real user input either way.
- **Hipster:** the wireframe shows both a `Clockface` tab and a `Tasks` tab, but
  the design detail so far ([Google Tasks UX playbook](../hipster/google-tasks-ux-playbook.md))
  is almost all about the Tasks side. Design work already leans this direction.
- **Hacker:** [offline task module architecture](../hacker/offline-task-module-architecture.md)
  already sequences a Tasks-only build (data layer, state, UI shell, inputs) with
  no Clockface phase. This decision confirms that plan rather than changing it.
  [Is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md)
  stays open — this decision does not answer it, it just says which one gets
  built and modelled first.
- **Hustler:** the underlying question — why switch from Google Tasks at all —
  is still unanswered. This decision does not resolve it. It fixes the build
  order without waiting for that answer.

## Options rejected

- **Build the Clockface first**, on the theory that it is the actual
  differentiator and Tasks alone is a weaker pitch than Google Tasks itself.
  Rejected — the owner chose to settle Tasks before spending effort on the
  harder, less-proven view.
- **Build both at once.** Rejected — nothing about either is settled yet
  ([how does a Day differ from its Routine?](../hacker/day-versus-routine.md) is
  still open), and splitting effort across two unsettled things is worse than
  settling one.

## What this does not decide

Whether the Clockface or the Tasks list is the source of truth for the
underlying data — see
[is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md).
Also does not answer why anyone switches from Google Tasks — see
[why would anyone switch from Google Tasks?](../hustler/why-switch-from-google-tasks.md).
Both stay open.

## How we will know we were wrong

If the Tasks module ships and the owner still cannot answer why anyone would
switch from Google Tasks, then building Tasks first bought nothing — the
hustler question needed the Clockface to answer it, not more Tasks polish.

---
Part of [Santian](../README.md)
