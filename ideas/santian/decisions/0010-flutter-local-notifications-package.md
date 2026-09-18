---
title: flutter_local_notifications for reminder and deadline notifications
idea: santian
lens: intelligence
kind: decision
status: adopted
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/local-notifications-package.md", "./0007-deadline-is-intentional-scope-beyond-google-tasks.md", "./0003-personal-tool-not-a-product.md"]
tags: [artifact, decision]
---

## Decision

Use **`flutter_local_notifications`** to schedule both of a Task's
independent notifications (`reminderAt`, `deadline`, per
[decision 0007](./0007-deadline-is-intentional-scope-beyond-google-tasks.md)).

## Context

Santian is offline-first with no backend
([decision 0003](./0003-personal-tool-not-a-product.md)), so these must be
device-scheduled local notifications, not push. `flutter_local_notifications`
is the Flutter ecosystem's standard package for exactly this — scheduling at
a future `DateTime`, surviving app close and device reboot (via its
platform-side alarm/notification-center integration on Android and iOS).

## What each lens said

- **Hound:** not applicable.
- **Hipster:** the two-independent-notifications behavior itself was already
  designed in
  [the deadline badge spec](../hipster/deadline-badge-and-overdue-styling.md);
  this decision is purely about what fires them, not what they look like or
  when.
- **Hacker:** this is the lens the decision lives in. The package needs to:
  schedule at an exact future time (`zonedSchedule`, using the `timezone`
  package for DST-correct firing), survive app-closed and device-reboot
  (both platforms need their own reboot-rescheduling — Android via a boot
  receiver, iOS via the system's own notification center persistence), and
  support per-notification cancel/reschedule by integer ID — all three are
  exactly what a Task's two independent, individually-editable/removable
  notifications need. No unusual requirement here that would push toward a
  less standard package.
- **Hustler:** not applicable, per
  [decision 0003](./0003-personal-tool-not-a-product.md).

## Options rejected

- **A custom platform-channel implementation.** Rejected — reinventing
  scheduled local notifications from scratch for a personal tool, when a
  mature, actively maintained package already does exactly this job, is
  effort spent on the least interesting part of the app.
- **Push notifications via a backend.** Rejected outright — Santian has no
  backend and isn't getting one; a personal offline tool has no server to
  push from, and no reason to add one just for notifications.

## How we will know we were wrong

If Android's exact-alarm permission requirements (Android 12+'s
`SCHEDULE_EXACT_ALARM`) turn out to make reminders unreliable in practice on
the owner's actual device, or the package's reboot-rescheduling proves
flaky — that's the signal to look at a lower-level platform-channel
approach instead of trusting the package's abstraction.

---
Part of [Santian](../README.md)
