---
title: Deadline list-row badge and overdue styling
idea: santian
lens: hipster
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md", "../assets/santian-hifi-export.html", "../assets/exodus.css"]
tags: [artifact]
---

## Question
[Decision 0007](../decisions/0007-deadline-is-intentional-scope-beyond-google-tasks.md)
confirmed `deadline` shows on the Tasks List row and drives overdue styling,
but neither was ever drawn. What should they look like, using only what's
already in the hi-fi export and theme?

## Short answer
- **List row:** a second, smaller line under `Task Time`, same muted color,
  calendar icon + short date — not a chip. Chips are for Task Detail, where
  there's room; the list row is dense and already tight at title + time.
- **Task Detail:** the existing empty `Deadline Field` ("Add deadline",
  calendar icon) becomes, once set, a pill using the exact same shape as the
  reminder's `Date Chip` — same radius, padding, removable-X pattern. Only
  the icon differs (calendar vs. clock), which the mockup already draws.
- **Overdue:** reuse the `--destructive` token already defined in
  `exodus.css` (light and dark) but never used anywhere in the hi-fi export.
  No new color, no new component — this resolves one instance of
  [the "unused theme tokens" critique](./hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)
  instead of adding to it.

## Detail

### List row: a second muted line, not a chip
Today `Tasks List` rows are `Checkbox` + `Text Group` (`Task Title` +
`Task Time`, 12px, `#a8a29e`/`#78716c` muted, no background — see the
`Task Time` node in the export). A chip (the `Date Chip` pill treatment)
belongs to Task Detail, where each field gets its own row and room to
breathe; repeating a filled pill on every single list row, for every task
that has a deadline, would be visually loud in a list that's meant to scan
fast — the opposite of what a muted 12px time label is doing today.

So: deadline renders as a second `Task Time`-style line — 12px, same muted
color, `calendar` icon (already drawn for `Deadline Field`) at the same size
as the existing 14px feather icons, then a short date (`Sep 20`, no year,
no time — time already lives in `Task Time` above it via `reminderAt`).
Only shown when `deadline` is set; the row doesn't grow when it isn't.

### Task Detail: reuse the Date Chip shape exactly
The `Deadline Field` already exists in the mockup as an empty row —
`calendar` icon + "Add deadline" text, same layout as `Repeat` and the other
detail rows. Once a deadline is set, it should become a chip identical in
shape to the reminder's `Date Chip`: `flex-row gap-[8px] p-[6px_12px]`,
`rounded-[20px]`, same removable `x` icon. This is the same "populated field
becomes a removable chip" interaction the reminder already teaches the user
once — reusing it here means zero new interaction vocabulary, just a second
instance of one already-learned pattern.

The one difference: background color. The reminder chip uses
`bg-[#f973161a]` (orange, 10% opacity) — that accent now means "notification
time" specifically, since it's also the fill this mockup already uses for
the clock icon's implied accent. Giving the deadline chip the same orange
background would make two functionally different chips (one fires a
reminder, one is a target date) look identical at a glance. Recommend a
neutral chip background instead — the existing `--muted` token
(`exodus.css`, already used for other subtle fills) rather than introducing
a second accent color. The calendar vs. clock icon is still the primary
differentiator; the neutral background just keeps them from being
confusable at a glance.

### Overdue styling
When `isCompleted: false` and `now > deadline`:
- The deadline line (list row) and deadline chip (Task Detail) switch from
  the muted color to `var(--destructive)` — `#b91c1c` light / `#ef4444`
  dark, both already defined in `exodus.css`.
- Nothing else changes — no extra icon, no banner, no row background change.
  A color shift on the one piece of text that's actually late is enough,
  matches the restraint of the rest of this UI (the whole design so far is
  monochrome-plus-one-accent, not badge-heavy).
- The moment `isCompleted` flips to `true`, or `deadline` is cleared, the
  color reverts. No separate "was overdue" state is stored — this is a
  computed style, not a field.

## What would change my mind
Seeing this next to real task rows (once built) and finding the second line
makes rows feel cluttered — in that case, collapse `Task Time` and the
deadline line into one line separated by a middot instead of stacking them.

## Open questions
- Does the Starred view's row layout need the same second line? It shares
  the same row component per the data model note, so probably yes by
  default — not separately confirmed.

---
Part of [Santian](../README.md)
