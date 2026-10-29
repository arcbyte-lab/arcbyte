---
title: Hifi mockup tickets for pen.dev — restyle the lofi frames with modern-minimal.css
idea: tasko
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-29
inputs: ["../decisions/0014-activity-logs-for-task-project-division-and-user.md", "../hacker/activity-log-build-tickets.md", "../decisions/0012-division-leads-run-repeats-from-a-repeating-view.md", "../hacker/repeating-view-build-tickets.md", "../decisions/0010-adding-a-project-member-needs-no-invitation.md", "../hacker/project-and-member-build-tickets.md", "../assets/modern-minimal.css", "./lofi-mockup-tickets-for-pen-dev.md", "../assets/pencil-new.pen", "../assets/lofi-snapshoots/"]
tags: [artifact]
---

## Question
What should pen.dev be asked to draw so that `pencil-new.pen` gets a hifi Tasko
mockup that uses the [modern-minimal theme](../assets/modern-minimal.css)?

## Short answer
- There are 7 tickets. Paste **H0 first**, then H1 to H6 in order. H7 was drawn
  after the app was built. H8 (the repeating view) was drawn before the app was built.
  H9 (the activity log) was drawn after it. H10 (the "my tasks" tab) was drawn
  before it.
- Hifi does **not** change any layout, copy or behaviour. Each ticket duplicates
  lofi frames from the [lofi tickets](./lofi-mockup-tickets-for-pen-dev.md) and
  restyles them. If a layout looks wrong, fix the lofi ticket, not this one.
- Light theme only. The CSS also has a `.dark` theme; that is a later pass.

## Detail

### Theme tokens, in hex
pen.dev works in hex, so the `oklch()` values in `modern-minimal.css` are
converted here. They match Tailwind's default grey and blue scales.

| token | hex | used for |
|---|---|---|
| background, card, popover | #FFFFFF | screens, sheets, menus |
| foreground | #333333 | main text |
| muted-foreground | #6B7280 | secondary text, meta, icons at rest |
| muted | #F9FAFB | pulse panel, unread notification rows, summary box |
| secondary | #F3F4F6 | chips, disabled buttons, segmented-control track |
| secondary-foreground | #4B5563 | text on secondary |
| accent | #E0F2FE | selected rows, hover, light heatmap |
| accent-foreground | #1E3A8A | text on accent |
| primary | #3B82F6 | buttons, active tab, selection, checkbox |
| primary-foreground | #FFFFFF | text on primary |
| destructive | #EF4444 | overdue, urgent, unread dot, decline |
| border, input | #E5E7EB | lines, field borders |
| chart-2 / 3 / 4 | #2563EB / #1D4ED8 / #1E40AF | heatmap steps (only #1E40AF is used) |
| heatmap-empty | #D7D7D9 | heatmap cell with 0 tasks (not in the CSS; chosen by the owner) |
| control-border | #D1D5DB | empty checkbox and radio, empty priority bars, empty-state icon |
| placeholder | #9CA3AF | placeholders, disabled text, greyed rows, keyboard label |
| warning pill | #FEF3C7 / #92400E | "review" status (Tailwind amber-100/800) |
| success pill | #DCFCE7 / #166534 | "done" status and the done check (Tailwind green-100/800) |

These hex values are the standard: they match the hifi frames in `pencil-new.pen`
as built. The last five rows are not in `modern-minimal.css`.

Radius: 6 (`--radius: 0.375rem`). Small 2, medium 4, large 6, extra large 10.
Shadow-sm: `0 1px 3px rgba(0,0,0,.10), 0 1px 2px -1px rgba(0,0,0,.10)`.
Shadow-lg: `0 1px 3px rgba(0,0,0,.10), 0 4px 6px -1px rgba(0,0,0,.10)`.
Fonts: Inter for everything. JetBrains Mono for task IDs like "TW-0042", group
labels, tab names (owner, 2026-10-29), and the repeat screen's times and dates.

### H0 — Ground rules

```text
Tasko hifi mockup — ground rules. Read these once. Every later ticket follows them.

File: pencil-new.pen. Do not edit or move any existing frame: not "Main Frame",
not the grey-block frames, not any "lofi / ..." frame. They are the reference.

Where to put new frames: a new row 200px below the lowest "lofi / ..." frame, in the
same left-to-right order as the lofi row, 60px apart. Name every frame
"hifi / <screen> / <state>", the same name as its lofi frame with "lofi" swapped.

How to make each hifi frame: duplicate the lofi frame, then restyle it with the rules
below. Keep every position, size, text and state from the lofi frame unless a ticket
says otherwise. Hifi changes the look, never the layout or the copy.

Theme (light, from modern-minimal.css):
- Background #FFFFFF. Main text #333333. Secondary text and resting icons #6B7280.
- Lines and field borders: 1px #E5E7EB.
- Primary #3B82F6 with white text: main buttons, active tab, selected states,
  checked checkboxes, the FAB.
- Secondary #F3F4F6 with #4B5563 text: chips, outlined-looking buttons, disabled buttons.
- Accent #E0F2FE with #1E3A8A text: the selected row in a list or menu.
- Muted #F9FAFB: background of the pulse panel. The list toolbar is white, like
  the list.
- Destructive #EF4444: unread dots, overdue dates, "urgent" priority, "decline".
- Extra greys: #D1D5DB for empty checkboxes, radios and bars; #9CA3AF for
  placeholders, disabled and greyed text; #D7D7D9 for empty heatmap cells.
- Status pills: review #FEF3C7 / #92400E, done #DCFCE7 / #166534.
- Radius 6 for buttons, fields, chips, cards and menus. Sheets keep radius 18 on the
  top corners; the detail panel and its action bar keep radius 18.
- Shadows: shadow-sm on the FAB and the action bar; shadow-lg on menus, dropdowns,
  the detail panel and the snackbar. Chips and segmented controls have no shadow.
  Nothing else gets a shadow. No gradients.

Type:
- Font: Inter everywhere. JetBrains Mono for task IDs ("TW-0042"), group labels,
  tab names, and the repeat screen's times and dates.
- Sizes: 20 semibold for big titles, 15 regular for body, 13 medium for labels,
  12 regular for meta. Group labels: JetBrains Mono 12 medium, #6B7280 at 50%
  opacity, uppercase, letter-spacing 0.5 ("OVERDUE" is #EF4444 at 50%).
  No italics.

Icons: lucide only, 20px, stroke 1.75, #6B7280 at rest, #333333 when active,
#3B82F6 when selected.

Avatars: circles, #E0F2FE fill, #1E3A8A initials (Ana = "A", Budi = "B", and so on).
"me" is #3B82F6 with a white "M".

Scrim: #000000 at 40%.

Snackbar: #333333, radius 6, shadow-lg, white 15px text. Same size and place as lofi.

Same sample data as the lofi tickets: user in "private", "tech", "tasko-app",
"tasko-web"; teammates Ana, Budi, Citra, Dimas; today is Wednesday, Oct 7 2026.
```

### H1 — Shared components

```text
Ticket H1 — Restyle the shared components first

Duplicate each lofi component and restyle it with H0. Make each one a new component
named "hifi / <name>". Later tickets use these, not the lofi ones.

1. Top bar: "welcome, <user_name>" in 15 medium #333333. Icons #6B7280. The bell's
   dot is 6px #EF4444 with a 1.5px white ring. The account square becomes a 24px
   avatar circle (the "me" look from H0). Bottom line #E5E7EB.
2. Task row: title 15 regular #333333; meta line 12 #6B7280. In the meta line the
   priority word is coloured: urgent #EF4444, high #333333, medium and low #6B7280.
   Overdue dates are #EF4444. Checkbox 20x20, radius 4:
   open = 1.5px #D1D5DB border, white fill
   in review = 1.5px #3B82F6 border, lower half #E0F2FE
   done = #3B82F6 fill, white check
   Done rows: title struck through, #6B7280.
3. Tab bar: tabs in JetBrains Mono 13 medium (Inter until 2026-10-29; frames
   drawn before then still show Inter). Active tab #333333 with a 2px #3B82F6 underline;
   others #6B7280. Group labels per H0 (uppercase).
4. Chips: height 32, radius 6, #F3F4F6 fill, no border, no shadow, 13 medium
   #4B5563, icon 16px. Selected chip: #3B82F6 fill, white text and icon.
5. Buttons: height 44, radius 6, 15 medium.
   primary = #3B82F6 fill, white text
   outline = white fill, 1px #E5E7EB border, #333333 text
   destructive = #EF4444 fill, white text
   disabled = #F3F4F6 fill, #9CA3AF text
   text button = no fill, #3B82F6 text
6. Fields: height 40, radius 6, 1px #E5E7EB border, 15 regular, placeholder
   #9CA3AF. Focused: 2px #3B82F6 border with a 3px #3B82F6 ring at 20%.
7. Sheet: white, top corners 18, a 36x4 #E5E7EB handle, scrim per H0.
8. Snackbar: per H0.
9. Keyboard: keep the lofi block, fill #F3F4F6, label #9CA3AF.

Done when: one row of the nine components sits above the hifi row, and each one
reads as clearly "the same thing" as its lofi twin.
```

### H2 — Home

```text
Ticket H2 — Home frames

Duplicate every "lofi / home / ..." frame (default, day-selected, private, empty,
pulse-fullscreen, search, view-options, account-menu, snackbar) and restyle with H0
and the H1 components.

Pulse panel:
- Panel background #F9FAFB, 1px #E5E7EB bottom line.
- "MONTHLY" as a group label, "October" in 20 semibold. Chevrons and maximize-2 #6B7280.
- Weekday initials 12 medium #6B7280.
- Heatmap cells, radius 4:
  0 tasks = #D7D7D9
  1 task  = #E0F2FE
  2-3     = #3B82F6
  4+      = #1E40AF
- Today: 1.5px #333333 outline. Overdue dot under the cell: 4px #EF4444.
- day-selected: the selected cell gets a 2px #3B82F6 outline with a 2px white gap.
  The "Oct 14 ×" chip uses the selected chip look.
- pulse-fullscreen: day number 13 medium, open count 12 regular. On cells with
  #3B82F6 or #1E40AF fill, both are white.

List toolbar: white background (same as the list), "9 open" in 12 #6B7280.
Group headers (OVERDUE, TODAY, TOMORROW, LATER): H0 group-label style. The
"OVERDUE" label is #EF4444.
"completed (3)" row: 13 medium #6B7280.
FAB: 56x56 circle, #3B82F6, white plus, shadow-sm. Same position as lofi.
Empty state: a 40px #D1D5DB inbox icon above "no tasks here" (15 medium #333333)
and "tap + to add one" (13 #6B7280).
View-options sheet: chips per H1; the "asc | desc" toggle is a segmented control,
#F3F4F6 track, white selected segment, no shadow. "reset" is a text button,
"apply" a primary button.
Account menu: white, radius 6, 1px #E5E7EB, shadow-lg. "log out" in #EF4444.
```

### H3 — Notifications, create and pickers

```text
Ticket H3 — Notifications, create sheet, pickers

Duplicate "lofi / notifications", every "lofi / create / ..." and every
"lofi / picker / ..." frame. Restyle with H0 and H1.

Notifications: unread rows have a #F9FAFB background and a 6px #EF4444 dot; read rows
are white. Each row starts with a 32px avatar of whoever caused it (a #F3F4F6 circle
with a bell icon for system messages). Time in 12 #6B7280 on the right.
"mark all read" is a text button.

Create sheet: title field with no border, 20 semibold, placeholder #9CA3AF. Note
field with no border, 15 #6B7280. Chips per H1, icons #6B7280. The priority chip
shows a small flag in the priority colour. "done" is a primary button, 36 tall,
right-aligned.

Pickers:
- priority: radios 18px, selected = #3B82F6 ring with a dot. The bar marks use
  #D1D5DB for empty bars and the priority colour for filled ones (urgent #EF4444,
  the rest #3B82F6).
- due-date: selected day = #3B82F6 circle, white number. Today = 1px #333333 ring.
  "time" row value in a field.
- assignee: search uses the H1 field. Selected row = #E0F2FE background with a
  #3B82F6 check. Roles 12 #6B7280.
- "cancel" outline button, "done" primary button, side by side.
```

### H4 — Task detail

```text
Ticket H4 — Task detail

Duplicate every "lofi / detail / ..." frame, including the seven
"lofi / detail / action / ..." bars. Restyle with H0 and H1.

Detail panel: white, radius 18, shadow-lg, on the 40% scrim.
- Header: "tasko-web" 12 medium #6B7280, then "TW-0042" in JetBrains Mono 12 #6B7280.
- Title 20 semibold. Note 15 #6B7280.
- Property rows: icon #6B7280, label 13 #6B7280, value 15 #333333 on the right.
  Status value is a small pill: in progress = #E0F2FE / #1E3A8A, waiting and to do =
  #F3F4F6 / #4B5563, review = #FEF3C7 / #92400E, done = #DCFCE7 / #166534.
  (assumption: the theme has no warning or success colour, so these two pills borrow
  Tailwind amber-100/800 and green-100/800.)
  Overdue due date in #EF4444. "urgent" in #EF4444.
- Sub-tasks: H1 checkbox at 16px. "+ add sub-task" is a text button.
- Discussion: 24px avatars, name 13 medium, time 12 #6B7280, text 15. Comment field
  per H1 with a #3B82F6 send icon.

Action bars (radius 18, white, shadow-sm, 1px #E5E7EB):
- start working, mark done, submit proof: primary button, full width.
- waiting for review: disabled button.
- review-reviewer: "decline" outline button with #EF4444 text, "approve" primary.
- done: a #166534 check icon, then "done · Oct 6" in 13 #6B7280.
- no-action: keep the empty frame and its note.

Menu, extension and decline sheets: menu per the H2 account menu, "archive task" in
#EF4444. "send request" primary. The decline sheet's button is destructive.
```

### H5 — Repeat setup

```text
Ticket H5 — Repeat setup screen

Duplicate "lofi / repeat / weekly" and "lofi / repeat / monthly-edit". Restyle with
H0 and H1.

- Header: arrow-left #333333, "repeat" 20 semibold, "done" text button.
- Row labels 13 medium #6B7280. Number boxes and the "week" dropdown use the H1 field.
- Weekday chips: 36x36 circles. Selected = #3B82F6 with white letter, others
  #F3F4F6 with #4B5563 letter.
- "09:00" and dates in JetBrains Mono 15.
- Radios per H3.
- Summary: a #F9FAFB box, radius 6, 13 #6B7280, with a repeat icon on the left.
- monthly-edit: the greyed "starts" row uses #9CA3AF text and a lock icon in place
  of the chevron. The note "set when first created" is 12 #9CA3AF.
```

### H6 — Snackbars and final check

```text
Ticket H6 — Snackbars, then check the whole row

1. Duplicate "lofi / home / snackbar" and every "lofi / snackbar / ..." frame.
   Restyle per H0. In "hifi / home / snackbar" the FAB still sits 16px above the
   snackbar.
2. Check the whole hifi row:
   - Every lofi frame has exactly one hifi twin with the same name after "hifi /".
   - No colour outside the H0 list.
   - No JetBrains Mono except task IDs, group labels, and the repeat screen's
     times and dates.
   - All text on #3B82F6 is white, and all body text is #333333 or #6B7280.
   List any frame that breaks a rule, then fix it.
```

### H7 — Projects and members (drawn 2026-10-14)

Drawn straight into `pencil-new.pen` by Claude, after the app was built
([build tickets](../hacker/project-and-member-build-tickets.md),
[0010](../decisions/0010-adding-a-project-member-needs-no-invitation.md)).
These are the first hifi frames with **no lofi twin**: they copy the app as
built, not a lofi layout. H6's "every lofi frame has one hifi twin" check
does not apply to them. They sit in a new row at y=2266, below the hifi
row, and follow H0 and H1. PNGs are in `assets/hi-fi snapshoots/`.

| Frame | Shows | Built from |
|---|---|---|
| `hifi / home / new-project-tab` | "+ new project" (plus icon, #6B7280) after the last project tab, for a division admin or supervisor ([0011](../decisions/0011-new-project-sits-at-the-end-of-the-tab-strip.md); was `account-menu-lead`, 2026-10-19) | `hifi / home / default` |
| `hifi / home / project-toolbar` | a `users` icon before search, on project tabs only | `hifi / home / default` |
| `hifi / create / project` | "new project" title, a division chip (only when there is a choice), due date; "done" disabled until named | `hifi / create / team` |
| `hifi / members / owner` | "tasko-web members", "add member" text button, rows with role and a ⋮ | `hifi / notifications` header, assignee-picker row style |
| `hifi / members / row-menu` | the ⋮ menu: make owner / person-in-charge / viewer, "remove" in #EF4444 | `members / owner`, account-menu look |
| `hifi / members / plain-member` | no "add member"; only the viewer's row has ⋮, with "leave project" in #EF4444 | `members / owner` |
| `hifi / picker / add-member` | "ADD MEMBER", "search people", emails under names, one selected | `hifi / picker / assignee` over `members / owner` |

The members screen, its menus and the picker are the layout the owner
should judge: they were never sketched in lofi.

### H8 — Repeating view (drawn 2026-10-19)

From [0012](../decisions/0012-division-leads-run-repeats-from-a-repeating-view.md)
and the [repeating view build tickets](../hacker/repeating-view-build-tickets.md).
Like H7, these frames have **no lofi twin**, and H6's twin check doesn't
apply. Unlike H7, they were drawn **before** the app is built, so the owner
can judge the layout first. Claude drew them straight into
`pencil-new.pen` on 2026-10-19, in a row at y=3396. PNGs are in
`assets/hi-fi snapshoots/`.

Where the drawing differs from the prompt below:
- **Task IDs use `TECH-`,** the tech division's prefix in the API seed data.
- **The create sheet's chips wrap onto two rows.** Due date and repeat
  are on the first row, then priority, assignee and proof. Five chips
  don't fit in one row.
- **The create frames sit over the repeating list.** So "server backup
  check" is already in the list behind the sheet.
- **Read-only shows only as a grey value.** Property rows have no
  chevron anywhere, so the editable rows have no chevron to take away.
  Frame 10 drops Sub-tasks and Discussion, and its action bar is
  "start working", because the task is `waiting`.

```text
Ticket H8 — Repeating view, for division leads

Follow H0 and the H1 components. These frames have no lofi twin: build each one
from the hifi frame named in its step. Put them in a new row 200px below the H7
row (the frames at y=2266), left to right in the order below, 60px apart.

Sample data: the viewer is a lead of "tech". Today is Wednesday, Oct 7 2026.
Task IDs use the tech division's prefix, as in the existing frames.

1. "hifi / home / repeat-toolbar" (from "hifi / home / default", on the "tech" tab):
   - The list toolbar shows "9 open", then three icons on the right: repeat,
     search, sliders-horizontal. All #6B7280.
   - The repeat icon is new. It sits left of search, with the same spacing as
     search and sliders-horizontal.

2. "hifi / repeating / list" (full screen; header from "hifi / members / owner"):
   - Header: arrow-left #333333, "tech repeating" 20 semibold, and a "+ new" text
     button on the right.
   - One row per repeating task, 1px #E5E7EB line between rows:
     line 1: the task name, 15 regular #333333; a 24px assignee avatar on the right.
     line 2: the rule and the next due date, 12 #6B7280, e.g.
       "every week on Mon · next Mon, Oct 12".
     line 3: up to 5 dots, 8px, 6px apart, oldest on the left: #3B82F6 = done on
       time, #EF4444 = done late. No dots yet = no line 3.
   - Rows, in this order:
     "server backup check", Budi, every week on Mon, next Mon, Oct 12, dots on
       time, on time, late, on time, on time.
     "expense report", Ana, every month, next Sat, Oct 31, dots on time, late, late.
     "standup notes", Dimas, every day, next Thu, Oct 8, five on time.
     "access review", Citra, every 3 months, next Tue, Jan 5. No dots: it starts
       in the future.

3. "hifi / repeating / empty" (from step 2):
   - Same header. In the middle: a 40px #D1D5DB repeat icon above
     "no repeating tasks yet" (15 medium #333333) and
     "tap + new to set one up" (13 #6B7280). Same layout as the H2 empty state.

4. "hifi / repeating / series" (full screen, for "server backup check"):
   - Header: arrow-left, "server backup check" 20 semibold, a more-vertical icon
     on the right.
   - Summary box as in H5 (#F9FAFB, radius 6, repeat icon, 13 #6B7280):
     "creates a new task every week on Mon, when this task is done."
   - Group label "OCCURRENCES" (H0 style), then one row each, newest first:
     line 1: task ID in JetBrains Mono 12 #6B7280, then the due date, 15 #333333.
     line 2: a 20px assignee avatar and the name, 12 #6B7280; on the right a
       status pill (H4 colours) or a result:
       "on time" 12 medium #6B7280, or "late · 2 days" 12 medium #EF4444.
     A 16px link icon #6B7280 at the far right when the occurrence has a proof.
   - Rows:
     due Mon, Oct 12, Budi, "waiting" pill (the open one).
     due Mon, Oct 5, Budi, on time, link icon.
     due Mon, Sep 28, Budi, on time, link icon.
     due Mon, Sep 21, Ana, late · 2 days, link icon.
     due Mon, Sep 14, Budi, on time.
     due Mon, Sep 7, Budi, on time.

5. "hifi / repeating / series-menu" (step 4 plus a menu):
   - The more-vertical menu, in the H2 account-menu look, anchored top right:
     "edit repeat", "stop repeating", and "delete" in #EF4444.

6. "hifi / repeating / delete-confirm" (step 4 plus a sheet; sheet from the H4
   decline sheet):
   - Title "delete this repeating task?" 20 semibold.
   - Body, 15 #6B7280: "the open task, due Mon, Oct 12, is deleted. finished
     tasks stay."
   - "cancel" outline button and "delete" destructive button, side by side.

7. "hifi / repeating / delete-started" (step 4 plus a snackbar):
   - The H0 snackbar: "already started — stop repeating instead".

8. "hifi / create / repeating" (from "hifi / create / team", over step 2):
   - Chips: due date "Mon, Oct 12" and a new "repeat" chip, both in the selected
     chip look. The repeat chip has the repeat icon and says "every week · Mon".
   - Title "server backup check". "done" is the primary button.

9. "hifi / create / repeating-no-due" (from step 8):
   - The due-date chip is empty (the unselected chip look) and "done" is disabled.
   - Under the chips, 12 #EF4444: "a repeating task needs a due date".

10. "hifi / detail / repeat-readonly" (from the H4 detail frame with a repeat row,
    for a member who is not a lead):
   - The repeat row shows "every week on Mon" in #6B7280, with no chevron.
     Everything else is unchanged.

Done when: all ten frames are in the new row, each name starts with "hifi /",
and no colour or font is used outside H0.
```

Two more frames, drawn 2026-10-19 for
[0013](../decisions/0013-ended-repeats-stay-until-deleted.md) at the end
of the same row:

| Frame | Shows | Built from |
|---|---|---|
| `hifi / repeating / list-ended` | an ended row last: name in #6B7280, "every week on Fri · ended", its dots kept | `hifi / repeating / list` |
| `hifi / repeating / series-ended` | "ended. it created a new task every week on Mon, when each was done.", no open occurrence, the menu with only "delete" | `hifi / repeating / series-menu` |

Choices made in this ticket, for the owner to judge:
- **Dots, not a percentage.** Five dots show the pattern ("late twice in a
  row") that a number hides. On time is primary blue, not the success
  green, so the list doesn't look like a status board.
- **"Late · 2 days", not just "late".** A lead can tell a slip from a
  problem.
- **A missing due date shows as an inline error.** It isn't a toast,
  because the sheet stays open.
- **Frame 10 assumes members see the rule read-only.** That is an open
  question in the build tickets.

### H9 — Activity log (drawn 2026-10-22)

From [0014](../decisions/0014-activity-logs-for-task-project-division-and-user.md)
and the [activity log build tickets](../hacker/activity-log-build-tickets.md).
Like H7, drawn **after** the app was built (B15), so it records the
as-built screen in the H0 theme. There's no lofi twin. Claude drew it
straight into `pencil-new.pen` on 2026-10-22, in a row at y=4526, 200px
below H8. PNGs are in `assets/hi-fi snapshoots/`.

| Frame | Shows | Built from |
|---|---|---|
| `hifi / home / activity-toolbar` | tech's toolbar: repeat, **history** (new), search, sliders | `hifi / home / repeat-toolbar` |
| `hifi / activity / division` | "tech activity": tech's own rows, tasko-web's member and project rows, "load more" | `hifi / repeating / list` header |
| `hifi / activity / user` | "Budi activity": by and to Budi; each time is followed by the tab, "09:12 · tech" | the division frame |
| `hifi / activity / task` | "Review PR #42 activity": the task goes unnamed ("Budi started it") | the division frame |
| `hifi / activity / empty` | history icon, "no activity yet", "changes from now on show up here" | `hifi / repeating / empty` |
| `hifi / detail / activity-menu` | the "More" menu for a lead: "activity · leads only", then "archive task" | `hifi / detail / menu` |
| `hifi / home / my-activity-menu` | the account menu with "my activity" above "account settings" | `hifi / home / account-menu` |

A row: a 24px avatar (H0 colours), the sentence in 15 #333333 (wraps),
and the time in JetBrains Mono 12 #6B7280. Rows are split by a 1px #E5E7EB
line. Days use the H0 group label: "TODAY", "YESTERDAY", "MON, OCT 5".
"load more" is a 15 medium #3B82F6 text button, centred.

Where the drawing differed from the app as built (B15). The owner chose
the drawing, so the app was aligned to all three in
[Tasko-Flutter #26](https://github.com/arcbyte-lab/Tasko-Flutter/pull/26)
(merged 2026-10-22):
- **Day labels.** The app writes "today" and "Mon, Oct 5" in plain 12
  #6B7280. The drawing uses the H0 group label (uppercase JetBrains Mono at
  50%), as every other list does.
- **Times.** The app uses Inter for the time. The drawing uses JetBrains
  Mono, as H0 does for the repeat screen's times.
- **Empty hint.** The app shows only "no activity yet". The drawing adds
  the hint, because a task created before the log existed has no rows.
- **The detail menu.** The app lists "activity" first, as drawn.

### H10 — The "my tasks" tab (drawn 2026-10-29)

From [0017](../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md).
Drawn **before** the app is built, straight into `pencil-new.pen` in a row
at y=6786, 200px below the calendar frames. PNGs are in
`assets/hi-fi snapshoots/`.

| Frame | Shows | Built from |
|---|---|---|
| `hifi / my tasks / default` | "my tasks" active and first in the strip; the user's tasks and reviews from private, tech, tasko-app and tasko-web, grouped by day; dots for the same tasks | `hifi / calendar / month` |
| `hifi / my tasks / day-selected` | Oct 14 picked: the week strip and the five things due that day, from three tabs | `hifi / calendar / day-selected` |

- The "my tasks" tab sits before WORKSPACES. It has no group label; its label
  line is kept but hidden, so its tab lines up with the others.
- Each row's meta line ends with the tab: " · tasko-web" in 12 #6B7280,
  also on overdue rows, where the date before it stays red.
- A task waiting for the user's review shows the in-review checkbox.
- The toolbar has search and view options only.

## What would change my mind
- If the owner wants Tasko to look different from the lofi layout (not just
  restyled), these tickets are the wrong shape. Each screen would need its own
  hifi ticket like the lofi ones.
- If the two status pills in H4 look out of place next to the blue theme, drop
  them back to `secondary` and show status as text only.

## Open questions
- Is dark mode needed in the mockup? `modern-minimal.css` has a `.dark` theme, but
  nothing asks for it yet.
- Should `modern-minimal.css` get warning, success, heatmap-empty, control-border
  and placeholder tokens? The mockup uses them as standard (see the token table),
  but the CSS does not define them yet.
- Is Inter the right font for a mobile app, or should it follow the platform
  (SF Pro / Roboto)? The CSS says Inter, so the tickets use it.

---
Part of [Tasko](../README.md)
