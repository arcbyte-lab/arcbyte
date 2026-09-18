---
title: Repeat-advance algorithm — next occurrence, and why there's no catch-up
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["./isar-schema.md", "./notification-scheduling.md", "../hipster/repeat-dialog-interactions.md", "./task-list-subtask-data-model.md", "./flutter-module-structure.md"]
tags: [artifact]
---

## Question
[Notification scheduling](./notification-scheduling.md) deferred two things
to this note: the actual date math for advancing a repeating Task's
`reminderAt`/`deadline`, and whether the app needs to "catch up" if it was
closed past one or more occurrences. What's the algorithm, and does catch-up
logic need to exist at all?

## Short answer
- One function, `nextOccurrence(DateTime current, Repeat repeat)`, called
  **independently** on `reminderAt` and on `deadline` (when set) — not a
  shared delta between them. Simpler, and correct for every frequency shape
  [the Repeat dialog](../hipster/repeat-dialog-interactions.md) supports.
- Weekly-with-multiple-weekdays is the one genuinely non-trivial case:
  finding the next matching weekday, not just adding 7 days.
- Monthly/yearly need explicit **clamping** for dates that don't exist in
  the target month (Jan 31 + 1 month) — recommended, not specified anywhere
  else.
- **No catch-up logic is needed at all.** Advance only happens when the
  user completes the Task — a missed occurrence just sits there, correctly
  shown as overdue by
  [the already-resolved overdue styling](../hipster/deadline-badge-and-overdue-styling.md),
  until the user acts on it. This isn't an oversight; it falls directly out
  of how completion is already defined.

## Detail

### `nextOccurrence(current, repeat)`
```dart
DateTime nextOccurrence(DateTime current, Repeat repeat) {
  final n = repeat.interval; // 1 unless frequency is custom

  switch (repeat.frequency) {
    case RepeatFrequency.daily:
      return current.add(Duration(days: n));

    case RepeatFrequency.weekly:
      return repeat.weekdays.isEmpty
          ? current.add(Duration(days: 7 * n))
          : _nextWeekday(current, repeat.weekdays, n);

    case RepeatFrequency.monthly:
      return _addMonthsClamped(current, n);

    case RepeatFrequency.yearly:
      return _addMonthsClamped(current, n * 12);

    case RepeatFrequency.custom:
      switch (repeat.unit!) {
        case RepeatUnit.days:   return current.add(Duration(days: n));
        case RepeatUnit.weeks:
          return repeat.weekdays.isEmpty
              ? current.add(Duration(days: 7 * n))
              : _nextWeekday(current, repeat.weekdays, n);
        case RepeatUnit.months: return _addMonthsClamped(current, n);
        case RepeatUnit.years:  return _addMonthsClamped(current, n * 12);
      }
  }
}
```
Called independently for `reminderAt` and, if set, `deadline` — **not**
"advance `reminderAt`, then shift `deadline` by whatever gap it had before."
Each field just moves forward by its own repeat rule from its own current
value. This is simpler (no delta to track or store) and gives the same
result as delta-preservation for daily/weekly/yearly; for monthly it's
arguably *more* correct, since a `deadline` on the 5th and a `reminderAt` on
the 28th of the same repeating Task should each keep their own day-of-month
identity, not an artificial fixed gap between them.

### Weekly with selected weekdays
The one real algorithm here — "every Monday and Thursday" needs the next
date *after* `current` whose weekday is in the set, not `current + 7 days`:
```dart
DateTime _nextWeekday(DateTime current, List<int> weekdays, int intervalWeeks) {
  final sorted = weekdays.toList()..sort();
  for (var d = current.add(const Duration(days: 1)); ; d = d.add(const Duration(days: 1))) {
    if (sorted.contains(d.weekday)) return d;
    // if we've crossed into a new ISO week and interval > 1, skip ahead
    // (interval - 1) extra weeks before continuing to scan for a match.
  }
}
```
Sketch only — the "skip ahead by `(interval - 1)` weeks" branch for
`custom, unit: weeks, interval > 1` needs care (ISO week boundaries, Monday
as week start) and is real implementation work, not something to fully
pseudocode here. Flagged as the trickiest piece of this whole algorithm.

### Monthly/yearly clamping
Not specified anywhere else. **Recommendation, not a ruling:** clamp to the
last valid day of the target month — Jan 31 repeating monthly becomes Feb
28 (or 29), not an overflow into March. Same for yearly: Feb 29 repeating
yearly becomes Feb 28 in a non-leap year. This is the standard behavior in
Google Calendar and most calendar apps; the alternative (rolling over into
the next month) is surprising and not how any reference this project has
used behaves.

### Why there's no catch-up logic
[The data model](./task-list-subtask-data-model.md#task) already ties
advancing to **completion**, not to time passing: "Checking it off advances
`reminderAt`/`deadline` to the next occurrence." Nothing says the app should
notice three days have passed and silently fast-forward through three
missed occurrences on its own. Given that:
- A missed occurrence's `reminderAt`/`deadline` just **stays where it
  was** — which is exactly what
  [overdue styling](../hipster/deadline-badge-and-overdue-styling.md) is
  for. A repeating Task that's overdue is not a bug state; it's the
  intended visual signal that it wasn't completed on time.
- Completing it — whenever that happens, today or three days late — runs
  `nextOccurrence()` exactly **once**, moving to the occurrence immediately
  after the one that was just completed, not to "today" or "the next future
  date." If the owner was on vacation for two weeks and a daily Task has two
  weeks of backlog, completing it once only advances by one day; getting
  fully caught up means completing it repeatedly, or the owner deciding to
  turn Repeat off and back on. Nothing asked for a "skip ahead to now"
  affordance, so this note doesn't invent one.
- Local notifications for occurrences that already fired while the app was
  closed are the OS's problem, not this algorithm's — `flutter_local_notifications`
  schedules one notification at a time (per
  [the scheduling spec](./notification-scheduling.md)'s reschedule-on-complete
  model), so there's never a backlog of *pending* notifications to reconcile,
  only the single next one.

### Integration with notification scheduling
[The scheduling spec](./notification-scheduling.md) already says completing
a repeating Task reschedules both notification IDs rather than cancelling
them. This note is what computes the dates that reschedule call uses:
`nextOccurrence(task.reminderAt, task.repeat!)` and, if `deadline` is set,
`nextOccurrence(task.deadline!, task.repeat!)` — called once, synchronously,
in `TaskRepository.toggleCompleted()`, the single method that flips
`isCompleted` for **any** Cubit's "complete this Task" action. See
[the module structure note](./flutter-module-structure.md) for why that
logic lives in one repository method rather than being duplicated per
Cubit.

## What would change my mind
If the owner actually wants a "skip to today" affordance for a badly-missed
repeating Task — that's a real feature request this note deliberately
didn't design for, not a gap in the algorithm above.

## Open questions
- The weekly-with-`interval`-greater-than-1 week-skipping logic is sketched,
  not fully specified — real implementation care needed.
- Monthly/yearly clamping — recommended above, not confirmed by the owner.

---
Part of [Santian](../README.md)
