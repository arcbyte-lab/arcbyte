---
title: Calendar spec — the home calendar as built: month, week and full screen
idea: tasko
lens: hipster
kind: wireframe
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: weak
created: 2026-11-10
updated: 2026-11-10
inputs: ["./calendar-revamp-iphone-style.md", "./hifi-mockup-tickets-for-pen-dev.md", "../decisions/0016-calendar-follows-the-iphone-calendar.md", "../decisions/0020-my-tasks-moves-to-my-workspace-pulled-down-from-home.md", "../decisions/0021-calendar-days-are-rings-not-dots.md", "../assets/pencil-new.pen"]
tags: [artifact]
---

## Question
What does the home calendar look and do like now? This replaces the "Pulse
panel" wording and the dots of the
[calendar revamp](./calendar-revamp-iphone-style.md); the component is called
**Calendar** from here on.

## Short answer
- Every day is a **grey disc with a ring**: one arc per kind of task due that
  day (overdue, open, in review, done). The dots are gone
  ([0021](../decisions/0021-calendar-days-are-rings-not-dots.md)).
- The **month is always 6 weeks tall**, so it never jumps between months.
  Week rows are 44 tall.
- **Full screen** uses the same discs and rings, and its titles are coloured
  by the same four kinds. Today is black in the month and week, blue in full
  screen.
- The white section under the calendar has **rounded top corners**. The
  grabber stays under the month.

Component and frames in `pencil-new.pen`: `hifi / Calendar` (month),
`hifi / Calendar / Week`, and the screens `hifi / home / default`,
`/ day-selected` and `/ calendar-fullscreen`. PNGs are in
`assets/hi-fi snapshoots/`. The app builds it as `CalendarPanel`
(`lib/tasks/widgets/calendar_panel.dart`).

## Detail

### The four kinds
A task due on a day is one of four kinds, from its status and the day.
The same rule colours the ring arcs and the full-screen titles.

| Kind | When | Ring arc | Title: background / text |
|---|---|---|---|
| overdue | open (`waiting`, `in progress`) and the day is before today | #EF4444 | #EF4444 at 12% / #DC2626 |
| open | open, due today or later | #2563EB | #E0F2FE / #1E3A8A |
| review | status `review`, on any day | #F97316 | #FEF3C7 / #92400E |
| done | status `done`, on any day | #16A34A | #DCFCE7 / #166534 |

### The ring
- A 2px ring round the disc, split evenly between the kinds present that
  day, drawn **clockwise from the top** in this order: overdue, open,
  review, done. One kind is a full ring; two are halves; three are thirds;
  four are quarters. Two tasks of one kind are one arc.
- A day with no task has no ring, only the disc.
- The ring counts **every task due that day in the active tab, whatever its
  status**. The dots counted open tasks only, so a day with only done
  tasks now shows a green ring.

### Month and week
| Part | Value |
|---|---|
| Panel | #F9FAFB background, no bottom border |
| Header | "**October** 2026" (22 semibold + 22 regular #6B7280), "Today" (15 medium #3B82F6), the maximize icon |
| Weekdays | M T W T F S S, as before |
| Day | a 36px disc, #F3F4F6; the number 15 regular #333333, weekends #9CA3AF |
| Today | black disc, white 600 number |
| Selected | #333333 disc, white 600 number (wins over today) |
| Rows | 44 tall, no lines between them |
| Month height | always 6 rows (264), so a 4 or 5 week month leaves empty space at the bottom. The panel may use up to 55% of the screen height |
| Week strip | one row of the same days. A day tap folds the month to its week, as in [0016](../decisions/0016-calendar-follows-the-iphone-calendar.md) |
| Grabber | 36×4 #D1D5DB **under the month**, where it was. Dragging it, or the tab bar, folds or opens the month |
| White section | the tab bar and list sit on white with **16px rounded top corners** over the grey |

### Full screen
| Part | Value |
|---|---|
| Panel | 16px rounded top corners over the black bar, a 36×4 #D1D5DB grabber at the top. The grabber only decorates; the corner icon closes the view |
| Day | a 30px disc with the same ring; number 13 medium |
| Today | **blue** disc, #2563EB, white 600 number |
| Titles | every task due that day, any status, coloured by kind (table above): 16 tall, 10 medium, radius 3, cut to one line with no ellipsis |
| Many tasks | more than 3: the first 2 and "+N more", N counting all the tasks, so 5 tasks show "+3 more" |
| Grid | no row lines; the 6 rows share the screen height |
| Hidden | the workload strip, the tabs, the list and the rails |

Tapping a title opens its day, as in 0016: back to the month, folded to that
week, the list filtered to that day.

### Gestures
- **Tap a day:** selects it and folds the month to its week (0016).
- **Swipe sideways:** changes the month, or the week in the strip. The
  selected day stays.
- **Drag the grabber or the tab bar:** folds or opens the month (0016).
- **Pull down on the open month:** slides home away and shows My Workspace
  ([0020](../decisions/0020-my-tasks-moves-to-my-workspace-pulled-down-from-home.md)).
  It works only while the month is open, and the calendar's own sideways
  swipe still works.

### Settled by the owner (2026-11-10, in chat)
- The ring colours and their order, as listed above.
- The grabber stays under the month.
- The month is as tall as 6 weeks, always.
- Each drawing is followed as drawn: today black in the month and week,
  blue in full screen.

## What would change my mind
- A full 6 week month leaves about 2 to 3 list rows above the rails on a
  852-tall phone. If that feels cramped on a real phone, shrink the disc
  (36) before the row (44).
- A task that is both in review and overdue shows only as review. If
  reviewers need to see lateness, split that arc.

## Open questions
- Does the full-screen "today" stay blue when it is also the selected day?
  The app shows #333333, as in the month.
- `hifi / home / day-selected` and `hifi / home / default` were drawn
  before the 44px rows, so they may need a redraw.

---
Part of [Tasko](../README.md)
