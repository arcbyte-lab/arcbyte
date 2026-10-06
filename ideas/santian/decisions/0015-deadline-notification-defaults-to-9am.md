---
title: A deadline notification fires at 9:00 AM, same default as reminderAt
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-22
updated: 2026-09-22
inputs: ["../../../archive/santian/hacker/notification-scheduling.md", "../../../archive/santian/hipster/date-time-picker-interactions.md", "../../../archive/santian/hipster/deadline-badge-and-overdue-styling.md"]
tags: [artifact, decision]
---

## Decision

Proposed, not yet adopted — see status. A `deadline` notification fires at
9:00 AM on the deadline's date — the same `defaultReminderTime` constant
already established (and implemented, in `date_time_picker_dialog.dart`)
for a date-only `reminderAt`. One default time-of-day concept for the whole
app, not two.

## Context

[Notification scheduling](../../../archive/santian/hacker/notification-scheduling.md) names this
as the one open question blocking Santian issue
[#12](https://github.com/arcbyte-lab/Santian/issues/12)'s deadline half:
`deadline` stores a date only, no time component, and nothing says what
clock time its notification should fire at. The reminder half of `#12` is
not blocked by this — `reminderAt` always carries a real time already, per
[the date/time picker spec](../../../archive/santian/hipster/date-time-picker-interactions.md)'s
9:00 AM default for a date-only pick.

## What each lens said

- **Hound:** not applicable — reasonable-default proposal, no user
  research.
- **Hacker:** the concrete question. Reusing `defaultReminderTime` means
  the notification-scheduling code needs no second named time constant, and
  no new field on `Task` — `deadline` stays date-only in storage exactly as
  [the Isar schema](../../../archive/santian/hacker/isar-schema.md) already settled; only the
  *notification trigger* gets a time attached, computed at schedule time.
- **Hipster:** consistent with
  [the overdue-styling note](../../../archive/santian/hipster/deadline-badge-and-overdue-styling.md)'s
  own restraint — `deadline` was deliberately kept simpler than `reminderAt`
  (no Set Time row in its picker) rather than growing a second
  time-of-day concept.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **End of day (e.g. 11:59 PM).** Rejected — a deadline notification firing
  at the last minute of the day gives the owner no time left to act on it;
  the whole point of a deadline reminder is advance notice, not a closing
  bell.
- **A separate, independently-configurable deadline notification time.**
  Rejected — this is exactly the "Set Time" row
  [the deadline picker deliberately dropped](../../../archive/santian/hipster/deadline-badge-and-overdue-styling.md)
  (calendar-only, per
  [decision 0007](./0007-deadline-is-intentional-scope-beyond-google-tasks.md)'s
  "target date, not a time-of-day commitment"); adding it back here just to
  serve notifications would quietly reverse that call.

## How we will know we were wrong

If the owner keeps missing deadline notifications because 9:00 AM is too
early (or too late) relative to when he actually wants the nudge — that's
the signal to revisit, likely as a per-Task or global setting, not a sign
reusing the reminder default was the wrong shape to start from.

---
Part of [Santian](../README.md)
