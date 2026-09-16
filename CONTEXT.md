# Santian

A mobile app for planning a day. The user keeps a repeating weekly Routine and
adjusts it for specific dates. One screen shows a day as a circular clockface;
another shows it as a linear list.

This file is a glossary and nothing else. No implementation details, no plans.
Product thinking lives in [docs/](./docs/README.md).

Santian here is a deliberate rethink of the model in `timez_core`. See
[decision 0001](./docs/ideas/santian/decisions/0001-rethink-the-focus-aggregate.md)
for what changed and why. Terms from that older model — `Focus`, `Schedule` —
are not current here.

## Language

**Santian**:
The product.
_Avoid_: RoutineApp, Timez, Routine. The folder on disk is still called
`RoutineApp` and the older codebase is called `timez_core`; neither is the
product's name, and "Routine" now means something specific — see below.

**Block**:
A span of time with a start and a duration, carrying one thing the user intends
to do. The core unit of the whole product. A Block is an interval, never a point
in time.
_Avoid_: task, event, entry, item, slot, session

**Routine**:
The repeating weekly plan — what a typical Tuesday looks like. Has no dates. A
Routine positions Blocks on a DayOfWeek. This is a domain term and refers to
nothing else; the repo folder name `RoutineApp` predates it and is unrelated.
_Avoid_: Pattern, Template, Schedule, Focus, week

**DayOfWeek**:
Where a Block sits inside a Routine: Tuesday, not 16 September.

**Day**:
One real calendar date. What the user actually sees and lives. A Day starts from
the Routine for its DayOfWeek and may differ from it.

**Clockface**:
The circular view of a Day, where time runs around a dial.
_Avoid_: dial, clock, radial view, wheel

**Block list**:
The linear view of a Day, where Blocks are stacked top to bottom.
_Avoid_: task list, agenda, feed

## Not yet defined

Do not invent definitions for these. They are open questions, not gaps to fill.

- **How a Day differs from its Routine.** Stored as an adjustment on top of the
  Routine, or copied out into a real Day the moment it is touched? See
  [how does a Day differ from its Routine?](./docs/ideas/santian/hacker/day-versus-routine.md).
  Nothing else can be modelled until this is answered.
- **Whether Blocks may overlap.** The older model forbade it outright. Whether
  that survives the rethink is open, and it decides whether the Clockface or the
  Block list is the source of truth. See
  [is the Clockface or the list the source of truth?](./docs/ideas/santian/hacker/clockface-or-list-source-of-truth.md).
