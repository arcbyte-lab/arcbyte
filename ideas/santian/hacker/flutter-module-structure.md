---
title: Flutter module structure — folders, and one repository instead of duplicated Cubit logic
idea: santian
lens: hacker
kind: architecture
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./isar-schema.md", "./notification-scheduling.md", "./repeat-advance-algorithm.md", "../decisions/0009-cubit-for-state-management.md", "../decisions/0003-personal-tool-not-a-product.md"]
tags: [artifact]
---

## Question
Every piece of the Tasks module has its own spec now — schema, notification
scheduling, repeat-advance, Cubit. None of them say where the code actually
lives, or how they connect. Writing that connection out surfaced a real gap:
**two different Cubits both need "complete this Task" logic**
(`TasksListCubit`'s checkbox, `TaskDetailCubit`'s Mark Completed pill), and
[notification scheduling](./notification-scheduling.md) said that logic
runs "in the same Cubit method" — which one, if there are two?

## Short answer
- A single **`TaskRepository`** sits between the Cubits and Isar — the one
  place that mutates a Task and coordinates the notification
  schedule/cancel/reschedule that goes with that mutation. Cubits call it;
  they don't touch Isar or `flutter_local_notifications` directly.
- This fixes a real duplication risk, not a hypothetical one: without it,
  completing a repeating Task would need the exact same
  advance-then-reschedule logic written twice, once per Cubit that offers a
  "complete" action.
- Folder layout is feature-first and flat — no clean-architecture
  domain/usecase layers. [Decision 0003](../decisions/0003-personal-tool-not-a-product.md)
  (personal tool, one developer) doesn't justify that ceremony.

## Detail

### Why a repository, when decision 0009 didn't mention one
[Decision 0009](../decisions/0009-cubit-for-state-management.md) described
"each [Cubit] subscribing to an Isar `watch()` stream" — true for reads, but
underspecified for writes. Three different UI actions all need to run the
exact same "complete a Task" logic:
[Tasks List's checkbox](../hipster/tasks-list-screen-interactions.md),
[Task Detail's Mark Completed pill](../hipster/task-detail-identity-and-fields.md),
and (per
[the repeat-advance algorithm](./repeat-advance-algorithm.md)) that logic
branches on whether the Task repeats, and either way ends with
[a notification reschedule](./notification-scheduling.md). Writing that
three times across three Cubits — or worse, having them drift out of sync
as one gets edited and the others don't — is exactly the kind of
duplication a thin shared layer exists to prevent. This isn't
over-engineering for its own sake; it's the direct consequence of two
already-settled specs sharing one action.

### `TaskRepository`
```dart
class TaskRepository {
  TaskRepository(this._isar, this._notifications);
  final Isar _isar;
  final NotificationService _notifications;

  Stream<List<Task>> watchByList(int listId) => /* Isar watch(), filtered */;
  Stream<List<Task>> watchStarred() => /* Isar watch(), isStarred filter */;

  Future<void> create(Task task) async { /* Isar put + schedule */ }
  Future<void> update(Task task) async { /* Isar put + reschedule */ }
  Future<void> delete(int taskId) async { /* Isar delete + cancel both IDs */ }

  // The one method both TasksListCubit and TaskDetailCubit call —
  // this is where "complete a Task" actually lives, once.
  Future<void> toggleCompleted(Task task) async {
    if (task.repeat == null) {
      task.isCompleted = !task.isCompleted;
      task.isCompleted
          ? await _notifications.cancelBoth(task.id)
          : await _notifications.scheduleBoth(task);
    } else {
      task.reminderAt = nextOccurrence(task.reminderAt!, task.repeat!);
      if (task.deadline != null) {
        task.deadline = nextOccurrence(task.deadline!, task.repeat!);
      }
      task.isCompleted = false;
      await _notifications.rescheduleBoth(task);
    }
    await _isar.writeTxn(() => _isar.tasks.put(task));
  }
}
```
`NotificationService` wraps
[the ID scheme and schedule/cancel/reschedule rules](./notification-scheduling.md)
directly — the repository calls it, it never touches
`flutter_local_notifications` itself.

### Folder layout
```
lib/
  main.dart
  app.dart                    # MaterialApp, theme, routing root

  core/
    theme/                    # exodus.css tokens ported to ThemeData
    notifications/
      notification_service.dart   # ID scheme, schedule/cancel/reschedule

  tasks/
    models/
      task.dart                # @collection Task
      task_list.dart            # @collection TaskList
      repeat.dart                # @embedded Repeat, RepeatFrequency/Unit
      subtask.dart               # @embedded Subtask
    repeat_advance.dart          # nextOccurrence() — a pure function, not
                                   # tied to Isar or notifications, so it's
                                   # top-level in tasks/, not buried in
                                   # models/ or repository/
    repository/
      task_repository.dart
      list_repository.dart       # TaskList CRUD — smaller, no notification
                                   # coordination needed
    cubits/
      tasks_list_cubit.dart
      task_detail_cubit.dart
      create_task_cubit.dart
    screens/
      tasks_list_screen.dart
      task_detail_sheet.dart
      create_task_sheet.dart
      date_time_picker_dialog.dart
      repeat_dialog.dart
      list_picker_sheet.dart      # Task Detail's List Selector, per its spec
    widgets/
      task_row.dart
      list_tab_bar.dart
      date_chip.dart              # reused for reminderAt and deadline
      deadline_badge.dart
```
No `domain/`, no `usecases/`, no interface-per-repository indirection —
[decision 0003](../decisions/0003-personal-tool-not-a-product.md) already
settled that this is a personal tool with one developer; a layer that
exists to let multiple teams swap implementations independently has no
audience here. `repeat_advance.dart` sits directly under `tasks/`, not
inside `repository/`, because it's a pure function with no Isar or
notification dependency — keeping it separate makes it trivially unit-
testable without mocking either.

## What would change my mind
If `TaskRepository` grows past a handful of methods and starts accumulating
unrelated concerns (List management creeping in, say), that's the signal to
split it — not a reason to avoid starting with one file now.

## Open questions
- None left open on the repository/duplication question this note exists
  to answer. Folder names above are a reasonable default, not something the
  owner has reviewed line-by-line.

---
Part of [Santian](../README.md)
