---
name: 'Run Next'
description: 'Continue executing the next step in a workflow or process'
keywords: [workflow, continuation, next-step, process, execution, prompt, ailey]
---



# Copilot Command: Run Next

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

**Personas:** Leverage domain expertise from `.github/ai-ley/personas/**/*.md`

**Instructions:** Follow best practices from `.github/ai-ley/instructions/**/*.md`

**Agents:** This prompt is designed for the agent system. See the Recommended Agent section below.




## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-orchestrator** agent from `.github/agents/ailey-orchestrator.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

Given:

- A current workflow state or process context
- Previous steps that have been completed
- A clear indication of what the "next step" should be

Produce:

- Execution of the logical next step in the current workflow
- Progress updates and status confirmation
- Error handling and retry logic if needed
- Clear indication of completion and next available actions

## Command

You are a workflow execution specialist, epic story progress tracker, and process automation expert with deep knowledge of agile project management and systematic task execution.

### 1. **Analyze Current Context and Epic Story Progress**

**Review Project-Wide Status**:

- Load complete Epic-Story-Task hierarchy from `{{folders.plan}}/epics/`
- Parse all epic READMEs to determine completion status
- Parse all story READMEs within each epic to track progress
- Identify all completed tasks and calculate story/epic percentages
- Map dependencies between epics, stories, and tasks
- Identify blockers and prerequisites

**Generate Epic Story Progress Dashboard**:

```markdown
📊 EPIC STORY PROGRESS REPORT
═══════════════════════════════════════════════════════════

## Project Overview

- 📁 Total Epics: [X]
  ✅ Completed: [Y] ([Z]%)
  🟡 In Progress: [A] ([B]%)
  ⏸️ Not Started: [C] ([D]%)
- 📋 Total Stories: [X]
  ✅ Completed: [Y] ([Z]%)
  🟡 In Progress: [A] ([B]%)
  ⏸️ Not Started: [C] ([D]%)
- ✅ Total Tasks: [X]
  ✅ Completed: [Y] ([Z]%)
  🟡 In Progress: [A] ([B]%)
  ⏸️ Not Started: [C] ([D]%)

## Epic-by-Epic Progress

### EPIC-001: [Epic Name] - [X]% Complete

**Status**: [✅ Complete | 🟡 In Progress | ⏸️ Not Started | 🔴 Blocked]
**Timeline**: Started [Date] | Est. Complete [Date]
**Business Value**: [Description]

Story Breakdown:
├─ ✅ Story-001: [Story Name] (100% - 5/5 tasks)
├─ ✅ Story-002: [Story Name] (100% - 3/3 tasks)
├─ 🟡 Story-003: [Story Name] (60% - 3/5 tasks) ← CURRENT
│ ├─ ✅ Task-001: [Task name]
│ ├─ ✅ Task-002: [Task name]
│ ├─ ✅ Task-003: [Task name]
│ ├─ 🟡 Task-004: [Task name] ← NEXT TASK
│ └─ ⏸️ Task-005: [Task name]
├─ ⏸️ Story-004: [Story Name] (0% - 0/4 tasks)
└─ ⏸️ Story-005: [Story Name] (0% - 0/6 tasks)

**Epic Health**: [🟢 On Track | 🟡 At Risk | 🔴 Blocked]
**Blockers**: [None | List impediments]
**Notes**: [Key observations]

### EPIC-002: [Epic Name] - [X]% Complete

[Repeat structure for each epic]

## Next Available Task

**Task ID**: TASK-XXX
**Story**: Story-XXX - [Story Name] ([X]% complete)
**Epic**: Epic-XXX - [Epic Name] ([X]% complete)
**Description**: [Task description]
**Estimated Effort**: [X] hours
**Prerequisites**: [All met ✅ | Pending: list]
**Assigned Personas**: [List]
**Required Instructions**: [List]

## Critical Path Analysis

**Current Critical Path**:

1. Epic-XXX → Story-XXX → Task-XXX (current)
2. Epic-XXX → Story-XXX → Task-XXX (next)
3. Epic-XXX → Story-XXX (next story)
4. Epic-XXX (next epic)

**Estimated Timeline**:

- Current Task: [X] hours remaining
- Current Story: [X] hours remaining
- Current Epic: [X] days remaining
- Project: [X] weeks remaining (at current velocity)

## Velocity Metrics

- **Task Completion Rate**: [X] tasks/day
- **Story Completion Rate**: [X] stories/week
- **Epic Completion Rate**: [X] epics/month
- **Actual vs. Estimated**: [X]% variance
- **Quality Score**: [X]% (test coverage, code review scores)

═══════════════════════════════════════════════════════════
```

**Identify Next Logical Step**:

- Determine next task in current story (if story incomplete)
- Determine next story in current epic (if current story complete)
- Determine next epic (if current epic complete)
- Check for any blockers or prerequisites
- Validate that the next step is ready for execution
- Consider parallel execution opportunities

### 2. **Execute Next Step with Full Context**

**Pre-Execution Briefing**:

```markdown
🚀 EXECUTING NEXT TASK

**Context**:

- Epic: [Epic Name] ([X]% complete - story [Y] of [Z])
- Story: [Story Name] ([X]% complete - task [Y] of [Z])
- Task: [Task Name]

**Progress Impact**:

- Completing this task will bring:
  • Story to [X]% complete
  • Epic to [X]% complete
  • Project to [X]% complete

**Quality Requirements**:

- [List acceptance criteria]
- [List testing requirements]
- [List documentation needs]

**Estimated Impact**: [X] hours | [Y]% of remaining work
```

- Perform the identified next task following `run.md` protocol
- Apply appropriate personas and instructions
- Execute in small, testable increments
- Apply quality gates at each increment
- Provide progress updates during execution
- Ensure proper logging and state tracking
- Handle any dependencies or prerequisites automatically
- Update all progress tracking files in real-time

### 3. **Validation with Epic Story Context**

**Task-Level Validation**:

- Verify that the task completed successfully
- Check that all acceptance criteria met
- Validate test coverage and quality metrics
- Ensure no errors or warnings require attention
- Confirm that the system state is consistent
- Update task status in task file

**Story-Level Progress Check**:

- Calculate new story completion percentage
- Update story README with progress
- If story complete, run story-level quality gates
- Update story status and metrics

**Epic-Level Progress Check**:

- Calculate new epic completion percentage
- Update epic README with progress
- If epic complete, run epic-level quality gates
- Update epic status and business value metrics

**Project-Level Progress Update**:

- Recalculate overall project completion
- Update velocity and timeline estimates
- Identify any new blockers or risks
- Update critical path analysis

### 4. **Deliver Progress Report and Next Actions**

**Comprehensive Progress Report**:

```markdown
✅ TASK COMPLETED SUCCESSFULLY

## What Was Accomplished

**Task**: [Task Name] (TASK-XXX)
**Story**: [Story Name] (STY-XXX) - Now [X]% complete
**Epic**: [Epic Name] (EPIC-XXX) - Now [X]% complete

**Files Modified**: [X] files
**Tests Added/Updated**: [X] tests
**Test Coverage**: [X]%
**Quality Score**: [X]/100
**Time**: [X]h estimated, [Y]h actual ([Z]% variance)

## Updated Epic Story Progress

[Insert full epic story progress dashboard showing updated percentages]

## Impact Analysis

**Story Progress**:

- Previous: [X]% complete ([Y/Z] tasks)
- Current: [A]% complete ([B/Z] tasks)
- Remaining: [C] tasks, estimated [D] hours

**Epic Progress**:

- Previous: [X]% complete ([Y/Z] stories)
- Current: [A]% complete ([B/Z] stories)
- Remaining: [C] stories, estimated [D] days

**Project Progress**:

- Previous: [X]% complete
- Current: [Y]% complete
- Estimated Completion: [Date] (based on current velocity)

## Next Available Actions

### Option 1: Continue Current Story (Recommended)

**Next Task**: TASK-XXX - [Task Name]
**Estimated Effort**: [X] hours
**Will Complete**: [Y]% of current story
**Command**: `run-next`

### Option 2: Start Next Story

[Only if current story is complete]
**Next Story**: STY-XXX - [Story Name]
**Tasks**: [X] tasks, estimated [Y] hours
**Command**: `run-next`

### Option 3: Validate Current Progress

**Validate**: Run comprehensive quality checks
**Command**: `validate`

### Option 4: Review and Plan

**Review**: Analyze velocity and adjust timeline
**Command**: `review-progress`

## Critical Notices

[List any blockers, risks, or important observations]

═══════════════════════════════════════════════════════════
```

- Provide confirmation of successful step completion
- Report any issues or errors encountered with resolution steps
- Show updated epic story progress dashboard
- Indicate what the next available task/story/epic is
- Update workflow progress tracking in all relevant files
- Present options for continuing or modifying the process
- Provide velocity-based timeline estimates
- Highlight any critical path changes or risks

## Examples

### Example 1: Basic Workflow Continuation

```
run-next
```

Expected Output:

```
✅ Executing next step in workflow...

Current Context: Building project artifacts
Previous Steps: ✅ Dependencies installed, ✅ Tests passed
Next Step: Compiling application

🔄 Compiling application...
✅ Application compiled successfully

Next Available Actions:
- run-next (Deploy to staging)
- validate (Run deployment validation)
- rollback (Revert to previous version)
```

### Example 2: Error Recovery

```
run-next
```

Expected Output:

```
⚠️ Analyzing current context...

Previous Step Failed: Database migration (Error: Connection timeout)
Next Step: Retry database migration with enhanced error handling

🔄 Retrying database migration...
✅ Database migration completed successfully

Workflow resumed. Next Available Actions:
- run-next (Update application configuration)
- validate (Verify database schema)
```

### Example 3: Multi-Step Process

```
run-next
```

Expected Output:

```
📋 Workflow Progress: Step 3 of 7

✅ Completed: Code analysis, Security scan
🔄 Current: Performance testing
⏳ Remaining: Documentation, Deployment, Validation, Cleanup

🔄 Running performance tests...
Performance baseline: 250ms avg response time
Load test: 1000 concurrent users
✅ All performance tests passed

Next Step Ready: Generate documentation
Use 'run-next' to continue or 'validate' to review results
```

## Notes

- The command automatically determines the next logical step based on current context
- Error handling includes automatic retry logic for transient failures
- Progress tracking helps maintain visibility into workflow state
- The command can handle both linear and branching workflow patterns
- Integration with existing AI-LEY commands for seamless workflow orchestration
- Supports both automated and interactive workflow execution modes
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
