# Arcbyte

A thinking space for product ideas.

It uses the four start-up skill sets from Sergio Marrero's article as **lenses**:
hound (research), hipster (design), hacker (build), hustler (money and
distribution). A fifth lens, **intelligence**, is not from the article — it is
the synthesis layer where the four meet and a decision gets made.

Inside Arcbyte we collect ideas, start projects, and keep the artifacts both
produce. One folder per idea under `ideas/`. An idea that gets built becomes a
**project** — same folder, same notes, its anchor note just says
`stage: project`. The code lives in its own repository; Arcbyte holds the
thinking, not the source.

Most notes here are **artifacts**: things produced by me or by an AI model
(ChatGPT, Gemini, Claude, a local model, anything). Every artifact says where it
came from, so this place stays honest about what is evidence and what is just a
machine's guess.

New here? Read this file, then [CONTEXT.md](./CONTEXT.md) — what every word here
means — then [SCHEMA.md](./SCHEMA.md). If you are an AI, read
[AGENTS.md](./AGENTS.md) too. It is the contract you work under.

## Ideas

| idea | stage | what it is |
|---|---|---|
| [Santian](./ideas/santian/README.md) | idea | A day planner with a circular Clockface and a Block list. Flutter, once it starts. |

## Folder map

```
Arcbyte/
  README.md      This file. The tour.
  CONTEXT.md     The glossary for Arcbyte itself. What idea, project, artifact mean.
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
  CONTEXT.md     This idea's glossary. Its words, not Arcbyte's.
  hound/         User research, evidence, opportunity areas.
  hipster/       Wireframes, flows, UI critiques, copy and tone.
  hacker/        Architecture, data model, spikes, feasibility.
  hustler/       Positioning, pricing, channels, competitor teardowns.
  decisions/     One note per decision. Short. Dated. Links to its inputs.
  narrative/     Long-form synthesis of the idea as a whole. Optional.
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
5. Run `python3 scripts/build_index.py` from the repo root.

## How to start a new idea

1. `mkdir -p ideas/<idea>/{hound,hipster,hacker,hustler,decisions,assets}`
2. Copy `templates/idea-brief.md` to `ideas/<idea>/README.md`. Set
   `stage: idea`.
3. Write `ideas/<idea>/CONTEXT.md` when the idea has words of its own worth
   pinning down. Not before — an empty glossary invents vocabulary nobody needs.
4. Add a row to the **Ideas** table above.
5. Rebuild the index.

An idea becomes a **project** when you start building it. Change `stage:` in the
anchor note, add a `repo:` line pointing at the code, and write a decision in
`decisions/` saying why it graduated. Nothing moves on disk.

## The weekly pass (15 minutes)

Empty `inbox/`. Move every `draft` you actually read to `reviewed` or
`rejected`. Update the anchor note of any idea you touched. Write one `digest`
note in the idea's `decisions/` folder. Rebuild the index. That is it.

## Rebuild the index

```bash
python3 scripts/build_index.py          # writes INDEX.md
python3 scripts/build_index.py --check  # exits 1 if anything breaks the schema
```

## Related

- [The 4 Start-Up Team Skill Sets](./library/four-startup-team-skill-sets.md) — the source article.
- [What "intelligence" means](./library/what-intelligence-means.md) — why there is a fifth lens.
