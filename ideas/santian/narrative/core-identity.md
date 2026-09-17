---
title: The Core Identity
idea: santian
lens: intelligence
evidence: weak
created: 2026-09-17
kind: narrative
status: draft
source: claude-sonnet-5 (cowork)
updated: 2026-09-17
tags: [product-narrative]
---

# The Core Identity

> Synthesis document. Part of [The Product Narrative](./product-narrative.md).

A note on what "current" means here: the root `README.md` states the Flutter
app "does not exist yet." Santian has no running code, so there is no shipped
feature to describe. What this document can describe honestly is the **settled
product concept** — the parts of the design that have moved from open question
to adopted decision — kept clearly apart from what is still being worked out.
Section by section below, each element says what is settled and what is not.

## What makes this product what it is

### A Block: time as an interval, not a point

**What it does.** Every Block carries a start and a duration. It is the one
entity everything else in the product is built from
([CONTEXT.md](../CONTEXT.md)).

**Why it exists.** It is the direct consequence of the finding that "you cannot
draw an arc from a point"
([is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md)).
A due-date-shaped item, the Google Tasks shape, cannot be the core entity if a
dial view is going to exist at all.

**How it reflects the vision.** This is the vision's clearest technical
expression: the glossary was rewritten specifically to make "task" an
_avoided_ word ([CONTEXT.md](../CONTEXT.md)), so that nothing in the product
can quietly regress into a point-in-time model.

### The Clockface and the Block list: one day, two views

**What it does.** The Clockface draws a day as a circle, time running around a
dial. The Block list draws the same day as a stack, top to bottom
([CONTEXT.md](../CONTEXT.md)).

**Why it exists.** This pairing is present in the wireframe's very first
exploratory frame and every frame after it
([wireframe geometry spec](../hipster/wireframe-geometry-spec.md)),
which makes it the single most stable element in the whole record — the one
thing that never got rethought the way the domain model and the build order
did.

**How it reflects the vision.** It is the vision, stated as a screen. The
vault itself is not settled on which of the two views is authoritative over the
data — see [Current state](#current-state) below — but the *presence* of both
is not in question anywhere in the repository.

### Routine and Day: a repeating pattern you can still change

**What it does.** A Routine describes a typical day of a given weekday, with no
date attached. A Day is one specific date, which starts from its Routine and
may be adjusted without changing the pattern ([CONTEXT.md](../CONTEXT.md)).

**Why it exists.** [Decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)
retired the earlier `Focus` model because it could describe a typical Tuesday
and nothing else. Routine-plus-Day is the replacement shape, adopted
specifically to hold "a typical Tuesday **and** the ability to change this
particular Tuesday."

**How it reflects the vision.** It is the concrete answer to "what did the
creator want that Google Tasks does not give him": a repeating structure that
does not fight a one-off change.

**What is still open.** *How* a Day diverges from its Routine — stored as an
override, materialised as an independent copy, or a hybrid where a boundary
moves forward nightly — is unresolved
([how does a Day differ from its Routine?](../hacker/day-versus-routine.md)).
This is named in the vault as blocking further modelling work; it is a design
intention, not yet a decision.

### The Tasks module's interaction model: a deliberate Google Tasks clone

**What it does.** Compose happens in a bottom sheet; date, subtasks, and
starring are icon-driven; completion is a pill-shaped button; date entry uses a
month-grid picker — patterns lifted directly from Google Tasks
([hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)).

**Why it exists.** [Decision 0004](../decisions/0004-clone-google-tasks-interactions.md)
states this in one line: "there is no user problem with Google Tasks'
interactions that Santian is trying to solve." Inventing new interaction
patterns for this part of the app was judged not worth the effort.

**How it reflects the vision.** Indirectly, by subtraction: the decision names
its own reasoning as protecting effort for the part that *is* the point —
"the Clockface pairing and being offline-first" — rather than spending it on
reinventing a compose sheet.

## What remains experimental

- **Day-versus-Routine storage.** Override, materialise, or a hybrid boundary —
  named as options, none chosen
  ([day-versus-routine](../hacker/day-versus-routine.md)).
- **Source of truth between the Clockface and the Block list.** A concrete test
  exists to settle it — two Blocks both sitting at 14:00–15:00, and whichever
  view refuses the overlap is the source of truth — but the test has not been
  run ([clockface-or-list-source-of-truth](../hacker/clockface-or-list-source-of-truth.md)).
- **Local storage engine.** Isar or sqflite, explicitly blocked by the two
  questions above
  ([isar-or-sqflite](../hacker/isar-or-sqflite.md)).
- **The generic theme underneath the hi-fi mockup.** The hipster review notes
  the visual layer rides "an unused generic theme," separate from the
  interaction-model question decision 0004 settled
  ([hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)).

## What is no longer relevant

- **The `Focus` aggregate and pure weekly, dateless recurrence** — retired by
  [decision 0001](../decisions/0001-rethink-the-focus-aggregate.md).
  `Focus` and `Schedule` are named in the glossary as terms to avoid
  ([CONTEXT.md](../CONTEXT.md)).
- **Planning one real day at a time with no repeating pattern** — considered
  briefly alongside the `Focus` rethink and rejected in the same decision, for
  losing the work-saving repetition the product is meant to provide.
- **Positioning, pricing, and channel work for Santian** — closed by
  [decision 0003](../decisions/0003-personal-tool-not-a-product.md).
  These are not "not yet done"; they are deliberately out of scope for as long
  as that decision stands.

## Current state

There is no build to point to. What is settled, as of this writing, is a
vocabulary (Block, Routine, Day, Clockface, Block list), a rejected prior
model, a confirmed two-view pairing, and a confirmed choice to clone Google
Tasks' interactions for the Tasks module specifically. What is unsettled is
everything about how Blocks are actually stored and which view governs the
data — and that unsettled part is, by the vault's own account, "the single
place where planner apps of this shape go wrong," which is why it has not been
rushed.

---
Part of [The Product Narrative](./product-narrative.md)
