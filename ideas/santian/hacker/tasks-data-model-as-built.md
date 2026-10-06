---
title: Tasks data model, as built — TaskList, Task, embedded Repeat and Subtask
idea: santian
lens: hacker
kind: data-model
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hacker/task-list-subtask-data-model.md", "../../../archive/santian/hacker/isar-schema.md", "../decisions/0006-isar-for-tasks-storage.md", "../decisions/0017-lists-are-name-only.md"]
tags: [artifact]
---

## Question
What exactly does Santian store today, field by field?

## Short answer
- There are two collections, `TaskList` and `Task`. Repeat and Subtask are
  embedded inside a Task, not tables of their own.
- A List is just `id` and `name`. A Task has a title, a description, a
  reminder (date and time), a deadline (date only), a repeat, a star, a
  done flag, and subtasks.
- There are **no timestamps**: no `createdAt`, `updatedAt` or
  `completedAt`. There is **no manual Task order**. Both matter when porting.

## Detail

Code: `lib/tasks/models/*.dart`. Stored in Isar
([0006](../decisions/0006-isar-for-tasks-storage.md)), package
`isar_community` 3.3.2.

### TaskList
The domain word is **List**. In code it is `TaskList`, because `List` is a
built-in Dart type.

| field | type | notes |
|---|---|---|
| `id` | int, auto | Creation order is id order. Tabs show Lists in this order. |
| `name` | String | Required. Trimmed and never blank (enforced in the UI and cubit). Duplicates are allowed. |

`icon` and `color` were removed in `3d0f44c`
([0017](../decisions/0017-lists-are-name-only.md)).

### Task
| field | type | notes |
|---|---|---|
| `id` | int, auto | Also the seed for notification ids. |
| `listId` | int, **indexed** | A plain id, not a link. No foreign key: the app deletes a List's Tasks itself. |
| `title` | String | Required. Trimmed and never blank. |
| `description` | String? | Trimmed. Blank is stored as null. "Notes" in Create Task is this same field. |
| `reminderAt` | DateTime? | Date **and** time, local. The notification trigger. A date picked with no time is stored at 09:00. |
| `deadline` | DateTime? | Date only (midnight, local). Its own notification fires at 09:00. Drives the overdue color. |
| `repeat` | Repeat? (embedded) | Null means no repeat. Only valid with a `reminderAt`: clearing the reminder clears this. |
| `isStarred` | bool, **indexed** | Default false. |
| `isCompleted` | bool | Default false. Never true on a repeating Task (see [behaviour rules](./tasks-behaviour-rules-as-built.md#completing-a-task)). |
| `subtasks` | List&lt;Subtask&gt; (embedded) | Default empty. |

### Repeat (embedded)
| field | type | notes |
|---|---|---|
| `frequency` | enum `daily, weekly, monthly, yearly, custom` | Stored by **ordinal**. Only add new values at the end. |
| `interval` | int | 1 unless `custom`. |
| `unit` | enum? `days, weeks, months, years` | Only for `custom`, null otherwise. Stored as `ordinal32` so it can be null. |
| `weekdays` | List&lt;int&gt; | ISO numbers, 1 = Mon … 7 = Sun, sorted. Only for weekly-shaped repeats, empty otherwise. |

The Repeat dialog writes "Every 1 X" as the plain frequency, and "Every
N X" (N > 1) as `custom` + `interval` + `unit`. There is no end condition
and no start date: the start is `reminderAt`.

### Subtask (embedded)
| field | type | notes |
|---|---|---|
| `id` | String (UUID v4) | Embedded objects have no Isar id, so this is what edit, delete and reorder target. |
| `title` | String | Never blank. |
| `isCompleted` | bool | Separate from the parent Task's flag. |
| `order` | int | Dense 0..n-1, rewritten on every reorder. Ties are broken by `id`. |

Subtasks are one level deep, with no subtask-of-subtask. They have no
dates, star or notifications.

### What is deliberately absent
- **Timestamps**: no created, updated or completed time anywhere. The
  Completed section cannot sort by "completed most recently".
- **Task position**: Tasks are always shown sorted by `reminderAt`, then
  `id`. There is no drag to reorder Tasks.
- **Soft delete**: deletes are hard. Undo works by writing back the copy
  held in memory.
- **Owner or user**: single-user, on-device only. No sync, no account.

## What would change my mind
- A need to sort Completed by recency, or to reorder Tasks by hand. Either
  forces new fields.

## Open questions
- None about what is stored. What is missing is listed above, ready for the
  Tasko mapping.

---
Part of [Santian](../README.md)
