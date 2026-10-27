---
title: GitHub holds ticket status; Arcbyte holds the spec and the why
idea: tasko
lens: intelligence
kind: decision
status: adopted
source: claude-opus-5.5 (claude-code)
evidence: weak
created: 2026-10-27
updated: 2026-10-27
inputs: ["../hacker/activity-log-build-tickets.md", "../hacker/project-and-member-build-tickets.md", "../hacker/repeating-view-build-tickets.md", "../../../AGENTS.md"]
tags: [artifact, decision]
---

## Decision
- **Ticket status lives on GitHub only.** Open, in review, merged and
  deployed are read from the issue and its PR in Tasko-API or
  Tasko-Flutter. Arcbyte stops copying status into notes.
- **A build-ticket note is a spec.** It says what to build and links its
  issues. It is edited when the spec changes, not when a PR moves.
- **Decisions stay files here.** Reasoning worked out in a PR is distilled
  into a decision note before the PR merges.
- **Links go both ways.** An issue links its spec note. A PR that implements
  or changes a decision says `Decision: tasko/NNNN`.

## Context
Since the project-and-member tickets, every ticket is already a GitHub
issue. Notes still track each PR's state by hand: on 2026-10-27, 20 of the
last 30 commits under `hacker/` were "Record X as merged/deployed" edits.
GitHub already records that, and the copy goes stale.

The owner asked on 2026-10-27 how to keep agents' reasoning compact.
Moving specs and decisions into issues and PRs was considered and rejected
(below).

## What each lens said
- **Hound:** no user input.
- **Hipster:** not affected.
- **Hacker:** status on GitHub costs nothing to keep current.
  `gh issue list` and `gh pr list` answer "what's built" faster than
  reading notes.
- **Hustler:** not consulted.

## Options rejected
- **Specs as issues.** Issues close; a spec stays true while the feature
  exists. Issue edits keep weak history.
- **Decisions only in PR descriptions.** Merged PRs are frozen, so they
  can't be marked superseded. Agents can't grep them, they're missing from
  `INDEX.md`, and they're split across two code repos.
- **Rebuilding the reasoning from commit history.** Diffs show what
  changed, not why. Rebuilt reasoning is a guess (hard rule 1).

## How we will know we were wrong
- Agents or the owner keep asking "is X built?" and can't answer from
  Arcbyte. Then put a one-line status pointer back into the anchor note,
  not into each ticket note.
- Reasoning settled in PRs never reaches a decision note. Then add the
  `Reasoning not yet in a decision note:` line to the PR template, or a
  check that it's empty.

---
Part of [Tasko](../README.md)
