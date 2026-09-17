# Arcbyte

A thinking space for product ideas, organised around five lenses.

This file is a glossary and nothing else. It defines the words Arcbyte uses
about itself — idea, project, artifact, lens. It says nothing about any
particular product. Each idea keeps its own glossary at
`ideas/<idea>/CONTEXT.md`; Santian's is
[here](./ideas/santian/CONTEXT.md).

Field values and file naming are in [SCHEMA.md](./SCHEMA.md). How to behave in
here is in [AGENTS.md](./AGENTS.md).

## Language

**Arcbyte**:
This whole space. Not a product, not a company, not a codebase. The place where
ideas are collected and thought about.
_Avoid_: vault, workspace, repo, org

**Idea**:
One product thought, with a folder of its own under `ideas/`. An idea exists the
moment it has an anchor note. It does not need to be good, funded, or started.
_Avoid_: concept, initiative, venture

**Project**:
An idea someone has started building. It is not a different folder or a
different kind of thing — it is an idea whose `stage` is `project` and whose
code lives somewhere else. Promotion is a decision, and gets a note in
`decisions/`.
_Avoid_: product, app, build

**Stage**:
Where an idea stands: `idea` (thinking only), `project` (being built), `parked`
(stopped, kept). Lives in the anchor note's frontmatter. One value.
_Avoid_: status — `status` is about a single note, not the idea. The two words
are not interchangeable here.

**Artifact**:
Any note in here that says something about an idea. Every artifact declares
where it came from (`source`) and how much evidence is behind it (`evidence`).
A model's guess and a real user's words are both artifacts, and the frontmatter
is what keeps them apart.
_Avoid_: doc, note, output, deliverable

**Lens**:
One of five ways of looking at an idea: **hound** (what is true about the user),
**hipster** (what it feels like), **hacker** (how it is built), **hustler** (who
pays and how they find it), **intelligence** (weighing the four and choosing).
An artifact has exactly one lens. Four of them are also folders inside an idea;
intelligence is not, because its output is a decision.
_Avoid_: hat, role, perspective, discipline

**Anchor note**:
`ideas/<idea>/README.md`. The hub for one idea, and the only note in the whole
space that must stay current. Everything else is allowed to go stale.
_Avoid_: index, overview, main note

**Decision**:
A choice that was made, with the reason attached, numbered and dated in
`ideas/<idea>/decisions/`. A decision is intelligence output. It outlives the
notes that fed it.
_Avoid_: ADR, RFC, conclusion

**Narrative**:
Long-form synthesis of one idea as a whole, in `ideas/<idea>/narrative/`.
Written from artifacts, never in place of them. Optional, and most ideas will
never need one.
_Avoid_: story, whitepaper, pitch

**Library**:
Somebody else's work, kept whole: articles, competitor docs, quotes. Shared
across ideas, which is why it sits at the root and not inside one.
_Avoid_: references, resources, reading

**Inbox**:
Raw input dropped in without filing it. A holding pen, emptied weekly, not a
folder anything lives in.

**Archive**:
Where superseded and rejected artifacts go. Nothing is ever deleted here; it is
moved and marked, so the same dead end is not rediscovered later.

## Not yet defined

Do not invent definitions for these. They are open questions, not gaps to fill.

- **What happens to an idea's thinking once its code exists.** Arcbyte keeps
  the thinking and the code repo keeps the code, but nothing says which one owns
  a domain model once both are real, or how they are kept from drifting apart.
- **Whether two ideas can share an artifact.** Today every artifact belongs to
  exactly one idea, and anything shared gets copied into `library/`. That has
  not been tested with a second idea, because there is not one yet.
