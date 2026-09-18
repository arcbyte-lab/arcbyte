---
title: Promote Santian from idea to project
idea: santian
lens: intelligence
kind: decision
status: adopted
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../README.md", "./0002-build-tasks-before-clockface.md", "./0006-isar-for-tasks-storage.md"]
tags: [artifact, decision]
---

## Decision

Move Santian's `stage` from `idea` to `project`. Code starts now, in its own
repository, separate from Arcbyte — Arcbyte keeps the thinking, the code repo
keeps the code, per [AGENTS.md](../../../AGENTS.md). This note is the
proposal; per AGENTS.md rule 9 an AI may not change `stage` itself. The owner
adopts this note and edits `ideas/santian/README.md` frontmatter by hand
(`stage: project`, plus a `repo:` line once the repository exists).

**Adopted 2026-09-18.** The repo exists:
[github.com/arcbyte-lab/Santian](https://github.com/arcbyte-lab/Santian),
checked out locally at `~/Projects/Dev/Santian`. `ideas/santian/README.md`
frontmatter now reads `stage: project` with that `repo:` line.

## Context

The Tasks data layer is settled enough to build: fields are fully inventoried
([data model](../hacker/task-list-subtask-data-model.md)), storage is chosen
([decision 0006](./0006-isar-for-tasks-storage.md)), and the two open
Clockface questions don't block a Tasks-only build
([decision 0005](./0005-clockface-questions-dont-block-tasks-build.md)). The
owner is ready to start writing code and wants it kept in a separate git
repository from Arcbyte, not mixed into this vault.

## What each lens said

- **Hound:** unaffected — still nothing here, per the one open hound
  question. Promotion doesn't depend on it, per decision 0005's precedent of
  not letting open questions block the parts they don't touch.
- **Hipster:** the 8 core Tasks screens have a hi-fi mockup and the two
  undrawn affordances (add-list, deadline badge) are now designed. Enough to
  build against.
- **Hacker:** data model, storage, and architecture sketch are all in place.
  This is the lens that's actually ready.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Keep `stage: idea` and build anyway.** Rejected — `stage` is supposed to
  say whether code exists, not lag behind it. Leaving it stale defeats the
  point of the field.
- **Put the code inside this repo.** Rejected outright by
  [AGENTS.md](../../../AGENTS.md): "Arcbyte holds thinking, not code." A
  mixed repo also breaks the assumption behind every coding-focused skill
  (tests, linting, CI) that expects a normal code repo, not a vault of notes.

## How we will know we were wrong

If the code repo's domain model starts drifting from
[`ideas/santian/CONTEXT.md`](../CONTEXT.md) — new terms invented in code that
never make it back here, or vocabulary that quietly means something different
in each place — that's the signal this vocabulary split needs a rule, not
just this promotion. (Flagged as unresolved in the
[root CONTEXT.md](../../../CONTEXT.md): "what happens to an idea's thinking
once its code exists.")

---
Part of [Santian](../README.md)
