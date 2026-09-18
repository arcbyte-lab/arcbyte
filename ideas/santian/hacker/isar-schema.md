---
title: Isar schema — TaskList, Task, embedded Repeat and Subtask
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./task-list-subtask-data-model.md", "../decisions/0006-isar-for-tasks-storage.md", "../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "../hipster/tasks-list-screen-interactions.md", "../hipster/repeat-dialog-interactions.md"]
tags: [artifact]
---

## Question
[The data model note](./task-list-subtask-data-model.md) settled List,
Task, and Subtask's *fields*. [Decision 0006](../decisions/0006-isar-for-tasks-storage.md)
picked Isar. Neither says what the actual Isar collections look like —
types, indexes, embedded-vs-linked. What's the schema to actually write?

## Short answer
- Three shapes: a `TaskList` collection, a `Task` collection, and two
  **embedded** (not collection) objects on `Task` — `Repeat?` and
  `List<Subtask>` — matching decision 0006's reasoning that Subtasks are
  never queried independently.
- **Naming collision, not in the data model:** the domain term is "List"
  (per [Arcbyte's own CONTEXT.md](../../../CONTEXT.md) and
  [Santian's](../CONTEXT.md)), but `List` is a reserved built-in type in
  Dart. The Isar collection class is named `TaskList` — this is
  [the Domain model rule](../../../CONTEXT.md) working as intended: code
  implements the domain model, it doesn't have to reuse the exact word when
  the language won't allow it, as long as nobody starts calling the concept
  something else in conversation or design docs.
- `listId` is a plain indexed `int` field on `Task`, not an `IsarLink` — a
  direct implementation of decision 0006's "plain indexed lookup" reasoning.
- One thing decision 0006 named that the resolved Tasks screens don't
  actually need yet: a "by day" query. Flagged below, not silently kept or
  dropped.

## Detail

### `TaskList` collection
```dart
@collection
class TaskList {
  Id id = Isar.autoIncrement;

  late String name;
  late String icon;   // lucide icon identifier, e.g. "rocket" — matched
                       // client-side to a Flutter icon widget, not stored
                       // as anything richer than a string key.
  late int color;      // ARGB int, direct Color(value) construction —
                        // simpler than parsing a hex String on every read.
}
```
`taskCount` is **not a field** — [the data model](./task-list-subtask-data-model.md#list)
already flagged it as "almost certainly derived," and this schema settles
that: it's a reactive `Task` query (`where listId == X && isCompleted ==
false, count()`), not a cached/stored number. No cache-invalidation logic
needed, and Isar's `watch()` (the reason decision 0006 picked Isar in the
first place) makes a live count cheap.

### `Task` collection
```dart
@collection
class Task {
  Id id = Isar.autoIncrement;

  @Index()
  late int listId;              // TaskList.id — plain field, not a link.

  late String title;
  String? description;

  DateTime? reminderAt;         // notification trigger. Date-only entry
                                 // still stores a full DateTime — see
                                 // "Date-only reminderAt" below.
  DateTime? deadline;            // separate field per decision 0007 — own
                                  // notification, own overdue styling.
                                  // Date-only always (no time component,
                                  // per the calendar-only picker).

  Repeat? repeat;                // embedded, see below. Null = no repeat.

  @Index()
  bool isStarred = false;

  bool isCompleted = false;

  List<Subtask> subtasks = [];   // embedded, see below.
}
```

### Embedded: `Repeat`
```dart
@embedded
class Repeat {
  // daily | weekly | monthly | yearly | custom
  @enumerated
  late RepeatFrequency frequency;

  int interval = 1;              // custom only; 1 otherwise, per the data model.

  // days | weeks | months | years — custom only, null otherwise.
  @enumerated
  RepeatUnit? unit;

  // ISO 8601 weekday numbering (1 = Monday … 7 = Sunday), used only when
  // frequency is weekly, or custom with unit: weeks.
  List<int> weekdays = [];
}

enum RepeatFrequency { daily, weekly, monthly, yearly, custom }
enum RepeatUnit { days, weeks, months, years }
```
Matches [the Repeat dialog spec](../hipster/repeat-dialog-interactions.md)'s
field mapping exactly: `N = 1` → `frequency` set directly, `unit`/`interval`
left at defaults; `N ≠ 1` → `frequency: custom` with `interval`/`unit` both
set. `weekdays` as plain `List<int>` rather than a `List<Enum>` — Isar
supports primitive lists natively without extra mapping overhead, and ISO
weekday numbers are unambiguous without needing a dedicated enum.

No `endDate`/`endCount` fields — [the data model](./task-list-subtask-data-model.md#task)
already confirmed Repeat has no end condition, echoed by
[the Repeat dialog spec](../hipster/repeat-dialog-interactions.md) dropping
the reference screenshot's "Ends" section entirely.

### Embedded: `Subtask`
```dart
@embedded
class Subtask {
  String id = const Uuid().v4();  // embedded objects have no Isar Id of
                                    // their own — a client-generated UUID
                                    // is what "delete subtask X" or
                                    // "reorder subtask X" actually targets.
  late String title;
  bool isCompleted = false;
  late int order;                  // manual, per the data model — not
                                    // list-insertion order.
}
```
No `taskId` field — unlike the conceptual data model (which named it to
describe the *relationship*), an embedded object in Isar has no independent
existence outside its parent `Task.subtasks` list, so there's nothing for
`taskId` to point at. The relationship is structural, not a stored field.

### Indexes: what the 3 confirmed queries actually need
Per [decision 0006](../decisions/0006-isar-for-tasks-storage.md), Tasks
needs exactly three query shapes: **by list**, **by star**, **by day**.
This schema gives the first two direct `@Index()` fields (`listId`,
`isStarred`). The third — **"by day" is not indexed here, and arguably
isn't needed yet**: nothing in [the resolved Tasks screens](../hipster/tasks-list-screen-interactions.md)
filters Tasks by a specific day — Tasks List filters by list or star only.
"By day" reads like a Clockface-era query (a day view needs "what's
scheduled today"), which [decision 0005](../decisions/0005-clockface-questions-dont-block-tasks-build.md)
already deferred. Not dropped, just not built into this schema — add a
`reminderAt`/`deadline` composite index when the Clockface's own storage
question is actually answered, rather than guessing its shape now.

### Sort order: inferred, not confirmed
Not addressed by any spec so far, but implied by the mockup's row order
("Morning workout 7:00 AM," "Review pull requests 9:00 AM," "Team standup
10:00 AM" — ascending). **Recommendation, not a ruling:** incomplete Tasks
sorted by `reminderAt` ascending (nulls last, since a Task with no reminder
has nothing to sort by), completed Tasks below all of them (per
[the resolved completed-task visual](../hipster/tasks-list-screen-interactions.md)),
sort order among completed Tasks unspecified — most-recently-completed
first is a reasonable default, not confirmed.

### Date-only `reminderAt`
[The date/time picker spec](../hipster/date-time-picker-interactions.md)
resolved that a date-only `reminderAt` selection defaults to a fixed time
(recommended 9:00 AM, not confirmed). This schema stores that as a full
`DateTime` either way — there's no separate "has a time" flag. If the
default-time recommendation changes, only the picker's write path changes,
not this schema.

## What would change my mind
If Subtasks ever need independent querying (a cross-Task subtask search or
list, mentioned as decision 0006's own stated risk), the embedded-object
choice for `Subtask` breaks and needs revisiting as its own `@collection`
with a `taskId` link — a real schema migration, not a small tweak.

## Open questions
- Sort order among completed Tasks — recommended above (most-recent-first),
  not confirmed.
- Whether a `reminderAt`/`deadline` index is worth adding now for future
  sorting even without a "by day" query driving it — leaning no (YAGNI
  until the Clockface actually needs it), not settled.

---
Part of [Santian](../README.md)
