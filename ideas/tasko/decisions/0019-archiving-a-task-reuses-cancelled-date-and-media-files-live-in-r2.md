---
title: Archiving a task reuses cancelled_date, Media files live in Cloudflare R2
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-sonnet-5.5 (claude-code)
evidence: none
created: 2026-11-10
updated: 2026-11-10
inputs: ["./0018-detail-edit-saves-explicitly-and-the-strip-counts-all-my-tasks.md", "../hacker/rails-edit-mode-media-and-discussion-build-tickets.md", "../hacker/build-choices-to-confirm.md"]
tags: [artifact, decision]
---

## Decision

Settles the two calls that block the API tickets in the
[H13 build tickets](../hacker/rails-edit-mode-media-and-discussion-build-tickets.md).

1. **Archiving a task sets `cancelled_date`.** No new task status and no
   migration. `POST /tasks/:id/archive` (A3) stays creator only, writes an
   activity log entry, and archived tasks leave every tab and the workload
   strip. Archive and cancel are the same thing in the API; the app calls
   it archive.
2. **Media files live in Cloudflare R2.** The API (A5) keeps the metadata in
   D1 and hands the app a signed URL to open. Uploads are out of A5's first
   cut unless the pages need them.

## Context

The owner chose both on 2026-11-10. For item 1 the options were a new
`archived` task status (Claude's recommendation), reuse of `cancelled_date`,
or a separate `archived_at` flag. The owner took `cancelled_date`, which is
the cheapest; the cost is that a cancelled task and an archived task cannot
be told apart, the worry [build-choices-to-confirm](../hacker/build-choices-to-confirm.md)
raised. If that matters later, add a status then. Item 2 was Claude's
recommendation, taken as given. Stays `draft` until the owner promotes it.

---
Part of [Tasko](../README.md)
