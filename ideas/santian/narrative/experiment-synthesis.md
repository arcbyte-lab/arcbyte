---
title: The Experiment
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

# The Experiment

> Synthesis document. Part of [The Product Narrative](./product-narrative.md).
> See [The Vision](./vision.md) for what the project started from.

Santian has no shipped code yet — the root `README.md` states plainly that "the
app code does not exist yet." Everything below is the record of a project
working out its own shape before writing a line of Flutter, through a sequence
of named experiments, discarded models, and decisions written down with the
reason attached. This is what was tried, what was learned, what changed, and
what stayed.

## What was tried

### 1. A purely repeating domain model (`timez_core` / `Focus`)

The earliest modelling attempt, from before this vault existed, made `Focus`
the aggregate root with weekly, dateless recurrence: a `TimeBlock` value object
ordered by `start_at`, no overlapping blocks, and a stateless `OverlapChecker`
([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
This was a locked, "tested" model at the time.

### 2. A wireframe that deliberately drew almost nothing

The first design artifact is a Penpot export reduced to a
[geometry spec](../hipster/wireframe-geometry-spec.md): frame
sizes, corner radii, two tab labels (`Clockface`, `Tasks`), and blank white
panels. The spec is explicit that this is on purpose — "the `.pen` source is
intentionally sparse... do not add those elements when reconstructing the
wireframe unless a later design artifact explicitly introduces them." The
experiment here was structural, not visual: confirm the two-view shell before
drawing anything inside it.

### 3. A pasted, unvetted architecture answer

A language model's answer describing a generic offline Flutter task app —
BLoC/Cubit, Isar or sqflite, a `Task(ID, Title, Notes, DueDate, IsCompleted)`
model — was filed whole, without editing its argument, as
[offline task module architecture](../hacker/offline-task-module-architecture.md),
tagged `evidence: none` by the vault's own convention. It was kept on record as
a first draft to react to, not as an accepted plan.

### 4. A high-fidelity mockup of the Tasks side

A full hi-fi export — 8 screens, light and dark, with real task rows, a
bottom-sheet compose flow, a task-detail sheet, and a month-grid date picker —
was produced and reviewed in
[hi-fi mockup is a Google Tasks clone riding an unused generic theme](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md).

## What was learned

### The pasted Task model and the Clockface contradict each other

Laying the architecture note next to the wireframe surfaced a conflict neither
one noticed on its own: the pasted `Task` model uses a `DueDate`, which is a
single point in time, but the Clockface wireframe needs to draw a wedge on a
dial, which needs a start **and** a duration — an interval
([is the Clockface or the list the source of truth?](../hacker/clockface-or-list-source-of-truth.md)).
"You cannot draw an arc from a point." This is the most consequential thing the
experimentation phase produced: it invalidated the model's most Google-Tasks-
like assumption before any code was written on top of it.

### The `Focus` model could not express "this Tuesday only"

The `timez_core` model could describe a typical Tuesday and nothing else. It
had no way to represent a one-off change to a single date without changing
every occurrence of that weekday
([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
This is what ended that model.

### The hi-fi mockup is a Google Tasks clone, named honestly

The review of the hi-fi export found that "every interaction pattern... matches
[the Google Tasks playbook] closely enough that a screenshot side-by-side would
need labels to tell them apart," while noting the rest of the execution —
corner radii, spacing, the `DM Sans` type, the two-panel shell — was
internally consistent
([hi-fi mockup review](../hipster/hifi-mockup-is-a-google-tasks-clone-with-unused-theme-tokens.md)).
The review's contribution was not a verdict on quality; it was making an
unnamed choice visible so it could be decided on purpose instead of drifting.

### Hound work never happened, and the vault says so

[Who plans their day by the clock?](../hound/who-plans-their-day-by-the-clock.md)
is on file, unanswered, since the idea's first day. No interview, no
observation, no analytics number backs the core premise that people think
about their day as time on a dial rather than as a list. This has not changed
during the experimentation recorded here. It is a hypothesis the project is
still carrying, not a finding it has closed.

## What changed

- **The domain model.** `Focus` (pure weekly recurrence) was retired. Santian's
  glossary now separates **Routine** (the repeating, dateless pattern) from
  **Day** (one real date that may diverge from it) — see
  [CONTEXT.md](../CONTEXT.md) — though *how* a Day diverges from its Routine
  (an override on top of the Routine, a materialised copy, or a hybrid that
  moves a boundary forward each night) is still an open question, named in
  [how does a Day differ from its Routine?](../hacker/day-versus-routine.md)
  and explicitly called "the single place where planner apps of this shape go
  wrong."
- **The scope.** The project stopped being evaluated as a product for
  strangers. [Decision 0003](../decisions/0003-personal-tool-not-a-product.md)
  closed the hustler lens for this idea almost entirely — no pricing, no
  channel, no positioning — because the honest answer to "why would anyone
  switch from Google Tasks" was that nobody needs to; it is being built for the
  owner.
- **The build order.** [Decision 0002](../decisions/0002-build-tasks-before-clockface.md)
  chose to build the Tasks module before the Clockface, even though the
  Clockface is the part the vault itself identifies as the actual
  differentiator. This was a conscious, named trade-off, not an oversight — the
  decision records its own falsification test: if the Tasks module ships and
  the owner still can't say why anyone would switch from Google Tasks, "building
  Tasks first bought nothing."
- **The interaction design of the Tasks module.** What started as an
  unexamined resemblance to Google Tasks became a stated choice —
  [decision 0004](../decisions/0004-clone-google-tasks-interactions.md) —
  to clone Google Tasks' interaction model on purpose and spend design effort
  on the Clockface pairing instead, which the decision calls "the reason
  Santian exists."

## What remained

- The name for the core entity, **Block**, and its definition as an interval —
  unchanged since the glossary rewrite, and the one piece of vocabulary every
  other artifact in the vault, including the ones written before the rename,
  points back to.
- The two-view pairing — Clockface and Block list, or Clockface and Tasks in
  the earlier vocabulary — present in the very first wireframe frame and in the
  most recent hi-fi mockup alike.
- The discipline of naming a question instead of guessing an answer. Every
  major unresolved point in the vault — Day-versus-Routine storage, source of
  truth between the two views, Isar-versus-sqflite — is written down as an open
  question with a stated blocking relationship to the others, rather than
  silently decided.

---
Part of [The Product Narrative](./product-narrative.md)
