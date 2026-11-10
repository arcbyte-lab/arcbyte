---
title: Calendar days are rings, not dots; the month is 6 weeks tall; the full screen shows every task
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-10
updated: 2026-11-10
inputs: ["./0016-calendar-follows-the-iphone-calendar.md", "../hipster/calendar-spec.md"]
tags: [artifact, decision]
---

## Decision

Amends [0016](./0016-calendar-follows-the-iphone-calendar.md). The rest of
0016 stands: a tap selects and folds to the week, sideways swipes, the drag
to fold, "Today", titles that open their day.

1. **Rings, not dots** (replaces 0016 rule 1). Every day is a grey disc.
   A day with tasks gets a ring with one arc per kind of task due that
   day: overdue, open, in review, done, in that order clockwise from the
   top. The ring counts every task due that day, whatever its status.
2. **The month is always 6 weeks tall,** so it does not change height
   between months.
3. **Full screen shows every task, coloured by kind** (amends 0016 rule 7).
   It had shown open tasks only. It also uses the discs and rings, and
   "+N more" counts all the tasks.
4. **Today is black in the month and week, blue in full screen,** as each
   drawing has it.
5. **The component is called Calendar,** not Pulse panel, in the docs, the
   pen file and the app.

## Context

The owner confirmed the arc colours and order, the fixed 6 weeks, and the
grabber staying under the month in chat on 2026-11-10, after the pen file's
`hifi / home / default` and `/ calendar-fullscreen` showed rings that the
written spec (dots) did not. The full spec is the [calendar spec](../hipster/calendar-spec.md).
Stays `draft` until the owner promotes it.

---
Part of [Tasko](../README.md)
