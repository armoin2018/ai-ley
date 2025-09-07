---
agentMode: general
applyTo: general
author: AI-LEY
description: Execute PlantUML workflow diagrams as sequences of AI-LEY command actions, interpreting flow logic and chaining prompts systematically.
extensions:
  - .md
guidelines: Follow AI-LEY project standards and workflow execution best practices
instructionType: general
keywords: [workflow-execution, plantuml-interpretation, command-chaining, automation]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 5.0
title: Run Flow
version: 1.0.0
---

# Copilot Command: Run Flow

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- A flow name provided by the user (e.g., `run-flow feature-development`)
- Existing PlantUML workflow diagram at `.ai-ley/shared/uml-flows/user/{flow-name}.puml`

Produce:

- Systematic execution of the workflow diagram as a sequence of AI-LEY command actions
- Intelligent interpretation of decision points and branching logic
- Real-time progress tracking and status updates
- Quality gate validation at each critical checkpoint
- Complete workflow execution with comprehensive logging and results

## Command

You are a workflow execution specialist and PlantUML interpreter with expertise in AI-LEY command orchestration and systematic automation.

### Step 1: Load and Parse PlantUML Workflow

**Load Flow Definition**:

- Read PlantUML file from `.ai-ley/shared/uml-flows/user/{flow-name}.puml`
- Parse the workflow structure and extract execution sequence
- Identify all command rectangles, decision diamonds, and integration points
- Map flow components to available AI-LEY commands in `.ai-ley/shared/prompts/`

**Flow Structure Analysis**:

```markdown
**PlantUML Component Mapping**:

1. **Command Rectangles**: Map to AI-LEY prompt files

   - Extract command name from rectangle identifier
   - Identify input requirements and expected outputs
   - Validate command availability in `.ai-ley/shared/prompts/{command}.md`

2. **Decision Diamonds**: Map to conditional logic

   - Extract decision criteria and branching conditions
   - Identify true/false path destinations
   - Prepare validation logic for runtime evaluation

3. **Integration Points**: Map to data combination steps

   - Identify input sources that need to be combined
   - Define validation criteria for integration success
   - Plan output generation and distribution

4. **Quality Gates**: Map to validation checkpoints

   - Extract quality criteria and success conditions
   - Plan validation procedures and failure handling
   - Define pass/fail actions and next steps

5. **Parallel Processing**: Map to concurrent execution
   - Identify fork/join points for parallel activities
   - Plan resource allocation and synchronization
   - Define merge criteria and completion validation
```

### Step 2: Initialize Execution Environment

**Execution Context Setup**:

- Initialize workflow execution tracking and logging
- Validate all required input files and data sources exist
- Load global instructions from `.ai-ley/shared/global-instructions.md`
- Prepare execution state management and progress monitoring
- Set up error handling and recovery mechanisms

**Pre-Execution Validation**:

```markdown
**Workflow Readiness Checklist**:

- [ ] PlantUML flow file exists and is parseable
- [ ] All referenced AI-LEY commands are available
- [ ] Required input files and data sources exist
- [ ] Execution environment has necessary permissions
- [ ] Resource requirements can be satisfied
- [ ] Error handling and rollback procedures defined
```

### Step 3: Execute Flow Sequence with Intelligent Interpretation

**Sequential Execution Engine**:

1. **Start Point Processing**

   - Begin workflow execution from defined start point
   - Initialize execution context and logging
   - Validate initial conditions and prerequisites
   - Set up progress tracking and status monitoring

2. **Command Rectangle Execution**

   ```markdown
   **For each command rectangle in flow**:

   **Step 1: Command Preparation**

   - Load AI-LEY command from `.ai-ley/shared/prompts/{command}.md`
   - Validate input requirements are satisfied
   - Prepare execution context and parameters
   - Set up output capture and validation

   **Step 2: Command Execution**

   - Execute the AI-LEY command with current workflow context
   - Apply command-specific personas and instructions
   - Monitor execution progress and quality metrics
   - Capture outputs and validate against expected results

   **Step 3: Post-Command Validation**

   - Verify command execution completed successfully
   - Validate outputs meet quality standards
   - Update workflow state and progress tracking
   - Prepare outputs for next workflow step
   ```

3. **Decision Diamond Processing**

   ```markdown
   **For each decision point in flow**:

   **Step 1: Condition Evaluation**

   - Evaluate decision criteria against current workflow state
   - Gather required data for condition assessment
   - Apply decision logic and determine branch direction
   - Log decision rationale and selected path

   **Step 2: Branch Navigation**

   - Navigate to appropriate branch based on decision result
   - Update execution path tracking and logging
   - Prepare context for next workflow component
   - Handle any branch-specific setup requirements
   ```

4. **Integration Point Processing**

   ```markdown
   **For each integration step in flow**:

   **Step 1: Data Gathering**

   - Collect outputs from all input sources
   - Validate data completeness and quality
   - Reconcile any conflicts or inconsistencies
   - Prepare data for integration processing

   **Step 2: Integration Processing**

   - Combine input data according to integration logic
   - Apply validation rules and quality checks
   - Generate integrated outputs and deliverables
   - Validate integration success and completeness
   ```

5. **Quality Gate Validation**

   ```markdown
   **For each quality gate in flow**:

   **Step 1: Criteria Assessment**

   - Evaluate all quality criteria against current state
   - Gather metrics and evidence for assessment
   - Apply pass/fail logic to determine gate status
   - Document assessment results and rationale

   **Step 2: Gate Action Processing**

   - If PASS: Continue to next workflow step
   - If FAIL: Execute failure handling procedures
   - Update quality tracking and metrics
   - Log gate results and next steps
   ```

6. **Parallel Processing Coordination**

   ```markdown
   **For parallel execution blocks**:

   **Step 1: Fork Processing**

   - Identify all parallel branches to execute
   - Allocate resources and execution contexts
   - Initialize parallel execution tracking
   - Begin concurrent execution of all branches

   **Step 2: Parallel Execution Management**

   - Monitor progress of all parallel branches
   - Handle errors and failures in individual branches
   - Provide status updates and progress reporting
   - Maintain synchronization and coordination

   **Step 3: Join Processing**

   - Wait for all parallel branches to complete
   - Validate successful completion of all branches
   - Merge results and outputs from parallel execution
   - Continue with unified workflow execution
   ```

### Step 4: Real-Time Progress Tracking and Monitoring

**Execution Status Management**:

```markdown
# Workflow Execution Status - {flow-name}

## Current Execution State

- **Flow**: {flow-name}
- **Current Step**: {current-component-name}
- **Progress**: {completed-steps}/{total-steps} ({percentage}%)
- **Status**: In Progress/Completed/Failed
- **Start Time**: {execution-start-time}
- **Estimated Completion**: {estimated-end-time}

## Completed Components

- [x] {component-1} - {completion-time} - SUCCESS
- [x] {component-2} - {completion-time} - SUCCESS
- [x] {component-3} - {completion-time} - SUCCESS

## Current Component

- [ ] {current-component} - In Progress
  - **Command**: {ai-ley-command}
  - **Input Sources**: {input-files-or-data}
  - **Expected Output**: {expected-deliverables}
  - **Quality Criteria**: {validation-requirements}

## Upcoming Components

- [ ] {next-component-1} - Pending
- [ ] {next-component-2} - Pending
- [ ] {next-component-3} - Pending

## Execution Metrics

- **Commands Executed**: {command-count}
- **Quality Gates Passed**: {passed-gates}/{total-gates}
- **Decision Points Navigated**: {decision-count}
- **Integration Steps Completed**: {integration-count}
- **Issues Encountered**: {issue-count}
- **Resolution Success Rate**: {resolution-percentage}%
```

**Progress Reporting and Logging**:

- Update execution status after each component completion
- Log all decision points and rationale for choices made
- Track quality gate results and failure recovery actions
- Maintain comprehensive audit trail of all workflow actions
- Provide real-time status updates to stakeholders

### Step 5: Decision Point and Branching Logic

**Intelligent Decision Processing**:

```markdown
**Decision Evaluation Framework**:

1. **Context Analysis**

   - Gather all relevant data for decision criteria
   - Analyze current workflow state and outputs
   - Consider historical execution patterns and outcomes
   - Apply domain knowledge and best practices

2. **Criteria Assessment**

   - Evaluate each decision criterion systematically
   - Apply logical operators (AND, OR, NOT) as specified
   - Consider confidence levels and uncertainty factors
   - Document assessment process and intermediate results

3. **Branch Selection**

   - Select branch based on criteria evaluation results
   - Consider alternative paths and their implications
   - Validate branch selection against workflow objectives
   - Log decision rationale and supporting evidence

4. **Path Preparation**
   - Prepare execution context for selected branch
   - Set up any branch-specific requirements or conditions
   - Initialize tracking for branch-specific metrics
   - Continue workflow execution on selected path
```

**Common Decision Patterns**:

```markdown
**Quality Check Decisions**:

- Criteria: All acceptance criteria met?
- True Path: Continue to next phase
- False Path: Return to revision/fix step

**Resource Availability Decisions**:

- Criteria: Required resources available?
- True Path: Proceed with resource-intensive step
- False Path: Execute resource generation/acquisition

**Environment-Based Decisions**:

- Criteria: Deployment environment type?
- Production Path: Full validation and rollback capabilities
- Staging Path: Integration testing procedures
- Development Path: Rapid iteration and experimentation
```

### Step 6: Error Handling and Recovery

**Comprehensive Error Management**:

```markdown
**Error Detection and Classification**:

1. **Command Execution Errors**

   - AI-LEY command fails to execute properly
   - Expected outputs not generated or invalid
   - Resource constraints or availability issues
   - Permission or access control problems

2. **Data Quality Errors**

   - Input data missing, incomplete, or corrupted
   - Data format incompatibilities between commands
   - Validation failures in quality gates
   - Integration conflicts or inconsistencies

3. **Workflow Logic Errors**

   - Decision criteria cannot be evaluated
   - Branch paths lead to undefined states
   - Circular dependencies or infinite loops
   - Resource contention in parallel processing

4. **System and Environment Errors**
   - File system access problems
   - Network connectivity issues
   - Resource exhaustion (memory, disk, CPU)
   - External dependency failures
```

**Recovery Strategies**:

```markdown
**Automatic Recovery Procedures**:

1. **Retry with Backoff**

   - Retry failed operations with exponential backoff
   - Adjust parameters or context for retry attempts
   - Limited retry count to prevent infinite loops
   - Log retry attempts and ultimate resolution

2. **Alternative Path Selection**

   - Identify alternative workflow paths when available
   - Evaluate feasibility of alternative approaches
   - Switch to alternative path with context preservation
   - Continue execution with modified workflow

3. **Degraded Mode Operation**

   - Continue workflow with reduced functionality
   - Skip non-critical components when possible
   - Generate partial results with quality annotations
   - Document degraded operation conditions and impacts

4. **Rollback and Recovery**
   - Restore previous known-good state when necessary
   - Undo partial changes and side effects
   - Preserve audit trail of rollback operations
   - Restart workflow from appropriate checkpoint
```

### Step 7: Quality Gate Validation and Control

**Multi-Level Quality Assurance**:

```markdown
**Quality Gate Processing Framework**:

1. **Pre-Gate Assessment**

   - Gather all artifacts and outputs for validation
   - Prepare quality criteria and success metrics
   - Set up validation environment and tools
   - Initialize quality gate tracking and logging

2. **Criteria Evaluation**

   - Execute all automated quality checks
   - Apply manual review procedures where specified
   - Measure performance and compliance metrics
   - Generate quality assessment report

3. **Gate Decision Processing**

   - Evaluate pass/fail criteria against assessment results
   - Consider confidence levels and risk factors
   - Apply business rules and policy constraints
   - Make gate decision with documented rationale

4. **Post-Gate Actions**
   - If PASS: Update quality metrics and continue workflow
   - If FAIL: Execute failure procedures and recovery actions
   - Log gate results and supporting evidence
   - Trigger appropriate notifications and alerts
```

**Quality Criteria Categories**:

- **Functional Quality**: Features work as specified
- **Technical Quality**: Code standards, performance, security
- **Process Quality**: Documentation, testing, review completion
- **Business Quality**: Value delivery, stakeholder satisfaction

### Step 8: Parallel Execution Coordination

**Advanced Parallel Processing**:

```markdown
**Parallel Execution Management**:

1. **Fork Point Processing**

   - Identify all parallel branches in workflow
   - Analyze resource requirements for each branch
   - Allocate execution contexts and environments
   - Initialize synchronization and coordination mechanisms

2. **Concurrent Execution Control**

   - Monitor progress of all parallel branches independently
   - Handle cross-branch dependencies and communications
   - Manage resource contention and allocation conflicts
   - Provide unified progress reporting across all branches

3. **Error Handling in Parallel Context**

   - Detect and isolate failures in individual branches
   - Decide on failure propagation vs. isolation strategies
   - Coordinate recovery actions across affected branches
   - Maintain overall workflow integrity and consistency

4. **Join Point Synchronization**
   - Wait for completion of all required parallel branches
   - Validate successful completion criteria for each branch
   - Merge outputs and results from parallel execution
   - Resolve any conflicts or inconsistencies in merged results
   - Continue unified workflow with integrated outputs
```

### Step 9: Integration and Output Management

**Comprehensive Integration Processing**:

```markdown
**Data Integration and Validation**:

1. **Source Data Gathering**

   - Collect outputs from all specified input sources
   - Validate data completeness and format consistency
   - Identify and resolve any missing or corrupted data
   - Prepare data for integration processing

2. **Integration Rule Application**

   - Apply defined integration logic and transformations
   - Handle data conflicts and resolution strategies
   - Validate integrated results against quality criteria
   - Generate comprehensive integration reports

3. **Output Generation and Distribution**
   - Create final integrated outputs and deliverables
   - Apply output formatting and quality standards
   - Distribute outputs to specified destinations
   - Update tracking and audit trails with integration results
```

### Step 10: Workflow Completion and Reporting

**Final Workflow Processing**:

```markdown
**Completion Validation and Reporting**:

1. **Final State Validation**

   - Verify all workflow objectives have been achieved
   - Validate final outputs meet quality and completeness criteria
   - Confirm all required deliverables have been generated
   - Execute final quality gates and acceptance procedures

2. **Comprehensive Execution Report**

   - Generate complete workflow execution summary
   - Include performance metrics and quality assessments
   - Document lessons learned and improvement opportunities
   - Provide stakeholder-ready completion report

3. **Cleanup and Archival**
   - Clean up temporary files and intermediate artifacts
   - Archive important outputs and execution logs
   - Update workflow execution history and metrics
   - Prepare handoff documentation for stakeholders
```

**Final Execution Report Template**:

```markdown
# Workflow Execution Report: {flow-name}

## Execution Summary

- **Flow Name**: {flow-name}
- **Execution Duration**: {start-time} to {end-time} ({duration})
- **Total Components**: {total-components}
- **Successful Components**: {successful-components}
- **Failed Components**: {failed-components}
- **Quality Gates**: {passed-gates}/{total-gates} passed

## Component Execution Details

| Component | Type         | Duration   | Status  | AI-LEY Command | Outputs        |
| --------- | ------------ | ---------- | ------- | -------------- | -------------- |
| {comp-1}  | Command      | {duration} | Success | {command}      | {outputs}      |
| {comp-2}  | Decision     | {duration} | Success | N/A            | {path-taken}   |
| {comp-3}  | Quality Gate | {duration} | Passed  | N/A            | {criteria-met} |

## Decision Points and Branching

- **Decision 1**: {criteria} → {path-taken} (Rationale: {reason})
- **Decision 2**: {criteria} → {path-taken} (Rationale: {reason})

## Quality Gate Results

- **Gate 1**: PASS - {criteria-summary}
- **Gate 2**: PASS - {criteria-summary}

## Issues and Resolutions

- **Issue 1**: {description} → Resolved by {resolution}
- **Issue 2**: {description} → Resolved by {resolution}

## Final Deliverables

- {deliverable-1}: {location-or-description}
- {deliverable-2}: {location-or-description}
- {deliverable-3}: {location-or-description}

## Performance Metrics

- **Average Component Duration**: {avg-duration}
- **Error Rate**: {error-percentage}%
- **Recovery Success Rate**: {recovery-percentage}%
- **Quality Gate Success Rate**: {quality-percentage}%

## Lessons Learned

- {lesson-1}
- {lesson-2}
- {lesson-3}

## Recommendations

- {recommendation-1}
- {recommendation-2}
- {recommendation-3}
```

## Examples

### Example 1: Simple Sequential Flow Execution

**Input**:

```
run-flow feature-development
```

**Flow Execution**:

```markdown
# Executing: feature-development.puml

## Step 1: Start Point

- Initializing workflow execution
- Loading required context and prerequisites

## Step 2: requirements Command

- Executing: `.ai-ley/shared/prompts/requirements.md`
- Input: {{files.ask}}, feature request
- Output: {{files.requirements}}
- Status: SUCCESS

## Step 3: plan Command

- Executing: `.ai-ley/shared/prompts/plan.md`
- Input: {{files.requirements}}
- Output: {{files.plan}}
- Status: SUCCESS

## Step 4: run Command

- Executing: `.ai-ley/shared/prompts/run.md`
- Input: {{files.plan}}
- Output: Implemented feature
- Status: SUCCESS

## Step 5: Quality Gate

- Evaluating: All acceptance criteria met
- Result: PASS
- Action: Continue to completion

## Step 6: Completion

- Workflow executed successfully
- Feature deployed and validated
- Execution report generated
```

### Example 2: Complex Multi-Path Flow with Decision Logic

**Input**:

```
run-flow project-lifecycle
```

**Flow Execution**:

```markdown
# Executing: project-lifecycle.puml

## Step 1: Start Point

- Initializing project lifecycle workflow

## Step 2: Decision Point - Requirements Exist?

- Evaluating: Check for {{files.requirements}}
- Criteria: File exists and is valid
- Result: FALSE (no existing requirements)
- Branch Selected: Generate new requirements

## Step 3: Generate Requirements Branch

- Executing: `requirements.md` in create new mode
- Input: {{files.ask}}
- Output: {{files.requirements}}
- Status: SUCCESS

## Step 4: plan Command

- Executing: `.ai-ley/shared/prompts/plan.md`
- Input: {{files.requirements}}
- Output: {{files.plan}}
- Status: SUCCESS

## Step 5: run Command

- Executing: `.ai-ley/shared/prompts/run.md`
- Input: {{files.plan}}
- Output: Implementation complete
- Status: SUCCESS

## Step 6: Decision Point - Deployment Type?

- Evaluating: Deployment environment selection
- Criteria: Environment configuration analysis
- Result: PRODUCTION
- Branch Selected: Production deployment path

## Step 7: Production Deployment

- Executing production deployment procedures
- Validation: Full integration testing
- Rollback: Capability confirmed and ready
- Status: SUCCESS

## Step 8: Completion

- Project lifecycle executed successfully
- Production deployment completed and validated
- Comprehensive execution report generated
```

## Notes

- **Flow execution requires existing PlantUML files** created by `build-flow` command
- **AI-LEY command chaining** leverages existing prompt ecosystem for maximum efficiency
- **Decision logic interpretation** supports complex branching and conditional workflows
- **Real-time progress tracking** provides visibility into execution status and metrics
- **Comprehensive error handling** ensures robust execution with recovery capabilities
- **Quality gate validation** maintains high standards throughout workflow execution
- **Parallel processing support** enables efficient execution of concurrent activities
- **Integration capabilities** support complex data combination and validation requirements
