---
title: Notifications, as built — ids, sync points, 9 AM deadline, lazy permission, tap-to-open
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hacker/notification-scheduling.md", "../decisions/0010-flutter-local-notifications-package.md", "../decisions/0015-deadline-notification-defaults-to-9am.md", "./tasks-behaviour-rules-as-built.md"]
tags: [artifact]
---

## Question
How do a Task's dates turn into local notifications today?

## Short answer
- A Task has up to two notifications. The reminder fires at `reminderAt`.
  The deadline fires at 09:00 on the deadline day. Their ids are `id*2`
  and `id*2+1`, worked out on the spot and never stored.
- One function, `syncTaskNotifications`, runs after every create, update,
  complete and undo. It schedules whatever is set, and cancels everything
  if the Task is completed.
- Permission is requested the first time a notification is actually
  scheduled. A tap opens that Task's Task Detail, whether the app was
  running or not.

## Detail

Code: `lib/core/notifications/` (`task_notifications.dart`,
`notification_service.dart`, `flutter_local_notifications_service.dart`),
`lib/main.dart`. The package is `flutter_local_notifications`
([0010](../decisions/0010-flutter-local-notifications-package.md)).
Android only so far: no iOS settings are passed.

### What fires
| | id | fires at | title | body |
|---|---|---|---|---|
| Reminder | `taskId * 2` | `reminderAt` | Task title | none |
| Deadline | `taskId * 2 + 1` | deadline day, 09:00 local | Task title | "Due today" |

The 09:00 deadline time is a constant. The owner confirmed it on
2026-09-22 outside the vault, so
[0015](../decisions/0015-deadline-notification-defaults-to-9am.md) is
still a draft but is already built. Both use one Android channel, `santian_tasks` /
"Tasks", at default importance, in exact-while-idle mode.

### When it syncs
`TaskRepository` is the only writer, and it runs a sync after:

| Write | Sync |
|---|---|
| `create` | schedule what is set |
| `update` (any Task Detail edit, and delete-undo) | reschedule both; cancel any that were cleared |
| `toggleCompleted` | completed: cancel both. Repeating: reschedule to the new dates. Un-completed: reschedule. |
| `delete`, `deleteInList` | cancel both for each Task |
| `toggleStarred` | none (a star does not affect notifications) |

Scheduling with an existing id replaces the old notification, so
"reschedule" is just "schedule again".

A date in the past is still handed to the plugin. Nothing filters it out
first.

### Permission
Requested **lazily**, once per app run, on the first `schedule` call.
Android 13+ asks for `POST_NOTIFICATIONS`, and Android 12+ for exact alarms.
A fresh install never prompts at launch.

### Tap to open
The payload is the Task id (`id ~/ 2`), so a tap on either notification
opens the same Task.
- **App running:** the `onTap` stream opens Task Detail through a global
  navigator key.
- **App killed:** `launchDetails()` is read once after the first frame, and
  then the same path runs.
- If the Task has since been deleted, nothing happens.

### Testing seam
`NotificationService` is the only boundary to the platform. Repository
tests use a fake that records what was scheduled and cancelled.

## What would change my mind
- Notifications arriving late or being dropped on the owner's phone
  because of battery limits.

## Open questions
- A reminder already in the past still gets scheduled. On Android this
  fires immediately or not at all, depending on the version. It is not
  handled on purpose.

---
Part of [Santian](../README.md)
