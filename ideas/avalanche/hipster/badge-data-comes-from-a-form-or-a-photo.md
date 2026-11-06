---
title: Badge data comes from a form or a photo
idea: avalanche
lens: hipster
kind: flow
status: draft
source: claude-opus-5.5 (claude-code)
evidence: none
created: 2026-10-30
updated: 2026-10-30
inputs: ["./badge-shows-only-eight-fields.md"]
tags: [artifact]
---

## Question
How does the user get a badge's data into Avalanche?

## Short answer
- Two ways in, both from the owner on 2026-10-30: type it into a form, or
  scan or photograph the real badge.
- Both ways end on the same form, filled with the
  [eight fields](./badge-shows-only-eight-fields.md), and the user checks it
  before the badge is made.
- The photo is only used to read the fields. It is not the badge, and it is
  not shared.

## Detail
The flow, as I read the owner's idea:

1. **Add badge** gives two choices: *Fill in a form* or *Scan / take a photo*.
2. **Form:** an empty form with the eight fields.
3. **Scan / photo:** the camera or gallery opens, the app reads the text it
   can, and the user lands on the same form with those fields filled in. Fields
   it can't read stay empty.
4. **Check and fix** on that form, then save. The 3D badge is drawn from the
   form's data.

The last line of the short answer, about the photo, is my addition. It keeps
the access-card worry closed: a photo of a real work card can show a barcode,
a card number or a face, and none of that is in the eight fields.

## What would change my mind
Not required for a hipster note.

## Open questions
- Should the photo's logo or background be cropped out and used as fields 6
  and 7 (logo, background image), or are those always picked by hand?
- Is the photo kept after the fields are read, or thrown away? Keeping it means
  storing a picture of a real access card.
- Is "scan" different from "photo", for example reading a QR code on an event
  badge? Then it needs its own step.
- Can reading the text work on the phone with no network? That's a hacker
  question for later.

---
Part of [Avalanche](../README.md)
