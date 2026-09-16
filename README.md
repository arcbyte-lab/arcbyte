# RoutineApp

A Flutter app with a **Clockface** and a **Tasks** view, plus the thinking behind
it. The app code does not exist yet.

- **[docs/](./docs/README.md)** — the thinking vault. Start here.
- **[docs/INDEX.md](./docs/INDEX.md)** — every artifact, generated.
- **[docs/ideas/routine-app/README.md](./docs/ideas/routine-app/README.md)** — the
  anchor note for the idea. The one note that stays current.
- **[AGENTS.md](./AGENTS.md)** — read this before letting an AI write in here.

When the Flutter project lands, it goes at this root. `docs/` does not move.

## Rebuild the index

```bash
python3 docs/scripts/build_index.py          # writes docs/INDEX.md
python3 docs/scripts/build_index.py --check  # exits 1 if anything breaks the schema
```
