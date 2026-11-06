---
title: The badge shows only eight fields
idea: avalanche
lens: hipster
kind: spec
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-30
updated: 2026-10-30
inputs: ["../../../library/vercel-interactive-3d-event-badge.md"]
tags: [artifact]
---

## Question
What data does an Avalanche badge show?

## Short answer
- Any kind of badge, for example an event badge or a work access card, shows
  the same eight fields and nothing else.
- The field list is the owner's, given in chat on 2026-10-30. I only wrote it down.
- It has no barcode, QR code, card number or photo, so a shared badge doesn't
  expose what a reader or scanner would check.

## Detail
The owner's list, in the owner's order:

| # | Field | Example |
|---|---|---|
| 1 | Active date / event date | |
| 2 | Timezone | |
| 3 | Province + nation | |
| 4 | User name | |
| 5 | Involvement role | attendee, senior software engineer |
| 6 | Logo or icon | |
| 7 | Background image | |
| 8 | Address of the event or office | |

The look follows the [Vercel 3D event badge](../../../library/vercel-interactive-3d-event-badge.md).

## What would change my mind
Not required for a hipster note.

## Open questions
- "Active date" for a work card: is that one date (start date), a range, or
  "valid until"? An event can also last more than one day.
- Is the timezone typed in, or worked out from province + nation? Some countries
  have more than one timezone.
- Is the logo or icon the event's or company's logo, or one the user picks? A
  real company logo on a shared image is a branding question.
- Is the full office address fine to share in public, or should a work card
  only show the city?

---
Part of [Avalanche](../README.md)
