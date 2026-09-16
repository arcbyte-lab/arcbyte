---
title: Vault Guide
tags: [meta]
updated: 2026-09-16
---

# Vault Guide

This vault is a thinking space for product ideas. It uses the four start-up
skill sets from Sergio Marrero's article "The 4 Start-Up Team Skill Sets" as
**lenses**: hound (research), hipster (design), hacker (build), hustler
(money and distribution). A fifth lens, **intelligence**, is not from the
article — it is the synthesis layer where the four lenses meet and a decision
gets made.

Most notes here are **artifacts**: things produced by me or by an AI model
(ChatGPT, Gemini, Claude, a local model, anything). Every artifact must say
where it came from, so the vault stays honest about what is evidence and what
is just a machine's guess.

## Folder map

```
00-meta/        How this vault works. Start here. Includes AGENTS.md.
01-lenses/      One note per lens. What it owns, what to ask it, open questions.
02-ideas/       One folder per idea. The real work lives here.
03-inbox/       Raw dumps not filed yet. Should be empty most of the time.
04-library/     External sources: articles, docs, competitor notes, quotes.
05-templates/   Templates for new notes.
99-archive/     Dead ideas and superseded artifacts. Never delete, move here.
```

Inside one idea:

```
02-ideas/routine-app/
  routine-app.md      Anchor note (the hub). Always start and end here.
  hound/              User research, interviews, evidence, opportunity areas.
  hipster/            Wireframes, flows, UI critiques, copy and tone.
  hacker/             Architecture, data model, spikes, feasibility notes.
  hustler/            Positioning, pricing, channels, competitor teardowns.
  decisions/          One note per decision. Short. Dated. Links to its inputs.
  assets/             Images, screenshots, exports. No text notes here.
```

## The two rules that matter

1. **Every artifact declares its source and its status.** Without this, in three
   months you cannot tell a user quote from a model's invention.
2. **Every artifact links up to the idea anchor note.** The anchor note is the
   only place that must stay current. Everything else is allowed to go stale.

## Frontmatter

Copy this from `05-templates/artifact.md`.

```yaml
---
title: UI Wireframe Analysis of Routine App
idea: routine-app          # folder name under 02-ideas/
lens: hipster              # hound | hipster | hacker | hustler | intelligence
kind: analysis             # see the kind list below
status: draft              # draft | reviewed | adopted | superseded | rejected
source: gemini-2.5-pro (browser)   # or: me | claude-opus-5 | interview | article
evidence: none             # none | weak | strong  -- see below
created: 2026-09-16
updated: 2026-09-16
inputs: ["[[Snapshot-routine-wireframe.png]]"]
tags: [artifact]
---
```

**status** is about you, not the model. `draft` means the model made it and you
have not read it properly yet. `reviewed` means you read it and it is not wrong.
`adopted` means you are building on it. `superseded` means a newer artifact
replaced it (link to the new one). `rejected` means you decided against it, and
you keep it so you do not rediscover the same dead end later.

**evidence** is the honest label:

- `none` — a model produced this from nothing. Most first drafts.
- `weak` — based on one user, one competitor, or your own memory.
- `strong` — based on real users, real numbers, or shipped behaviour.

A hound artifact with `evidence: none` is not research. It is a hypothesis
wearing a lab coat (pretending to be more certain than it is). Label it honestly.

## Artifact kinds

| kind | what it is |
|---|---|
| `brief` | the anchor note for an idea |
| `question` | one open question, waiting for an answer |
| `interview` | notes from a real person |
| `insight` | a pattern found across evidence |
| `jtbd` | a job-to-be-done statement |
| `flow` | a user flow or journey |
| `wireframe` | a screen sketch or its description |
| `critique` | a review of an existing design |
| `spec` | what to build, precisely |
| `spike` | a small technical experiment and what it proved |
| `architecture` | how the system is shaped |
| `data-model` | entities and their relationships |
| `risk` | something that could kill the idea |
| `positioning` | who it is for and why they would pay |
| `pricing` | how money comes in |
| `channel` | how people find it |
| `teardown` | a competitor pulled apart |
| `decision` | a choice made, with the reason |
| `digest` | a weekly roll-up of what changed |
| `analysis` | catch-all when nothing above fits |

## Naming

Use plain human titles: `Radial clock reduces planning friction.md`. Obsidian
links read better that way. Only use a date prefix for things that repeat:
`2026-09-16 digest.md`, `2026-09-16 interview - Rina.md`.

## Where does a new note go?

1. Is it about a specific idea? → `02-ideas/<idea>/<lens>/`
2. Is it a choice you made? → `02-ideas/<idea>/decisions/`
3. Is it about how to think, not what to build? → `01-lenses/`
4. Is it somebody else's work? → `04-library/`
5. Don't know yet? → `03-inbox/` and file it within a week.

## Weekly pass (15 minutes)

Empty `03-inbox/`. Move every `draft` you actually read to `reviewed` or
`rejected`. Update the anchor note of any idea you touched. Write one `digest`
note. That is it.
