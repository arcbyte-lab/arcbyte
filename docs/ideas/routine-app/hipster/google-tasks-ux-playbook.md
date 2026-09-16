---
title: Google Tasks UX playbook
idea: routine-app
lens: hipster
kind: critique
status: draft
source: unknown (pasted by owner)
evidence: none
created: 2026-09-16
updated: 2026-09-16
inputs: ["./wireframe-geometry-spec.md", "../assets/routine-wireframe-snapshot.png"]
tags: [artifact]
---

> Filed from a longer model answer that mixed design and architecture. This half
> is the design half. The build half is in
> [offline task module architecture](../hacker/offline-task-module-architecture.md).
> Wording below is unchanged from the original.

## Question
Which Google Tasks interaction patterns should the task module copy to feel
lightweight?

## Short answer
-
-
-

## Detail

Man, Google Tasks really does nail that sweet spot, doesn't it? They’ve mastered the art of getting out of the user's way. The way they lean on bottom sheets to keep you in the context of your list, use swipe gestures so you don't have to reach for buttons, and rely on clean iconography instead of clunky text labels is top-tier UX.



Looking at the wireframes you've got mapped out in your pen.dev tab, you're already translating those exact concepts perfectly—especially with those slide-up "Create Task" modal sheets and the clean, split-screen task detail views.

  

Since you’re zeroing in on an **offline-first clone of the task module**, here is a research and strategy report to help you bridge the gap between those wireframes and a working build.

  

### 1. The UX/UI Playbook (Nailing the Google Tasks Vibe)

To capture that lightweight, frictionless feel, you'll need to focus heavily on specific UI components and micro-interactions:

  

- **Context-Preserving Modals:** When a user taps to add a task, it shouldn't push a whole new screen. You want a persistent Bottom Sheet that slides up, immediately focusing the keyboard, so they can type, hit enter, and drop the sheet.
    
      
    
- **Gesture-Driven Actions:** Swipe right to complete, swipe left to delete. This requires smooth physics and clear background color/icon indicators behind the swipe card so the user knows exactly what action they are triggering.
    
      
    
- **Visual Language:** Keep it strictly icon-driven for actions (date, subtasks, lists). To give it a really crisp, custom feel while maintaining that simplicity, a unified monoline line art style for the icons paired with a clean, geometric font like DM Sans will make the UI look incredibly sharp and modern.
    
      
    
- **Specialized Inputs:** Hooking into native (or native-feeling) Date/Time picker dialogs. No typing dates manually.

## What would change my mind
This note assumes Google Tasks is the right thing to feel like. If the radial
clockface is the real product, copying a flat list app may be copying the wrong
thing entirely.

## Open questions
- Is "offline-first clone of the task module" the product, or scaffolding for the
  clockface?
- Which of these patterns does the current wireframe actually contain? See
  [wireframe geometry spec](./wireframe-geometry-spec.md) — most of them are not
  drawn yet.

---
Part of [Routine App](../README.md)
