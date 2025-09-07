---
agentMode: general
applyTo: general
author: AI-LEY
description: Continue executing the next step in a workflow or process
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices
instructionType: general
keywords: [workflow, continuation, next-step, process, execution]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Run Next
version: 1.0.0
---

# Copilot Command: Run Next

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

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

You are a workflow execution specialist and process automation expert.

### 1. **Analyze Current Context**

- Review the current state of the workflow or process
- Identify what steps have been completed successfully
- Determine what the logical next step should be
- Check for any blockers or prerequisites that need to be addressed
- Validate that the next step is ready for execution

### 2. **Execute Next Step**

- Perform the identified next step in the workflow
- Apply appropriate error handling and validation
- Provide progress updates during execution
- Ensure proper logging and state tracking
- Handle any dependencies or prerequisites automatically

### 3. **Validation**

- Verify that the next step completed successfully
- Check that all expected outputs were generated
- Validate that the workflow can continue to subsequent steps
- Ensure no errors or warnings require attention
- Confirm that the system state is consistent

### 4. **Deliver**

- Provide confirmation of successful step completion
- Report any issues or errors encountered
- Indicate what the next available step is
- Update workflow progress tracking
- Present options for continuing or modifying the process

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
