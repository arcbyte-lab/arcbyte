---
title: Calendar revamp build tickets — dots, a week strip, task titles in full screen
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-29
updated: 2026-10-29
inputs: ["../decisions/0016-calendar-follows-the-iphone-calendar.md", "../hipster/calendar-revamp-iphone-style.md", "./flutter-app-as-built.md"]
tags: [artifact]
---

## Question
What are the build tickets for the calendar revamp in
[0016](../decisions/0016-calendar-follows-the-iphone-calendar.md)?

## Short answer
- 2 app tickets, **B16–B17**, in order. **No API ticket.** `HomeCubit`
  already holds every tab's tasks (`tasksByTab`), so the counts, the dots
  and the full-screen titles all come from tasks the app already has.
- B16 changes the rules and the Cubit: a tap always selects, "Today"
  selects today, the week strip moves by week. B17 redraws `PulsePanel`.
- The drawing is the spec: `hifi / calendar / month`, `/ day-selected`,
  `/ fullscreen` in `pencil-new.pen`, PNGs in `assets/hi-fi snapshoots/`.

## Detail
Read against Tasko-Flutter `main` at `be6f21a` (2026-10-29). Status lives on
the issues and their PRs once they are opened
([0015](../decisions/0015-github-holds-ticket-status-arcbyte-holds-the-why.md)).

### Rules
| Rule | Value |
|---|---|
| Dots | 0 open tasks = none, 1 = 1 dot, 2–3 = 2, 4+ = 3. The same steps as `PulsePanel.cellColor` today |
| Dot colour | #EF4444 on a day in `overdueDays`, else #3B82F6 |
| Tap a day | Selects it, always. Never clears. Collapses the full screen and the month to that day's week |
| Second tap on the selected day | Nothing happens. Only the chip's "×" (`clearDay`) clears |
| "Today" | Selects today: month = today's month, the list filtered to today, collapsed to the week |
| Tap a title in full screen | The same as tapping its day |
| Swipe sideways | Month open: next or previous month. Week strip: next or previous week. Swiping only moves the view: the selected day and the filter stay until a day is tapped |
| Switch tabs | The selected day and its filter stay. The calendar shows the new tab's dots |
| Open the month again | Tap the title or drag the grabber down. The day stays selected and the list stays filtered |
| Full-screen titles | Open tasks due that day, in `taskOrder`. 3 or fewer: all. More: the first 2 and "+N more" |

### App (Tasko-Flutter)
Same shape as now: a pure `*View`, a thin `*Screen`, Cubits behind the
`TasksApi` seam. Each ticket is done when `flutter analyze` and
`flutter test` pass.

**B16 — Rules and state**
- `task_rules.dart`:
  - `dotCount(int count)` → 0–3, using the steps above.
  - `dueByDay(Iterable<Task> tasks, DateTime month)` →
    `Map<int, List<Task>>`, open tasks only, each list in `taskOrder`.
    `dueCounts` becomes the lengths of that map, so the two can't disagree.
  - Unit tests for both, including the 1/2/3/4 edges and a done task that
    must not count.
- `HomeState`:
  - gains `monthOpen` (bool, default true). The week strip shows when
    `selectedDay != null && !monthOpen`.
  - gains `week`: the Monday of the week the strip shows. It is separate
    from `selectedDay`, so the strip can show a week the selected day isn't
    in.
  - gains `dueByDayThisMonth`, for B17's full-screen titles.
- `HomeCubit`:
  - `selectDay(day)`: always sets `selectedDay`. Sets `monthOpen: false` and
    `calendarExpanded: false`, and moves `week` to the day's week and `month`
    to the day's month. The toggle is gone.
  - `goToToday()`: `selectDay(state.today)`.
  - `changeWeek(int delta)`: moves `week` by 7 days and sets `month` to
    the new Monday's month. It does not touch `selectedDay`.
  - `openMonth()`: `monthOpen: true`.
  - `clearDay()`: also sets `monthOpen: true`.
- `HomeState.pageFor`: stop resetting `selectedDay`, so switching tabs
  keeps the day. It still resets `showCompleted` and the view filters.
- Tests in `home_cubit_test.dart`. Rewrite two tests that now expect the
  wrong thing: "selecting a day filters; selecting it again clears" (a
  second tap keeps the filter) and "changing tab loads its tasks and clears
  the day filter" (the day now stays). Add tests for: `goToToday` from
  another month, `changeWeek` across a month end (week of Oct 26 + 1 = week
  of Nov 2, `month` becomes November, `selectedDay` and `listed`
  unchanged), and `clearDay` reopening the month.

**B17 — Redraw `PulsePanel`**
Match the three `hifi / calendar / …` frames. The numbers are in the
[revamp note](../hipster/calendar-revamp-iphone-style.md).
- Header: "October" (22 w600 `foreground`) and "2026" (22 regular
  `mutedForeground`). The year always shows. Then a "Today" text button
  (15 w500 `primary`) → `onToday`, and the existing expand/collapse
  button. The chevron buttons and "MONTHLY" go. While the week strip
  shows, a `chevron-down` follows the year, and tapping the title calls
  `onOpenMonth`.
- Grid: full width, 7 columns, weekday initials 11 w500 (S S in
  `placeholder`). A 1px `border` line above each week. Rows 40 high.
- Day: the number 15 regular, centred in a 28px circle. Weekends are in
  `placeholder`. Today: a `primary` circle with white w600. Selected: a
  `foreground` circle with white w600. If today is selected, it shows
  selected. Dots (4px, 2px gap) sit 2px under the circle.
- Week strip: the selected day's week only, then a 36×4 `controlBorder`
  grabber, radius 2. Dragging down on it calls `onOpenMonth`.
- Swipes: `onHorizontalDragEnd` calls `onMonthChange` in the month and
  `onWeekChange` in the strip. Same 200 velocity threshold as now.
- Full screen: the same header with collapse. Rows fill the height. Each
  cell has the day number (13 w500, a 24px circle for today or selected),
  then the title pills: 10 w500 on one line, cut off with no ellipsis,
  `accent` / `accentForeground`, radius 3, 16 high. Overdue pills are
  `destructive` text on `destructive` at 12%. Tapping a pill or a cell
  calls `onDayTap(date)`.
- `HomeView` and `HomePanel` wire the new callbacks: `goToToday`,
  `changeWeek`, `openMonth`. `PulsePanel` takes `dueByDay` in place of
  `counts`, since the count is the list's length.
- Accessibility: each day keeps `Semantics(button, selected, label)`. The
  label also says the count, e.g. "Day 14, 5 open". The grabber and the
  title get labels too ("Show month").
- Delete `PulsePanel.cellColor`, `AppColors.heatmapEmpty` and
  `AppColors.heatmapBusiest`. Nothing uses them after this.
- Update the widget tests that find the old chevrons or the "MONTHLY"
  label.

### Not in these tickets
- Swiping up and down between months, as the iPhone does. Rejected in 0016.
- A year view, or a week view with times. Tasks have a due date, not a
  time slot.
- Days from the next and previous month in the grid's empty cells. The
  drawing leaves them blank.
- Animating the collapse from month to week. A plain switch is fine for v1.
  Add an `AnimatedSize` if it looks abrupt on the phone.

## What would change my mind
- If the full-screen titles are slow with large tabs, `dueByDay` should be
  worked out once per reload, not on every build.
- If people can't find how to clear a selected day, the second tap comes
  back as a clear (0016 names this signal).

## Open questions
- None yet. The owner settled the week swipe and the tab switch in chat on
  2026-10-29.

---
Part of [Tasko](../README.md)
