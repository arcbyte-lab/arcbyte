---
title: Promote Tasko from idea to project
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-07
updated: 2026-10-07
inputs: ["../README.md", "./0005-v1-build-defaults.md", "../hacker/v1-home-build-tickets.md"]
tags: [artifact, decision]
---

## Decision
Tasko is now a `project`. The owner made this change on 2026-10-07: the
anchor note now has `stage: project` and
`repo: https://github.com/arcbyte-lab/Tasko-Flutter`. The repo was created
the same day and is still empty. This note records why. Following AGENTS.md
rule 9, the AI did not make the change.

## Context
The stack is chosen ([0005](./0005-v1-build-defaults.md)). The
[v1 home build tickets](../hacker/v1-home-build-tickets.md) run on a fake
API, so they do not wait on the server. That makes the build ready to
start.

## What each lens said
- **Hound:** no user input. The open hound questions do not block a home
  screen build.
- **Hipster:** the lofi and hifi mockups cover the home screen. Task Detail
  is not final yet, but no v1 ticket needs it.
- **Hacker:** this lens is the one that is ready: schema, stack and
  tickets. The server API is still unknown, and only the "Later" tickets
  wait on it.
- **Hustler:** not started.

## Options rejected
- **Keep `stage: idea` and build anyway.** `stage` should say whether code
  exists, so it must not fall behind the code.
- **Put the code in this repo.** Arcbyte holds thinking, not code
  ([AGENTS.md](../../../AGENTS.md)).

## How we will know we were wrong
The fake API's shape drifts far from the real Laravel API, and B1 to B6
have to be rewritten instead of rewired.

---
Part of [Tasko](../README.md)
