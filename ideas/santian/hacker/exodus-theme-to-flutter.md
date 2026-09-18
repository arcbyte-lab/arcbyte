---
title: exodus.css → Flutter ThemeData — what maps, what's dead
idea: santian
lens: hacker
kind: spec
status: draft
source: claude-sonnet-5 (cowork)
evidence: none
created: 2026-09-18
updated: 2026-09-18
inputs: ["../assets/exodus.css", "../assets/tailwind.config.ts", "../assets/santian-hifi-export.html", "../decisions/0011-blue-by-day-orange-by-night.md", "../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md", "../hipster/deadline-badge-and-overdue-styling.md"]
tags: [artifact]
---

## Question
`exodus.css` defines a full shadcn-style token set (colors, radius, shadows,
three font families, chart colors, a whole sidebar palette). The hi-fi
export only actually *uses* a fraction of it. What maps cleanly to Flutter's
`ThemeData`, and what should be left behind rather than dutifully ported?

## Short answer
- Two independently authored `ColorScheme`s (light, dark) — per
  [decision 0011](../decisions/0011-blue-by-day-orange-by-night.md), light's
  `primary` is blue, dark's is orange, not one seed color varied by
  brightness.
- **Confirmed dead, checked against actual usage in the export, not
  guessed:** `--secondary` (0 uses anywhere), `--accent` (0 uses of its real
  hex in either mode — dark mode's 51 hits on that hex are actually
  `--border`/`--input` sharing the same value by coincidence, not `--accent`
  being used), `--chart-1..5`, every `--sidebar-*` token, `--font-serif`,
  `--font-mono`. None of these need a Flutter equivalent.
- Two real font families **are** used, and consistently: **DM Sans** for
  nav labels, titles, and buttons (45 uses); **Inter** for everything else —
  body text, task titles, placeholders (552 uses). Worth two
  `TextTheme` font families, not one.
- Every real corner radius in the export (58, 73, 100, 20, 14, 26px) is a
  hand-picked value with **no relationship to `--radius` (8px)** or its
  `calc()`-derived scale. Recommend named Flutter constants instead of
  trying to force them through Material's radius scale.

## Detail

### ColorScheme
```dart
final lightColorScheme = ColorScheme.light(
  background: Color(0xFFF5F5F4),   // --background
  onBackground: Color(0xFF1C1917), // --foreground
  surface: Color(0xFFFFFFFF),       // --card / --popover (identical)
  onSurface: Color(0xFF1C1917),     // --card-foreground / --popover-foreground
  primary: Color(0xFF0284C7),       // --primary — see decision 0011
  onPrimary: Color(0xFFFFFFFF),     // --primary-foreground
  error: Color(0xFFB91C1C),         // --destructive, per the overdue-styling spec
  onError: Color(0xFFFFFFFF),       // --destructive-foreground
  outline: Color(0xFFE7E5E4),       // --border / --input (identical in light)
);

final darkColorScheme = ColorScheme.dark(
  background: Color(0xFF0C0A09),
  onBackground: Color(0xFFFAFAF9),
  surface: Color(0xFF1C1917),
  onSurface: Color(0xFFFAFAF9),
  primary: Color(0xFFF97316),       // decision 0011 — orange, not blue
  onPrimary: Color(0xFF0C0A09),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFAFAF9),
  outline: Color(0xFF44403C),
);
```
`muted`/`muted-foreground` (`#e7e5e4`/`#57534e` light,
`#292524`/`#a8a29e` dark) don't map to a Material `ColorScheme` role
directly — Material has no "muted" concept. Recommend keeping them as two
named constants (`AppColors.muted`, `AppColors.mutedForeground`, per
brightness) used directly where the mockup uses them: `Task Time` text, the
`Count Badge` fill, `Checkbox` outlines, empty-field placeholders (`Add
deadline`, `Add subtasks`).

**`--ring`** (`#0284c7` light / `#f97316` dark) is worth naming explicitly:
it's **identical to `--primary`** in both modes — not a distinct value.
Nothing in the export shows a focus state (it's a static mockup), but this
confirms Flutter's focus/ring color can just reuse `ColorScheme.primary`
directly rather than needing its own token.

### Confirmed-dead tokens
Checked against the actual export, not assumed:
- **`--secondary`** (`#b45309` light / `#7f1d1d` dark) — zero uses anywhere
  in either mode. [The hi-fi critique](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)
  already flagged this app as "monochrome-plus-one-accent"; this confirms
  it precisely — there's no second UI color at all, just primary plus
  muted plus destructive.
- **`--accent`** (`#d6d3d1` light / `#44403c` dark) — the *light* hex has
  zero uses anywhere. The *dark* hex (`#44403c`) does appear 51 times, but
  those are all `Checkbox` outlines and borders — which is
  `--border`/`--input`'s value in dark mode, not `--accent`, they're just
  coincidentally identical hex values. `--accent` as its own semantic role
  is unused in both modes.
- **`--chart-1` through `--chart-5`**, every **`--sidebar-*`** token — this
  is leftover surface from whatever dashboard/admin starter template
  `exodus.css` was generated from. Santian has no chart and no sidebar.
- **`--font-serif`** (Playfair Display), **`--font-mono`** (Fira Code) —
  zero uses. Only `--font-sans` (DM Sans) is referenced by the CSS, and even
  that's incomplete — see fonts below.

### Fonts: two families, not one
`--font-sans` names DM Sans as *the* sans font, but the export actually uses
**two** families with a consistent split:
- **DM Sans** (45 uses) — `Clockface`/`Tasks` nav labels, the active
  `List Tab Bar` tab label, `Task Title` in Task Detail (24px bold),
  `Create Task` sheet title, `Cancel`/`Done`/`Mark Completed` button text.
  Chrome and actions.
- **Inter** (552 uses, the overwhelming majority) — task row titles and
  times, descriptions, placeholders, list names, everything else.

Recommend two Flutter `TextStyle` families rather than defaulting
`ThemeData.fontFamily` to DM Sans and special-casing Inter everywhere (or
the reverse) — e.g. `textTheme.titleLarge`/`labelLarge` (DM Sans, for the
chrome/action roles above) and `textTheme.bodyMedium`/`bodySmall` (Inter,
for everything else), matching Material's own role split reasonably well.

### Corner radii: hand-picked, not derived from `--radius`
`--radius: 0.5rem` (8px) and its `calc()`-derived `xl`/`lg`/`md`/`sm` scale
in `tailwind.config.ts` are never actually used — every real radius in the
export is its own value: `58px` (the two main panels, all bottom sheets),
`73px` (the outer device frame — not an app UI element, just the mockup's
phone chrome, irrelevant to the real app), `100px` (`Mark Completed` pill),
`20px` (the reminder `Date Chip`), `14px` (dark mode's smaller `Date` pill
variant in Create Task), `26px` (the `FAB`). **Recommendation:** define
these as named constants (`AppRadius.sheet = 58`, `AppRadius.pill = 100`,
`AppRadius.chip = 20`, `AppRadius.fab = 26`) rather than trying to map them
onto Material's `borderRadius` scale, which was built for a different,
smaller set of numbers that don't match anything actually drawn here.

### Shadows: one real value, not the `--shadow-*` scale
Only one shadow appears anywhere in the export — the `FAB`'s:
`0px 4px 16px 0px #00000025` (16px blur, ~14.5% opacity). It doesn't
exactly match any of `exodus.css`'s eight `--shadow-*` tokens (the closest,
`--shadow-md`, is `10px` blur at `10%` opacity plus a second shadow layer —
different enough that "close" isn't "the same"). **Recommendation:** define
this one shadow as its own `BoxShadow` constant matching the drawn value
exactly, rather than reusing an approximate `--shadow-*` token that would
quietly change the FAB's actual appearance.

## What would change my mind
If a screen not yet built (Clockface, eventually) turns out to need
`--secondary` or one of the chart tokens after all — that's new information
this note didn't have, not a sign the "confirmed dead" findings above were
wrong for the Tasks module.

## Open questions
- None left open on what maps vs. what's dead — that's checked against
  actual usage counts, not guessed. The named-constant recommendations
  (radii, the one shadow, muted/ring) are proposals the owner hasn't
  explicitly signed off on individually, though decision 0011 settles the
  one genuinely contested piece (the primary color split).

---
Part of [Santian](../README.md)
