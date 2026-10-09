---
title: Server rules settled in the Tasko API review — a proof is a link, who edits, one level of sub-tasks
idea: tasko
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-09
updated: 2026-10-09
inputs: ["./0002-tabs-are-workspaces-then-projects.md", "./0004-checkbox-goes-to-review-only-when-needed.md", "./0005-v1-build-defaults.md", "../hacker/tasko-api-as-built.md", "../hacker/build-choices-to-confirm.md"]
tags: [artifact, decision]
---

## Decision
The Tasko API runs on Hono, Cloudflare Workers and D1, not Laravel. The open
rules found while reviewing it are closed like this:

| Question | Answer |
|---|---|
| Server | Hono on Cloudflare Workers, D1 database, deployed. No Laravel app shares the database. This replaces the "Server" row of [0005](./0005-v1-build-defaults.md). |
| What is a proof? | A link: any http or https URL. No uploads for now. It is stored in `proofs.file`. Sending a task to review needs one ([0004](./0004-checkbox-goes-to-review-only-when-needed.md): "the user is asked for it first"). |
| Who edits a team task | Its assignee, its creator and its reviewers. Only the creator and reviewers can change the assignee. |
| Sub-tasks | One level deep. A sub-task can't have its own sub-tasks. |
| A project author who leaves | Stops being a reviewer of its tasks ([0002](./0002-tabs-are-workspaces-then-projects.md): membership comes from the member tables). |
| Extension requests | Only on an open task, only to a later date, and only one pending at a time. |
| Review words | `approved` and `rejected`, as in 0004. |
| Login | Tokens last 30 days. `must_change_password` is reported but not enforced until a change-password route exists. |

## Context
On 2026-10-09 every API pull request was reviewed. The review found rules
that no note had settled. The owner chose "a proof is only a link" and "no
Laravel sharing" directly. The other rows are defaults offered in chat,
which the owner accepted ("yes, build them"). This note writes them down. It stays
`draft` until the owner promotes it.

## What each lens said
- **Hound:** no user input.
- **Hipster:** the proof becomes a text field for a link, not a file picker.
  The proof chip and "submit proof" in Task Detail can now be built.
- **Hacker:** the `proofs` table from `sqlite-schema.sql` already has a
  `file` column, so a link needs no new table design. The upload columns
  (`drive_file_id`, `size`, `original_name`) stay empty.
- **Hustler:** not consulted.

## Options rejected
- **Proof uploads (image or file) now.** They need storage and an upload
  flow. A link covers v1.
- **Checking the link against `required_proof_type`** (`image` / `file`).
  Any link is accepted, so for now the type only means "needs a proof".
- **Any member edits any task.** A member could reassign a task to
  themselves and then tick it, which gets around "only the assignee ticks".
- **Sub-tasks of any depth.** Task Detail shows one level. Allowing more is
  easy later; taking it away is not.

## How we will know we were wrong
People need to attach photos or files that have no link. Or a team member
who isn't the assignee, creator or a reviewer needs to fix a typo in a task.
Or someone asks for a checklist inside a sub-task.

---
Part of [Tasko](../README.md)
