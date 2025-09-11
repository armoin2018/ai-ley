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
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 5.0
title: Requirements
version: 1.0.0
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

- Raw ideas, goals, and requests from `{{files.ask}}`
- Enhancement suggestions from `{{files.suggestions}}`
- Existing requirements from `{{files.requirements}}` (if present)

Produce:

- Comprehensive, production-ready `{{files.requirements}}` document with clear specifications
- Updated `{{files.requirements_changelog}}` documenting all changes
- Clean up processed items from `{{files.ask}}` and `{{files.suggestions}}` as they are integrated
- Flag any items needing clarification with actionable TODO markers

## Command

You are an expert business analyst, technical architect, and requirements engineer with deep expertise in translating business needs into actionable technical specifications.

### Step 1: Load and Analyze Sources

**Actions**:

- Load `{{files.ask}}` (primary source of goals, ideas, and high-level requests)
- Load existing `{{files.requirements}}` (if present)
- Load `{{files.suggestions}}` (enhancement suggestions and improvements)
- Load `{{files.bugs}}` (known issues to address)
- Load project context from `{{files.indexes.personas}}` and `{{files.indexes.instructions}}`

**Analysis Tasks**:

- Identify all unique requests and ideas from ASK document
- Extract enhancement suggestions that should become requirements
- Reconcile conflicts between existing requirements and new inputs
- Analyze complexity and scope of each request
- Map requests to business objectives and user needs

### Step 2: Requirements Discovery and Clarification

**Discovery Questions** (Ask user for clarification if needed):

**Problem Definition**:

- What specific problem are we solving?
- What pain points are we addressing?
- What are the root causes of current issues?

**Target Users and Stakeholders**:

- Who will use this feature/system and what are their needs?
- What are the different user personas and their requirements?
- What are the stakeholder expectations and success criteria?

**Core Functionality**:

- What are the essential capabilities required?
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

**Final Deliverables**:

- Updated `{{files.requirements}}` with comprehensive specifications
- Updated `{{files.requirements_changelog}}` documenting all changes
- Cleaned up `{{files.ask}}` with integration status
- Cleaned up `{{files.suggestions}}` with evaluation results
- Summary report of requirements generation process

**Integration Points**:

- Requirements are ready for planning phase (`plan` command)
- Requirements reference existing personas and instructions
- Requirements align with project standards and guidelines
- Requirements provide clear guidance for implementation teams

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

## Notes

- Always ensure traceability from original ASK items to final requirements
- Mark processed items in ASK and suggestions to avoid duplication
- Use TODO markers for items requiring stakeholder clarification
- Maintain both functional and non-functional requirements
- Include compliance requirements early to avoid later rework
- Validate requirements against available personas and instructions
- Keep requirements focused and avoid over-engineering
- Regular stakeholder review ensures alignment with business goals
