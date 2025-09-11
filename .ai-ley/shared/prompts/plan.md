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

- Load and analyze `{{files.indexes.personas}}` to understand available expertise profiles
- Load and analyze `{{files.indexes.instructions}}` to understand available technical guidance
- Map requirements to available personas in `{{folders.personas}}`
- Map requirements to available instructions in `{{folders.instructions}}`
- Identify missing expertise areas that need personas
- Identify missing technical guidance that needs instructions
- Determine external dependencies and third-party integrations

**Resource Mapping Process**:

1. **Parse Index Files**: Extract persona and instruction metadata including:

   - Expertise areas and technical skills
   - Experience levels and complexity handling
   - Domain knowledge and specializations
   - Tool and technology proficiencies
   - Communication styles and approaches

2. **Requirement Categorization**: Classify each requirement by:

   - Technical complexity (Simple/Moderate/High/Expert)
   - Domain area (Frontend/Backend/DevOps/Security/Testing/etc.)
   - Required expertise level
   - Communication style needed (Analytical/Creative/Technical/Default)

3. **Intelligent Matching Algorithm**: For each requirement:
   - Score personas based on expertise alignment
   - Score instructions based on technical relevance
   - Consider complexity matching (persona experience vs requirement difficulty)
   - Factor in workload distribution and availability
   - Select optimal persona-instruction combinations

**Resource Mapping Outputs**:

- Create persona-to-requirement mapping with confidence scores
- Create instruction-to-requirement mapping with relevance scores
- Generate resource utilization matrix showing workload distribution
- Log missing resources to `{{files.review}}` for later generation
- Estimate effort based on available expertise and optimal assignments

### Step 2.5: Intelligent Resource Matching Algorithm

Implement smart resource assignment using index-based matching:

**Matching Process**:

1. **Index Analysis**: For each persona and instruction in the indexes:

   - Extract skill tags, expertise levels, and domain specializations
   - Parse complexity ratings and experience indicators
   - Identify communication styles and working approaches
   - Note technology stack preferences and proficiencies

2. **Requirement Profiling**: For each identified requirement:

   - Determine required skill set and expertise level
   - Assess technical complexity and domain knowledge needs
   - Identify preferred communication and working styles
   - Map to technology stack and tooling requirements

3. **Scoring Algorithm**: Calculate assignment scores using:

   ```
   Assignment Score = (Skill_Match * 0.4) + (Experience_Level * 0.3) +
                     (Domain_Knowledge * 0.2) + (Availability * 0.1)

   Where:
   - Skill_Match: 0-100 based on required vs available skills
   - Experience_Level: 0-100 based on complexity match
   - Domain_Knowledge: 0-100 based on specialization alignment
   - Availability: 0-100 based on current workload allocation
   ```

4. **Optimal Assignment Selection**: For each task/story:
   - Rank all personas by assignment score
   - Select highest-scoring available persona as primary
   - Identify secondary personas for review/support roles
   - Match relevant instructions based on technical requirements
   - Document selection rationale and confidence level

**Resource Optimization**:

- Balance workload across available personas
- Ensure critical expertise is not over-allocated
- Plan for knowledge transfer and mentoring opportunities
- Identify cross-training needs for better resource utilization
- Schedule persona availability to minimize conflicts

**Quality Assurance**:

- Validate that complex tasks are assigned to expert-level personas
- Ensure review assignments include appropriate senior resources
- Check that all required expertise areas are covered
- Verify instruction relevance and completeness for each assignment
- Document any gaps or risks in resource allocation

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

## Resource Assignments

**Primary Persona**: `{{folders.personas}}/[best-match-persona].md` (Confidence: X%)

- **Expertise Match**: [Why this persona was selected]
- **Experience Level**: [Matching complexity level]
- **Domain Knowledge**: [Relevant specializations]

**Supporting Personas**:

- `{{folders.personas}}/[secondary-persona].md` (For [specific aspect])
- `{{folders.personas}}/[review-persona].md` (For quality assurance)

**Instructions**:

- `{{folders.instructions}}/[primary-instruction].md` (Relevance: X%)
- `{{folders.instructions}}/[secondary-instruction].md` (For [specific guidance])

**Context Directories**:

- `{{folders.context}}/[relevant-directories]/`

## Technical Details

**Complexity**: Expert/High/Moderate/Simple
**Style**: Analytical/Creative/Technical/Default
**Estimated Hours**: X hours (based on persona experience and task complexity)

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

## Resource Assignments

**Optimal Persona**: `{{folders.personas}}/[selected-persona].md`

- **Selection Rationale**: [Why this persona was chosen based on index analysis]
- **Expertise Score**: X/100 (based on skill alignment)
- **Experience Level**: [Persona's capability vs task complexity]

**Required Instructions**:

- **Primary**: `{{folders.instructions}}/[main-instruction].md` (Relevance: X%)
- **Secondary**: `{{folders.instructions}}/[supporting-instruction].md` (For [specific aspect])

**Alternative Assignments** (if primary is unavailable):

- **Backup Persona**: `{{folders.personas}}/[alternative-persona].md`
- **Rationale**: [Why this is a viable alternative]

## Technical Context

**Files to Modify**: [List of files]
**Technologies**: [Specific tech stack elements]
**Patterns**: [Design patterns to apply]
**Testing Requirements**: [Unit/integration tests needed]
**Complexity Assessment**: [Simple/Moderate/High/Expert - matching persona capability]

## Implementation Steps

1. [Step 1 with specific action and persona guidance]
2. [Step 2 with specific action and instruction reference]
3. [Step 3 with specific action and quality validation]

## Quality Gates

- [ ] Code follows project standards (validated by [persona])
- [ ] Tests written and passing (guided by [testing-instruction])
- [ ] Documentation updated (reviewed by [documentation-persona])
- [ ] Performance requirements met (validated by [performance-instruction])
- [ ] Security requirements addressed (reviewed by [security-persona])

## Dependencies

**Prerequisite Tasks**: [Tasks that must complete first]
**Resource Dependencies**: [External resources needed]
**Knowledge Dependencies**: [Specific expertise required from index]
**Persona Dependencies**: [If requires coordination between multiple personas]
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

Create team structure and resource allocation plan based on intelligent matching:

**Create `{{folders.plan}}/planning/resource-allocation.md`**:

```markdown
# Resource Allocation Plan

## Intelligent Resource Matching Summary

**Matching Methodology**: Index-based scoring algorithm with skill alignment, experience level, domain knowledge, and availability factors.

**Overall Assignment Confidence**: X% (average confidence across all assignments)

**Critical Resource Dependencies**: [List any single points of failure or over-allocated experts]

## Persona Assignment Matrix

### Primary Assignments (by Epic/Story)

**Epic 1: Foundation**

- **Story 1.1**: `{{folders.personas}}/devops-engineer.md` (Score: 95/100)
  - **Rationale**: Perfect match for infrastructure and CI/CD expertise
  - **Supporting**: `{{folders.personas}}/senior-developer.md` (for code review)
- **Story 1.2**: `{{folders.personas}}/technical-architect.md` (Score: 92/100)
  - **Rationale**: High-level design and architectural decision expertise

**Epic 2: Core Features**

- **Story 2.1**: `{{folders.personas}}/backend-developer.md` (Score: 88/100)
  - **Rationale**: API development and database design specialization
  - **Supporting**: `{{folders.personas}}/security-specialist.md` (for security review)

### Instruction Mapping by Technical Area

**Infrastructure & DevOps**:

- Primary: `{{folders.instructions}}/cicd-pipeline-setup.md`
- Secondary: `{{folders.instructions}}/containerization-best-practices.md`

**Backend Development**:

- Primary: `{{folders.instructions}}/api-design-patterns.md`
- Secondary: `{{folders.instructions}}/database-optimization.md`

**Frontend Development**:

- Primary: `{{folders.instructions}}/react-component-architecture.md`
- Secondary: `{{folders.instructions}}/responsive-design-principles.md`

## Team Structure and Roles

**Core Team** (based on available personas):

- **Technical Lead**: `{{folders.personas}}/technical-architect.md`

  - **Assignment Confidence**: 95%
  - **Workload**: Architecture design, complex implementation tasks
  - **Backup**: `{{folders.personas}}/senior-developer.md`

- **Senior Developer**: `{{folders.personas}}/senior-developer.md`

  - **Assignment Confidence**: 90%
  - **Workload**: Core feature development, code reviews
  - **Specializations**: [Based on persona expertise from index]

- **Frontend Developer**: `{{folders.personas}}/frontend-developer.md`

  - **Assignment Confidence**: 85%
  - **Workload**: User interface implementation, user experience
  - **Technology Stack**: [React/Vue/Angular based on persona proficiency]

- **Backend Developer**: `{{folders.personas}}/backend-developer.md`

  - **Assignment Confidence**: 88%
  - **Workload**: API development, database design
  - **Specializations**: [Database types and API patterns from index]

- **DevOps Engineer**: `{{folders.personas}}/devops-engineer.md`

  - **Assignment Confidence**: 93%
  - **Workload**: Infrastructure, CI/CD, deployment
  - **Tool Proficiency**: [Docker/Kubernetes/Cloud platforms from index]

- **QA Engineer**: `{{folders.personas}}/qa-engineer.md`
  - **Assignment Confidence**: 87%
  - **Workload**: Testing strategy, test automation
  - **Testing Approaches**: [Unit/Integration/E2E based on persona expertise]

## Sprint Capacity Planning

**Sprint Velocity Estimates** (adjusted for persona capabilities):

- Sprint 1 (Foundation): 35 story points

  - **Primary Contributors**: DevOps Engineer (20 pts), Technical Architect (15 pts)
  - **Resource Utilization**: 85% (accounting for setup overhead)

- Sprint 2 (Core Features): 40 story points

  - **Primary Contributors**: Backend Dev (25 pts), Frontend Dev (15 pts)
  - **Resource Utilization**: 90% (team ramped up)

- Sprint 3 (Advanced Features): 42 story points
  - **Balanced allocation across all team members**
  - **Resource Utilization**: 95% (peak efficiency)

**Resource Allocation by Epic** (based on optimal assignments):

- **Epic 1**: DevOps Engineer (100%), Technical Architect (75%), Senior Dev (50%)
- **Epic 2**: Backend Dev (100%), Frontend Dev (100%), QA Engineer (75%)
- **Epic 3**: All team members with balanced workload distribution

## Persona Workload Analysis

**High Utilization Personas** (>80% allocation):

- `{{folders.personas}}/devops-engineer.md`: 95% utilization

  - **Risk**: Single point of failure for infrastructure
  - **Mitigation**: Cross-train Senior Developer on deployment processes

- `{{folders.personas}}/backend-developer.md`: 90% utilization
  - **Risk**: API development bottleneck
  - **Mitigation**: Technical Architect to provide API design support

**Optimal Utilization Personas** (60-80% allocation):

- `{{folders.personas}}/frontend-developer.md`: 75% utilization
- `{{folders.personas}}/qa-engineer.md`: 70% utilization

**Low Utilization Personas** (<60% allocation):

- `{{folders.personas}}/technical-architect.md`: 55% utilization
  - **Opportunity**: Available for complex problem-solving and mentoring

## Missing Resource Analysis

**Resource Gaps Identified**:

- **Security Specialist**: No persona available for security-focused tasks

  - **Impact**: Medium - security reviews will need external expertise
  - **Logged to**: `{{files.review}}` for persona creation

- **Database Administrator**: No dedicated DBA persona available
  - **Impact**: Low - Backend Developer can handle basic database tasks
  - **Mitigation**: Technical Architect to provide database design guidance

**Instruction Gaps Identified**:

- **Performance Testing**: No dedicated performance testing instruction
  - **Impact**: Medium - performance validation may be inconsistent
  - **Logged to**: `{{files.review}}` for instruction creation

## Risk Mitigation

**Resource Risks**:

- **Over-allocation Risk**: DevOps Engineer at 95% utilization

  - **Mitigation**: Prepare backup assignment using Senior Developer
  - **Monitoring**: Track actual vs estimated effort weekly

- **Knowledge Concentration**: Critical expertise concentrated in few personas

  - **Mitigation**: Schedule knowledge sharing sessions
  - **Cross-training**: Identify mentoring opportunities

- **Dependency Bottlenecks**: Sequential dependencies may cause delays
  - **Mitigation**: Plan parallel work streams where possible
  - **Buffer Time**: Add 15% buffer for complex technical tasks

**Dependency Management**:

- **Early identification of external dependencies**
- **Backup plans for critical path items requiring scarce expertise**
- **Regular dependency review meetings with persona assignments**
- **Escalation procedures for persona availability conflicts**

## Quality Assurance Strategy

**Review Assignments** (based on expertise matching):

- **Architecture Reviews**: Technical Architect (100% coverage)
- **Code Reviews**: Senior Developer + domain-specific personas
- **Security Reviews**: [External consultant] + Technical Architect
- **Performance Reviews**: [Performance Testing instruction] + Senior Developer

**Knowledge Transfer Plan**:

- **Persona Shadowing**: Junior personas work with senior on complex tasks
- **Documentation Requirements**: All personas must document decisions and approaches
- **Regular Team Syncs**: Share learnings and best practices across personas
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
- [ ] Resource assignments based on intelligent matching from `{{files.indexes.personas}}` and `{{files.indexes.instructions}}`
- [ ] Persona assignments include confidence scores and selection rationale
- [ ] Instruction assignments show relevance scores and technical alignment
- [ ] Alternative resource assignments documented for high-risk dependencies
- [ ] Resource utilization balanced across available personas (no >95% allocation)
- [ ] Missing resources properly logged to `{{files.review}}` for future creation
- [ ] Timeline estimates account for persona experience levels and capabilities
- [ ] Quality gates include appropriate persona assignments for reviews
- [ ] JIRA import file includes persona assignments and instruction references
- [ ] Gantt chart accurately reflects dependencies and timeline
- [ ] Business case justifies the investment and approach

**Resource Assignment Validation**:

- [ ] All tasks have primary persona assignments with >70% confidence scores
- [ ] Complex tasks (Expert level) assigned to personas with appropriate experience
- [ ] Review tasks include secondary persona assignments for quality assurance
- [ ] Instruction assignments align with technical requirements and persona capabilities
- [ ] Workload distribution prevents over-allocation of critical expertise
- [ ] Backup assignments identified for high-risk or specialized tasks
- [ ] Cross-training opportunities identified for knowledge transfer

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
- [ ] Resource needs identified and mapped using intelligent matching algorithm
- [ ] Persona assignments based on index analysis with documented confidence scores
- [ ] Instruction assignments show relevance alignment and technical coverage
- [ ] Dependencies clearly defined and realistic
- [ ] Alternative resource assignments documented for risk mitigation
- [ ] Timeline estimates based on team capacity, persona experience, and complexity
- [ ] Quality standards defined at each level with appropriate reviewer assignments

**Plan Quality**:

- [ ] Stories follow proper user story format with acceptance criteria
- [ ] Tasks are actionable and have clear deliverables with optimal persona assignments
- [ ] Resource allocation is balanced and realistic based on persona capabilities
- [ ] Risk assessment includes mitigation strategies and backup resource assignments
- [ ] Business case supports investment and approach
- [ ] Missing resources properly identified and logged for future development

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
