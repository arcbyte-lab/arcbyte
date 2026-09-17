---
title: The Personal Dimension
idea: santian
lens: intelligence
evidence: weak
created: 2026-09-17
kind: narrative
status: draft
source: claude-sonnet-5 (cowork)
updated: 2026-09-17
tags: [product-narrative]
---

# The Personal Dimension

> Synthesis document. Part of [The Product Narrative](./product-narrative.md).

This section exists because one decision in the vault changes what every other
document in this set means: Santian is being built for its own creator, not for
an audience. That fact shapes a lot of the project's choices. It is documented
here only where it explains a decision — not as a case for why a personal
project is inherently valuable.

## The decision that set this

[Decision 0003](../decisions/0003-personal-tool-not-a-product.md)
states it directly: "Santian is built for the owner's own use. It is not a
product aimed at strangers, and there is no positioning, pricing, or channel to
work out." It is the one decision in the vault marked `evidence: strong`,
because it rests on the owner's own direct statement rather than an inference —
the vault's own convention reserves `strong` for "real users, real numbers, or
shipped behaviour," and here the "real user" is the person answering the
question.

The decision arrived by elimination, not by design. A hustler-lens question,
[why would anyone switch from Google Tasks?](../hustler/why-switch-from-google-tasks.md),
asked what a stranger already on Google Tasks would gain by moving. Asked
directly, "the owner's answer was: nobody needs to. This is for him." The vault
did not set out to be a personal-tool story; it became one because the
market-facing question had no honest market-facing answer.

## What this changes

- **The hustler lens is mostly closed for this idea.** No pricing, channel, or
  positioning artifact exists or is expected. The one hustler-shaped question
  left open, by the decision's own account, is "does the owner keep using it
  after the novelty wears off" — survival, not acquisition.
- **The hound question about who plans their day by a clock is reframed, not
  answered.** [Decision 0003](../decisions/0003-personal-tool-not-a-product.md)
  says this explicitly: the open question "is no longer a gap to close — the
  owner is the only user this needs to be right for. The question is still
  worth answering, but as self-knowledge, not market research." The question
  itself, [who plans their day by the clock?](../hound/who-plans-their-day-by-the-clock.md),
  remains on file, unanswered, and is not treated as closed by this reframing —
  only re-scoped.
- **Design and engineering standards did not drop.** The same decision is
  explicit that this "still has to work for one real person using it daily,
  which is a real design bar, not a lower one," and that nothing about the data
  model or storage changes because there is one user instead of many.

## What this does not mean

The vault does not argue that Santian is worth building *because* it is
personal, exclusive, or unavailable to anyone else. It also does not treat
being self-made as a substitute for the product working well. The interaction
design of the Tasks module, for example, was decided by asking whether there
was a real problem to solve, not by asking what would feel most personally
authored —
[decision 0004](../decisions/0004-clone-google-tasks-interactions.md)
chose to copy Google Tasks precisely because inventing something original there
would have spent effort on a part of the app that "isn't the point." A
personal-tool framing did not push the project toward novelty for its own
sake; here, it pushed the opposite way.

## Where a personal habit shaped a product decision

The clearest place the owner's own perspective enters the record is the
rethink of the domain model itself. The earlier `Focus` model — purely weekly,
dateless recurrence — was replaced because the owner "wants a typical Tuesday
**and** the ability to change this particular Tuesday without changing every
Tuesday"
([decision 0001](../decisions/0001-rethink-the-focus-aggregate.md)).
That is a description of how one person plans, stated as a requirement, not a
survey finding. The Routine/Day split in the current glossary exists because of
it.

The renaming history recorded in that same decision — "Routine" was removed
from the project at one point on the belief that nothing repeated, then
reinstated the same day because it was "the right English word for the
concept" — is a small, honest trace of the same thing: a creator working out
his own vocabulary for his own idea, in real time, and writing down the
correction rather than smoothing it over.

## An open point this section does not resolve

Nothing in the repository states whether Santian will ever be shown to, or
used by, anyone other than the owner. [Decision 0003](../decisions/0003-personal-tool-not-a-product.md)
says plainly that this "is a future question, not a current one, and nothing
here forecloses it." This document does not speculate further than that.

---
Part of [The Product Narrative](./product-narrative.md)
