---
title: Docs — the thinking vault
kind: meta
updated: 2026-09-16
---

# The thinking vault

This is a thinking space for product ideas. It uses the four start-up skill sets
from Sergio Marrero's article as **lenses**: hound (research), hipster (design),
hacker (build), hustler (money and distribution). A fifth lens,
**intelligence**, is not from the article — it is the synthesis layer where the
four meet and a decision gets made.

Most notes here are **artifacts**: things produced by me or by an AI model
(ChatGPT, Gemini, Claude, a local model, anything). Every artifact says where it
came from, so the vault stays honest about what is evidence and what is just a
machine's guess.

New here? Read this file, then [SCHEMA.md](./SCHEMA.md). If you are an AI, read
[AGENTS.md](./AGENTS.md) too — it is the contract you work under.

## Folder map

```
docs/
  README.md      This file. The tour.
  AGENTS.md      The contract for an AI working in here.
  SCHEMA.md      Exact frontmatter fields, allowed values, naming rules.
  INDEX.md       Generated list of every artifact. Do not edit by hand.
  lenses/        One note per lens: what it owns, what to ask it.
  ideas/         One folder per idea. The real work lives here.
  inbox/         Raw dumps not filed yet. Should be empty most of the time.
  library/       External sources: articles, docs, competitor notes, quotes.
  templates/     Copy one of these when you start a new note.
  archive/       Dead ideas and superseded artifacts. Never delete, move here.
  scripts/       build_index.py — rebuilds INDEX.md from frontmatter.
```

Inside one idea:

```
ideas/santian/
  README.md      Anchor note (the hub). Always start and end here.
  hound/         User research, evidence, opportunity areas.
  hipster/       Wireframes, flows, UI critiques, copy and tone.
  hacker/        Architecture, data model, spikes, feasibility.
  hustler/       Positioning, pricing, channels, competitor teardowns.
  decisions/     One note per decision. Short. Dated. Links to its inputs.
  assets/        Images, screenshots, exports. No text notes here.
```

## The three rules that matter

1. **Every artifact declares its `source` and its `evidence`.** Without this, in
   three months you cannot tell a user's quote from a model's invention.
2. **Every artifact links back to its idea's anchor note**, and the anchor note
   links to it. The anchor is the only note that must stay current. Everything
   else is allowed to go stale.
3. **One artifact answers one question.** If a draft grows past about one screen
   of text, split it.

## How to add a note in 30 seconds

1. Pick the lens. If you cannot, it is probably two notes.
2. Copy the matching file from `templates/` into
   `ideas/<idea>/<lens>/<kebab-case-name>.md`.
3. Fill the frontmatter. Be honest about `source` and `evidence`.
4. Add a link to it under **Artifacts** in the idea's `README.md`.
5. Run `python3 docs/scripts/build_index.py` from the repo root.

## The weekly pass (15 minutes)

Empty `inbox/`. Move every `draft` you actually read to `reviewed` or
`rejected`. Update the anchor note of any idea you touched. Write one `digest`
note in the idea's `decisions/` folder. Rebuild the index. That is it.

## Related

- [The 4 Start-Up Team Skill Sets](./library/four-startup-team-skill-sets.md) — the source article.
- [Root AGENTS.md](../AGENTS.md) — how this vault sits next to the app code.
