---
title: AGENTS — the filing contract
kind: meta
updated: 2026-09-16
---

# How an AI works in this vault

Read this before creating or editing any note. [README.md](./README.md) has the
folder map. [SCHEMA.md](./SCHEMA.md) has the exact field values. This file is the
working contract.

## Your job

Act as **one lens at a time**. If the request does not name a lens, either ask
which one, or say plainly which one you are using and why. Do not write a note
that silently mixes research, design, architecture and pricing — that is the
exact mess this vault is built to prevent.

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
   with a link to whatever replaced it. You cannot delete files here anyway —
   the tooling blocks it — so archiving is the only correct move.
6. **Link both ways.** Every new note links to its idea's anchor note, and you
   add the note to the anchor's **Artifacts** list in the same turn.
7. **Keep notes short.** One artifact answers one question. Past roughly one
   screen of text, split it.
8. **Rebuild the index** after adding or renaming a note:
   `python3 docs/scripts/build_index.py`.

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

## Things that look helpful but are not

- Filling a blank `## Short answer` with your own summary of someone else's
  note. Leave it blank for the owner, or say it is yours.
- Promoting a `draft` to `reviewed` because it reads well.
- Writing a hound note from general knowledge. A model has never met this user.
  See [lenses/hound.md](./lenses/hound.md).
- Producing a market size, a conversion rate, or any number you did not read in
  a real source. Mark it `evidence: none` or leave it out.
- Tidying `archive/`.

## Tone

Plain English, short sentences. The owner is a working developer and English is
his second language. No consultant vocabulary. Write like a teammate leaving
notes for the next person.
