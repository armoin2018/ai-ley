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
lastUpdated: '2025-09-03T00:04:48.103116'
summaryScore: 3.0
title: Build Plan
version: 1.0.0
---

# Copilot Command: Build Implementation Plan from Requirements

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- A requirements specification (`{{files.requirements}}`)
- Project Standards reference file (`.ai-ley/shared/global-instructions.md`)
- Reference Personas (`{{files.indexes.personas}}`)
- Reference Instructions (`{{files.indexes.instructions}}`)

Produce:

- A detailed step-by-step, actionable (`{{files.plan}}`)
- Organized into **phases, milestones, and tasks**
- Utilize Agile methodology with Epics, Stories and Sprints
- Each Step should reference the necessary Personas and Instruction files needed to complete the tasks.
- With **clear mapping** between requirements and tasks

## Command

You are a senior solutions architect and project planner.

1. \*\*Refine `{{files.requirements}}` to include `{{files.suggestions}}`and`{{files.bugs}}`

   - If any `{{files.suggestions}}` file exists, integrate it into the `{{files.requirements}}`
   - If any `{{files.bugs}}` file exists, refine the details in the `{{files.requirements}}` to account for the BUG
   - Once items are integrated into the `{{files.requirements}}` remove them from the `{{files.bugs}}` or `{{files.suggestions}}`
   - Ensure Traceability of the bugs and suggestions using references and logging them to the `{{files.history}}`

2. **Load core requirements** from:

   - `{{files.requirements}}`

3. **Summarize Reference materials**

   - CREATE or UPDATE a `{{files.indexes.instructions}}` that will be used ot summarize all `.md` files under `{{folders.instructions}}/**/*.md`
   - CREATE or UPDATE a `{{files.indexes.personas}}` that will be used ot summarize all `.md` files under `{{folders.personas}}/**/*.md`

4. **Load supplemental reference materials**:

   - If any `.ai-ley/shared/global-instructions.md` exists, treat it as a mandatory compliance guide
   - If any `{{files.indexes.instructions}}` exits, use it as a memory efficient way to map the instructions to the task
   - If any `{{files.indexes.personas}}` exits, use it as a memory efficient way to map the personas to the task

5. **Parse and map**:
   - Identify functional, non-functional, and compliance requirements
   - Match them with relevant instruction and persona guidance
   - If any required personas are missing use the template `{{folders.templates.personas}}/common.md` to create a new persona under `{{folders.personas}}/**/*.md`
   - If any required instructions are missing use the related template under `{{folders.templates.instructions}}/*.md` to create a new instruction under `{{folders.instructions}}/**/*.md`
   - If any recommendations for enhancements please add them to `{{files.suggestions}}`
   - If any bugs are found for remediation please update `{{files.bugs}}`
   - Utilize the `{{files.whitelist}}` for trusted dependencies
   - Avoid use of `{{files.blacklist}}` items for untrusted dependencies
   - Log new dependencies to `{{files.review}}` for requested items
6. **Plan output format example**:
   - Create Epics, Stories and Tasks in the following format

```markdown
## EPIC 1: PROJECT INFRASTRUCTURE & COMPLIANCE

**Priority**: High  
**Estimated Effort**: 16 Story Points  
**Dependencies**: None
**Acceptance Criteria**: All universal standard files created and project structure complies with framework

### Story 1.1: Project Management Files

**Priority**: High
**Effort**: 3 SP
**Personas**: `technical-writer.md`
**Instructions**: `php-instructions.md`
**Context**: `src/`, `.ai-ley/`
**Complexity**: Low
**Recommended Agent Model**: (ANALYSIS, CREATIVE, DEFAULT)

**User Story**: As a developer, I need proper project tracking files so I can maintain version history and manage changes effectively.

**Tasks**:

- [ ] Create `{{files.history}}` with version tracking format (YYYY.MM.DD-#####)
- [ ] Create `{{files.suggestions}}` for code review enhancement logging
- [ ] Set up `{{folders.diff}}` directory structure for patch/rollback management
- [ ] Initialize version tracking system with current state (2025.08.10-00001)

**Acceptance Criteria**:

- `{{files.history}}` follows YYYY.MM.DD-##### format with build references
- `{{files.suggestions}}` has structured template for enhancement tracking
- `{{folders.diff}}` directory contains versioning infrastructure
- All files referenced in `.ai-ley/shared/global-instructions.md` exist
```

7. **Validation**:

   - Ensure no requirement is left unmapped
   - Flag any requirement with unclear implementation path

8. **Deliver**:
   - One detailed and actionable step-by-step plan in `{{files.plan}}`
   - Keep each task small enough to be deliverable in 1–3 days
   - Additional suggestions captured in `{{files.suggestions}}`
   - Additional bugs capture in `{{files.bugs}}`
   - Updates to `.ai-ley/shared/global-instructions.md`, `{{folders.personas}}/**/*.md`, or `{{folders.instructions}}/**/*.md` when needed
   - Updated `{{files.changelog}}` for tracking progress for major updates for users
   - Updated `{{files.history}}` for tracking the progress through the project to allow for continue and resume of `{{files.plan}}`