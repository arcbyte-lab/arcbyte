---
title: Rails, edit mode, Media and Discussion build tickets — H13
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: weak
created: 2026-11-10
updated: 2026-11-10
inputs: ["../hipster/hifi-mockup-tickets-for-pen-dev.md", "../decisions/0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md", "./detail-tabs-and-workload-strip-build-tickets.md", "./flutter-app-as-built.md", "./tasko-api-as-built.md"]
tags: [artifact]
---

## Question
What is left to build for the rails, edit mode, Media and Discussion
([H13](../hipster/hifi-mockup-tickets-for-pen-dev.md)), and what is already
built?

## Short answer
- Already done: the rails (app [#40](https://github.com/arcbyte-lab/Tasko-Flutter/issues/40)),
  the submitted proofs sheet (app [#47](https://github.com/arcbyte-lab/Tasko-Flutter/issues/47))
  and the API's `proofs` list (API [#46](https://github.com/arcbyte-lab/Tasko-API/issues/46), A2).
- Open: edit mode, app [#49](https://github.com/arcbyte-lab/Tasko-Flutter/issues/49) (B23).
- New: 4 API tickets, **A3** to **A6**, and 4 app tickets, **B24** to **B27**.
- The API side is the risk. Read on 2026-11-10: Tasko-API has no media or
  discussion tables or routes (`comments` is per task), and `tasks.status`
  has no `archived` value (only `projects.status` does).
- Order: A4 before B23's due-date field and B24. A3 before B24. A5 before
  B25. A6 before B26. B27 is independent.

## Detail
Drawings: H13 in `pencil-new.pen`. These tickets build on
[B20 and B21](./detail-tabs-and-workload-strip-build-tickets.md).

### Rules
| Rule | Value |
|---|---|
| Edit mode | Pencil quick action ([#49](https://github.com/arcbyte-lab/Tasko-Flutter/issues/49)). Title, note, priority, assignee are fields; the due date too, but only for creators and reviewers. Status, repeat and proof stay plain. Save and Cancel replace the action bar ([0018](../decisions/0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md) item 1) |
| Due date | The API rejects a due-date change from a user who is only the assignee (0018 item 2) |
| Extension pending | Grey "Oct 10 pending" pill by the due date; extension button disabled |
| Archive | Creator only. Confirm sheet "Archive this task?". Archived tasks drop out of every tab |
| Images | Tapping one opens the phone's browser. No viewer |

### API (Tasko-API)
**A3 — Archive a task** ([#48](https://github.com/arcbyte-lab/Tasko-API/issues/48)). 0018 item 4 leaves the meaning to the backend.
Tasks have `waiting`, `in_progress`, `review`, `done`; only projects have
`archived`. [0019](../decisions/0019-archiving-a-task-reuses-cancelled-date-and-media-files-live-in-r2.md)
reuses `cancelled_date`: no migration. Add `POST /tasks/:id/archive`
(creator only, as `canArchive` says) that sets it, log it, and leave
archived tasks out of every tab and the workload.

**A4 — Due-date rule and the pending extension** ([#49](https://github.com/arcbyte-lab/Tasko-API/issues/49)).
- `PATCH /tasks/:id` today lets the assignee change any field but the
  assignee. Reject a `dueDate` change when the caller is neither the
  creator nor a reviewer, with a message the app shows as a toast.
  The app sends the date with every edit, so only a *change* is refused.
- Task detail returns `pendingExtension`: the requested date of the task's
  pending row in `task_deadline_requests`, or null.
- Tests: the refusal, an unchanged date passing, the pending date.

**A5 — Media** ([#50](https://github.com/arcbyte-lab/Tasko-API/issues/50)). New tables (the old `attachments` table was never copied).
Files live in Cloudflare R2, metadata in D1
([0019](../decisions/0019-archiving-a-task-reuses-cancelled-date-and-media-files-live-in-r2.md)).
- `GET /media/folders` (project and division tabs),
  `GET /media/folders/:id` (task folders),
  `GET /media/tasks/:id/files?kind=all|images|documents`.
- Match the live web pages (tasko.scuto.co.id). Access follows project and
  division membership.

**A6 — Discussion** ([#51](https://github.com/arcbyte-lab/Tasko-API/issues/51)). New tables for chats and messages.
- `GET /discussions` (list with `unread` and the last message),
  `GET /discussions/:id/messages`, `POST /discussions/:id/messages`,
  `PATCH /discussions/:id/read`.
- Access follows membership. The unread count feeds the rails badge.

### App (Tasko-Flutter)
Each ticket is done when `flutter analyze` and `flutter test` pass.

**B23 — Edit mode** is [#49](https://github.com/arcbyte-lab/Tasko-Flutter/issues/49).
Needs A4 for the due-date refusal. Replaces today's save-on-close drafts
of title and note with Save and Cancel.

**B24 — Archive confirm and the pending pill** ([#51](https://github.com/arcbyte-lab/Tasko-Flutter/issues/51)). Needs A3 and A4.
- Archive opens the "Archive this task?" sheet, then calls A3 and closes
  the panel. The task leaves the list.
- Grey pending pill by the due date and a disabled extension button from
  `pendingExtension`.
- Tests: archive removes the task; the pill and the disabled button.

**B25 — Media** ([#52](https://github.com/arcbyte-lab/Tasko-Flutter/issues/52)). Needs A5.
- `media/` feature: `MediaCubit` and three screens: `default` (project and
  division folder tabs), `project` (back header, one row per task folder)
  and `files` (All / Images / Documents chips, two-column grid).
- Tapping an image or document opens it with `url_launcher`.
- Tests: tabs, chips filter, empty folder.

**B26 — Discussion** ([#53](https://github.com/arcbyte-lab/Tasko-Flutter/issues/53)). Needs A6.
- `discussion/` feature: the list (unread row #F9FAFB, bold title, 6px red
  dot), the conversation (bubbles, date pills, message field, rails
  hidden), and a message with several images in rows of three.
- Opening a chat calls `read`, then refreshes the rails badge. The badge
  counts unread chats.
- Tests: unread clears on open; sending appends; image rows.

**B27 — My Workspace pull** ([#54](https://github.com/arcbyte-lab/Tasko-Flutter/issues/54)).
- Swiping down on the calendar in home moves to My Workspace: the white
  section slides down and stays peeking at the bottom with a grabber
  ("swipe up to back to home"). Swiping up returns home.
- My Workspace stays dark: Tab Bar with "my tasks" (active) and
  "private", on black with a #27272A border and a #3B82F6 underline.
  No rails.
- Tests: the gesture switches both ways. The animation is not tested.

### Not in these tickets
- Viewing images inside the app. Not drawn.
- The rails' "+ new project" and PROJECTS group: checked in Tasko-Flutter on
  2026-11-10, #40 has them (`tab_strip.dart` has no "new project" and shows
  PROJECTS only when there is a project tab; `rails.dart` hides New project
  unless the viewer may create one). Media and Discussion only show a message
  on tap until B25 and B26.

## What would change my mind
- If the web app's server already has media and chat tables, A5 and A6
  shrink to "expose them to the mobile token". Tasko-API does not have them.

## Open questions
- None for A3 and A5; both settled in 0019. The R2 bucket and its binding are set up by the owner.
- Does the badge count chats or messages? The drawing shows 7 as sample data.

---
Part of [Tasko](../README.md)
