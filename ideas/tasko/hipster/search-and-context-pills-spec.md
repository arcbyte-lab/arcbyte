---
title: Search bar and context pills — the new section under the calendar, and My Workspace
idea: tasko
lens: hipster
kind: wireframe
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-20
updated: 2026-11-20
inputs: ["../assets/hi-fi snapshoots/hifi ! home ! default.png", "../assets/hi-fi snapshoots/hifi ! home ! day-selected.png", "../assets/hi-fi snapshoots/hifi ! My Workspace ! default.png", "../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0017-a-my-tasks-tab-gathers-the-users-tasks.md", "../decisions/0020-my-tasks-moves-to-my-workspace-pulled-down-from-home.md"]
tags: [artifact]
---

## Question
The owner restyled the section between the calendar and the task list on Home.
How does My Workspace get the same section?

## Short answer
- Only the look changed. Tabs still switch context, and a task is still in
  exactly one tab ([0002](../decisions/0002-tabs-are-workspaces-then-projects.md)).
- Home now has a **search row** (search field + filter toggle) and a **pill
  row** (divisions, a divider, projects). The old text tab strip and its
  "WORKSPACES / PROJECTS" labels are gone.
- My Workspace gets the same two rows. Its pills are `my tasks` and `private`.

## Detail

Read from the Home screenshots (sizes are estimates, not measured in the pen
file):

**Search row**
- One outlined capsule holds the search field and the filter toggle.
- The field is a grey rounded bar with a search icon and no placeholder.
- The filter toggle (sliders icon) is a separate round grey button at the right
  end of the capsule.

**Pill row** (the old tab strip)
- Each tab is an outlined pill, about 24 tall, full radius, text in the same
  type as the task titles. Selected = filled blue `#3B82F6`, white text.
- Home order: divisions (`HO:IT`, `HO:Marketing`), a 1px vertical divider,
  then projects (`TASKO APP`, `TASKO WEB`). The divider replaces the group
  labels.

**My Workspace** (dark screen today: `my tasks | private` as underlined text,
then a "7 open" row with search and sliders icons)
- Replace the text tabs with two pills: `my tasks` (selected by default) and
  `private`. Same group, so **no divider**.
- Replace the "7 open" row with the search row. The search and sliders icons
  move into it, so they must not appear twice.
- Use the dark theme tokens for the capsule, field and unselected pills. The
  selected pill stays `#3B82F6`.
- Everything else stays: workload strip, date groups, task rows, Completed (4).

## What would change my mind
If the owner decides the "7 open" count is still useful, it needs a new home.

## Open questions
- Where does "7 open" go? Drop it, put it inside the filter sheet, or keep a
  small line under the pills?
- Do the pills stay uppercase? Home shows `TASKO APP`, `HO:IT` and the data is
  `tasko-app`. Is that a text transform, and does it apply to `my tasks` and
  `private`?
- Should every other screen with the old strip (the day-selected, search and
  project frames) also be restyled? That needs pen.dev, which is paused.

---
Part of [Tasko](../README.md)
