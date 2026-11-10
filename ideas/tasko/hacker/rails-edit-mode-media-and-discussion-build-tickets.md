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
What are the build tickets for the rails, edit mode, Media and Discussion
([H13](../hipster/hifi-mockup-tickets-for-pen-dev.md))?

## Short answer
- 3 API tickets, **A19** to **A21**, and 5 app tickets, **B22** to **B26**.
- The API side is the risk. Today it has no archive state, returns only the
  latest proof, and has no media or discussion routes. Those routes were
  not checked against the web app's server yet (see Open questions).
- Order: B22 first (nothing else depends on it, and it removes the FAB).
  A19 and A20 before B23. A21 before B24 and B25. B26 is independent.

## Detail
Drawings: H13 in `pencil-new.pen`. These tickets build on
[B20 and B21](./detail-tabs-and-workload-strip-build-tickets.md): B23 adds
to the quick actions B20 creates.

### Rules
| Rule | Value |
|---|---|
| Rails | Navigations (Home, Media, Discussion) and Actions (new project, new task) in a `Rails Dock` at the bottom. They replace the FAB. Home is active by default |
| Hidden | Under a sheet or the detail panel, on the full-screen calendar, and on the conversation screen |
| Unread badge | On Discussion: the count of unread chats |
| Edit mode | Pencil quick action. Title, note, priority, assignee are fields. Due date too, but only for creators and reviewers. Status, repeat and proof stay plain. Save and Cancel replace the action bar ([0018](../decisions/0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md) item 1) |
| Due date | The API rejects a due-date change from a user who is only the assignee (0018 item 2) |
| Proof list | The file-up quick action opens "Submitted proofs", newest first, top one tagged Latest |
| Extension pending | Grey "Oct 10 pending" pill by the due date; extension button disabled |
| Images | Tapping one opens the phone's browser. No viewer |

### API (Tasko-API)
**A19 — Archive a task.** 0018 item 4 leaves the meaning to the backend.
Pick one: a task `archived` status, or reuse `cancelled_date`. Write it as
a decision, then add `POST /tasks/:id/archive` (creator only, which
`canArchive` already says) and write an activity log entry. Archived tasks
drop out of every tab. Until this is decided, B23 keeps the placeholder
sheet wording.

**A20 — Edit rules and the proof list.**
- `PATCH /tasks/:id`: reject a `dueDate` change when the caller is only the
  assignee, with a message the app shows as a toast.
- Task detail returns `proofs` (every proof, newest first) beside `proof`
  (the latest). Keep `proof` so the current app works.
- Task detail returns `pendingExtension` (the requested date, or null) for
  the grey pill.
- Tests: the rejection, the order of `proofs`, the pending date.

**A21 — Media and discussion reads.** Match the live web pages
(tasko.scuto.co.id).
- `GET /media/folders` (project and division tabs), `GET /media/folders/:id`
  (task folders), `GET /media/tasks/:id/files?kind=all|images|documents`.
- `GET /discussions` (chat list with `unread` and the last message),
  `GET /discussions/:id/messages`, `POST /discussions/:id/messages`,
  `PATCH /discussions/:id/read`.
- Tests: access follows project and division membership.

### App (Tasko-Flutter)
Each ticket is done when `flutter analyze` and `flutter test` pass.

**B22 — Rails.**
- `widgets/rails.dart`: `RailItem` (44 tall pill, 20px icon over an 8px
  uppercase label; 76 wide in Navigations, 70 in Actions) and `Rails`
  with the two groups in the dock (426×100 at the bottom, 16px blur, 50%
  white, 1px #E5E7EB border). Active: #E0F2FE pill, #1E3A8A.
- Remove the FAB from `HomeView`. New task opens the create sheet and New
  project the new-project sheet, as the FAB and "+ new project" do now.
- Remove "+ new project" from the tab strip, and show the PROJECTS group
  only when the user has a project tab (0018 item 7). This supersedes 0011.
- Hide on a sheet, the detail panel, the full-screen calendar and the
  conversation. On the snackbar frame, sit 16px above the toast.
- Discussion badge: 16px #EF4444, white count; hidden at zero.
- Tests: each item navigates; hidden in each case above; badge at 0 and 7.

**B23 — Edit mode, proof list, archive confirm, pending pill.** Needs A19
and A20.
- `task_detail_sheet.dart`: the pencil in `_QuickActions` toggles edit
  mode. Fields are `Field` boxes for title, note, priority, assignee, and
  due date unless the viewer is only the assignee. A creator or reviewer
  gets no extension button in edit mode.
- Action bar in edit mode: Save (one `PATCH`, one log entry) and Cancel
  (drop the draft). This replaces today's save-on-close drafts of title
  and note.
- The file-up circle opens the "Submitted proofs" sheet from `proofs`.
- Archive opens the "Archive this task?" confirm sheet, then calls A19.
- Grey pending pill and disabled extension button from `pendingExtension`.
- Tests: Save sends one update; Cancel sends none; an assignee has no
  due-date field; the proof list order; archive removes the task.

**B24 — Media.** Needs A21.
- `media/` feature: `MediaCubit` and three screens: `default` (project and
  division folder tabs), `project` (back header, one row per task folder)
  and `files` (All / Images / Documents chips, two-column grid).
- Tapping an image or document opens it with `url_launcher`.
- Tests: tabs, chips filter, empty folder.

**B25 — Discussion.** Needs A21.
- `discussion/` feature: the list (unread row #F9FAFB, bold title, 6px
  red dot), the conversation (bubbles, date pills, message field, rails
  hidden), and a message with several images in rows of three.
- Opening a chat calls `read`, then refreshes the rails badge.
- Tests: unread clears on open; sending appends the message; image rows.

**B26 — My Workspace pull.**
- Swiping down on the calendar in home moves to My Workspace: the white
  section slides down and stays peeking at the bottom with a grabber
  ("swipe up to back to home"). Swiping up returns home.
- My Workspace stays dark: Tab Bar with "my tasks" (active) and
  "private", on black with a #27272A border and a #3B82F6 underline.
  No rails.
- Tests: the gesture switches both ways. The animation is not tested.

### Not in these tickets
- Viewing images inside the app. Not drawn.

## What would change my mind
- If A21's routes already exist in the web app's server, A21 shrinks to
  "let the mobile token use them".

## Open questions
- What does archive do? A19 decides.
- Do the web's media and discussion endpoints exist in Tasko-API, or only
  in the web app's own server? A21 assumes they do not.
- Does the badge count chats or messages? The drawing shows 7 as sample data.

---
Part of [Tasko](../README.md)
