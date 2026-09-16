---
title: SCHEMA — frontmatter and naming
kind: meta
updated: 2026-09-16
---

# Schema

Everything a note must get right, in one place. If you are an AI filing a note,
this is the file to follow literally. `scripts/build_index.py` reads these
fields, so a typo here means the note disappears from `INDEX.md`.

## Where the file goes

| The note is about | Path |
|---|---|
| A specific idea, seen through one lens | `docs/ideas/<idea>/<lens>/<name>.md` |
| A choice that was made | `docs/ideas/<idea>/decisions/<name>.md` |
| The idea as a whole | `docs/ideas/<idea>/README.md` (the anchor — one per idea) |
| How to think, not what to build | `docs/lenses/<lens>.md` |
| Somebody else's work | `docs/library/<name>.md` |
| Not placeable yet | `docs/inbox/<name>.md` |
| An image or export | `docs/ideas/<idea>/assets/` (no text notes here) |

`<lens>` is one of: `hound`, `hipster`, `hacker`, `hustler`. There is no
`intelligence/` folder — intelligence output is a decision, so it goes in
`decisions/`.

## Naming files

- **kebab-case, lowercase, no spaces.** `radial-clock-reduces-friction.md`, not
  `Radial Clock Reduces Friction.md`. The repo will hold code, and spaces in
  paths break shell commands and scripts.
- **Name it after the claim, not the topic.** `isar-beats-sqflite-for-this.md`
  beats `database.md`. You should be able to read the folder listing and know
  what was decided.
- **Date prefix only for things that repeat:** `2026-09-16-digest.md`,
  `2026-09-16-interview-rina.md`. Format is always `YYYY-MM-DD-`.
- The human-readable title lives in the `title` frontmatter field. It can have
  capitals and spaces. The filename does not.

## Frontmatter

Every note under `ideas/` and `library/` starts with this block. Copy it from
`templates/artifact.md`.

```yaml
---
title: Google Tasks UX playbook        # human title, free text
idea: santian                      # folder name under ideas/
lens: hipster                          # see below
kind: critique                         # see below
status: draft                          # see below
source: gemini-2.5-pro (browser)       # see below
evidence: none                         # none | weak | strong
created: 2026-09-16                    # YYYY-MM-DD, never changes
updated: 2026-09-16                    # YYYY-MM-DD, bump on every edit
inputs: ["../assets/santian-wireframe-snapshot.png"]   # relative paths, may be []
tags: [artifact]
---
```

### `lens`

`hound` | `hipster` | `hacker` | `hustler` | `intelligence`

One value. Never two. If it feels like two, it is two notes.

### `status` — about the owner, not the model

| value | means |
|---|---|
| `draft` | Written, not properly read by the owner yet. Every new note starts here. |
| `reviewed` | The owner read it and it is not wrong. |
| `adopted` | The owner is building on it. |
| `superseded` | A newer artifact replaced it. Link to the new one. File lives in `archive/`. |
| `rejected` | Decided against, kept so the same dead end is not rediscovered. |

An AI may only ever write `draft`. Promotion is the owner's job.

### `source` — who produced this

Name the model **and** the surface, or the human origin:

- `me` — the owner wrote it himself
- `claude-opus-5 (cowork)`, `gemini-2.5-pro (browser)`, `gpt-5 (chatgpt)`
- `interview` — a real conversation with a real person
- `article` — an external piece, with the `url` field filled in
- `unknown (pasted by owner)` — origin genuinely not known. Never guess.

### `evidence` — the honest label

| value | means |
|---|---|
| `none` | A model produced this from nothing. Most first drafts. |
| `weak` | Based on one user, one competitor, or the owner's memory. |
| `strong` | Based on real users, real numbers, or shipped behaviour. |

A hound artifact with `evidence: none` is not research. It is a hypothesis
wearing a lab coat — pretending to be more certain than it is. Label it honestly.

### `kind`

| kind | what it is | usual lens |
|---|---|---|
| `brief` | the anchor note for an idea | intelligence |
| `question` | one open question, waiting for an answer | any |
| `interview` | notes from a real person | hound |
| `insight` | a pattern found across evidence | hound |
| `jtbd` | a job-to-be-done statement | hound |
| `flow` | a user flow or journey | hipster |
| `wireframe` | a screen sketch or its description | hipster |
| `critique` | a review of an existing design | hipster |
| `spec` | what to build, precisely | hipster / hacker |
| `spike` | a small technical experiment and what it proved | hacker |
| `architecture` | how the system is shaped | hacker |
| `data-model` | entities and their relationships | hacker |
| `risk` | something that could kill the idea | hacker / hustler |
| `positioning` | who it is for and why they would pay | hustler |
| `pricing` | how money comes in | hustler |
| `channel` | how people find it | hustler |
| `teardown` | a competitor pulled apart | hustler |
| `decision` | a choice made, with the reason | intelligence |
| `digest` | a weekly roll-up of what changed | intelligence |
| `analysis` | catch-all when nothing above fits | any |
| `meta` | a file about the vault itself | none |

### Optional fields

- `url:` — required when `source: article`.
- `supersedes:` / `superseded_by:` — relative path to the other note.
- `aliases:` — other titles this note has been called.

## Linking

Plain Markdown relative links, not `[[wiki links]]`. This folder is read on
GitHub and by tools that do not understand Obsidian syntax.

```markdown
Part of [Santian](../README.md)
See also [the wireframe spec](../hipster/wireframe-geometry-spec.md)
![Wireframe snapshot](../assets/santian-wireframe-snapshot.png)
```

Every artifact ends with a `Part of [<Idea>](../README.md)` line.

## After you write

1. Add the note to the **Artifacts** list in `docs/ideas/<idea>/README.md`.
2. Update **Status by lens** in that anchor note if the lens moved forward.
3. Run `python3 docs/scripts/build_index.py` from the repo root.
