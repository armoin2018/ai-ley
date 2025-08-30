# Claude Command: Build Implementation Plan from Requirements

## Goal

Given:

- A requirements specification (`project/REQUIREMENTS.md`)
- Project Standards reference file (`.claude/claude-instructions.md`)
- Reference Personas (`.claude/agents/personas/personas-index.md`)
- Reference Instructions (`.claude/agents/instructions/instructions-index.md`)

Produce:

- A detailed step-by-step, actionable (`project/PLAN.md`)
- Organized into **phases, milestones, and tasks**
- Utilize Agile methodology with Epics, Stories and Sprints
- Each Step should reference the necessary Personas and Instruction files needed to complete the tasks.
- With **clear mapping** between requirements and tasks

## Command

You are a senior solutions architect and project planner.

1. **Refine** `project/REQUIREMENTS.md` to inlcude `project/SUGGESTIONS.md` and `project/BUGS.md`

   - If any `*project/SUGGESTIONS.md` file exists, integrate it into the `project/REQUIREMENTS.md`
   - If any `project/BUGS.md` file exists, refine the details in the `project/REQUIREMENTS.md` to account for the BUG
   - Once items are integrated into the `project/REQUIREMENTS.md` remove them from the `project/BUGS.md` or `project/*SUGGESTIONS.md`
   - Ensure Traceability of the bugs and suggestions using references and logging them to the `project/HISTORY.md`

2. **Load core requirements** from:

   - `project/REQUIREMENTS.md`

3. **Summarize Reference materials**

   - CREATE or UPDATE a `.claude/agents/instructions-index.md` that will be used ot summarize All `.md` files under `.claude/agents/instructions/`
   - CREATE or UPDATE a `.claude/agents/personas-index.md` that will be used ot summarize All `.md` files under `.claude/agents/personas/`

4. **Load supplemental reference materials**:

   - If any `.claude/claude-instructions.md` exists, treat it as a mandatory compliance guide
   - If any `.claude/agents/instructions/instructions-index.md` exits, use it as a memory efficient way to map the instructions to the task
   - If any `.claude/agents/personas/personas-index.md` exits, use it as a memory efficient way to map the personas to the task

5. **Parse and map**:

   - Identify functional, non-functional, and compliance requirements
   - Match them with relevant instruction and persona guidance
   - If any required personas are missing use the template `.claude/agents/personas/templates/personas-template.md` to create a new persona under `.claude/agents/personas/**/*.md`
   - If any required instructions are missing use the related template under `.claude/agents/instructions/templates/*.md` to create a new instruction under `.claude/agents/instructions/**/*.md`
   - If any recommendations for enhancements please add them to `project/SUGGESTIONS.md`
   - If any bugs are found for remediation please update `project/BUGS.md`
   - Utilize the `project/WHITELIST.md` for trusted dependencies
   - Avoid use of `project/BLACKLIST.md` items for untrusted dependencies
   - Log new dependencies to `project/REVIEW.md` for requested items

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
**Context**: `src/`, `templates/`
**Complexity**: Low
**Recommended Agent Model**: (ANALYSIS, CREATIVE, DEFAULT)

**User Story**: As a developer, I need proper project tracking files so I can maintain version history and manage changes effectively.

**Tasks**:

- [ ] Create `project/HISTORY.md` with version tracking format (YYYY.MM.DD-#####)
- [ ] Create `project/SUGGESTIONS.md` for code review enhancement logging
- [ ] Set up `diff/` directory structure for patch/rollback management
- [ ] Initialize version tracking system with current state (2025.08.10-00001)

**Acceptance Criteria**:

- project/HISTORY.md follows YYYY.MM.DD-##### format with build references
- project/SUGGESTIONS.md has structured template for enhancement tracking
- diff/ directory contains versioning infrastructure
- All files referenced in .claude/claude-instructions.md exist
```

7. **Validation**:

   - Ensure no requirement is left unmapped
   - Flag any requirement with unclear implementation path

8. **Deliver**:

   - One detailed and actionable step-by-step plan in a markdown document (`project/PLAN.md`)
   - Keep each task small enough to be deliverable in 1–3 days
   - Additional suggestions captured in (`project/SUGGESTIONS.md`)
   - Additional bugs capture in (`project/BUGS.md`)
   - Updates to `.claude/claude-instructions.md`, `.claude/agents/personas/*.md`, or `.claude/agents/instructions/*.md` when needed
   - Updated `project/CHANGELOG.md` for tracking progress for major updates for users
   - Updated `project/HISTORY.md` for tracking the progress through the project to allow for continue and resume of `project/PLAN.md`
