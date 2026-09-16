# AGENTS.md — RoutineApp

This folder holds two things:

1. `docs/` — a product thinking vault. Notes about what to build and why.
   This exists today and is where almost all work happens right now.
2. The root — the Flutter app. It does not exist yet. When it does,
   `pubspec.yaml`, `lib/`, `test/`, `android/` and `ios/` live here and `docs/`
   does not move.

## Before you write anything in `docs/`

Read these two first, in this order:

- **`docs/AGENTS.md`** — the filing contract. How to behave, and what never to do.
- **`docs/SCHEMA.md`** — the exact frontmatter fields and file naming rules.

`docs/README.md` is the tour for a human. `docs/INDEX.md` is the generated list
of every artifact that exists.

## The short version

The vault splits product thinking into four lenses — **hound** (what is true
about the user), **hipster** (what it feels like), **hacker** (how it is built),
**hustler** (who pays) — plus **intelligence**, which weighs the four and
decides. The owner is one developer playing all four roles, so the lenses exist
to stop him thinking about everything at once.

Work as **one lens at a time**. Say which lens you are using. Never write a note
that quietly mixes research, design, architecture and pricing.

Every note is an **artifact** and must declare where it came from (`source`) and
how much evidence is behind it (`evidence`). A model's plausible guess and a real
user's words must never look the same in this vault.

## Where your output goes

| You produced | Put it in |
|---|---|
| A note about a specific idea | `docs/ideas/<idea>/<lens>/` |
| A choice that was made | `docs/ideas/<idea>/decisions/` |
| Guidance about how to think, not what to build | `docs/lenses/` |
| Somebody else's work (article, competitor, docs) | `docs/library/` |
| Something you cannot place yet | `docs/inbox/` |
| Code | the root, once the Flutter project exists |

After writing a note, do two things: link it from the idea's anchor note
(`docs/ideas/<idea>/README.md`) and run `python3 docs/scripts/build_index.py`.

## Working alongside other skills

Some skills want to write their own files. Map them into this vault instead of
letting them scatter:

- An **ADR / decision record** → `docs/ideas/<idea>/decisions/`, using
  `docs/templates/decision.md`. Same content, this vault's frontmatter.
- A **research findings file** → `docs/ideas/<idea>/hound/` if it is about users
  or the market, `docs/ideas/<idea>/hacker/` if it is about a library or an API.
  If it is mostly quoting one external source, `docs/library/`.
- A **`CONTEXT.md` / domain model** → the repo root, as `CONTEXT.md`. That file
  is about code vocabulary, so it is deliberately outside the vault. Link to it
  from the hacker lens rather than copying it in.
- A **spike or prototype** → keep the code wherever it ran, but write one
  artifact in `docs/ideas/<idea>/hacker/` using `docs/templates/spike.md` that
  says what it proved. The code was the experiment; that note is the result.

## Tone

Plain English, short sentences. The owner is a working developer and English is
his second language. No consultant vocabulary. Write like a teammate leaving
notes for the next person.
