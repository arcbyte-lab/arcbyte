---
title: AGENTS — the filing contract
kind: meta
updated: 2026-09-17
---

# How an AI works in Arcbyte

Read this before creating or editing any note. [README.md](./README.md) has the
folder map, [CONTEXT.md](./CONTEXT.md) defines every word used here, and
[SCHEMA.md](./SCHEMA.md) has the exact field values. This file is the working
contract.

Arcbyte holds thinking, not code. One folder per idea under `ideas/`. An idea
being built is a **project** — same folder, `stage: project` in its anchor note,
code in its own repository. Nothing about that changes how you file.

## Your job

Act as **one lens at a time**. If the request does not name a lens, either ask
which one, or say plainly which one you are using and why. Do not write a note
that silently mixes research, design, architecture and pricing — that is the
exact mess this place is built to prevent.

The owner is one developer playing all four roles, so the lenses exist to stop
him thinking about everything at once.

## Hard rules

1. **Never invent evidence.** If you did not get it from a real source in the
   conversation, set `evidence: none` and write it as a hypothesis. Do not write
   "users say…" or "research shows…" unless a real input says so.
2. **Always fill the frontmatter.** `source` must name the model and the surface,
   for example `claude-opus-5 (cowork)`. If you are writing the note, `source` is
   you, not the owner.
3. **New artifacts start at `status: draft`.** Only the owner promotes a note to
   `reviewed` or `adopted`. Never do that yourself.
4. **Never edit another lens's note.** If a hacker note contradicts a hipster
   note, write your own and link to the other one. Contradictions are
   information; do not smooth them over.
5. **Never delete.** Move the file to `archive/` and set `status: superseded`
   with a link to whatever replaced it.
6. **Link both ways.** Every new note links to its idea's anchor note, and you
   add the note to the anchor's **Artifacts** list in the same turn.
7. **Keep notes short.** One artifact answers one question. Past roughly one
   screen of text, split it.
8. **Rebuild the index** after adding or renaming a note:
   `python3 scripts/build_index.py`.
9. **Never change an idea's `stage`.** Promoting an idea to a project is the
   owner's call and needs a decision note. You may propose it; you may not do it.

## Where your output goes

| You produced | Put it in |
|---|---|
| A note about a specific idea | `ideas/<idea>/<lens>/` |
| A choice that was made | `ideas/<idea>/decisions/` |
| Vocabulary for one idea | `ideas/<idea>/CONTEXT.md` |
| Long-form synthesis of one idea | `ideas/<idea>/narrative/` |
| Vocabulary for Arcbyte itself | `CONTEXT.md` at the root |
| Guidance about how to think, not what to build | `lenses/` |
| Somebody else's work (article, competitor, docs) | `library/` |
| Something you cannot place yet | `inbox/` |
| Code | not here. It lives in the idea's own repository. |

## Note shape

Copy the frontmatter block from `templates/artifact.md`, then:

```markdown
## Question
The single question this note answers.

## Short answer
Three bullets, maximum. Someone should get the point in 20 seconds.

## Detail
The body.

## What would change my mind
What evidence would make this note wrong. Required for hound and hustler notes.

## Open questions
Each one as a bullet. Promote the important ones into their own `question` note
in the right lens folder.
```

## Choosing the lens

- Is it about **what the user actually wants and what is true**? → hound
- Is it about **what the thing looks and feels like**? → hipster
- Is it about **how it gets built and whether it is feasible**? → hacker
- Is it about **who pays, how they find it, whether it is a business**? → hustler
- Is it **weighing the four against each other and choosing**? → intelligence,
  and it probably belongs in `ideas/<idea>/decisions/` instead.

If a single piece of input covers two lenses — very common with a long model
answer — **split it into two artifacts** and have each one link to the other.
Do not file a mixed note.

## When the owner pastes output from another model

He will paste raw text from ChatGPT, Gemini, or a local model. Your job is to
file it, not to rewrite it:

1. Ask which model and surface it came from, if he did not say. Put that in
   `source`. If he never answers, write `source: unknown (pasted by owner)` —
   never guess a model name.
2. Keep the original wording in the body, under `## Detail`. You may cut filler,
   but do not improve the argument — then it stops being that model's artifact.
3. Add the frontmatter, the `## Question` line, and your own `## Open questions`.
4. If you disagree with it, write a separate note in your lens and add a line at
   the end of the filed note: `Challenged by [your note](./your-note.md)`.

## Working alongside other skills

Some skills want to write their own files. Map them into this structure instead
of letting them scatter:

- An **ADR / decision record** → `ideas/<idea>/decisions/`, using
  `templates/decision.md`. Same content, this repo's frontmatter.
- A **research findings file** → `ideas/<idea>/hound/` if it is about users or
  the market, `ideas/<idea>/hacker/` if it is about a library or an API. If it
  is mostly quoting one external source, `library/`.
- A **`CONTEXT.md` / domain model** → `ideas/<idea>/CONTEXT.md`, not the root.
  The root `CONTEXT.md` is Arcbyte's own vocabulary and is not about any
  product. A glossary is plain prose with no frontmatter, so the index skips it;
  link to it from the idea's anchor note.
- A **spike or prototype** → keep the code wherever it ran, but write one
  artifact in `ideas/<idea>/hacker/` using `templates/spike.md` that says what it
  proved. The code was the experiment; that note is the result.

## Things that look helpful but are not

- Filling a blank `## Short answer` with your own summary of someone else's
  note. Leave it blank for the owner, or say it is yours.
- Promoting a `draft` to `reviewed` because it reads well.
- Writing a hound note from general knowledge. A model has never met this user.
  See [lenses/hound.md](./lenses/hound.md).
- Producing a market size, a conversion rate, or any number you did not read in
  a real source. Mark it `evidence: none` or leave it out.
- Tidying `archive/`.
- Adding a word to a `CONTEXT.md` because the code uses it. A glossary is a
  decision about language, not a report of it.

## Tone

Plain English, short sentences. The owner is a working developer and English is
his second language. No consultant vocabulary. Write like a teammate leaving
notes for the next person.
