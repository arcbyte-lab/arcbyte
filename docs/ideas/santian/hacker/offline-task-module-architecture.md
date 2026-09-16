---
title: Offline task module architecture
idea: santian
lens: hacker
kind: architecture
status: draft
source: unknown (pasted by owner)
evidence: none
created: 2026-09-16
updated: 2026-09-16
inputs: ["../hipster/google-tasks-ux-playbook.md"]
tags: [artifact]
---

> Filed from a longer model answer that mixed design and architecture. This half
> is the build half. The design half is in
> [Google Tasks UX playbook](../hipster/google-tasks-ux-playbook.md).
> Wording below is unchanged from the original.

## Question
How should an offline-first task module be built in Flutter?

## Short answer
-
-
-

## Detail

### 2. Technical Architecture (The Offline Engine)

Since this is an offline module, your state management and local storage strategy have to be bulletproof.

  

- **The Frontend Framework:** Flutter is practically built for this exact use case. It gives you out-of-the-box Material components (like `showModalBottomSheet`, `Dismissible` for swipe gestures, and native date pickers) that perfectly mimic the Google Tasks feel.
    
      
    
- **State Management:** BLoC or Cubit is going to be your best friend here. You can set up a `TaskCubit` to handle the immediate UI state (adding, toggling completion, updating dates) so the UI reacts instantly to user input without waiting for database callbacks.
    
      
    
- **Local Storage:** Since it's completely offline, you need a fast local database.
    
      
    - **Isar Database:** Super fast, NoSQL, built specifically for Flutter/Dart. It handles complex queries (like sorting by date or filtering completed tasks) incredibly well.
        
          
        
    - **SQLite (sqflite):** The classic, reliable relational choice if you prefer writing raw SQL and mapping it to Dart objects.
        
          
        

### 3. Execution Plan (Where to start)

Here is a logical roadmap to kick off development:

  

**Phase 1: The Core Data Layer**

  

1. Define your `Task` model (ID, Title, Notes, DueDate, IsCompleted).
    
      
    
2. Set up your local database (Isar or SQLite) and write the basic CRUD (Create, Read, Update, Delete) operations.
    
      
    

**Phase 2: State & Business Logic**

  

1. Initialize your Cubit/BLoC.
    
      
    
2. Wire it up so that when a task is added or swiped away, the Cubit updates the local database and instantly emits the new state to the UI.
    
      
    

**Phase 3: The UI Shell (Bringing the Wireframes to Life)**

  

1. Build the main layout with your custom fonts and monoline icons.
    
      
    
2. Implement the `ListView.builder` for your tasks.
    
      
    
3. Wrap your task cards in `Dismissible` widgets to get those swipe gestures working early.
    
      
    

**Phase 4: The Frictionless Inputs**

  

1. Build out the "Create Task" bottom sheet. Focus on getting the keyboard to pop up automatically when the sheet opens.
    
      
    
2. Wire up the specialized dialogs (Date Picker / Time Picker) to the action icons inside the bottom sheet.
    
      
    

You've already got a solid visual foundation going in your wireframes. Are you thinking of building this as a standalone mobile app, or are you planning to integrate it into a larger web/desktop ecosystem later down the line?

## What would change my mind
This is a model's default Flutter stack, not a decision. Isar vs sqflite is still
open — see [Isar or sqflite](./isar-or-sqflite.md). Nothing here has been checked
against a real build.

## Open questions
- Does the clockface need the same store as the task list, or a different shape
  of data entirely?
- Is Cubit enough, or does the clockface need something with more structure?

---
Part of [Santian](../README.md)
