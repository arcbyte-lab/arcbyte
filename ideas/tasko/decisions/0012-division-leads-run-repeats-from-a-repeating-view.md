---
title: Division leads run repeating tasks from one "repeating" view, opened from the toolbar
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-19
updated: 2026-10-19
inputs: ["./0009-workspace-tasks-repeat-on-completion.md", "./0007-server-rules-settled-in-the-api-review.md", "./0004-checkbox-goes-to-review-only-when-needed.md", "./0011-new-project-sits-at-the-end-of-the-tab-strip.md", "../hacker/tasko-api-as-built.md", "../hacker/flutter-app-as-built.md"]
tags: [artifact, decision]
---

## Decision
This builds on [0009](./0009-workspace-tasks-repeat-on-completion.md).
The repeat rule still lives on the task, and finishing a task still
creates the next one.

- **Only division leads set up repeats.** A lead is an `admin` or
  `supervisor` of the division (`division_members.role_type`). Only a lead
  can add, change or remove a task's repeat rule. Before this, the
  assignee, the creator and the reviewers could
  ([0007](./0007-server-rules-settled-in-the-api-review.md)). Assignees
  still tick the task, and ticking it still creates the next one.
- **Occurrences share a series.** A new `tasks.series_id` column holds the
  id of the first task in the series. Every next task copies it. This is
  what lets a lead see how each occurrence went.
- **A "repeating" view, one per division tab.** A `repeat` icon in the
  pinned toolbar opens it. It sits left of search (`search`), which sits
  left of view options (`sliders-horizontal`). Leads see the icon only on
  division tabs where they are a lead.
- **What the view does:**
  - **List.** Each live series: its open task's name, the rule ("every
    week on Mon, Thu"), the next due date, the assignee, and how the last
    few occurrences went (on time or late).
  - **History.** Tapping a series lists every occurrence, newest first:
    due date, assignee, status, finished on time or late, and the proof
    link. Tapping an occurrence opens its Task Detail.
  - **Change.** "edit repeat" opens the existing Repeat screen for the
    open task.
  - **New.** "+ new repeating task" opens the create sheet with a repeat
    chip. A due date is required. The first task shows in the tab right
    away, even when its due date is weeks away.
  - **Stop.** "stop repeating" removes the rule. The open task stays as a
    one-off task.
  - **Delete.** "delete" removes the rule and deletes the open task, but
    only if it is still `waiting`. A task someone has started or sent for
    review can only be stopped. Finished occurrences are never deleted.

## Context
On 2026-10-19 the owner described the feature: "as a manager/supervisor,
i want to be able to see which tasks that are repeating … see how my team
member do the task … reconfig … create a recurring tasks setup … delete
the recurring tasks setup or stop repeating". "Manager" means the `admin`
role. Claude suggested keeping 0009's model and showing a future task
right away. The owner said yes and chose the icon's place: beside search
and view options.

## What each lens said
- **Hound:** no user input.
- **Hipster:** the icon is `repeat`, the same icon as the repeat row in
  Task Detail, so it means the same thing in both places. Order in the
  toolbar: members (project tabs only), repeat (division tabs, leads
  only), search, view options. A division tab never shows members, so
  there are at most three icons. The frames are drawn as
  [H8](../hipster/hifi-mockup-tickets-for-pen-dev.md) (2026-10-19).
- **Hacker:** one migration (`series_id`) and three routes. No scheduled
  job and no `recurring_tasks` table. "Did they do it" uses data that
  already exists: `status`, `completed_date` against `due_date`, and the
  latest proof. A workspace task's reviewers are already its division's
  leads, so `isReviewer` is the lead check.
- **Hustler:** not consulted.

## Options rejected
- **Hide a future task until it's near its due date.** That needs a
  template the server turns into tasks on a schedule. It is the
  `recurring_tasks` model that 0009 rejected.
- **Reuse `tasks.recurring_task_id` as the series id.** The column exists
  but points at `recurring_tasks`, which isn't copied. Reusing it would
  give the name a second meaning.
- **Any editor sets up repeats** (0009 as built). An assignee could make
  their own task repeat, or stop a repeat the lead set up.

## How we will know we were wrong
- Leads want to see a series that has ended (it ran out, or was stopped).
  The view lists only live series.
- A lead creates a repeat that starts next month, and the team gets
  confused by a task that sits in the list for weeks.
- Members ask to set up their own repeats, for example a weekly check
  only they do.

---
Part of [Tasko](../README.md)
