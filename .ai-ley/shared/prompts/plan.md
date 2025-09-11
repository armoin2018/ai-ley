---
agentMode: general
applyTo: general
author: AI-LEY
description: Generate comprehensive project plans from requirements using Epic-Story-Task structure with JIRA compatibility and Gantt charts.
extensions:
  - .md
guidelines: Follow Universal Project Coding & Management Guide
instructionType: general
keywords: [planning, epic, story, task, jira, gantt, project-management]
lastUpdated: '2025-08-15T00:00:00.000000'
summaryScore: 5.0
title: Plan
version: 1.0.0
---

# Copilot Command: Generate Project Plan

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Convert detailed requirements from `{{files.requirements}}` into a comprehensive, actionable project plan using Epic-Story-Task structure with JIRA compatibility, Gantt charts, and intelligent resource allocation. The plan should be immediately executable with clear dependencies, time estimates, and quality gates.

## Project Structure

The command creates a comprehensive plan structure:

```
{{folders.project}}/PLAN.md
{{folders.plan}}/
├── business/                          # Business case and financial documents
│   ├── business-case.md               # Detailed business case
│   ├── financial-estimates.md         # Cost estimates and projections
│   ├── revenue-projections.md         # Revenue and ROI analysis
│   └── pitch-deck.md                  # Executive presentation
├── architecture/                      # Technical architecture documentation
│   ├── README.md                      # Architecture overview
│   ├── diagrams/                      # PlantUML diagrams
│   │   ├── data-flow.puml            # Data flow diagrams
│   │   ├── sequence.puml             # Sequence diagrams
│   │   ├── erd.puml                  # Entity relationship diagrams
│   │   ├── component.puml            # Component diagrams
│   │   └── deployment.puml           # Deployment diagrams
│   ├── design-patterns.md            # Design patterns and principles
│   ├── technology-stack.md           # Technology decisions
│   └── api-specifications.md         # API design and contracts
├── planning/                          # Project planning artifacts
│   ├── gantt-chart.puml              # PlantUML Gantt chart
│   ├── jira-import.csv               # JIRA-compatible import file
│   └── resource-allocation.md        # Team and resource planning
└── epics/                            # Epic-based project structure
    ├── epic-001-foundation/          # Epic folder
    │   ├── README.md                 # Epic details and overview
    │   ├── story-001-setup/          # Story folder
    │   │   ├── README.md             # Story details
    │   │   ├── task-001-init.md      # Individual task files
    │   │   └── task-002-config.md    # Individual task files
    │   └── story-002-core/
    │       ├── README.md
    │       └── task-001-impl.md
    └── epic-002-features/
        ├── README.md
        └── story-001-auth/
            ├── README.md
            └── task-001-login.md
```

## Command

You are a senior project manager and technical architect specializing in agile planning methodologies. Your expertise includes Epic-Story-Task decomposition, JIRA workflow optimization, and intelligent resource allocation.

### Step 1: Requirements Analysis and Validation

Load and analyze the requirements to ensure completeness:

**Actions**:

- Load `{{files.requirements}}` as the primary input
- Load suggestions from `{{files.suggestions}}`
- Load new requests from `{{files.ask}}`
- Load known issues from `{{files.bugs}}`
- Load project indexes from `{{files.indexes.personas}}` and `{{files.indexes.instructions}}`
- Integrate changes from the `{{files.suggestions}}`, `{{files.ask}}`, and `{{files.bugs}}` into the `{{files.requirements}}`
- Validate requirements completeness and clarity

**Analysis Tasks**:

- Identify functional requirements (R1, R2, R3...)
- Identify non-functional requirements (NF1, NF2, NF3...)
- Extract user stories and acceptance criteria
- Identify technical dependencies and constraints
- Determine compliance and regulatory requirements

### Step 2: Resource Requirements Analysis

Analyze requirements against available resources and identify gaps:

**Actions**:

- Map requirements to available personas in `{{folders.personas}}`
- Map requirements to available instructions in `{{folders.instructions}}`
- Identify missing expertise areas that need personas
- Identify missing technical guidance that needs instructions
- Determine external dependencies and third-party integrations

**Resource Mapping**:

- Create persona-to-requirement mapping
- Create instruction-to-requirement mapping
- Log missing resources to `{{files.review}}` for later generation
- Estimate effort based on available expertise

### Step 3: Epic Decomposition

Break down requirements into logical epics representing major functional areas:

**Epic Creation Guidelines**:

- Group related functionality into cohesive epics
- Ensure each epic delivers standalone business value
- Keep epics to reasonable size (15-40 story points)
- Define clear epic-level success criteria
- Establish epic dependencies and sequencing

**Epic Structure**:
Create `{{folders.plan}}/epics/epic-XXX-[name]/README.md` for each epic:

```markdown
# Epic XXX: [EPIC NAME]

## Overview

**Epic ID**: EPIC-XXX
**Priority**: High/Medium/Low
**Status**: Not Started
**Estimated Effort**: X Story Points
**Sprint Assignment**: Sprint X-Y
**Dependencies**: [List epic dependencies]

## Business Value

**Objective**: [Clear business objective]
**Success Metrics**: [Measurable outcomes]
**Acceptance Criteria**: [Epic-level success criteria]
**ROI Impact**: [Revenue/cost impact]

## Technical Context

**Architecture Impact**: [System components affected]
**Technology Stack**: [Primary technologies involved]
**Integration Points**: [External system connections]
**Performance Requirements**: [Performance benchmarks]

## Stories

- [ ] [Story 1: Story Name](story-001-[name]/README.md)
- [ ] [Story 2: Story Name](story-002-[name]/README.md)

## Risk Assessment

**Technical Risks**: [List and mitigation strategies]
**Business Risks**: [Market/user risks]
**Dependency Risks**: [External dependency risks]

## Model Selection Guidance

**Recommended Models by Task Type**:

- Planning/Analysis: GPT-4 (Expert/Analytical)
- Implementation: Claude-3-Sonnet (High/Technical)
- Testing: GPT-3.5-Turbo (Moderate/Technical)
- Documentation: Claude-3-Sonnet (Moderate/Creative)
```

### Step 4: Story Decomposition

Break down each epic into user stories representing specific user value:

**Story Creation Guidelines**:

- Follow "As a [user], I want [goal], so that [benefit]" format
- Keep stories small enough to complete in one sprint (3-8 story points)
- Ensure each story has clear acceptance criteria
- Define story dependencies and prerequisites
- Assign stories to appropriate personas and instructions

**Story Structure**:
Create `{{folders.plan}}/epics/epic-XXX/story-XXX-[name]/README.md` for each story:

```markdown
# Story XXX: [STORY NAME]

## Overview

**Story ID**: STORY-XXX
**Epic**: [Parent Epic]
**Priority**: High/Medium/Low
**Status**: Not Started
**Effort**: X SP
**Sprint**: Sprint X
**Assignee**: [Team member/persona]

## User Story

**As a** [user type]
**I want** [goal/functionality]
**So that** [benefit/value]

## Acceptance Criteria

- [ ] [Specific testable condition 1]
- [ ] [Specific testable condition 2]
- [ ] [Specific testable condition 3]

## Technical Details

**Personas**: `persona-file.md`
**Instructions**: `instruction-file.md`
**Context**: `relevant-directories/`
**Complexity**: Expert/High/Moderate/Simple
**Style**: Analytical/Creative/Technical/Default

## Tasks

- [ ] [Task 1: Task Name](task-001-[name].md)
- [ ] [Task 2: Task Name](task-002-[name].md)

## Dependencies

**Prerequisite Stories**: [Stories that must complete first]
**Blocking Stories**: [Stories blocked by this one]
**External Dependencies**: [Third-party/system dependencies]

## Definition of Done

- [ ] All tasks completed
- [ ] All acceptance criteria met
- [ ] Code review completed by relevant persona
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Performance benchmarks met
- [ ] Security review completed
```

### Step 5: Task Decomposition

Break down each story into specific, actionable tasks:

**Task Creation Guidelines**:

- Make tasks small enough to complete in 1-4 hours
- Ensure tasks have specific, measurable deliverables
- Define clear quality gates for each task
- Assign appropriate personas and instructions
- Estimate effort and identify dependencies

**Task Structure**:
Create `{{folders.plan}}/epics/epic-XXX/story-XXX/task-XXX-[name].md` for each task:

```markdown
# Task XXX: [TASK NAME]

## Overview

**Task ID**: TASK-XXX
**Story**: [Parent Story]
**Priority**: High/Medium/Low
**Status**: Not Started
**Estimated Hours**: X hours
**Assignee**: [Team member/persona]

## Description

[Detailed description of what needs to be accomplished]

## Acceptance Criteria

- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2]
- [ ] [Quality/performance requirement]

## Technical Context

**Files to Modify**: [List of files]
**Technologies**: [Specific tech stack elements]
**Patterns**: [Design patterns to apply]
**Testing Requirements**: [Unit/integration tests needed]

## Implementation Steps

1. [Step 1 with specific action]
2. [Step 2 with specific action]
3. [Step 3 with specific action]

## Quality Gates

- [ ] Code follows project standards
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Performance requirements met
- [ ] Security requirements addressed

## Dependencies

**Prerequisite Tasks**: [Tasks that must complete first]
**Resource Dependencies**: [External resources needed]
**Knowledge Dependencies**: [Specific expertise required]
```

### Step 6: JIRA Integration Artifacts

Generate JIRA-compatible import file for project management integration:

**Create `{{folders.plan}}/planning/jira-import.csv`**:

```csv
Summary,Issue Type,Priority,Description,Epic Link,Story Points,Assignee,Labels,Components,Fix Version,Sprint,Dependencies
"EPIC: Foundation Infrastructure",Epic,High,"Establish core project infrastructure and development environment",,"16",,"infrastructure,foundation",,"1.0.0",,"None"
"Setup Development Environment",Story,High,"Configure development tools and environment",EPIC-001,"3",,"setup,devenv",,"1.0.0","Sprint 1","None"
"Initialize Project Structure",Task,High,"Create initial project directory structure and configuration files",STORY-001,"2",,"setup,config",,"1.0.0","Sprint 1","None"
"Configure CI/CD Pipeline",Task,High,"Set up continuous integration and deployment pipeline",STORY-001,"4",,"cicd,automation",,"1.0.0","Sprint 1","Setup Development Environment"
```

**CSV Column Guidelines**:

- **Summary**: Brief, descriptive title for the work item
- **Issue Type**: Epic/Story/Task/Bug
- **Priority**: High/Medium/Low/Blocker
- **Description**: Detailed description with context
- **Epic Link**: Links Stories and Tasks to parent Epics
- **Story Points**: Effort estimation for Stories (Fibonacci: 1,2,3,5,8,13,21)
- **Assignee**: Team member or persona responsible
- **Labels**: Tags for categorization (comma-separated)
- **Components**: System components affected
- **Fix Version**: Target release version
- **Sprint**: Sprint assignment for planning
- **Dependencies**: Prerequisite items (comma-separated)

### Step 7: Gantt Chart Generation

Create visual project timeline using PlantUML:

**Create `{{folders.plan}}/planning/gantt-chart.puml`**:

```plantuml
@startgantt
!theme plain
title Project Development Timeline

Project starts 2025-08-15

[Planning Phase] lasts 5 days
[Architecture Phase] lasts 7 days
[Architecture Phase] starts at [Planning Phase]'s end

[Epic 1: Foundation] lasts 14 days
[Epic 1: Foundation] starts at [Architecture Phase]'s end

[Story 1.1: Project Setup] lasts 3 days
[Story 1.1: Project Setup] starts at [Epic 1: Foundation]'s start

[Task 1.1.1: Initialize Structure] lasts 1 day
[Task 1.1.1: Initialize Structure] starts at [Story 1.1: Project Setup]'s start

[Task 1.1.2: Configure Environment] lasts 2 days
[Task 1.1.2: Configure Environment] starts at [Task 1.1.1: Initialize Structure]'s end

[Story 1.2: CI/CD Setup] lasts 4 days
[Story 1.2: CI/CD Setup] starts at [Task 1.1.2: Configure Environment]'s end

[Epic 2: Core Features] lasts 21 days
[Epic 2: Core Features] starts at [Story 1.2: CI/CD Setup]'s end

-- Milestones --
milestone : Foundation Complete
milestone happens at [Epic 1: Foundation]'s end

milestone : Core Features Complete
milestone happens at [Epic 2: Core Features]'s end

@endgantt
```

**Gantt Chart Features**:

- Visual timeline showing all epics, stories, and critical tasks
- Dependencies displayed with proper sequencing
- Milestones for major deliverables
- Critical path identification
- Resource allocation visibility

### Step 8: Resource Allocation Planning

Create team structure and resource allocation plan:

**Create `{{folders.plan}}/planning/resource-allocation.md`**:

```markdown
# Resource Allocation Plan

## Team Structure and Roles

**Core Team**:

- **Technical Lead**: Architecture design, complex implementation tasks
- **Senior Developer**: Core feature development, code reviews
- **Frontend Developer**: User interface implementation, user experience
- **Backend Developer**: API development, database design
- **DevOps Engineer**: Infrastructure, CI/CD, deployment
- **QA Engineer**: Testing strategy, test automation
- **Product Manager**: Requirements clarification, stakeholder communication

## Persona Mapping

**Development Roles**:

- `{{folders.personas}}/technical-architect.md` → Technical Lead
- `{{folders.personas}}/senior-developer.md` → Senior Developer
- `{{folders.personas}}/frontend-developer.md` → Frontend Developer
- `{{folders.personas}}/backend-developer.md` → Backend Developer
- `{{folders.personas}}/devops-engineer.md` → DevOps Engineer
- `{{folders.personas}}/qa-engineer.md` → QA Engineer
- `{{folders.personas}}/product-manager.md` → Product Manager

## Sprint Capacity Planning

**Sprint Velocity Estimates**:

- Sprint 1 (Foundation): 35 story points
- Sprint 2 (Core Features): 40 story points
- Sprint 3 (Advanced Features): 42 story points
- Sprint 4 (Integration): 35 story points
- Sprint 5 (Testing & Polish): 30 story points

**Resource Allocation by Epic**:

- Epic 1: Technical Lead (50%), Senior Dev (75%), DevOps (100%)
- Epic 2: Frontend Dev (100%), Backend Dev (100%), QA (50%)
- Epic 3: All team members (balanced allocation)

## Risk Mitigation

**Resource Risks**:

- Cross-training on critical components
- Buffer time for complex technical tasks
- Early integration testing points
- Stakeholder review checkpoints
- Knowledge sharing sessions

**Dependency Management**:

- Early identification of external dependencies
- Backup plans for critical path items
- Regular dependency review meetings
- Escalation procedures for blockers
```

### Step 9: Architecture and Design Documentation

Create supporting architecture documentation:

**Create `{{folders.plan}}/architecture/README.md`**:

```markdown
# Architecture Overview

## System Context

[High-level system description based on requirements]

## Architecture Principles

- [Principle 1: e.g., Microservices for scalability]
- [Principle 2: e.g., API-first design]
- [Principle 3: e.g., Security by design]

## Technology Stack

**Frontend**: [Technology choices with rationale]
**Backend**: [Framework and language choices]
**Database**: [Data storage decisions]
**Infrastructure**: [Deployment and hosting choices]
**Integration**: [Third-party services and APIs]

## Quality Attributes

**Performance**: [Performance requirements and targets]
**Security**: [Security requirements and measures]
**Scalability**: [Scaling requirements and approach]
**Reliability**: [Availability and fault tolerance]
**Maintainability**: [Code quality and technical debt management]
```

### Step 10: Business Case and Financial Planning

Create business justification documents:

**Create `{{folders.plan}}/business/business-case.md`**:

```markdown
# Business Case

## Executive Summary

[Brief overview of the project value proposition]

## Problem Statement

[Clear articulation of the business problem being solved]

## Proposed Solution

[High-level solution approach and key benefits]

## Market Analysis

**Target Market**: [Primary target audience and market size]
**Competition**: [Competitive landscape and differentiation]
**Opportunity**: [Market opportunity and timing]

## Financial Impact

**Development Investment**: [Total development cost estimate]
**Expected Revenue**: [Revenue projections and assumptions]
**ROI Analysis**: [Return on investment calculations]
**Break-even Timeline**: [When the investment pays back]

## Risk Assessment

**Technical Risks**: [Technology and implementation risks]
**Market Risks**: [Business and competitive risks]
**Resource Risks**: [Team and timeline risks]
**Mitigation Strategies**: [How risks will be managed]

## Success Metrics

**Business KPIs**: [Key performance indicators for success]
**Technical Metrics**: [System performance and quality metrics]
**User Metrics**: [User adoption and satisfaction measures]
```

### Step 11: Master Plan Navigation

Create master plan overview document:

**Create `{{folders.plan}}/PLAN.md`**:

```markdown
# Project Plan Overview

## Quick Navigation

- [Business Case](business/business-case.md) - Business justification and ROI
- [Architecture](architecture/README.md) - Technical architecture and design
- [Planning Artifacts](planning/) - Gantt charts, JIRA imports, resources
- [Epic Breakdown](epics/) - Detailed epic, story, and task structure

## Project Summary

**Objective**: [One-sentence project goal]
**Timeline**: [Project duration and key milestones]  
**Team Size**: [Number of team members and key roles]
**Budget**: [Total project budget and major cost categories]

## Epic Overview

### Epic 1: Foundation ([X Story Points])

- Status: Not Started
- Stories: [Number] stories, [Number] tasks
- Sprint: Sprint 1-2
- Key Deliverables: [Major outputs]

### Epic 2: Core Features ([X Story Points])

- Status: Not Started
- Stories: [Number] stories, [Number] tasks
- Sprint: Sprint 3-4
- Key Deliverables: [Major outputs]

[Additional epics...]

## Key Milestones

- **M1**: Foundation Complete - [Date]
- **M2**: Core Features Complete - [Date]
- **M3**: Integration Complete - [Date]
- **M4**: Project Complete - [Date]

## Resource Requirements

**Team Structure**: [Brief team overview]
**Key Personas**: [Critical personas needed]
**External Dependencies**: [Third-party dependencies]
**Infrastructure Needs**: [Technology and tool requirements]

## Success Criteria

- [ ] All functional requirements implemented
- [ ] All non-functional requirements met
- [ ] Quality gates passed
- [ ] Stakeholder acceptance achieved
- [ ] Budget and timeline targets met
```

### Step 12: Plan Validation and Optimization

Validate the complete plan for quality and feasibility:

**Validation Checks**:

- [ ] All requirements from `{{files.requirements}}` are addressed
- [ ] Epic-Story-Task hierarchy is logical and complete
- [ ] Dependencies are properly mapped and realistic
- [ ] Resource assignments match available personas and instructions
- [ ] Timeline estimates are reasonable and achievable
- [ ] Quality gates are comprehensive and measurable
- [ ] JIRA import file is properly formatted and complete
- [ ] Gantt chart accurately reflects dependencies and timeline
- [ ] Business case justifies the investment and approach

**Optimization Actions**:

- Identify opportunities for parallel execution
- Optimize task sequencing for efficiency
- Balance workload across team members
- Minimize critical path dependencies
- Add buffer time for high-risk items
- Ensure resource utilization is realistic

### Step 13: Plan Delivery and Integration

Finalize and deliver the complete plan:

**Deliverables**:

- Save complete plan structure to `{{folders.plan}}/`
- Update `{{files.changelog}}` with plan creation details
- Log planning activity to `{{files.history}}` for traceability
- Add new resource requirements to `{{files.review}}` if needed
- Integrate suggestions from `{{files.suggestions}}` as appropriate

**Integration Points**:

- Plan is ready for execution by build-plan-run command
- Plan references existing personas and instructions
- Plan is compatible with JIRA and other project management tools
- Plan provides clear guidance for AI-assisted development

## Quality Gates

**Plan Completeness**:

- [ ] All requirements addressed in epic-story-task breakdown
- [ ] Resource needs identified and mapped to personas/instructions
- [ ] Dependencies clearly defined and realistic
- [ ] Timeline estimates based on team capacity and complexity
- [ ] Quality standards defined at each level (task, story, epic)

**Plan Quality**:

- [ ] Stories follow proper user story format with acceptance criteria
- [ ] Tasks are actionable and have clear deliverables
- [ ] Resource allocation is balanced and realistic
- [ ] Risk assessment includes mitigation strategies
- [ ] Business case supports investment and approach

**Tool Integration**:

- [ ] JIRA CSV format is correct and importable
- [ ] Gantt chart properly shows dependencies and timeline
- [ ] File structure follows AI-LEY standards and conventions
- [ ] Plan integrates with existing AI-LEY command ecosystem

## Success Metrics

**Planning Success**:

- Complete breakdown of requirements into executable tasks
- Clear resource allocation and timeline estimates
- Comprehensive business case and architecture documentation
- Integration-ready artifacts for project management tools

**Execution Readiness**:

- Plan provides clear guidance for AI-assisted development
- All necessary resources (personas, instructions) identified
- Quality gates enable continuous validation and improvement
- Business case supports stakeholder buy-in and funding decisions
