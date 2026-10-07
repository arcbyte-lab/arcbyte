---
title: Lofi mockup tickets for pen.dev — thirteen prompts, pasted one at a time
idea: tasko
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-07
inputs: ["../assets/blueprint.md", "../assets/pencil-new.pen", "../assets/home-wireframe-snapshot.png", "../assets/tasko-app-wireframe-snapshoot.png", "../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md", "../decisions/0004-checkbox-goes-to-review-only-when-needed.md"]
tags: [artifact]
---

## Question
What should pen.dev be asked to draw so that `pencil-new.pen` gets a full
lofi mockup of Tasko built from the [blueprint](../assets/blueprint.md)?

## Short answer
- There are 13 tickets. Paste **T0 first** in a pen.dev session, then T1 to T12 in
  order. Each ticket is one fenced block.
- They follow the blueprint, the owner's two wireframes, and decisions
  [0002](../decisions/0002-tabs-are-workspaces-then-projects.md) to
  [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md).
  Where the blueprint leaves a gap, the ticket picks a default and marks it
  **(assumption)**.
- New frames go in a new row. The existing frames stay as the owner's reference.

## Detail

### What the tickets add to the blueprint
- **A checkbox on the task row** with three looks (open, in review, done), from 0004.
- **A "proof" chip in Create.** Under 0004 a task goes to review only when
  `required_proof_type` is set, and the blueprint had no place to set it.
- **"mark done"** for team tasks without proof. The blueprint only had "submit proof".
- **A tap on a calendar day filters the list**, from 0003.
- **Repeat is for team tasks only.** `recurring_tasks.division_id` is required,
  so a personal task cannot repeat.
- **A snackbar for undecided actions** (owner, 2026-10-07). When what an action
  opens depends on an open question, the mockup shows a snackbar naming the action,
  not a screen. That applies to log, archive task, choosing a proof type and
  submitting proof (T12).

### T0 — Ground rules

```text
Tasko lofi mockup — ground rules. Read these once. Every later ticket follows them.

File: pencil-new.pen. Do not edit or move the existing frames ("Main Frame" and
the five grey-block frames in the group next to it). They are the owner's reference.

Where to put new frames: a new row 200px below the lowest existing frame, starting at
the left edge of "Main Frame", 60px apart, in the order the tickets ask for them.
Name every frame "lofi / <screen> / <state>".

Device: phone portrait. Each frame is 426x930 with clip on and a white background,
unless a ticket says otherwise.

Lofi means:
- Greyscale only. Two exceptions: accent #508BEB for the active tab underline and
  selected states, and red #DB3B3B for unread dots.
- Font: JetBrains Mono everywhere. Sizes: 21 for big titles, 16 for body text, 12 for meta and labels.
- Text colours: #000000 for main text, #00000080 for secondary text, #00000033 for group labels (italic).
- Lines: 1px #0000004D. Placeholder boxes and avatars: #CCCCCC, radius 5.
- Icons: lucide only, 20-24px, black.
- No images, shadows or gradients. Use short, realistic text, not lorem ipsum.

Shared pieces. Make each one a component the first time you draw it, then reuse it:
- Top bar: 61px tall with a bottom line. Left: "welcome, <user_name>". Right, 15px apart:
  git-commit-vertical (log), bell with a 6px red dot (notifications), and a 21px black
  rounded square with a grey user icon (account). Copy it from "Main Frame".
- Sheet: a #00000080 scrim over the whole frame, then a white panel with top corners
  radius 18 and a 36x4 grey drag handle centred 8px from its top.
- Keyboard: a #E3E3E3 block, full width, 226px tall, at the bottom, labelled "keyboard".
- Snackbar: a #333333 bar, 48px tall, radius 8, 16px from each side. It sits 16px above
  the bottom edge, or above whatever floats there (the FAB, the action bar). White 16px
  text on the left: "action: <name>". No button.

Snackbar rule: some actions are not designed yet. Tapping one shows only the snackbar,
naming the action. Do not draw a screen for it. T12 lists these actions.

Sample data: the user is in workspaces "private" and "tech", and in projects
"tasko-app" and "tasko-web". Teammates: Ana, Budi, Citra, Dimas. Today is Wednesday,
Oct 7 2026. October 2026 starts on a Thursday.
```

### T1 — Home: top bar and pulse panel

```text
Ticket T1 — Home: top bar and pulse panel

Frame: "lofi / home / default". Duplicate "Main Frame", then change it as below.

Top bar: keep it as it is.

Pulse panel (below the top bar, about 230px tall):
- Top left: "monthly" (12px) above "October" (21px). A small chevron-left and
  chevron-right on either side of "October" show that you can swipe to other months.
- Top right: a maximize-2 icon. It opens the panel full screen (see T3).
- A real month grid: 7 columns, Monday first, with a row of weekday initials
  M T W T F S S (12px, secondary). Oct 1 is in the Thursday column. 31 cells in
  5 rows. Cells are 24x24, radius 5, with 8px gaps. Centre the grid.
- The cells are a heatmap of open tasks due that day: 0 = #F2F2F2, 1 = #CCCCCC,
  2-3 = #999999, 4 or more = #555555. Make a few days busy and leave most at 0 or 1.
- Today (Oct 7) has a 1.5px black outline.
- Past days that still have open tasks (overdue) get a small black dot under the
  cell. (assumption)

Done when: the grid reads as October 2026 at a glance and today is easy to find.
```

### T2 — Home: tabs, toolbar and task rows

```text
Ticket T2 — Home: tabs, list toolbar and task rows

Frame: continue in "lofi / home / default", below the pulse panel.

Tab bar: copy it from "Main Frame". Group labels "workspaces" (private, tech) and
"projects" (tasko-app, tasko-web). The active tab is "tasko-web": black text with a
2px #508BEB underline. The other tabs use secondary text.

List toolbar (36px, under the tab bar): "9 open" on the left (12px, secondary).
On the right: a search icon, then sliders-horizontal (view options, see T5).

Task row component (about 56px tall, 15px side padding, 1px line between rows):
- Left: a 20x20 checkbox, radius 4, with three looks:
  open = empty with a 1.5px black border
  in review = the same border with the lower half filled grey (assumption: any
  clear "half done" look will do)
  done = filled black with a white check
- Line 1: the title, 16px, one line, cut off with "…".
- Line 2: "priority · status · due" in 12px secondary, e.g. "high · in progress · Oct 9".
- Overdue rows show the date as "overdue · Oct 3".
- Done rows: the title is struck through and in secondary text.

The list is grouped by due date. Each group has a small header (12px, italic, secondary):
- overdue:  Fix login redirect     urgent · in progress · overdue · Oct 3
- today:    Write onboarding copy  medium · waiting · Oct 7
            Review PR #42          high · review · Oct 7   (in-review checkbox)
- tomorrow: Deploy staging         high · waiting · Oct 8
- later:    Design empty state     low · waiting · Oct 14
            Update favicon         low · in progress · Oct 20
- then a collapsed row "completed (3)" with chevron-down.

FAB: a 61x61 grey square, radius 5, with a plus icon in the centre, 20px from the
right and bottom edges, floating over the list.

Done when: every row's priority, status and due date can be read without zooming,
and the three checkbox looks are clearly different.
```

### T3 — Home: other states

```text
Ticket T3 — Home: other states

Duplicate "lofi / home / default" four times. In each copy, change only what that state needs.

1. "lofi / home / day-selected": the user tapped Oct 14 in the calendar. That cell gets
   a 2px #508BEB outline. A chip "Oct 14 ×" sits above the list. The list shows only
   that day's tasks, with no group headers. Tapping the day again clears the filter.
2. "lofi / home / private": the "private" tab is active. Personal tasks have no review,
   so the statuses are "to do", "in progress" and "done", and no checkbox shows the
   in-review look. The calendar shading changes to match this tab.
3. "lofi / home / empty": the "tech" tab is active and has no tasks. Every calendar
   cell is 0. In the middle of the list area: "no tasks here", and under it in
   secondary text "tap + to add one".
4. "lofi / home / pulse-fullscreen": the pulse panel fills the screen under the top bar.
   The tabs, list and FAB are hidden. Cells are bigger (about 48x48) and show the day
   number and the open count, e.g. "14" and "3". The top-right icon becomes minimize-2.
```

### T4 — Top bar: notifications and account

```text
Ticket T4 — Top bar: notifications, account

The log icon has no screen. Tapping it shows a snackbar (T12).

1. "lofi / notifications": full screen. Header: arrow-left, the title "notifications",
   and a text button "mark all read" on the right. Rows have a 6px red dot when unread
   and a time. Examples: "Ana assigned you Deploy staging", "Your extension request
   for Fix login redirect was approved", "Write onboarding copy is due today".
   3 unread, 4 read.
2. "lofi / home / account-menu": the home frame with a small dropdown under the avatar,
   right-aligned, white, 1px border, radius 8. Rows: the user's name with their email
   in secondary text, a line, "account settings", "log out".
```

### T5 — Task list: search and view options

```text
Ticket T5 — Task list: search, group, sort, filter

1. "lofi / home / search": the list toolbar becomes a text field with a search icon,
   the typed text "deploy", and an x to close it. The list shows only the matching
   rows, with no group headers. The keyboard is at the bottom. The FAB is hidden.
2. "lofi / home / view-options": a sheet from the bottom, about 520px tall, opened by
   the sliders icon. It has three sections, each with a 12px italic secondary label:
   - "group by": single-choice chips: due date (selected), priority, status, assignee, none.
   - "sort by": single-choice chips: due date (selected), priority, title, created.
     Next to them, a two-part toggle "asc | desc".
   - "filter": three rows, each with a label on the left and a value plus chevron-down
     on the right: priority "any", status "any", assignee "anyone".
   At the bottom: a text button "reset" on the left and a black button "apply" on the right.
   Selected chips have a black fill and white text. The others have a 1px border.
```

### T6 — Create task sheet

```text
Ticket T6 — Create task sheet

The FAB opens this sheet. It creates a task in the active tab.

1. "lofi / create / team": the home frame behind the scrim, with "tasko-web" as the
   active tab. A sheet at the bottom, about 300px tall:
   - Title field, 21px, placeholder "new task".
   - Note field under it, 16px secondary, placeholder "add note".
   - A row of chips, each with an icon and a short value, 1px border, radius 16:
     calendar "due date", flag "medium", user "me", paperclip "no proof".
     (Setting a proof type means the task goes to review when it is ticked.
     Tapping the proof chip shows a snackbar, see T12.)
   - A text button "done" at the bottom right.
2. "lofi / create / private": the same sheet with "private" as the active tab. Only the
   due date and priority chips. Personal tasks have no assignee and no proof.
3. "lofi / create / keyboard-on": the team sheet sitting on top of the keyboard, with
   "Prepare demo" typed into the title and the cursor still in it.
```

### T7 — Pickers

```text
Ticket T7 — Pickers opened from the create chips

Each picker is a second sheet on top of the create sheet, with the scrim covering both.
Each one ends with "cancel" on the left and "done" on the right.

1. "lofi / picker / priority": 4 rows, each with a radio on the right: low,
   medium (selected), high, urgent. Left of each label is a small mark of 1 to 4 bars.
2. "lofi / picker / due-date": "October 2026" with chevrons, weekday initials, and a
   7-column grid of day numbers (Monday first). Oct 9 is selected (black circle,
   white number) and today has an outline. Below the grid: a row "time" with "09:00".
3. "lofi / picker / assignee": a search field, then "me" pinned first, then 6 members.
   Each row has a 32px grey avatar, the name, and the role in secondary text
   ("person-in-charge" or "member"). One row is selected and shows a check.

There is no proof picker. The proof chip shows a snackbar (T12).
```

### T8 — Task detail sheet

```text
Ticket T8 — Task detail sheet

Tapping a task row opens this sheet. Follow the owner's grey-block frame
"main-screen: task-detail-view": a white panel with radius 18 on all corners,
from y 131 to y 798, and a separate floating action bar below it (x 39, y 824,
348x83, radius 18). T9 covers the action bar. Here, give it the label "start working".

1. "lofi / detail / team-top": the task "Fix login redirect" in "tasko-web".
   - Header row: "tasko-web · TW-0042" (12px, secondary) on the left, more-vertical on the right.
   - Title, 21px, may wrap to 2 lines.
   - Note, 16px secondary, 3 lines.
   - Property rows (icon, label in secondary text, value on the right, 44px each,
     lines between them):
     circle-dot "status": in progress
     flag "priority": urgent
     calendar "due": Oct 3, 17:00 (styled as overdue)
     repeat "repeat": does not repeat
     user "assignee": avatar + "me"
     paperclip "proof": required
2. "lofi / detail / team-scrolled": the same sheet, scrolled down:
   - "sub-tasks (1/3)": three rows with small checkboxes, one of them done, then "+ add sub-task".
   - "discussion": two comments (24px avatar, name, time, text), then a text field
     "write a comment…" with a send icon.
3. "lofi / detail / private": the personal task "Buy domain". Show only status (to do),
   priority, due and sub-tasks. There is no repeat, assignee, proof or discussion.
4. "lofi / detail / keyboard-on": like the owner's frame "task-detail-view (keyboard-on)".
   The panel moves up to y 37, the comment field has focus with text typed into it,
   and the keyboard covers the bottom 226px.
```

### T9 — Detail action bar states

```text
Ticket T9 — Task detail: the action bar for each status

The floating bar under the detail panel changes with the task's status and with who
is looking at it. Draw only the bar, one small frame per state, 426x120 each, in a row.
Name them "lofi / detail / action / <state>".

1. waiting (the viewer is the assignee): a black button "start working".
2. in-progress-no-proof: a black button "mark done".
3. in-progress-proof: a black button with a paperclip, "submit proof". Tapping it
   shows a snackbar (T12).
4. review-assignee: a grey, disabled button "waiting for review".
5. review-reviewer: two buttons side by side, an outlined "decline" and a black "approve".
6. done: text only, secondary: "done · Oct 6".
7. no-action (the viewer is neither the assignee nor a reviewer): no bar. Draw the
   empty frame with a small note "no bar".
```

### T10 — Detail menu and follow-up sheets

```text
Ticket T10 — Task detail: menu and follow-up sheets

1. "lofi / detail / menu": the detail sheet with a dropdown from the more-vertical icon:
   "request due date extension" and "archive task". Under each, in 12px secondary text,
   who sees it: "members only" and "author only". Tapping "archive task" shows a
   snackbar (T12).
2. "lofi / detail / extension": a sheet over the detail sheet with the title "request extension".
   Rows: "current due" Oct 3, "new due" Oct 10 (opens the date picker), and a
   multi-line field "reason" marked required. A black button "send request".
3. "lofi / detail / decline": the title "decline". A multi-line field "reason", marked
   required, with text typed into it. A black button "decline". The keyboard is visible.
```

### T11 — Repeat setup screen

```text
Ticket T11 — Repeat setup screen

The "repeat" row in task detail opens this screen. It is a full screen, not a sheet.

1. "lofi / repeat / weekly":
   - Header: arrow-left, the title "repeat", and a text button "done" on the right.
   - "every" row: a number box "1" and a dropdown "week" (choices: day, week, month, year).
   - Weekday chips M T W T F S S, with Mon and Thu selected (black).
   - "at" row: "09:00".
   - "starts" row: "Oct 8, 2026".
   - "ends": three radio rows: "never" (selected), "on" plus a date box, and
     "after" plus a number box plus "occurrences".
   - At the bottom, a summary in secondary text: "Creates a new task every week on
     Mon and Thu at 09:00."
2. "lofi / repeat / monthly-edit": the same screen for a repeat that already exists:
   "every 1 month", a row "on day 14" in place of the weekday chips, and
   "ends after 6 occurrences". The "starts" row is greyed out with the note
   "set when first created".
```

### T12 — Snackbars for undecided actions

```text
Ticket T12 — Snackbars for undecided actions

These actions are not designed yet. Tapping one shows only a snackbar that names the
action (see the snackbar in the ground rules).

1. "lofi / home / snackbar": duplicate "lofi / home / default". Add the snackbar
   "action: open log" at the bottom. Move the FAB up so it sits 16px above the snackbar.
2. One small frame per message, 426x80 each, in a row, named
   "lofi / snackbar / <action>". Each shows only the snackbar:
   - open-log: "action: open log" (the log icon in the top bar)
   - choose-proof-type: "action: choose proof type" (the proof chip in create)
   - submit-proof: "action: submit proof" (the action bar in task detail)
   - archive-task: "action: archive task" (the task detail menu)
```

## What would change my mind
- The owner may answer an open question differently. Then only the tickets marked
  **(assumption)** change.
- pen.dev may lose the T0 rules over a long session. Then paste T0 again at the top of each
  ticket instead of once.

## Open questions
Parked with a snackbar in the mockup (owner, 2026-10-07):
- What does "log" open?
- What does "archive task" do? Tasks have no `archived` status. The schema has
  `cancelled_date`.
- Which proof types exist? `required_proof_type` is a free `varchar`. This blocks both
  the proof picker and the submit-proof form.

Still open. These do not block the mockup:
- Does "only-member" for the extension request mean the assignee, or any member who is
  not management?
- Does the row need an assignee avatar? The blueprint row has none. Supervisors
  looking at other people's tasks may need one (see
  [Santian's screens in a team app](./santian-screens-in-a-team-app.md)).
- `recurring_tasks` has no columns for a start date or an end rule (never, on a date,
  after n occurrences), but T11 draws them. That is a hacker question.

---
Part of [Tasko](../README.md)
