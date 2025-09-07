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
lastUpdated: '2025-09-03T00:04:48.099834'
summaryScore: 3.0
title: Build Requirements
version: 1.0.0
---

# Copilot Command: Build or Refine `{{files.requirements}}` from `{{files.ask}}`

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Transform the ideas, requests, and raw notes in `{{files.ask}}` into a clear, detailed, production-ready `{{files.requirements}}` document.  
If `{{files.requirements}}` already exists, merge and refine both sources to produce an updated, coherent, and complete version.

## Command

You are an expert business analyst and technical architect.

1. **Load core source**:

   - `{{files.ask}}` (primary input of goals, ideas, and high-level asks)

2. **Load existing requirements** (if present):

   - `{{files.requirements}}`

3. **Merge and reconcile**:

   - Ensure all points in `{{files.ask}}` are addressed in `{{files.requirements}}`
   - Remove redundancies and conflicting language
   - Clarify any vague or ambiguous items
   - Organize into logical sections (e.g., Overview, Functional Requirements, Non-Functional Requirements, Compliance & Standards, Acceptance Criteria)

4. **Refine for production readiness**:

   - Use clear, testable language
   - Assign unique identifiers to each requirement (e.g., R1, R2, …)
   - Separate functional vs. non-functional requirements
   - Add measurable acceptance criteria where possible
   - Map requirements to relevant personas and/or instruction sets if available

5. **Validation**:

   - Ensure no requirement from `{{files.ask}}` is lost
   - Flag any items that need clarification with a `[TODO: ...]` marker
   - Verify alignment with `.ai-ley/shared/global-instructions.md`, `{{folders.instructions}}/**/*.md` and `{{folders.personas}}/**/*.md` if provided

6. **Deliver**:
   - Output the updated `{{files.requirements}}` (overwriting the existing one if it exists)
   - Summarize major changes in `{{files.requirements_changelog}}`