---
title: Detail edit saves with a button, assignees cannot edit the due date, the strip counts all my tasks, archive is the backend's call
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-10
updated: 2026-11-10
inputs: ["./0007-server-rules-settled-in-the-api-review.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../hacker/build-choices-to-confirm.md"]
tags: [artifact, decision]
---

## Decision

Settles the open questions of [H12 and H13](../hipster/hifi-mockup-tickets-for-pen-dev.md).

1. **Edit mode saves with a button.** The action bar shows Save and Cancel
   while edit mode is on. One save sends one update and writes one activity
   log entry. Cancel drops the changes. (Replaces "Submit proof" on the edit frames.)
2. **Assignees cannot edit the due date.** They use the extension request.
   Creators and reviewers edit it directly. This amends
   [0007](./0007-server-rules-settled-in-the-api-review.md): the API rejects a
   due-date change from someone who is only the assignee.
3. **The workload strip counts all my tasks.** It ignores the selected tab.
   "Due soon" means due within 48 hours.
4. **Archive is the backend's call.** The owner leaves the meaning to the API.
   The API has `canArchive` (creator only) but tasks have no `archived`
   status yet, only projects do. The API ticket must pick one (a task
   `archived` status, or reuse `cancelled_date`), write it as a decision,
   and the app follows. Until then the sheet wording stays a placeholder.
7. **New project lives only on the rails.** The "+ new project" at the end
   of the tab strip is removed, which supersedes
   [0011](./0011-new-project-sits-at-the-end-of-the-tab-strip.md). The
   PROJECTS group shows only when the user has a project tab.

## Context

The owner answered these in chat on 2026-11-10; options 1 to 3 were Claude's
recommendations, taken as given. Item 4 was left to the backend by the owner.
Items 5 to 7 came from the owner in chat the same day.
Stays `draft` until the owner promotes it.

---
Part of [Tasko](../README.md)
