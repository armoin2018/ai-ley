---
agentMode: general
applyTo: general
author: AI-LEY
description: Generate detailed requirements from ASK documents and suggestions, integrating all inputs into comprehensive production-ready specifications.
extensions:
  - .md
guidelines: Follow AI-LEY project standards and Universal Project Coding & Management Guide
instructionType: general
keywords: [requirements, ask, suggestions, analysis, specifications, business-analysis]
lastUpdated: '2025-10-04T00:00:00.000000'
summaryScore: 5.0
title: Requirements
version: 1.1.0
---

# Copilot Command: Generate Requirements

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- **Primary source** (priority order):
  1. Structured intake responses from `.project/INTAKE.md` (if available)
  2. Raw ideas, goals, and requests from `{{files.ask}}`
  3. Enhancement suggestions from `{{files.suggestions}}`
- Existing requirements from `{{files.requirements}}` (if present)

Produce:

- Comprehensive, production-ready `{{files.requirements}}` document with clear specifications
- Updated `{{files.requirements_changelog}}` documenting all changes
- Clean up processed items from `{{files.ask}}` and `{{files.suggestions}}` as they are integrated
- Flag any items needing clarification with actionable TODO markers

## Chunking Strategy

**IMPORTANT**: Large requirements generation tasks MUST be broken down into manageable chunks to avoid token limits and ensure quality output.

### When to Use Chunking

- Projects with more than 20 functional requirements
- Complex systems with multiple subsystems or modules
- When the requirements document would exceed 5000 lines
- When analyzing large existing codebases for requirements extraction
- When context window limits are approaching

### Chunking Approaches

#### Approach 1: Functional Domain Chunking

Break requirements by functional domains:

- **Pass 1**: Authentication & Authorization requirements
- **Pass 2**: Core business logic requirements
- **Pass 3**: Data management & storage requirements
- **Pass 4**: API & integration requirements
- **Pass 5**: UI/UX requirements
- **Pass 6**: Non-functional & compliance requirements

#### Approach 2: Section-by-Section Chunking

Generate requirements document in sequential sections:

- **Pass 1**: Executive Summary & Overview (Section 3.1)
- **Pass 2**: Functional Requirements (Section 3.2)
- **Pass 3**: Non-Functional Requirements (Section 3.3)
- **Pass 4**: Compliance & Standards (Section 3.4)
- **Pass 5**: User Stories (Section 3.5)
- **Pass 6**: Technical Considerations & Dependencies (Sections 3.6-3.8)

#### Approach 3: Requirement Type Chunking

Group by requirement types:

- **Pass 1**: High-priority functional requirements (R1-R20)
- **Pass 2**: Medium/Low-priority functional requirements (R21-R40)
- **Pass 3**: Security & compliance requirements (C1-C15)
- **Pass 4**: Performance & reliability requirements (NF1-NF15)
- **Pass 5**: User stories mapped to all requirements (US1-US40)

### Chunking Workflow

For each chunk/pass:

1. **Declare Chunk Scope**: Clearly state which section/domain is being addressed
2. **Load Relevant Context**: Read only the files/sections needed for this chunk
3. **Generate Requirements**: Create requirements for this specific chunk
4. **Save Progress**: Write chunk to requirements file (append mode)
5. **Track Progress**: Update changelog with chunk completion status
6. **Verify**: Ensure chunk is complete before moving to next
7. **Cross-Reference**: Note any dependencies to other chunks for later integration

### Multi-Pass Integration

After all chunks are complete:

1. **Consolidation Pass**: Review entire requirements document for consistency
2. **Cross-Reference Pass**: Validate all requirement dependencies and references
3. **Numbering Pass**: Ensure sequential numbering (R1-RN, NF1-NFN, etc.)
4. **Deduplication Pass**: Remove any redundant requirements across chunks
5. **Final Validation Pass**: Run all validation checks from Step 7

### Chunk Progress Tracking

Maintain a progress tracker in requirements document during multi-pass generation:

```markdown
<!-- REQUIREMENTS GENERATION PROGRESS -->
<!-- DO NOT REMOVE UNTIL COMPLETE -->

## Generation Status

- [x] Pass 1: Executive Summary & Overview - COMPLETE
- [x] Pass 2: Core Functional Requirements (R1-R25) - COMPLETE
- [ ] Pass 3: Integration Requirements (R26-R40) - IN PROGRESS
- [ ] Pass 4: Non-Functional Requirements - PENDING
- [ ] Pass 5: Compliance Requirements - PENDING
- [ ] Pass 6: User Stories - PENDING
- [ ] Pass 7: Final Integration & Validation - PENDING

**Current Pass**: 3/7
**Estimated Completion**: Pass 7

<!-- END PROGRESS TRACKER -->
```

## Command

You are an expert business analyst, technical architect, and requirements engineer with deep expertise in translating business needs into actionable technical specifications.

**CRITICAL**: Before starting requirements generation, assess the scope and determine if chunking is needed. If the project requires more than 30 requirements or the existing codebase is large, automatically apply the appropriate chunking strategy and work in multiple passes.

### Step 0: Prerequisites - Check for Intake Document

**Check for structured intake data**:

Before proceeding with requirements generation, check if `.project/INTAKE.md` exists and contains intake data:

1. **Check if `.project/INTAKE.md` exists**

2. **If INTAKE.md exists and has content**:

   - Load intake responses as primary input source
   - Parse structured answers (Q&A format)
   - Extract key information:
     - Project name and description
     - Project goals and objectives
     - Technology stack
     - Team composition
     - Timeline and budget
     - Constraints and requirements
     - Referenced assets (personas, instructions, etc.)
   - Use intake data to inform requirements structure and content
   - Note in requirements: "Generated from intake session: [timestamp]"

3. **If INTAKE.md does NOT exist or is empty**:

   Ask the user if they want to run intake first:

   ```
   ℹ️  No structured intake data found.

   Running an intake session first can help create more comprehensive
   and accurate requirements.

   Would you like to:
   1. Run /intake to gather structured project information first (recommended)
   2. Continue with requirements generation from ASK/SUGGESTIONS
   3. Cancel and prepare intake manually

   Your choice (1/2/3):
   ```

4. **If user chooses to run intake (option 1)**:

   - Prompt for intake template type:

     ```
     Select intake template type:
     1. web-app - Web application project
     2. api - API or microservices project
     3. mobile - Mobile application project
     4. ml-pipeline - Machine learning pipeline
     5. general - General purpose project

     Your choice (1-5):
     ```

   - Trigger `/intake type=[selected-type]`
   - After intake completion, resume requirements generation

5. **If user chooses to continue (option 2)**:
   - Proceed with Step 1 using `{{files.ask}}` and `{{files.suggestions}}`
   - Note in requirements: "Generated without structured intake"

### Step 1: Scope Assessment and Chunking Decision

**PERFORM THIS STEP AFTER INTAKE CHECK**: Assess project scope to determine chunking strategy.

**Scope Assessment**:

1. **Check existing codebase size**: Count API endpoints, database models, modules
2. **Estimate requirement count**: Based on features, aim for 5-10 requirements per feature area
3. **Evaluate complexity**: Consider integrations, compliance needs, technical constraints
4. **Check ASK/Suggestions volume**: Count items needing analysis

**Chunking Decision Matrix**:

| Project Size | Estimated Requirements | Chunking Strategy      | Number of Passes |
| ------------ | ---------------------- | ---------------------- | ---------------- |
| Small        | < 30 requirements      | Single Pass            | 1                |
| Medium       | 30-60 requirements     | Functional Domain      | 3-4              |
| Large        | 60-100 requirements    | Section-by-Section     | 6-7              |
| Enterprise   | > 100 requirements     | Hybrid (Domain + Type) | 8-12             |

**If Chunking Required**:

1. Announce chunking strategy to user
2. Create progress tracker in requirements file
3. Define clear boundaries for each chunk
4. Proceed with Step 1 for first chunk only

### Step 2: Load and Analyze Sources

**Actions** (Adjust based on current chunk):

**Priority 1 - Structured Intake Data** (if available):

- Load `.project/INTAKE.md` and parse structured Q&A responses
- Extract key project information:
  - Project name, description, and goals from intake
  - Technology stack selections and justifications
  - Team composition and available expertise
  - Timeline, budget, and constraints
  - Platform targets and user personas
  - Referenced assets (personas, instructions, agents)
- Use intake responses as authoritative source for core requirements

**Priority 2 - Additional Context**:

- Load `{{files.ask}}` (raw ideas and requests not covered in intake)
- Load existing `{{files.requirements}}` (if present or from previous chunk)
- Load `{{files.suggestions}}` (enhancement suggestions and improvements)
- Load `{{files.bugs}}` (known issues to address)
- Load project context from `{{files.indexes.personas}}` and `{{files.indexes.instructions}}`
- **If chunking**: Load only the codebase sections relevant to current chunk

**Analysis Tasks** (Scoped to current chunk):

- **If INTAKE.md available**: Derive requirements from structured intake responses
  - Project goals → Functional requirements
  - Constraints → Non-functional requirements and compliance
  - Technology stack → Technical requirements and dependencies
  - Timeline/budget → Project constraints
- Identify all unique requests and ideas from ASK document relevant to this chunk
- Extract enhancement suggestions that should become requirements for this chunk
- Reconcile conflicts between intake, existing requirements, and new inputs
- Analyze complexity and scope of each request in this domain
- Map requests to business objectives and user needs
- **If chunking**: Note cross-chunk dependencies for later integration

### Step 3: Requirements Discovery and Clarification

**Discovery Questions** (Ask user for clarification if needed):

**Note**: If intake data is available, many of these questions may already be answered.
Reference intake responses and only ask for missing or unclear information.

**Problem Definition**:

- What specific problem are we solving? (Check INTAKE.md Q2: Project Description)
- What pain points are we addressing?
- What are the root causes of current issues?

**Target Users and Stakeholders**:

- Who will use this feature/system and what are their needs?
- What are the different user personas and their requirements?
- What are the stakeholder expectations and success criteria?

**Core Functionality**:

- What are the essential capabilities required? (Check INTAKE.md Q3: Project Goals)
- What are the must-have vs. nice-to-have features?
- What workflows and user journeys need to be supported?

**Success Criteria and Metrics**:

- How will we measure success?
- What are the key performance indicators (KPIs)?
- What are the acceptance criteria for each major feature?

**Scope and Boundaries**:

- What's included and what's explicitly excluded?
- What are the project boundaries and constraints?
- What integrations are required vs. future considerations?

**Technical Constraints**:

- Performance requirements and benchmarks?
- Security and compliance requirements?
- Platform limitations and technology constraints?
- Scalability and reliability requirements?

**Business Context**:

- Revenue potential, cost savings, competitive advantage?
- Target market size, competition, market timing?
- Budget and resource constraints?
- Timeline and milestone requirements?

### Step 3: Requirements Structure and Organization

**Create comprehensive requirements document with the following structure**:

#### 3.1 Executive Summary and Overview

- Project context and background
- High-level goals and objectives
- Business case summary
- Key stakeholders and their interests
- Success criteria and measurable outcomes

#### 3.2 Functional Requirements (R1, R2, R3...)

- **Core Features**: Essential functionality that must be delivered
- **User Interface Requirements**: User experience and interaction requirements
- **Data Requirements**: Data models, storage, and processing needs
- **Integration Requirements**: External system connections and APIs
- **Workflow Requirements**: Business processes and user journeys
- **Reporting Requirements**: Analytics, dashboards, and reporting needs

_Format each requirement as_:

```markdown
**R[X]: [Requirement Title]**

- **Description**: Clear, detailed description of what needs to be implemented
- **Acceptance Criteria**:
  - [ ] Specific testable condition 1
  - [ ] Specific testable condition 2
  - [ ] Specific testable condition 3
- **Priority**: High/Medium/Low
- **Complexity**: Simple/Moderate/High/Expert
- **Dependencies**: References to other requirements or external systems
- **Source**: Reference to originating ASK item or suggestion
```

#### 3.3 Non-Functional Requirements (NF1, NF2, NF3...)

- **Performance Requirements**: Response times, throughput, scalability targets
- **Security Requirements**: Authentication, authorization, data protection
- **Reliability Requirements**: Uptime, fault tolerance, disaster recovery
- **Usability Requirements**: User experience standards and accessibility
- **Compatibility Requirements**: Browser, device, and system compatibility
- **Maintainability Requirements**: Code quality, documentation standards

#### 3.4 Compliance & Standards Requirements (C1, C2, C3...)

- **Regulatory Compliance**: GDPR, HIPAA, SOX, industry regulations
- **Organizational Standards**: Company policies, coding standards, architecture principles
- **Security Standards**: Encryption, audit trails, access controls
- **Quality Standards**: Testing requirements, code coverage, performance benchmarks

#### 3.5 User Stories with Acceptance Criteria

- Convert functional requirements into user story format
- Include acceptance criteria for each story
- Map stories to user personas and workflows
- Define story priorities and dependencies

_Format each user story as_:

```markdown
**US[X]: [Story Title]**
**As a** [user type/persona]
**I want** [specific functionality/goal]
**So that** [business value/benefit]

**Acceptance Criteria**:

- [ ] [Specific testable condition 1]
- [ ] [Specific testable condition 2]
- [ ] [Specific testable condition 3]

**Related Requirements**: R1, R3, NF2
```

#### 3.6 Technical Considerations

- **Architecture Constraints**: System architecture requirements and limitations
- **Technology Stack**: Preferred technologies, frameworks, and platforms
- **Data Architecture**: Database design, data models, migration requirements
- **Security Architecture**: Security controls, threat modeling, risk assessment
- **Performance Architecture**: Caching strategies, load balancing, optimization

#### 3.7 Dependencies and Assumptions

- **Internal Dependencies**: Other projects, teams, or systems
- **External Dependencies**: Third-party services, vendors, regulatory approvals
- **Technical Dependencies**: Infrastructure, tools, libraries, frameworks
- **Business Assumptions**: Market conditions, user behavior, business priorities
- **Resource Assumptions**: Team availability, skill sets, budget constraints

#### 3.8 Success Metrics and KPIs

- **Business Metrics**: Revenue impact, cost savings, user adoption
- **Technical Metrics**: Performance benchmarks, system reliability, security metrics
- **User Experience Metrics**: User satisfaction, task completion rates, usability scores
- **Quality Metrics**: Bug rates, test coverage, code quality scores

### Step 4: Requirements Validation and Refinement

**Validation Checks**:

- [ ] All items from `{{files.ask}}` are addressed in requirements
- [ ] All suggestions from `{{files.suggestions}}` are evaluated and integrated or rejected with rationale
- [ ] Requirements are clear, testable, and unambiguous
- [ ] Conflicts and inconsistencies are resolved
- [ ] Dependencies are clearly identified and realistic
- [ ] Acceptance criteria are specific and measurable
- [ ] Requirements are traceable to business objectives

**Refinement Actions**:

- Remove redundancies and conflicting language
- Clarify vague or ambiguous items
- Add measurable acceptance criteria where missing
- Assign unique identifiers to each requirement
- Map requirements to relevant personas and instruction sets
- Ensure alignment with `.ai-ley/shared/global-instructions.md`
- Flag items needing clarification with `[TODO: ...]` markers

### Step 5: Integration and Cleanup

**Integration Actions**:

- Integrate processed ASK items into requirements
- Integrate approved suggestions into requirements
- Remove processed items from `{{files.ask}}` (mark as integrated)
- Remove processed items from `{{files.suggestions}}` (mark as integrated)
- Maintain unprocessed or rejected items with rationale

**ASK Cleanup Process**:

```markdown
# Original ASK Items Status

## Integrated into Requirements

- [x] ~~Item 1: User authentication system~~ → R1-R5, US1-US3
- [x] ~~Item 2: Dashboard with analytics~~ → R6-R8, NF3, US4-US6

## Needs Clarification

- [ ] Item 3: Advanced reporting [TODO: Define specific report types needed]
- [ ] Item 4: Mobile support [TODO: Specify target platforms and feature scope]

## Future Considerations

- [ ] Item 5: AI integration → Deferred to Phase 2
- [ ] Item 6: Multi-language support → Future enhancement
```

**Suggestions Cleanup Process**:

```markdown
# Suggestions Integration Status

## Integrated into Requirements

- [x] ~~Performance optimization suggestions~~ → NF1, NF2
- [x] ~~Security enhancement recommendations~~ → C1-C3, NF4

## Rejected with Rationale

- [x] ~~Complex workflow automation~~ → Out of scope for current phase
- [x] ~~Advanced AI features~~ → Technical complexity exceeds current resources

## Under Review

- [ ] API rate limiting → Evaluating technical feasibility
- [ ] Real-time notifications → Assessing user value vs. complexity
```

### Step 6: Documentation and Changelog

**Create Requirements Changelog (`{{files.requirements_changelog}}`)**:

```markdown
# Requirements Changelog

## Version 2.0 - [Current Date]

### Added

- **New Functional Requirements**: R1-R12 covering core user management and dashboard functionality
- **Enhanced Security Requirements**: C1-C5 for comprehensive security controls
- **Performance Benchmarks**: NF1-NF3 defining system performance targets

### Modified

- **Updated R3**: Enhanced user profile requirements based on stakeholder feedback
- **Refined NF2**: More specific performance targets based on technical analysis

### Integrated from ASK

- User authentication system → R1-R5, US1-US3
- Dashboard analytics → R6-R8, US4-US6
- Security enhancements → C1-C3, NF4

### Integrated from Suggestions

- Performance optimizations → NF1-NF2
- API design improvements → R9-R11
- User experience enhancements → R4, R7, US2

### Removed

- Deprecated legacy system integration requirements
- Out-of-scope advanced AI features moved to future phases

### Todo Items for Clarification

- [TODO: Define specific mobile platform requirements]
- [TODO: Clarify advanced reporting feature scope]
- [TODO: Confirm third-party integration security requirements]
```

### Step 7: Quality Assurance and Validation

**Final Quality Checks**:

- [ ] Requirements document is complete and comprehensive
- [ ] All ASK items have been processed (integrated, clarified, or deferred)
- [ ] All suggestions have been evaluated and processed
- [ ] Requirements are organized logically and numbered consistently
- [ ] Cross-references between requirements are accurate
- [ ] Acceptance criteria are specific and testable
- [ ] Dependencies are realistic and well-defined
- [ ] Success metrics are measurable and relevant

**Stakeholder Review Preparation**:

- [ ] Executive summary highlights key business value
- [ ] Technical requirements are clear for development teams
- [ ] User stories are understandable by product stakeholders
- [ ] Compliance requirements address regulatory needs
- [ ] Timeline and resource implications are realistic

### Step 8: Delivery and Handoff

**For Single-Pass Generation**:

**Final Deliverables**:

- Updated `{{files.requirements}}` with comprehensive specifications
- Updated `{{files.requirements_changelog}}` documenting all changes
- Cleaned up `{{files.ask}}` with integration status
- Cleaned up `{{files.suggestions}}` with evaluation results
- Summary report of requirements generation process

**For Multi-Pass/Chunked Generation**:

**Chunk Completion Deliverables**:

- Append chunk requirements to `{{files.requirements}}`
- Update progress tracker in requirements file
- Document chunk completion in `{{files.requirements_changelog}}`
- Note any cross-chunk dependencies discovered
- Provide summary of chunk: "Completed Pass X/Y: [Chunk Description]"
- Ask user: "Ready to proceed with next chunk?" or automatically continue if instructed

**Final Chunk Deliverables** (after all chunks complete):

- Complete requirements document with all sections integrated
- Consolidated `{{files.requirements_changelog}}`
- Final validation report with all checks passed
- Cross-reference validation of all dependencies
- Remove progress tracker from requirements file
- Cleaned up `{{files.ask}}` and `{{files.suggestions}}`
- Comprehensive summary report

**Integration Points**:

- Requirements are ready for planning phase (`plan` command)
- Requirements reference existing personas and instructions
- Requirements align with project standards and guidelines
- Requirements provide clear guidance for implementation teams
- **For chunked work**: All cross-chunk dependencies are resolved and documented

## Examples

### Example 1: Basic ASK Integration

**Input ASK Item**:

```markdown
- Need user login functionality
- Want analytics dashboard
- Must be secure
```

**Generated Requirement**:

```markdown
**R1: User Authentication System**

- **Description**: Implement secure user registration, login, and session management with email verification and password reset capabilities
- **Acceptance Criteria**:
  - [ ] Users can register with email and password
  - [ ] Email verification required before account activation
  - [ ] Secure login with password hashing (bcrypt or stronger)
  - [ ] Password reset functionality via email
  - [ ] Session management with secure logout
- **Priority**: High
- **Complexity**: Moderate
- **Dependencies**: Database schema design (R15), Email service integration (R16)
- **Source**: ASK Item 1
```

### Example 2: Suggestion Integration

**Input Suggestion**:

```markdown
- Add API rate limiting to prevent abuse
- Consider implementing caching for better performance
```

**Generated Requirements**:

```markdown
**NF3: API Rate Limiting**

- **Description**: Implement rate limiting on all public APIs to prevent abuse and ensure fair usage
- **Acceptance Criteria**:
  - [ ] 1000 requests per hour per user for authenticated endpoints
  - [ ] 100 requests per hour per IP for public endpoints
  - [ ] Graceful degradation with appropriate HTTP status codes
  - [ ] Rate limit headers in API responses
- **Priority**: High
- **Complexity**: Moderate
- **Dependencies**: API framework configuration, monitoring system
- **Source**: Suggestion - Security enhancements

**NF4: Performance Caching**

- **Description**: Implement multi-tier caching strategy to optimize system performance
- **Acceptance Criteria**:
  - [ ] Redis cache for frequently accessed data
  - [ ] Browser caching for static assets
  - [ ] Database query result caching
  - [ ] Cache invalidation strategy for data updates
- **Priority**: Medium
- **Complexity**: High
- **Dependencies**: Cache infrastructure setup, monitoring tools
- **Source**: Suggestion - Performance optimization
```

## Example 3: Multi-Pass Chunked Generation

**Scenario**: Large enterprise system with 80+ requirements across multiple domains

**Pass 1 - Executive Summary & Core Requirements**:

```markdown
<!-- REQUIREMENTS GENERATION PROGRESS -->

## Generation Status

- [x] Pass 1: Executive Summary & Core Auth Requirements (R1-R15) - COMPLETE
- [ ] Pass 2: Business Logic Requirements (R16-R35) - PENDING
- [ ] Pass 3: Integration & API Requirements (R36-R50) - PENDING
- [ ] Pass 4: Non-Functional Requirements (NF1-NF20) - PENDING
- [ ] Pass 5: Compliance Requirements (C1-C10) - PENDING
- [ ] Pass 6: User Stories (US1-US60) - PENDING
- [ ] Pass 7: Final Integration & Validation - PENDING

**Current Pass**: 1/7 - Completed executive summary and core authentication requirements

<!-- END PROGRESS TRACKER -->

# 1. Executive Summary and Overview

[Content here...]

# 2. Functional Requirements

## 2.1 Authentication & Authorization (R1-R15)

**R1: User Registration System**
[Full requirement here...]
```

**Pass 2 Continuation**:

```markdown
<!-- REQUIREMENTS GENERATION PROGRESS -->

## Generation Status

- [x] Pass 1: Executive Summary & Core Auth Requirements (R1-R15) - COMPLETE
- [x] Pass 2: Business Logic Requirements (R16-R35) - COMPLETE
- [ ] Pass 3: Integration & API Requirements (R36-R50) - IN PROGRESS
      [...]

## 2.2 Business Logic Requirements (R16-R35)

**R16: Claims Processing Engine**
[Full requirement here...]
```

**Final Pass - After All Chunks**:

```markdown
# EQ TimeChain Systems™ - Comprehensive Requirements Document

[Complete integrated document with all sections, no progress tracker]
```

## Chunking Best Practices

### File Size Management

- **Target chunk size**: 1000-2000 lines per pass
- **Use append mode**: Add to existing file rather than rewriting
- **Preserve formatting**: Maintain consistent structure across chunks
- **Version control**: Commit after each chunk for rollback capability

### Context Preservation

- **Start each chunk**: Reference previous chunk summary
- **End each chunk**: Provide transition note to next chunk
- **Track dependencies**: Maintain running list of cross-chunk references
- **Use consistent IDs**: Don't renumber; continue sequential IDs

### Quality Assurance Per Chunk

- **Validate internally**: Each chunk should be internally consistent
- **Check boundaries**: Ensure no overlap with previous/next chunks
- **Document assumptions**: Note anything that needs verification in later chunks
- **Progressive refinement**: Later chunks can refine earlier chunks if needed

### Communication

- **Announce strategy**: Tell user upfront how many passes are needed
- **Progress updates**: Report completion of each chunk
- **Seek confirmation**: Ask before proceeding to next chunk (unless instructed to continue)
- **Flexibility**: Allow user to adjust chunking strategy mid-generation

## Notes

- Always ensure traceability from original ASK items to final requirements
- Mark processed items in ASK and suggestions to avoid duplication
- Use TODO markers for items requiring stakeholder clarification
- Maintain both functional and non-functional requirements
- Include compliance requirements early to avoid later rework
- Validate requirements against available personas and instructions
- Keep requirements focused and avoid over-engineering
- Regular stakeholder review ensures alignment with business goals
- **For large projects**: Use chunking strategy to maintain quality and manageability
- **Chunk boundaries**: Choose logical breakpoints that minimize cross-chunk dependencies
- **Progressive integration**: Each chunk builds upon previous chunks coherently
