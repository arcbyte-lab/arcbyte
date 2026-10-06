---
title: Theme tokens, as built — colors, fonts, tracking, radii, the one shadow
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: strong
created: 2026-10-06
updated: 2026-10-06
inputs: ["../../../archive/santian/hacker/exodus-theme-to-flutter.md", "../decisions/0011-blue-by-day-orange-by-night.md", "../assets/exodus.css"]
tags: [artifact]
---

## Question
Which visual tokens does the app actually use today? Several changed after
the exodus.css mapping note.

## Short answer
- The primary color is blue `#0284C7` in light mode and orange `#F97316`
  in dark mode ([0011](../decisions/0011-blue-by-day-orange-by-night.md)).
  There are two extra tokens: `muted` and `mutedForeground`.
- Fonts are Inter for content and DM Sans for titles and buttons, with
  **−0.8 letter spacing on every text style** (`77b1991`).
- Radii were reduced from the mockup: sheet 58 → **28** (`77b1991`) and
  FAB 26 → **15** (`90a7d98`). Dialogs use **24**.

## Detail

Code: `lib/core/theme/`.

### Colors
| role | light | dark |
|---|---|---|
| `primary` / `onPrimary` | `#0284C7` / `#FFFFFF` | `#F97316` / `#0C0A09` |
| `surface` (cards, sheets, dialogs) | `#FFFFFF` | `#0C0A09` |
| `background` (scaffold) | `#F5F5F4` | `#1C1917` |
| `onSurface` | `#1C1917` | `#FAFAF9` |
| `error` / `onError` | `#B91C1C` / `#FFFFFF` | `#EF4444` / `#FAFAF9` |
| `outline` (checkbox rings, dividers) | `#E7E5E4` | `#44403C` |
| `muted` (deadline chip, done pill) | `#E7E5E4` | `#292524` |
| `mutedForeground` (secondary text, icons) | `#57534E` | `#A8A29E` |

In dark mode, `surface` and `background` are **swapped** compared with the
old mapping note: the card is the darker one (`b6f92b5` aligned the tests
to this). The light and dark schemes are written by hand, not generated
from one seed color.

### Type
- Default family: **Inter**. Used for task titles, descriptions, times and
  hints.
- **DM Sans:** `titleLarge` (the "Tasks" label), `labelLarge` (button
  labels), Task Detail's title (bold 24), the Create List name (bold 22),
  and dialog headers (semibold 16).
- Every text-theme style gets `letterSpacing: -0.8`.
- Sizes used: 24 / 22 / 16 / 15 / 14 / 13 / 12.

### Radii (`AppRadius`)
| token | value | used by |
|---|---|---|
| `sheet` | 28 | bottom sheets, the Tasks card |
| `dialog` | 24 | reminder, deadline and Repeat dialogs |
| `chip` | 20 | reminder and deadline chips |
| `fab` | 15 | the FAB |
| `actionPill` | 14 | defined, but unused since the compose circle was removed |
| `pill` | 100 | Mark completed |

### Shadow and dims
- **FAB only:** `0 4 16 #00000025`.
- **Modal dims:** create sheets and the List selector use `#00000040`.
  Task Detail uses `#00000080`.

### Not ported
`--secondary`, `--accent`, `--chart-*`, `--sidebar-*`, the serif and mono
fonts, and the `--radius` scale are all unused, as the old note found.

## What would change my mind
- The −0.8 tracking hurts readability at 12 px on a real screen.

## Open questions
- `AppRadius.actionPill` is unused now. Remove it in code.

---
Part of [Santian](../README.md)
