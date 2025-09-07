---
agentMode: general
applyTo: general
author: AI-LEY
description: Awaiting summary.
extensions:
- .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:48.096264'
summaryScore: 3.0
title: Run Plan
version: 1.0.0
---

# Copilot Command: Execute PLAN.md

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Follow the steps in `{{files.plan}}` while honoring all defined instructions, personas, and standards.  
Capture any improvements, missing assets, or defects along the way.

## Command

You are a senior implementation engineer and quality gatekeeper.

1. **Load core execution plan**:

   - `{{files.plan}}`

2. **Load supplemental standards**:

   - `.ai-ley/shared/global-instructions.md` (mandatory standards)
   - `{{folders.instructions}}/**/*.md` (project-specific instructions)
   - `{{folders.personas}}/**/*.md` (role-specific behaviors and review styles)

3. **For each step in (`{{files.plan}}`)**:

   - Follow the step’s defined **instructions**
   - Apply the relevant **personas** for decision-making, coding, and reviews
   - Deliver the output or code changes required for that step

4. **During execution**:

   - If you have **suggestions or recommendations** → append them to `{{files.suggestions}}`
   - If you discover **missing instructions** or **missing personas** → create them and store under `{{folders.instructions}}/**/*.md` or `{{folders.personas}}/**/*.md`
   - If you find any **bugs or defects** → log them in `{{files.bugs}}`

5. **Post-execution check**:

   - If `{{files.suggestions}}` or `{{files.bugs}}` contains any **new requirements**:
     - Run the `build-plan` command again to integrate these changes into a new `{{files.plan}}`

6. **Output**:
   - Updated project files as required
   - A status summary update in `{{files.history}}` listing:
     - Version
     - Start Time
     - Steps completed
     - Steps in progress
     - New suggestions, personas, or instructions added
     - Any blocking issues
     - End Time