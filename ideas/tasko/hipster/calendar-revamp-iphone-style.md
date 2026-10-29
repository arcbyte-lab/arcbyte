---
title: Calendar revamp — the home calendar redrawn after the iPhone Calendar app
idea: tasko
lens: hipster
kind: wireframe
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-29
updated: 2026-10-29
inputs: ["../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md", "./home-screen-wireframe.md", "./hifi-mockup-tickets-for-pen-dev.md", "../assets/pencil-new.pen"]
tags: [artifact]
---

## Question
The owner asked to revamp the home calendar, with the iPhone Calendar app as
the reference. What does that look like in Tasko's hifi theme?

## Short answer
- Day **numbers with dots** replace the grey heatmap squares. 1 dot = 1 open
  task, 2 dots = 2–3, 3 dots = 4 or more. Red dots = overdue. Today is a
  blue circle, the selected day a dark circle.
- Tapping a day **collapses the month to its week**, like iPhone's month →
  day. The list below shows that day. Swipe the strip to move by week.
- Full screen becomes iPhone's detailed month: each day shows **task titles**,
  two at most plus "+N more" when there are more than three.

## Detail

The iPhone points are from general knowledge of iOS Calendar, not from a
source in this conversation. That's why `evidence: none`. Drawn in
`pencil-new.pen` in a new row at y=5656. PNGs are in `assets/hi-fi snapshoots/`.

| Frame | Shows | Built from |
|---|---|---|
| `hifi / calendar / month` | the home screen with the new month panel | `hifi / home / default` |
| `hifi / calendar / day-selected` | Oct 14 tapped: one week strip, a grabber, the "Oct 14 ×" chip and that day's list | `hifi / home / day-selected` |
| `hifi / calendar / fullscreen` | the month with task titles in each day | `hifi / home / pulse-fullscreen` |


### What changes, part by part

| Part | Before (H2) | After |
|---|---|---|
| Header | "MONTHLY" label, "‹ October ›" | "**October** 2026" (22 semibold + 22 regular #6B7280), "Today" text button (15 medium #3B82F6), maximize-2 |
| Month change | chevrons | swipe sideways. "Today" jumps back |
| Grid | 24px squares, centred, 216px wide | full width, 7 columns, a 1px #E5E7EB line above each week |
| Day | a coloured square | the number in 15 regular, weekends #9CA3AF |
| Load | square shade (4 steps) | 0–3 dots, 4px, #3B82F6, under the number. Same steps as the old shades |
| Overdue | a red dot under the square | the day's dots turn #EF4444 |
| Today | 1.5px outline | 28px #3B82F6 circle, white 600 number |
| Selected | 2px blue outline | 28px #333333 circle, white 600 number |
| Day tapped | grid stays, list filters | grid collapses to that week. Tap the title (chevron-down) or drag the grabber to open the month again |
| Full screen | bigger squares with a count | day number plus up to 3 task pills (10 medium, #E0F2FE / #1E3A8A, radius 3, cut to one line). Overdue pills: #EF4444 on #EF4444 at 12%. More than 3: 2 pills and "+N more" |

### Settled by the owner in chat (2026-10-29)
- **A second tap on the selected day does not clear the filter.** The "×"
  on the "Oct 14" chip clears it.
- **Months change by swiping sideways**, as now. Not up and down like the
  iPhone.
- **Tapping a task title in full screen opens that day**: the panel goes
  back to normal size, collapsed to that day's week, with the list filtered
  to that day (the `day-selected` frame). It does not open Task Detail.

Kept: the panel's #F9FAFB background, the maximize/minimize icon, the
"Oct 14 ×" chip, and every part below the panel.

The panel grows from 245 to 276px tall, so the list loses about 30px when
the month is open. When a day is selected the panel is only 136px, so the
list gains more than that back.

### Where this pushes on 0003
[0003](../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md) says
the days are "shaded". Dots still show the same count, in the same steps,
but they are not shading. 0003 also says "tapping it again clears the
filter", and the owner has now said a second tap does not clear it. This
note also answers two of 0003's open questions: the scale is three steps,
and overdue days are red. Changing what 0003 says is an intelligence call,
so it is not edited here.

## What would change my mind
- Dots are too small to read the load at a glance on a real phone. Then go
  back to tinted day cells behind the numbers.
- People keep the month open and never use the week strip. Then the collapse
  only costs taps.

## Open questions
- Does "Today" only move the calendar to today, or also select today and
  filter the list?
- Does the week strip keep the selected weekday when you swipe to the next
  week, like iPhone does?

---
Part of [Tasko](../README.md)
