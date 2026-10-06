---
title: Tasks List screen, as built — card, tabs, swipe, day groups, Completed, List options
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hipster/tasks-list-screen-interactions.md", "../../../archive/santian/hipster/add-list-method.md", "../decisions/0016-follow-google-tasks-mobile-over-the-mockup.md", "../decisions/0017-lists-are-name-only.md"]
tags: [artifact]
---

## Question
What does the Tasks List screen do today, in Santian at `f64e2c0`
(2026-10-02)?

## Short answer
- There is one rounded card. On it are a "Tasks" title, a List options
  menu, a tab bar (Star, then each List, then `+`), and one swipeable page
  per tab. A FAB sits in the corner.
- A List's page groups open Tasks under day headers: Past, Today, Tomorrow,
  a date, No date. Below them is a collapsible "Completed (N)" section. The
  Star page is one flat list.
- The List options menu can rename the List, delete it with all its Tasks,
  or delete only its completed Tasks. Each delete asks for confirmation.

## Detail

Code: `lib/tasks/screens/tasks_list_view.dart`, `tasks_list_panel.dart`,
`widgets/list_tab_bar.dart`. The row itself is in
[task row](./task-row-as-built.md).

### Layout
- The screen background is `background`. On it sits one card: inset 15 px
  from the safe area, radius 28, filled with `surface`. The whole screen
  lives inside that card.
- **Header**, 48 px high: an empty 48 px slot, then the centered title
  "Tasks" (DM Sans, `titleLarge`, weight 500), then the 48 px List options
  slot. The height is fixed, so switching to Star (no menu) does not move
  anything.
- **Tab bar**, aligned left and scrolling sideways: a Star icon (no text),
  then one tab per List with its **name only**, then a `+` icon. Tabs are
  24 px apart. The active tab is tinted `primary` and its label turns
  semibold. One 2 px `primary` underline marks it.
- **Pages:** one per tab (Star, then each List), side by side.
- **FAB:** 52×52, radius 15, `primary` fill, a `+` icon, shadow
  `0 4 16 #00000025`. Placed 21 px from the right and 23 px from the bottom
  of the card.
- The screen does not resize under the keyboard. Sheets lift themselves,
  so the empty-state text and the FAB stay where they are.

### Switching tabs
- **Tap a tab:** the pages slide to it (300 ms, ease-out).
- **Swipe sideways** anywhere on the pages: the neighbouring tab's page
  follows the finger. The underline slides and resizes between the two
  tabs as you drag, and the tint fades from one tab to the other. Letting
  go on a page makes that tab active.
- Once a tab is active, the tab bar scrolls it into view (centered).
- **`+`** is never an active tab. It opens the Create List sheet (see
  [create sheets](./create-sheets-as-built.md)). The new List's tab appears
  before `+` and becomes active.
- **On launch:** the first List is active, not Star.

### A List's page
1. **Open Tasks, grouped by reminder day.** Tasks are sorted by
   `reminderAt` (no reminder last). Each run of Tasks on the same day gets
   a header:
   - **Past**: any day before today. The header is in `error` color.
   - **Today**, **Tomorrow**.
   - Otherwise a short date: "Wed 30 Sept". Outside the current year:
     "Fri, 1 Jan 2027".
   - **No date**: Tasks with no reminder, always last.

   Headers are 14 px, weight 500, `mutedForeground`.
2. **"Completed (N)"** shows below the open Tasks on every List, even when
   N is 0. It starts expanded and tapping the header collapses it. Each
   List remembers its own expanded or collapsed state across swipes.
   Completed Tasks are in the same sort order, with no day headers.

Completed rows are not struck through. They look different only because
the circle is filled and the title is muted (see
[task row](./task-row-as-built.md)).

### The Star page
Every starred Task from every List, open and completed mixed together, in
one flat list sorted by reminder. No headers, no Completed section.

### Empty state
"No tasks for today" (12 px, `mutedForeground`), centered. It shows when
the tab has no Tasks at all. On a List, the "Completed (0)" header still
shows above it.

### List options menu
A `⋮` icon in the header's right slot, shown only while a List is active.
It has three items:

| Item | Enabled when | What happens |
|---|---|---|
| Rename list | always | A dialog with a text field, autofocused and pre-filled with the current name. Save is disabled while the name is blank. Cancel or Save. |
| Delete list | more than one List exists | Asks "Delete "&lt;name&gt;"?", "All tasks in this list will be deleted." Cancel / Delete. Deletes the List's Tasks first, then the List. The first List becomes active. No undo. |
| Delete all completed tasks | the active List has a completed Task | Asks "Delete all completed tasks?", "Completed tasks in "&lt;name&gt;" will be deleted." Cancel / Delete. No undo. |

The last List cannot be deleted. The FAB always needs a List to create
into.

### FAB
It opens the Create Task sheet. The new Task goes into the active List. On
Star, it goes into the last List that was active, or the first List if
none was. The new Task is **not** starred automatically when created from
Star. See the open questions.

### Tapping inside a row
The checkbox completes the Task, the star toggles it, and anywhere else
opens Task Detail. See [task row](./task-row-as-built.md).

## What would change my mind
- Using it day to day turns up grouping that feels wrong. Santian groups by
  `reminderAt`, not by `deadline`.

## Open questions
- Should creating a Task from the Star tab star it? Today it does not.
  Check what Google Tasks does.
- Grouping uses `reminderAt` only. A Task with only a `deadline` lands
  under "No date". Is that right?
- Is "No tasks for today" the right empty text? It shows on any tab with
  no Tasks at all, Star included. It does not mean "nothing due today".

---
Part of [Santian](../README.md)
