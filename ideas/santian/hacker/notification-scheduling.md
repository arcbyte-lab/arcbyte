---
title: Notification scheduling — IDs, lifecycle triggers, permissions, tap-to-open
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./local-notifications-package.md", "../decisions/0010-flutter-local-notifications-package.md", "../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "./isar-schema.md", "../hipster/tasks-list-screen-interactions.md", "../hipster/task-detail-more-menu-and-delete.md", "./repeat-advance-algorithm.md"]
tags: [artifact]
---

## Question
[Decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md)
confirmed two independent notifications per Task, and
[decision 0010](../decisions/0010-flutter-local-notifications-package.md)
picked the package to fire them. Neither says how a Task's fields actually
turn into scheduled, cancelled, and rescheduled notifications as the app is
used. What's the spec?

## Short answer
- Each Task gets up to **two notification IDs**, derived deterministically
  from `Task.id` — no separate ID storage needed. No catch-up logic is
  needed after the app's been closed a while — see
  [the repeat-advance algorithm](./repeat-advance-algorithm.md), which
  resolves this note's original open question.
- Every write that touches `reminderAt`, `deadline`, `isCompleted`, or
  deletes the Task re-syncs its notifications: schedule if a date is set and
  the Task is incomplete, cancel if cleared, completed, or deleted.
- Completing a **repeating** Task doesn't just cancel — it reschedules both
  notifications to the next occurrence, since `isCompleted` resets to
  `false` per [the data model](./task-list-subtask-data-model.md#task).
- Notification permission is requested **the first time the user sets a
  reminder or deadline**, not on app launch — recommendation, not confirmed.
- Tapping a notification opens the app straight to that Task's
  `Task Detail` — needs a `taskId` payload and cold-start handling.

## Detail

### Notification ID scheme
`flutter_local_notifications` needs a stable `int` ID per notification, to
cancel/reschedule it precisely later. Recommend deriving both IDs directly
from `Task.id` (an Isar `int`) rather than storing them:
```
reminderNotificationId = task.id * 2
deadlineNotificationId = task.id * 2 + 1
```
Guaranteed unique per Task, no extra field on the schema, and trivially
computed anywhere the Task is in scope — no lookup table needed.

### When notifications get (re)scheduled or cancelled
Every path that changes a Task's `reminderAt`, `deadline`, or `isCompleted`
— or deletes it — needs to re-sync both notifications. Concretely:

- **Task created or `reminderAt` edited** (via
  [the date/time picker](../hipster/date-time-picker-interactions.md)):
  cancel `reminderNotificationId` if it existed, then schedule a new one at
  the new `reminderAt` — unless `reminderAt` is now null, in which case just
  cancel.
- **`deadline` edited** (via its own calendar-only picker): same
  cancel-then-reschedule pattern on `deadlineNotificationId`, independent of
  whatever happens to `reminderAt`.
- **Non-repeating Task completed** (checkbox or Mark Completed pill, per
  [Tasks List interactions](../hipster/tasks-list-screen-interactions.md)):
  cancel both IDs. A completed Task has nothing left to remind about.
- **Repeating Task completed:** per
  [the data model](./task-list-subtask-data-model.md#task), completing
  advances `reminderAt`/`deadline` to the next occurrence and resets
  `isCompleted` to `false` — so this is **not** a cancel, it's a
  **reschedule** of both IDs to the newly-computed dates, using
  [the repeat-advance algorithm](./repeat-advance-algorithm.md).
- **Task deleted** (via [Task Detail's More menu](../hipster/task-detail-more-menu-and-delete.md)):
  cancel both IDs. Since delete shows an undo toast, cancelling immediately
  and **re-scheduling on Undo** is simpler and safer than trying to "pause"
  a scheduled notification — a cancelled-then-rescheduled notification
  behaves identically to one that was never touched.
- **App reopened after being closed past a repeating Task's occurrence
  date:** flagged, not solved here — see below.

### Content
Not addressed by any hipster spec (they cover what's shown on-screen, not
notification copy). **Recommendation, not a ruling:**
- Reminder notification: title = `Task.title`, no body — matches this app's
  restraint elsewhere (no extra chrome where a plain title suffices).
- Deadline notification: title = `Task.title`, body = "Due today" — enough
  to distinguish it from the reminder notification if both arrive the same
  day, without inventing a longer copy system nothing has asked for.

### Permissions
Android 13+ requires runtime `POST_NOTIFICATIONS` permission; Android 12+
needs `SCHEDULE_EXACT_ALARM`/`USE_EXACT_ALARM` for precise-time delivery;
iOS requires an explicit notification permission request. **Recommendation,
not a ruling:** request permission **lazily**, the first time the user sets
a `reminderAt` or `deadline` on any Task — not on app launch. Matches real
Google Tasks' own contextual-request pattern (never request a permission
before the feature that needs it is actually invoked) and avoids a blank
permission prompt on first open before the user has done anything yet.

### Tap-to-open
Not addressed by any hipster spec. Each scheduled notification needs a
`payload` carrying that Task's `id`. On tap:
- **App already running:** navigate directly to `Task Detail` for that
  `taskId`, same sheet-opening behavior as tapping the row from Tasks List.
- **Cold start:** `flutter_local_notifications`'s
  `getNotificationAppLaunchDetails()` needs to be checked on app init and
  the same navigation triggered once the app's first frame is up — this is
  a real implementation detail worth naming now so it isn't missed, since
  it's easy to handle the warm-start case and forget the cold-start one.

### What this note deferred — now resolved
- **The next-occurrence date math** and **catch-up behavior** are both
  resolved in [the repeat-advance algorithm spec](./repeat-advance-algorithm.md):
  a `nextOccurrence()` function applied independently to `reminderAt` and
  `deadline`, and **no catch-up logic at all** — a missed occurrence just
  stays overdue until the user completes it, advancing exactly once per
  completion. That resolution is what "reschedule both IDs" (above) actually
  calls.

## What would change my mind
If Android's exact-alarm and battery-optimization restrictions turn out to
delay or drop reminders in practice on the owner's actual device — that's a
real-world signal or [decision 0010](../decisions/0010-flutter-local-notifications-package.md)
being wrong, not something this scheduling spec can fix on its own.

## Open questions
- Notification content copy — recommended above, not confirmed.
- Permission-request timing — recommended above (lazy, on first
  reminder/deadline set), not confirmed.

---
Part of [Santian](../README.md)
