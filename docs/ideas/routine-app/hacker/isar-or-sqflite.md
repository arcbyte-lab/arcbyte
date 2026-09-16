---
title: Isar or sqflite?
idea: routine-app
lens: hacker
kind: question
status: draft
source: claude-opus-5 (cowork)
evidence: none
created: 2026-09-16
updated: 2026-09-16
inputs: ["./offline-task-module-architecture.md"]
tags: [artifact, question]
---

## The question
Which local store for the offline task data: Isar or sqflite?

## Why it matters
It is the first thing that is expensive to change later, and
[offline task module architecture](./offline-task-module-architecture.md) names
both without choosing. A model listed the options; nobody has checked either one
against this app's real queries or against the current state of both packages.

## How I could answer it
- Cheapest way: write down the three queries the clockface actually needs, then
  see which store expresses them more simply.
- Best way: a one-day spike on each, storing a week of real blocks, and measure.
  Then file the result with `templates/spike.md`.

## Answer
Empty. When answered, this becomes a note in `../decisions/`.

---
Part of [Routine App](../README.md)
