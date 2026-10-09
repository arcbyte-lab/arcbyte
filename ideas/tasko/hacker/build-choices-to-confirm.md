---
title: Choices made while building the Tasko app, waiting for the owner
idea: tasko
lens: hacker
kind: question
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-07
updated: 2026-10-09
inputs: ["./flutter-app-as-built.md", "../hipster/hifi-mockup-tickets-for-pen-dev.md", "../hipster/lofi-mockup-tickets-for-pen-dev.md", "../decisions/0004-checkbox-goes-to-review-only-when-needed.md"]
tags: [artifact]
---

## Question
Which calls did the build make that no note or decision had settled, and
which still block UI?

## Short answer
- Eight small calls were made so the build could go on. Each one is
  cheap to change. None of them is a decision until the owner says so.
- Four questions left an "action: …" placeholder in the app. Proof is
  now answered by [0007](../decisions/0007-server-rules-settled-in-the-api-review.md);
  three are still open.

## Detail
### Made while building (confirm or overrule)
| Choice | Why | Where it differs |
|---|---|---|
| "N open" counts tasks in review | The hifi day-selected frame counts them | [0004](../decisions/0004-checkbox-goes-to-review-only-when-needed.md) says review is not open. The calendar still follows 0004. |
| No repeat row in Task Detail | [0005](../decisions/0005-v1-build-defaults.md) cut repeat | The hifi detail frame shows the row |
| Personal tasks show no code | `personal_tasks` has no `code` column | The hifi frame shows "PV-0007" |
| FAB stays in the full-screen calendar | The hifi frame shows it | Lofi T3 hides it |
| Tapping a day in the full-screen calendar collapses it | The filtered list is the point of the tap | Not specified |
| The server writes each notification's text | Keeps sentence-building out of the app | Not specified |
| Tapping a notification only marks it read | Opening its task needs a task id in the data | Not specified |
| Notification times: "2h ago" all day | One rule for all of today | The hifi frame shows "8:00" |

### Still open (each one is an "action: …" placeholder in the app)
- ~~**Proof:** which proof types exist, and how is a proof submitted?~~
  Answered 2026-10-09 by [0007](../decisions/0007-server-rules-settled-in-the-api-review.md):
  a proof is an http(s) link, sent with the tick to review. The app's
  placeholders can now be built against the
  [API](./tasko-api-as-built.md).
- **Archive task:** tasks have no `archived` status, only `cancelled_date`.
  Is archive the same as cancel?
- **The header's slider icon:** still unexplained, so it is left out.
- **Account settings and log out:** what the settings screen holds.
  Sign-in itself now exists on the server: email and password, a 30-day
  bearer token, `POST /auth/logout` ([API](./tasko-api-as-built.md)).

## Open questions
- Should any row in the first table become a decision note?

---
Part of [Tasko](../README.md)
