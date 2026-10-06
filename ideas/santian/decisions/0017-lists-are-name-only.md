---
title: Lists are name-only, managed from a More menu on the Tasks card
idea: santian
lens: intelligence
kind: decision
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/decisions/0012-add-list-icon-set.md", "../../../archive/santian/decisions/0013-add-list-color-palette.md", "../../../archive/santian/hipster/add-list-method.md", "../hipster/tasks-list-screen-as-built.md"]
tags: [artifact, decision]
---

## Decision

A List has a name and nothing else: no icon, no color. Lists are renamed
and deleted from a More menu on the Tasks card. This supersedes
[0012](../../../archive/santian/decisions/0012-add-list-icon-set.md) (icon set) and
[0013](../../../archive/santian/decisions/0013-add-list-color-palette.md) (color palette).

## Context

The [add-list method](../../../archive/santian/hipster/add-list-method.md) gave a List
an icon and a color. 0012 and 0013 proposed the sets for both, and #8
shipped them. In commit `3d0f44c` (2026-09-28) the owner removed both. That
change took out the model fields, the pickers, `list_icon`/`list_color`, and
the `lucide_icons_flutter` dependency. Tabs, the List Selector, and Task
Detail now show only the name. Google Tasks mobile also shows Lists by name
only.

The same commit answered the add-list method's open question, "can a List
be renamed or deleted?". Yes, both are now possible from the List options
menu. See the [Tasks List spec](../hipster/tasks-list-screen-as-built.md#list-options-menu).

## What each lens said

- **Hound:** the owner removed both after using them. That is weak
  evidence, from one real user.
- **Hipster:** removing the icon frees room in the tab bar for more Lists.
  The active List is shown by the underline and the tint, not by an icon.
- **Hacker:** one field instead of three, and one fewer dependency.
- **Hustler:** not applicable.

## Options rejected

- **Keep icon and color as optional fields.** Rejected. Nothing displays
  them now, so they would be dead data.

## How we will know we were wrong

Lists become hard to tell apart at a glance, for example many Lists with
similar names. Then color is the cheaper thing to bring back first.

---
Part of [Santian](../README.md)
