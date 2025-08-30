# PlantUML Flow Diagrams for Common Prompts

This directory contains PlantUML flow diagrams that visualize the workflow and process flow for each prompt in the `common/prompts/` directory.

## Diagram Files

### 1. Build-Plan-Run Complete Workflow

**File**: `build-plan-run.flow.puml`
**Source Prompt**: `build-plan-run.prompt.md`
**Description**: Comprehensive end-to-end workflow from ASK analysis through requirements, planning, architecture, execution, and optimization. Includes 7 major phases with intelligent model selection and memory management.

**Key Phases**:

- Phase 1: ASK to Requirements Transformation
- Phase 2: Creative Enhancement & Innovation
- Phase 3: Resource Discovery & Generation
- Phase 4: Architecture & Design
- Phase 5: Intelligent Planning
- Phase 6: Execution with Quality Gates
- Phase 7: Optimization & Cleanup

### 2. Build Implementation Plan

**File**: `build-plan.flow.puml`
**Source Prompt**: `build-plan.prompt.md`
**Description**: Workflow for transforming requirements into detailed implementation plans using Agile methodology with Epics, Stories, and Tasks.

**Key Steps**:

- Refine requirements by integrating suggestions and bugs
- Load and summarize reference materials
- Parse and map requirements to personas/instructions
- Create hierarchical plan structure
- Validate coverage and deliverability

### 3. Build Requirements from ASK

**File**: `build-requirements.flow.puml`
**Source Prompt**: `build-requirements.prompt.md`
**Description**: Process for transforming raw ideas and requests from ASK.md into production-ready requirements documentation.

**Key Steps**:

- Load and merge source materials
- Reconcile and organize content
- Refine for production readiness
- Validate completeness and clarity
- Deliver structured requirements

### 4. Git Commit Process

**File**: `git-commit.flow.puml`
**Source Prompt**: `git-commit.prompt.md`
**Description**: Standardized workflow for creating meaningful git commits with proper message formatting and change analysis.

**Key Steps**:

- Analyze current git status and changes
- Stage appropriate files
- Create conventional commit messages
- Execute commit with validation

### 5. Execute Plan Workflow

**File**: `run-plan.flow.puml`
**Source Prompt**: `run-plan.prompt.md`
**Description**: Systematic execution of implementation plans while maintaining quality standards and capturing improvements.

**Key Steps**:

- Load execution plan and standards
- Execute steps with persona guidance
- Capture suggestions and issues
- Update status and documentation

## Usage

To view these diagrams, you can:

1. **Online PlantUML Editor**: Copy the contents of any `.puml` file to [PlantUML Online Editor](http://www.plantuml.com/plantuml/uml/)

2. **VS Code Extension**: Install the PlantUML extension for VS Code to preview diagrams directly in the editor

3. **Command Line**: Use PlantUML CLI to generate images:

   ```bash
   plantuml *.puml
   ```

4. **Integration**: These diagrams can be embedded in documentation, presentations, or project wikis

## Diagram Conventions

- **Start/Stop**: Every workflow has clear entry and exit points
- **Partitions**: Major phases or logical groupings
- **Decision Points**: Diamond shapes for conditional logic
- **Notes**: Additional context and explanations
- **Color Coding**: Consistent visual themes for clarity

## Relationship to Prompts

Each PlantUML diagram directly corresponds to its source prompt file and visualizes:

- The logical flow of operations
- Decision points and branching logic
- Input and output artifacts
- Dependencies between steps
- Quality gates and validation points

These diagrams serve as both documentation and implementation guides for understanding and executing the prompt workflows.
