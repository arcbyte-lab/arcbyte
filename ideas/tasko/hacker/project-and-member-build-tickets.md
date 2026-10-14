---
title: Project and member build tickets — create a project, add people directly, no invitation step
idea: tasko
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-14
updated: 2026-10-14
inputs: ["../decisions/0010-adding-a-project-member-needs-no-invitation.md", "../decisions/0002-tabs-are-workspaces-then-projects.md", "../decisions/0007-server-rules-settled-in-the-api-review.md", "./tasko-api-as-built.md", "./flutter-app-as-built.md", "../assets/sqlite-schema.sql"]
tags: [artifact]
---

## Question
What are the build tickets, for the API and for the app, that let people
create projects and manage who is in them?

## Short answer
- 4 API tickets (**A9–A12**) and 4 app tickets (**B7–B10**). Do them in
  order. A9 comes first, because only a division admin or supervisor can
  create a project, and the live database has no division members yet.
- **Inviting someone adds them right away.** There is no pending state and
  no email. The `project_members` row is written with `invited_by`, and
  the person gets a notification. Every possible member already has an
  account, because users are added by script.
- The rules are settled by
  [0010](../decisions/0010-adding-a-project-member-needs-no-invitation.md).

## Detail
Issues: API [#21](https://github.com/arcbyte-lab/Tasko-API/issues/21)–[#24](https://github.com/arcbyte-lab/Tasko-API/issues/24)
(A9–A12), app [#5](https://github.com/arcbyte-lab/Tasko-Flutter/issues/5)–[#8](https://github.com/arcbyte-lab/Tasko-Flutter/issues/8)
(B7–B10).

**Built, 2026-10-14.** The API tickets are merged
([#25](https://github.com/arcbyte-lab/Tasko-API/pull/25)–[#28](https://github.com/arcbyte-lab/Tasko-API/pull/28))
and deployed. The app tickets are in open pull requests,
[#9](https://github.com/arcbyte-lab/Tasko-Flutter/pull/9)–[#12](https://github.com/arcbyte-lab/Tasko-Flutter/pull/12),
each stacked on the one before: merge in order, moving each next PR's base
to `main`. The phone walkthrough (`integration_test/live_test.dart`, run
against a local API) passes all 21 steps, the new ones included. It found
one bug the widget tests missed: after leaving, the app reloaded a member
list the server no longer shows, and toasted "Not a member". Fixed in #11. "New project" sits in the account menu and the
members icon in the project toolbar, as defaults; neither is in the hifi
mockups yet.

### Rules
| Rule | Value |
|---|---|
| Who creates a project | An `admin` or `supervisor` of the division, from `division_members` |
| On create | `projects` row with `status = planning` and `creator_id = me`, plus a `project_members` row for me as `owner`, in one `db.batch` |
| Who manages members | `owner` and `person-in-charge` |
| Who can be added | Any active user, from any division |
| Making or removing an owner | Only an `owner` can do it. A project always keeps at least one owner. |
| Leaving | Any member can remove themselves, unless they are the last owner |
| A removed member's tasks | Their `todo` / `waiting` / `in_progress` tasks in the project get `assignee_id = null`, in the same batch. Tasks in `review` keep the assignee, so the review still makes sense. |
| Reviewer | No change. 0007 already drops a creator who leaves. |

The server enforces every rule. The app only hides buttons a user can't
use.

### API (tasko-api)
Same shape as today: a Hono router per file, `HTTPException` with a plain
message, and tests in `test/` that use `login()` and `api()` from
`test/helpers.ts`. Each ticket is done when `npm test` (vitest) passes and the
change is deployed.

**A9 — Seed divisions and division members**
- `scripts/users-sql.ts` also accepts
  `{ divisions: [{prefix, name}], users: [...] }`. A plain array still
  works, as before.
- A user can have `divisions: {"TECH": "admin"}` (prefix → role).
- The script prints `insert or ignore` statements for divisions (slug is
  the lowercase name with dashes) and for `division_members`. Users and
  divisions are looked up by email and by prefix in a subselect.
- Test: extend `test/users-sql.test.ts`.

**A10 — Roles in `GET /tabs`, and user search**
- Division and project rows in `GET /tabs` gain `role`: the viewer's
  `role_type` or `role`. The private tab has `role: null`. The app uses it
  to decide which buttons to show.
- `GET /users?q=` returns up to 20 active users as `{id, name, email}`,
  where the name or email contains `q` (`like`, case-insensitive). An
  empty `q` returns the first 20 by name. Any logged-in user can call it.

**A11 — `POST /projects`**
- Body: `{divisionId, name, description?, dueDate?}`. The name is trimmed
  and can't be empty (400).
- Returns 403 unless the viewer is an admin or supervisor of that division.
- One `db.batch`: insert into `projects`, then insert into
  `project_members (project_id, user_id, role, invited_by)` using
  `last_insert_rowid()`, `'owner'`, and null.
- Returns 201 with the new tab: `{kind: 'project', id, name, role: 'owner'}`.

**A12 — Member routes** (new file `src/projects.ts`, mounted at `/projects`)
```
POST   /projects/:id/members          {userId, role?}   role defaults to member
PATCH  /projects/:id/members/:userId  {role}
DELETE /projects/:id/members/:userId                    removing yourself = leave
```
- All three call `assertMember(db, 'project', id, me)` first.
- **Add** and **role change:** 403 unless the viewer is an owner or
  person-in-charge. 403 if the change gives or takes away `owner` and the
  viewer is not an owner. 422 if the user is inactive. 409 if they are
  already a member (the unique index catches this; turn the error into a
  409).
- **Remove:** a manager can remove anyone. Anyone can remove themselves.
  If it would leave no owner, 422 "A project needs an owner". The delete
  and the unassign run in one batch.
- After an add, `notify(db, [userId], 'project_member_added', {projectId,
  projectName, actorId})`. Widen `Data` in `src/notifications.ts`: the
  task fields become optional and project fields are added. Its text:
  `${actor} added you to ${projectName}`.
- Responses: add returns 201 with a `Member` (`{user, role}`), the same
  shape `membersOf` returns. The role change returns the `Member`.
  Remove returns 204.
- The existing `GET /tabs/project/:id/members` is the list. It doesn't
  change.
- Tests: each 403/409/422 above, the last owner, unassigning on removal,
  and a notification on add.

### App (Tasko-Flutter)
Same shape as now: a pure `*View`, a thin `*Panel` or `*Sheet`, and
Cubits. The seam is still `TasksApi`. Every ticket is done when
`flutter analyze` and `flutter test` pass.

**B7 — Seam and models**
- `TaskTab` gains `final String? role`. Reading it from JSON is
  null-safe, so an older server still works.
- `TasksApi` gains: `createProject(int divisionId, String name,
  {String? description, DateTime? dueDate}) → TaskTab`,
  `searchUsers(String q) → List<User>`, `addMember(TaskTab project, int
  userId, {String role = 'member'}) → Member`, `setMemberRole(TaskTab
  project, int userId, String role) → Member`, and `removeMember(TaskTab
  project, int userId)`.
- Build them in `HttpTasksApi` and in `FakeTasksApi`. The fake applies the
  same owner and manager rules, so the Cubit tests exercise them.
- Rule helpers in `task_rules.dart`, with unit tests:
  `canCreateProject(TaskTab)` (division with role admin or supervisor) and
  `canManageMembers(TaskTab)` (project with role owner or
  person-in-charge).

**B8 — New project sheet**
- The account menu gets **new project**, shown only when some tab passes
  `canCreateProject`.
- The sheet copies the create-task sheet: a name field, a division chip
  (shown only when more than one division is allowed) and a due-date chip
  that reuses `DueDatePicker`.
- On success, `HomeCubit.addTab(tab)` puts the tab after the other
  projects and selects it. A server error shows as a toast, as it does
  everywhere else.

**B9 — Members screen**
- Opened from a members icon in the pinned toolbar, on project tabs only.
- `MembersCubit` loads `membersOf(tab)`. The rows look like the assignee
  picker's `_MemberRow`, with the role on the right.
- Managers see **add member**. It opens a user search picker
  (`PickerFrame`, a search field with a 300 ms debounce, current members
  hidden). Tapping a user adds them as `member`.
- Tapping a row opens a menu with the roles and **remove**. Only managers
  see it, and an owner role only appears for owners. Your own row shows
  **leave project** instead.
- Leaving removes the tab from `HomeCubit` and goes back to the first tab.
  Any other change refreshes that tab's members in `HomeCubit`, so the
  assignee picker stays correct.

**B10 — New tabs show up**
- When the notifications screen closes, `HomeCubit.reloadTabs()` runs, so
  a person who was just added sees the new project without restarting.
  Tapping a notification still only marks it read.

### Not in these tickets
Invitation links, email, accept or decline, editing or archiving a
project, and a screen for managing divisions. Add them when someone
outside the company needs to join, or when a project needs editing.

## What would change my mind
- People ask to decline being added → add a `pending` state to the
  invitation.
- Division leads say anyone from another division appearing in their
  project is a problem → limit search to the project's division.

## Open questions
- Where the members icon and **new project** go is a hipster call. They
  are not in the hifi mockups yet.

---
Part of [Tasko](../README.md)
