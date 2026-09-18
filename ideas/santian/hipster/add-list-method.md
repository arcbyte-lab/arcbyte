---
title: Add-list method for the scrollable List Tab Bar
idea: santian
lens: hipster
kind: flow
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../hacker/task-list-subtask-data-model.md", "./hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md", "../decisions/0004-clone-google-tasks-interactions.md"]
tags: [artifact]
---

## Question
The owner confirmed the `List Tab Bar` (Star / Personal Interest / My Tasks /
Building) scrolls horizontally and ends in an action button to create a new
list — not drawn in the current hi-fi export. What should that button and the
flow behind it look like, given the app's existing patterns?

## Short answer
- A trailing `+` tab, same height as the other tabs, always last, after the
  scroll — not a floating or separate control.
- Tapping it opens the same bottom-sheet pattern already used for Create Task,
  with three fields: name (text, keyboard focused immediately), icon
  (a grid of the same lucide-icon set already in use), color (a row of dots,
  same shape as the existing `List Dot`).
- No new component, no new sheet behaviour, no new token. Everything it needs
  already exists in the hi-fi export.

## Detail

### Why a trailing tab, not a FAB or menu item
[Decision 0004](../decisions/0004-clone-google-tasks-interactions.md) commits
to cloning Google Tasks' interaction model and only changing the skin. Real
Google Tasks puts "Create new list" behind a dropdown menu, not a tab bar —
but this app has already departed from that by making lists a horizontally
scrollable tab row instead of a dropdown (that departure predates this note;
it's what the mockup draws). Given that departure already exists, the
Google-Tasks-faithful move is to extend the *pattern already on screen*
rather than reach back for the dropdown Google Tasks uses for a different
layout. A trailing `+` at the end of a scrollable tab row is a standard,
unsurprising affordance (same shape as adding a browser tab or a Sheets tab)
and needs no new UI vocabulary.

Rejected: a floating action button (FAB) for "add list" — the FAB in this app
already means "create task" (see the hi-fi mockup's Tasks List screen). Reusing
it for a second, unrelated action would overload one control with two
meanings. Rejected: a kebab/overflow menu on the tab bar — adds a menu
component nowhere else in this app for one action that a trailing tab already
covers.

### The sheet
Reuses the Create Task bottom sheet's shape exactly, per
[the hi-fi mockup](./hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md):
same corner radius, same rise-with-keyboard behaviour, same "compose row
focused on open" pattern used when the Create Task sheet opens.

Fields, matching [the List entity](../hacker/task-list-subtask-data-model.md#list)
exactly — nothing invented beyond what that note already lists:
- **Name** — single-line text field, keyboard focused the instant the sheet
  opens, same as the Create Task compose row.
- **Icon** — a picker grid using the same lucide icon set already drawn for
  Personal Interest (rocket), My Tasks (footprints), and Building (hammer).
  No new icon family.
- **Color** — a row of color dots, same visual shape as the `List Dot` already
  shown next to the list name in Task Detail. Picking one sets both the dot
  color and the tab's active-state color.

No `taskCount` field — that's derived, per the data model note, and doesn't
belong in a creation form.

### Where the new tab lands
Inserted at the end of the scrollable row, before the trailing `+`, so `+` is
always the last thing in the scroll — consistent with it being an
always-available action, not a per-list one.

## What would change my mind
The owner drawing or describing a different flow (e.g. list creation as part
of the List Selector inside Task Detail, not the tab bar itself) — the data
model doesn't force this location, it's a hipster placement choice made to
fit the pattern already on screen.

## Open questions
- Can a list be deleted or renamed, and does that reuse this same sheet
  (edit mode) or need its own flow? Not asked, not answered here.
- Is there a cap on the number of lists before the scrollable tab bar becomes
  unwieldy? Not addressed — no evidence either way.

---
Part of [Santian](../README.md)
