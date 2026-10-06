---
title: Follow the Google Tasks mobile app, not the hi-fi mockup, where the two differ
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["./0004-clone-google-tasks-interactions.md", "../hipster/tasks-list-screen-as-built.md", "../hacker/tasks-behaviour-rules-as-built.md"]
tags: [artifact, decision]
---

## Decision

Where the hi-fi mockup and the Google Tasks mobile app disagree, Santian
follows Google Tasks. The as-built specs are now the reference, not the
mockup-era specs they replace.

## Context

Tickets #1–#12 were built from the mockup-era specs between 2026-09-18 and
2026-09-22. The owner used the result and felt it did not behave like Google
Tasks. Between 2026-09-25 and 2026-10-02 he changed it by hand. The main
commits in the Santian repo are:

- `77b1991`, `90a7d98`: tighter letter spacing, a "Tasks" label on the card,
  smaller sheet radius, and the compose circle removed from Create Task.
- `6da6293` (#26): swipe between Lists, with a tab underline that follows
  the finger.
- `3d0f44c`: a List options menu (rename, delete, delete completed). The
  List icon and color are dropped (see
  [decision 0017](./0017-lists-are-name-only.md)). Open Tasks get day
  headers, and a "Completed (N)" section sits below them. Rows get a star
  and relative dates.
- `f64e2c0`: the Tasks screen becomes a panel inside a `PrimaryView`.

This decision gives those commits a reason in the vault. Without it, the
code and the specs disagree with nothing saying which one wins.
[Decision 0004](./0004-clone-google-tasks-interactions.md) already said
"copy Google Tasks' interactions". This one adds that the copy is of the
live app, and that the mockup loses where the two disagree.

## What each lens said

- **Hound:** the owner is the only user ([0003](./0003-personal-tool-not-a-product.md)).
  The changes come from his own daily use, so this is weak-to-strong
  evidence about one real person. The label is `evidence: strong` because
  the behaviour has shipped and is in use.
- **Hipster:** see the [as-built hipster specs](../README.md#artifacts). They
  describe the screens as they are now.
- **Hacker:** see the [as-built hacker specs](../README.md#artifacts). One
  real defect turned up while writing them: completing a repeating Task
  from Task Detail. It is logged there, not fixed.
- **Hustler:** not applicable, per [0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Revert the code to the mockup-era specs.** Rejected. The owner made
  these changes on purpose, after using the app.
- **Edit the mockup-era specs in place.** Rejected by the owner (2026-10-06).
  The old notes are kept in `archive/` as `superseded`, so the reasoning
  from the mockup era stays readable.

## How we will know we were wrong

The owner keeps changing behaviour directly in code after this, and the
as-built specs fall behind again. That would mean specs should be written
after the code, not before it.

---
Part of [Santian](../README.md)
