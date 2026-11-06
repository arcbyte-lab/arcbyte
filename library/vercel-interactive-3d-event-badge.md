---
title: Building an interactive 3D event badge with React Three Fiber
kind: analysis
status: draft
source: article
evidence: strong
created: 2026-10-30
updated: 2026-10-30
tags: [library, source, avalanche]
url: https://vercel.com/blog/building-an-interactive-3d-event-badge-with-react-three-fiber
---

# Building an interactive 3D event badge with React Three Fiber

Paul Henschel, Vercel blog, 2024-04-17. The owner gave this as the look
Avalanche's badge should have. Summarised by claude-opus-5.5 (claude-code)
from a fetch of the page. Read the original before you build on it.

## What it is
A virtual lanyard on the Vercel Ship 2024 site. You drag the card and it pulls
a band that swings and settles, like a physics simulation. The card turns back to
face you, and it shows the user's first and last name. The goal was "a highly
shareable element that rewards the user for signing up."

## How it was built
- **Tools:** Blender for the 3D models. React Three Fiber, Drei
  (`<RenderTexture>`, `<Text3D>`), react-three-rapier for physics, and MeshLine
  for the band.
- **Physics:** small ball segments joined by rope joints to a fixed anchor. A
  spherical joint holds the card so it can rotate.
- **Band:** a Catmull-Rom curve runs through the joint positions. It is sampled
  at 32 points every frame and fed to MeshLine.
- **Drag:** the pointer position is unprojected into 3D and moves the card as a
  kinematic body. A small correction keeps the card facing front.
- **Name:** `<Text3D>` is rendered into a texture on the card.

## What it does not cover
It does not describe how the badge is shared, saved or exported. It only says
the badge was meant to be shareable.

Used by [Avalanche](../ideas/avalanche/README.md)
