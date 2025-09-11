---
agentMode: general
applyTo: general
author: AI-LEY
description: Generate PlantUML workflow diagrams by chaining existing AI-LEY prompts to visualize complex automation flows.
extensions:
  - .md
guidelines: Follow AI-LEY project standards and PlantUML best practices
instructionType: general
keywords: [plantuml, workflow, automation, flow-diagram, prompt-chaining]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 5.0
title: Build Flow
version: 1.0.0
---

# Copilot Command: Build Flow

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A flow name and description provided by the user (e.g., `build-flow feature-development "Complete feature development from idea to deployment"`)
- Input instructions describing the desired workflow process

Produce:

- PlantUML workflow diagram stored as `.ai-ley/shared/uml-flows/user/{flow-name}.puml`
- Visual representation of the workflow leveraging existing AI-LEY prompts when possible
- Clear flow documentation with decision points, inputs, outputs, and command chaining
- Optimized workflow that reuses existing prompts for maximum efficiency

## Command

You are a workflow architect and PlantUML diagram specialist with expertise in AI-LEY command ecosystem integration.

### Step 1: Parse User Input and Analyze Requirements

**Extract Flow Information**:

- Extract the flow name from user input (convert to kebab-case)
- Extract the description and workflow requirements
- Parse input instructions to identify key workflow steps and decision points
- Validate that the flow name is unique and descriptive

**Analyze Workflow Requirements**:

- Identify the main workflow phases and their objectives
- Determine input requirements and expected outputs
- Identify decision points and branching logic
- Map workflow steps to potential AI-LEY command integrations

### Step 2: Discover Available AI-LEY Commands

**Scan Available Commands**:
Load and analyze all existing commands from `.ai-ley/shared/prompts/*.md`:

- `requirements.md` - Generate detailed requirements from ASK and suggestions
- `plan.md` - Create comprehensive Epic-Story-Task project plans
- `run.md` - Execute plans with intelligent task management
- `new-feature.md` - End-to-end feature development workflow
- `repair-prompts.md` - Synchronize missing prompt reference files
- `build-requirements.md` - Transform ASK into production-ready requirements
- `build-plan-run.md` - Complete development lifecycle automation
- `run-plan.md` - Execute existing project plans
- `new-prompt.md` - Create new standardized command prompts
- `git-commit.md` - Generate standardized commit messages
- `update-instructions.md` - Update and maintain instruction files
- `update-personas.md` - Update and maintain persona files
- `build-registry.md` - Build comprehensive project registries
- `lean-canvas.md` - Create business model canvas documentation
- `bench.md` - Performance benchmarking and analysis

**Command Capability Mapping**:
For each available command, extract:

- Primary purpose and functionality
- Input requirements and expected data sources
- Output deliverables and file locations
- Integration points with other commands
- Quality gates and validation steps

### Step 3: Design Optimal Workflow Chain

**Workflow Optimization Strategy**:

- **Maximize Reuse**: Prioritize existing AI-LEY commands over custom steps
- **Minimize Redundancy**: Avoid duplicate work across command chains
- **Ensure Compatibility**: Verify input/output compatibility between chained commands
- **Optimize Efficiency**: Sequence commands for optimal resource utilization and timeline

**Command Chaining Logic**:

```markdown
**Chain Analysis Process**:

1. Map user requirements to available command capabilities
2. Identify command sequence that maximizes existing prompt reuse
3. Design decision points for branching workflow paths
4. Define data flow between chained commands
5. Integrate quality gates and validation checkpoints
6. Plan error handling and fallback strategies
```

### Step 4: Generate PlantUML Workflow Diagram

**Create Directory Structure**:
Ensure `.ai-ley/shared/uml-flows/user/` directory exists and create the PlantUML file.

**PlantUML Structure Template**:

```plantuml
@startuml {flow-name}
!theme plain
title {Flow Title}

' Define styling
skinparam rectangle {
    BackgroundColor lightblue
    BorderColor darkblue
}
skinparam diamond {
    BackgroundColor lightyellow
    BorderColor orange
}
skinparam note {
    BackgroundColor lightgreen
    BorderColor darkgreen
}

' Start and End points
start
note right: {Flow Description}

' Main workflow steps using existing AI-LEY commands
rectangle "command-name" as cmd1 {
    note : **Input**: {input-description}
    note : **Command**: `.ai-ley/shared/prompts/{command}.md`
    note : **Output**: {output-description}
}

' Decision diamonds for branching logic
diamond "Decision Point" as decision1
note right: {decision-criteria}

' Parallel processing where applicable
fork
    :Parallel Task 1;
fork again
    :Parallel Task 2;
end fork

' Integration points
rectangle "Integration Step" as integration {
    note : **Combines**: {input-sources}
    note : **Validates**: {quality-criteria}
    note : **Produces**: {output-deliverables}
}

' Quality gates
diamond "Quality Gate" as qgate1
note right: {quality-criteria}

' Error handling
if (Error Detected?) then (yes)
    :Error Resolution;
    note right: {error-handling-strategy}
else (no)
    :Continue Workflow;
endif

stop
note right: {completion-criteria}

@enduml
```

**Workflow Component Types**:

1. **Command Rectangles**: Represent existing AI-LEY prompts

   ```plantuml
   rectangle "requirements" as req {
       note : **Input**: {{files.ask}}, {{files.suggestions}}
       note : **Command**: `.ai-ley/shared/prompts/requirements.md`
       note : **Output**: {{files.requirements}}
   }
   ```

2. **Decision Diamonds**: Represent workflow branching points

   ```plantuml
   diamond "Requirements Complete?" as req_check
   note right: Validate all ASK items addressed
   ```

3. **Integration Points**: Represent data combination and validation

   ```plantuml
   rectangle "Plan Integration" as plan_int {
       note : **Combines**: Requirements + Available Resources
       note : **Validates**: Dependencies and constraints
       note : **Produces**: Executable project plan
   }
   ```

4. **Quality Gates**: Represent validation checkpoints

   ```plantuml
   diamond "Quality Gate" as qg1
   note right: All acceptance criteria met
   ```

5. **Parallel Processing**: Represent concurrent activities
   ```plantuml
   fork
       :Generate Documentation;
   fork again
       :Run Test Suite;
   fork again
       :Deploy Artifacts;
   end fork
   ```

### Step 5: Implement AI-LEY Command Integration

**Command Chaining Patterns**:

**Sequential Chain Pattern**:

```plantuml
:ASK Input; -> :requirements; -> :plan; -> :run; -> :Complete;
```

**Conditional Chain Pattern**:

```plantuml
if (Has Existing Requirements?) then (yes)
    :Update requirements;
else (no)
    :Generate new requirements;
endif
-> :plan;
```

**Parallel Chain Pattern**:

```plantuml
fork
    :requirements;
    :plan;
fork again
    :repair-prompts;
    :update-personas;
end fork
-> :run;
```

**Integration Chain Pattern**:

```plantuml
:Multiple Inputs; -> :Integration Step; -> :Validation; -> :Output;
```

### Step 6: Add Flow Documentation and Metadata

**Flow Documentation Structure**:

```plantuml
' Flow metadata
title {Flow Name}: {Description}
caption Generated on {date} for AI-LEY Project Automation

' Legend explaining command types
legend right
    |= Color |= Meaning |
    | <#lightblue> | AI-LEY Command |
    | <#lightyellow> | Decision Point |
    | <#lightgreen> | Manual Input |
    | <#lightcoral> | Output/Deliverable |
end legend

' Notes section
note top
    **Prerequisites**: {list-prerequisites}
    **Estimated Duration**: {time-estimate}
    **Resource Requirements**: {resource-list}
    **Success Criteria**: {success-measures}
end note
```

### Step 7: Workflow Validation and Optimization

**Validation Checklist**:

- [ ] All workflow steps have clear inputs and outputs
- [ ] Command chains are compatible (output → input matching)
- [ ] Decision points have clear criteria and branching logic
- [ ] Quality gates are positioned at appropriate validation points
- [ ] Error handling paths are defined for critical failures
- [ ] Resource requirements are realistic and available
- [ ] Timeline estimates are reasonable for the workflow complexity

**Optimization Review**:

- [ ] Maximum reuse of existing AI-LEY commands
- [ ] Minimal custom steps or manual interventions
- [ ] Efficient sequencing with parallel processing where appropriate
- [ ] Clear integration points between workflow phases
- [ ] Comprehensive error handling and recovery strategies

### Step 8: Generate Complete PlantUML File

**File Structure**:
Create `.ai-ley/shared/uml-flows/user/{flow-name}.puml` with:

1. **Header and Metadata**

   - PlantUML start directive with theme
   - Flow title and description
   - Generation timestamp and author

2. **Styling Definitions**

   - Color schemes for different component types
   - Font sizes and styling for readability
   - Consistent visual patterns

3. **Workflow Diagram**

   - Complete flow from start to finish
   - All decision points and branching logic
   - Command integrations with proper annotations
   - Quality gates and validation checkpoints

4. **Documentation Elements**
   - Legend explaining component types
   - Prerequisites and resource requirements
   - Success criteria and completion measures
   - Notes on optimization and best practices

### Step 9: Flow Integration and Testing

**Integration Points**:

- Verify compatibility with existing AI-LEY command ecosystem
- Ensure proper file path references and variable usage
- Test command chaining logic with sample inputs
- Validate output deliverables meet expected formats

**Testing Strategy**:

- **Syntax Validation**: Verify PlantUML syntax correctness
- **Visual Verification**: Generate diagram and verify readability
- **Logic Testing**: Walk through workflow paths and decision points
- **Integration Testing**: Verify command chain compatibility

## Examples

### Example 1: Simple Feature Development Flow

**Input**:

```
build-flow feature-development "Complete feature development from idea to deployment"

Steps:
1. Analyze feature request
2. Generate requirements
3. Create development plan
4. Execute implementation
5. Deploy to production
```

**Generated PlantUML**:

```plantuml
@startuml feature-development
!theme plain
title Feature Development Flow

start
note right: Complete feature development from idea to deployment

rectangle "requirements" as req {
    note : **Input**: {{files.ask}}, feature request
    note : **Command**: `.ai-ley/shared/prompts/requirements.md`
    note : **Output**: {{files.requirements}}
}

rectangle "plan" as plan_cmd {
    note : **Input**: {{files.requirements}}
    note : **Command**: `.ai-ley/shared/prompts/plan.md`
    note : **Output**: {{files.plan}}
}

rectangle "run" as run_cmd {
    note : **Input**: {{files.plan}}
    note : **Command**: `.ai-ley/shared/prompts/run.md`
    note : **Output**: Implemented feature
}

diamond "Quality Gate" as qg1
note right: All acceptance criteria met

req -> plan_cmd -> run_cmd -> qg1
qg1 -> stop : Success
qg1 -> req : Revise Requirements

stop
note right: Feature deployed successfully

@enduml
```

### Example 2: Complex Multi-Path Workflow

**Input**:

```
build-flow project-lifecycle "Full project lifecycle with branching paths"

Steps:
1. Check if requirements exist
2. Generate or update requirements
3. Create project plan
4. Execute with quality gates
5. Handle different deployment scenarios
```

**Generated PlantUML**:

```plantuml
@startuml project-lifecycle
!theme plain
title Project Lifecycle Management Flow

start
note right: Full project lifecycle with intelligent branching

diamond "Requirements Exist?" as req_check
note right: Check for {{files.requirements}}

if (req_check) then (yes)
    rectangle "Update Requirements" as update_req {
        note : **Command**: `requirements.md`
        note : **Mode**: Update existing
    }
else (no)
    rectangle "Generate Requirements" as gen_req {
        note : **Input**: {{files.ask}}
        note : **Command**: `requirements.md`
        note : **Mode**: Create new
    }
endif

rectangle "plan" as plan_cmd {
    note : **Input**: {{files.requirements}}
    note : **Command**: `plan.md`
    note : **Output**: {{files.plan}}
}

rectangle "run" as run_cmd {
    note : **Input**: {{files.plan}}
    note : **Command**: `run.md`
    note : **Output**: Implementation
}

diamond "Deployment Type?" as deploy_check

if (deploy_check) then (Production)
    :Production Deployment;
    note right: Full validation and rollback capability
elseif (deploy_check) then (Staging)
    :Staging Deployment;
    note right: Integration testing environment
else (Development)
    :Development Deployment;
    note right: Local development environment
endif

stop
note right: Project lifecycle complete

@enduml
```

## Notes

- **Flow names should be descriptive** and follow kebab-case convention
- **Maximize reuse** of existing AI-LEY commands to avoid duplication
- **Include comprehensive documentation** within the PlantUML diagrams
- **Use consistent styling** for different component types
- **Validate command compatibility** before creating chains
- **Include error handling paths** for robust workflow design
- **Test generated diagrams** for visual clarity and correctness
- **Document prerequisites** and resource requirements clearly
