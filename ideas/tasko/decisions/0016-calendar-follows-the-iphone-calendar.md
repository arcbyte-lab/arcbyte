---
title: The home calendar follows the iPhone Calendar app — dots, a week strip on tap, task titles in full screen
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-29
updated: 2026-10-29
inputs: ["../hipster/calendar-revamp-iphone-style.md", "./0003-calendar-is-a-due-date-heatmap-that-filters.md"]
tags: [artifact, decision]
---

## Decision

The home calendar is redrawn after the iPhone Calendar app, as in the
[calendar revamp](../hipster/calendar-revamp-iphone-style.md). It still
counts open tasks due per day in the active tab and still filters the list
([0003](./0003-calendar-is-a-due-date-heatmap-that-filters.md)). These rules
change:

1. **Dots, not shading.** Under each day number: 1 dot for 1 open task,
   2 dots for 2–3, 3 dots for 4 or more. A past day with open tasks gets red
   dots.
2. **Tapping a day selects it and collapses the month to that day's week.**
   The list shows only that day's tasks.
3. **A second tap on the selected day does nothing.** Only the "×" on the
   date chip clears the filter. This replaces 0003's "tapping it again
   clears the filter".
4. **"Today" selects today and filters the list**, the same as tapping
   today's date.
5. **Months change by swiping sideways.** The chevrons are gone. In the
   week strip, a sideways swipe changes the week but not the selected day.
   Only a tap selects a day.
6. **Switching tabs keeps the selected day.** The new tab's list is
   filtered to the same day. Before, a tab switch cleared it.
7. **Full screen shows task titles.** Each day shows up to three titles,
   or two and "+N more" when there are more. Tapping a title opens that
   day: the calendar goes back to its normal size, collapsed to that week,
   with the list filtered to that day. It does not open Task Detail.
8. **The calendar folds by dragging, with the finger.** Dragging the tab
   bar (or the bar under the calendar) down opens the month from the week
   strip. Dragging up folds the month to a week: the selected day's, else
   today's. Nothing is selected by folding. There is no tap for this: the
   chevron after the year and the bar's tap are gone. A day tap, "Today"
   and the chip's "×" animate the same fold.

## Context

The owner asked for the calendar to be revamped, using the iPhone Calendar
app as the reference (2026-10-29). Claude drew it in hifi, and the owner
answered the open points in chat the same day: no clearing on a second tap,
swipe sideways, a title opens its day, "Today" selects and filters,
swiping the week strip doesn't select, and a tab switch keeps the day.
After using the build, the owner asked the same day for rule 8: the switch
between week and month by a drag that follows the finger, not by taps. It stays
`draft` until the owner promotes it.

## What each lens said

- **Hound:** no user input. The iPhone behaviour comes from general
  knowledge of iOS Calendar, not from a source here.
- **Hipster:** see the [revamp note](../hipster/calendar-revamp-iphone-style.md).
  Dots keep the old heatmap's steps, so the load reads the same. The week
  strip gives the filtered list more room.
- **Hacker:** the per-day count is unchanged. Full screen also needs the
  titles of the open tasks due each day. The app already holds every tab's
  tasks, so there is no API change
  ([build tickets](../hacker/calendar-revamp-build-tickets.md)).
- **Hustler:** not consulted.

## Options rejected

- **A second tap clears the filter** (0003's rule). Rejected by the owner.
  The "×" on the chip is the one way out.
- **"Today" only scrolls to today.** Rejected. It selects today and filters.
- **Swiping up and down between months, like the iPhone.** Rejected. It
  would fight the list scroll.
- **A title in full screen opens Task Detail.** Rejected. It opens the day.
- **Tapping the title or the bar to open the month.** Built in B17, then
  dropped by the owner for the drag (rule 8).

## How we will know we were wrong

- People can't read the load from dots at phone size. Then the days go back
  to tinted cells.
- People can't find how to clear a selected day without a second tap.

---
Part of [Tasko](../README.md)
