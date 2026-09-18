---
title: Which package schedules the reminder/deadline notifications?
idea: santian
lens: hacker
kind: question
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "../decisions/0003-personal-tool-not-a-product.md", "./offline-task-module-architecture.md"]
tags: [artifact, question]
---

## The question
[Decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md)
confirmed `reminderAt` and `deadline` each fire their own independent
notification. What actually schedules and fires them?

## Blocked by
Nothing — independent of the open Clockface questions.

## Why it matters
Santian is offline-first ([decision 0003](../decisions/0003-personal-tool-not-a-product.md):
personal tool, no backend) — these have to be **local**, device-scheduled
notifications, not push. Getting this wrong means picking a package that
can't survive the app being closed, which defeats the entire point of a
Task having a reminder.

## How I could answer it
Cheapest way, and the one actually used here: check what the Flutter
ecosystem's standard local-notification package is and whether it covers
the two things this app specifically needs — scheduling at an exact future
`DateTime`, and surviving app restarts/reboots.

## Answer
**`flutter_local_notifications`** — see
[decision 0010](../decisions/0010-flutter-local-notifications-package.md).
It's the de facto standard for this exact job (offline, device-scheduled,
survives app close) on both iOS and Android, actively maintained, and
nothing about Santian's two-notifications-per-Task need is unusual enough
to justify a less-proven alternative.

---
Part of [Santian](../README.md)
