---
title: Santian's screens in a team app — what each one keeps and what it has to add
idea: tasko
lens: hipster
kind: analysis
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../santian/hipster/tasks-list-screen-as-built.md", "../../santian/hipster/task-row-as-built.md", "../../santian/hipster/create-sheets-as-built.md", "../../santian/hipster/task-detail-as-built.md", "../../santian/hipster/date-pickers-and-repeat-as-built.md", "../hacker/santian-concepts-mapped-to-tasko-schema.md"]
tags: [artifact]
---

## Question
If Tasko's task UX copies [Santian's screens](../../santian/README.md#artifacts),
what does each screen keep, and what does Tasko's data force it to add?

## Short answer
- **Keep the skeleton:** the tabbed card with swipe, day-grouped rows, a
  one-line Create sheet, a Task Detail sheet that saves at once, and the
  shared date picker.
- **Must add:** assignee, status beyond done/not done (review, proof),
  and priority. Each one competes for room on a row that Santian kept
  minimal.
- **Settled since:** a tab is `private`, a division, or a project, and
  there is no Star tab ([0002](../decisions/0002-tabs-are-workspaces-then-projects.md)).
  A due-date calendar sits above the tabs ([0003](../decisions/0003-calendar-is-a-due-date-heatmap-that-filters.md),
  [wireframe](./home-screen-wireframe.md)).

## Detail

`evidence: none`. This is a design proposal with no user input and no
Tasko UI to compare against.

| Santian screen | Keep | Add or change for Tasko |
|---|---|---|
| [Tasks List](../../santian/hipster/tasks-list-screen-as-built.md) | swipe, day headers, Completed section, FAB | Tabs per 0002, with no Star tab and no `+`. The calendar sits above them. Group by `due_date`. Completed could sort by `completed_date`. List options become project actions (rename, archive), shown by role. |
| [Task row](../../santian/hipster/task-row-as-built.md) | checkbox, title, 2-line description, date line, star | An assignee avatar (on the right, beside the star?). A third checkbox state for "in review". Priority: maybe a colored date or a mark, not a new line. |
| [Create sheets](../../santian/hipster/create-sheets-as-built.md) | title-first, Enter saves, notes, date, star | An assignee chip (default: me). `code`, division and creator are filled in by the server, so the user never sees them. Create List → create project only if the user may. |
| [Task Detail](../../santian/hipster/task-detail-as-built.md) | top bar, title, description, dates as chips, subtasks, the big completion pill | Rows for assignee, status, priority, and proof (upload when required). Comments and attachments below the subtasks. The pill's text follows status ("Submit for review", "Approve"). |
| [Pickers and Repeat](../../santian/hipster/date-pickers-and-repeat-as-built.md) | month grid, Cancel/Done, Repeat dialog | The deadline picker may need a time (`due_date` is a datetime). Repeat edits a recurring template, so its summary has to say "creates a new task every …". |

### Where Santian's minimalism will hurt
Santian's row works because it shows only the user's own data. A team row
needs at least "who" and "what state". If both go on the row, it stops
looking like Google Tasks. The likely trade-off is to show only Tasks
assigned to me by default, which keeps the row Santian-shaped, and to put
"who" in Detail. That is a question for the owner, not a recommendation.

## What would change my mind
- Real Tasko users mostly look at other people's Tasks, for example
  supervisors. Then the row needs "who" up front, and Google Tasks is the
  wrong model.

## Open questions
- Default view: my Tasks only, or everyone's in the project?
- Is a star per user (only the person who starred sees it)? The hacker
  note assumes so.

---
Part of [Tasko](../README.md)
