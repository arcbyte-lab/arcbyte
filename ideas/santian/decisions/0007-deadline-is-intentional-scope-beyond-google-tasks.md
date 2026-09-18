---
title: Deadline is intentional scope beyond Google Tasks parity
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "./0004-clone-google-tasks-interactions.md"]
tags: [artifact, decision]
---

## Decision

`deadline` is a real, separate field from `reminderAt`, with its own
behaviour: it shows on the Tasks List row alongside the reminder time, fires
its own notification independent of `reminderAt`'s, and drives overdue
styling on an incomplete Task once `now` passes it. This is a deliberate
addition beyond what real Google Tasks has (one date field, no overdue
styling), not an artifact of an unedited pasted mockup.

## Context

[The data model note](../hacker/task-list-subtask-data-model.md) flagged
this mockup drawing two date concepts where real Google Tasks has one, and
left open whether that was real scope past
[decision 0004](./0004-clone-google-tasks-interactions.md) or a mockup slip.
Asked directly, the owner confirmed all three behaviours above.

## What each lens said

- **Hound:** unaffected — no real user asked for this.
- **Hipster:** not addressed here — this decision fixes the *fields and
  behaviour*, not the visual treatment of the list-row deadline badge or the
  overdue styling. That's a follow-up hipster note once Task Detail and
  Tasks List are redesigned to show it.
- **Hacker:** the Task schema now has two independent date fields
  (`reminderAt`, `deadline`) plus two independent notification triggers off
  one Task. Both need their own scheduling in the notification layer, not
  one shared mechanism.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **Treat the second date row as a mockup artifact and collapse to one date
  field.** Rejected — the owner confirmed real, distinct behaviour for it,
  not just a stray row.
- **Give `deadline` no notification, keep it silent (just overdue styling).**
  Rejected — the owner asked for its own notification.

## How we will know we were wrong

If, once built, having two independent notifications per Task (one from
`reminderAt`, one from `deadline`) turns out to be noisy or confusing in
daily use, that's the signal to fold `deadline` back into being a silent
target date, or merge it with `reminderAt`.

---
Part of [Santian](../README.md)
