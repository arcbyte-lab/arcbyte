---
title: Hifi mockup tickets for pen.dev — restyle the lofi frames with modern-minimal.css
idea: tasko
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-07
inputs: ["../assets/modern-minimal.css", "./lofi-mockup-tickets-for-pen-dev.md", "../assets/pencil-new.pen", "../assets/lofi-snapshoots/"]
tags: [artifact]
---

## Question
What should pen.dev be asked to draw so that `pencil-new.pen` gets a hifi Tasko
mockup that uses the [modern-minimal theme](../assets/modern-minimal.css)?

## Short answer
- There are 7 tickets. Paste **H0 first**, then H1 to H6 in order.
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
labels, and the repeat screen's times and dates.

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
  and the repeat screen's times and dates.
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
3. Tab bar: tabs in 13 medium. Active tab #333333 with a 2px #3B82F6 underline;
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
