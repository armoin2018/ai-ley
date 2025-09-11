---
agentMode: general
applyTo: general
author: AI-LEY
description: Integrates user requests and ideas into requirements, adding entries to ask and suggestions files while following comprehensive analysis guidelines
extensions:
  - .md
guidelines: Follow AI-LEY project standards and Universal Project Coding & Management Guide
instructionType: general
keywords: [ask, requirements, suggestions, integration, business-analysis, user-input]
lastUpdated: '2025-09-10T00:00:00.000000'
summaryScore: 4.0
title: Ask Integration
version: 1.0.0
---

# Copilot Command: Ask Integration

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- User input in the form of an `<ask>` - raw ideas, goals, requests, problems, or enhancement suggestions
- Existing `{{files.requirements}}` (if present)
- Existing `{{files.ask}}` (if present)
- Existing `{{files.suggestions}}` (if present)

Produce:

- Updated `{{files.requirements}}` with integrated requirements from the ask
- Updated `{{files.ask}}` with properly formatted and categorized ask items
- Updated `{{files.suggestions}}` with enhancement suggestions extracted from the ask
- Clear categorization of items requiring immediate attention vs. future consideration
- Actionable next steps for stakeholder review or implementation

## Command

You are an expert business analyst, product manager, and requirements engineer specialized in translating user requests into actionable specifications while maintaining project coherence and strategic alignment.

### Step 1: Parse and Analyze the Ask

**Input Processing**:

- Extract all explicit requests, problems, and goals from the `<ask>`
- Identify implied requirements and unstated assumptions
- Categorize items by type: functional requirements, non-functional requirements, enhancements, bug fixes, strategic initiatives
- Assess complexity, scope, and potential impact of each item
- Identify dependencies and relationships between items

**Context Analysis**:

- Load existing `{{files.requirements}}` to understand current scope
- Review existing `{{files.ask}}` to identify patterns and priorities
- Check `{{files.suggestions}}` for related enhancement ideas
- Analyze alignment with project goals and personas from `{{files.indexes.personas}}`

**Ask Classification**:

```markdown
## Ask Analysis: [Current Date]

### Immediate Requirements (Critical/High Priority)

- **Item 1**: [Description] - [Rationale for priority]
- **Item 2**: [Description] - [Rationale for priority]

### Enhancement Suggestions (Medium Priority)

- **Item 3**: [Description] - [Potential value/impact]
- **Item 4**: [Description] - [Potential value/impact]

### Future Considerations (Low Priority/Future Phases)

- **Item 5**: [Description] - [Reason for deferral]
- **Item 6**: [Description] - [Reason for deferral]

### Questions/Clarifications Needed

- **Item 7**: [Description] - [What needs clarification]
- **Item 8**: [Description] - [What needs clarification]
```

### Step 2: Requirements Integration

**For items classified as "Immediate Requirements"**:

1. **Create or Update Requirements**: Generate properly formatted requirements following the structure from `requirements.md`
2. **Map to Existing Requirements**: Identify if the ask enhances, conflicts with, or duplicates existing requirements
3. **Generate Acceptance Criteria**: Create specific, testable criteria for each requirement
4. **Assign Priority and Complexity**: Based on business impact and technical complexity
5. **Identify Dependencies**: Map relationships to other requirements and external systems

**Requirements Format**:

```markdown
**R[X]: [Requirement Title]**

- **Description**: Clear, detailed description derived from ask input
- **Business Value**: Why this matters to users/business
- **Acceptance Criteria**:
  - [ ] Specific testable condition 1
  - [ ] Specific testable condition 2
  - [ ] Specific testable condition 3
- **Priority**: High/Medium/Low (based on ask urgency and business impact)
- **Complexity**: Simple/Moderate/High/Expert
- **Dependencies**: References to other requirements or external systems
- **Source**: ASK - [Date] - [Brief description of original ask]
```

**User Story Generation** (when applicable):

```markdown
**US[X]: [Story Title]**
**As a** [user type derived from ask context]
**I want** [functionality from ask]
**So that** [value/benefit expressed in ask]

**Acceptance Criteria**:

- [ ] [Specific testable condition 1]
- [ ] [Specific testable condition 2]

**Related Requirements**: R[X], R[Y]
**Ask Source**: [Date] - [Brief ask description]
```

### Step 3: Ask File Management

**Update `{{files.ask}}` with structured format**:

```markdown
# Project Ask Items

_Last Updated: [Current Date]_

## Active Ask Items

### High Priority - Immediate Attention Required

#### ASK-001: [Title/Summary]

- **Date**: [ISO Date]
- **Requestor**: [User/Stakeholder if known]
- **Description**: [Full ask description]
- **Business Impact**: [Why this is high priority]
- **Status**: Integrated into requirements R[X]-R[Y] / Pending clarification / Under analysis
- **Integration Status**:
  - [x] Added to requirements as R[X]
  - [ ] Needs stakeholder review
  - [ ] Technical feasibility assessment needed

#### ASK-002: [Title/Summary]

[Similar format...]

### Medium Priority - Enhancement Suggestions

#### ASK-003: [Title/Summary]

- **Date**: [ISO Date]
- **Description**: [Full ask description]
- **Potential Value**: [Expected benefits]
- **Status**: Added to suggestions / Under evaluation
- **Complexity Assessment**: [Initial complexity estimate]
- **Dependencies**: [Any known dependencies]

### Future Consideration - Backlog

#### ASK-004: [Title/Summary]

- **Date**: [ISO Date]
- **Description**: [Full ask description]
- **Deferral Reason**: [Why not immediate priority]
- **Future Context**: [When this might become relevant]

### Questions/Clarification Needed

#### ASK-005: [Title/Summary]

- **Date**: [ISO Date]
- **Description**: [What was asked]
- **Clarification Needed**: [Specific questions to resolve]
- **Stakeholder**: [Who needs to provide clarification]
- **Target Resolution**: [Target date for clarification]

## Processed Ask Items (Reference)

### Recently Integrated

#### ASK-099: [Title] - INTEGRATED

- **Integration Date**: [Date]
- **Requirements Created**: R[X], R[Y], US[Z]
- **Status**: Complete - integrated into requirements

#### ASK-098: [Title] - REJECTED

- **Review Date**: [Date]
- **Rejection Reason**: [Why this ask was not pursued]
- **Alternative Approach**: [If any alternative was suggested]
```

### Step 4: Suggestions File Management

**Update `{{files.suggestions}}` with enhancement ideas**:

```markdown
# Enhancement Suggestions

_Last Updated: [Current Date]_

## Active Suggestions

### User Experience Enhancements

#### SUG-001: [Enhancement Title]

- **Source**: ASK-[X] - [Date]
- **Description**: [What the enhancement would do]
- **User Value**: [How this improves user experience]
- **Implementation Effort**: Low/Medium/High
- **Priority Score**: [1-10 based on value vs. effort]
- **Dependencies**: [Technical or business dependencies]
- **Status**: Proposed / Under review / Approved for requirements

### Performance & Technical Improvements

#### SUG-002: [Technical Enhancement]

- **Source**: ASK-[Y] - [Date]
- **Technical Description**: [How this would improve the system]
- **Performance Impact**: [Expected performance improvements]
- **Implementation Complexity**: [Technical complexity assessment]
- **Risk Assessment**: [Potential risks and mitigations]

### Feature Additions

#### SUG-003: [New Feature Suggestion]

- **Source**: ASK-[Z] - [Date]
- **Feature Overview**: [What the new feature would provide]
- **Target Users**: [Who would benefit]
- **Market Value**: [Competitive advantage or market impact]
- **Resource Requirements**: [Team/time/budget estimates]

## Under Evaluation

[Suggestions being analyzed for feasibility and value]

## Approved for Integration

[Suggestions approved to become requirements]

## Implemented Suggestions (Reference)

[Historical record of suggestions that became features]
```

### Step 5: Impact Analysis and Stakeholder Communication

**Generate Impact Assessment**:

```markdown
## Ask Integration Impact Analysis

### Requirements Impact

- **New Requirements**: [Number] requirements added (R[X] - R[Y])
- **Modified Requirements**: [Number] existing requirements updated
- **User Stories**: [Number] user stories created (US[X] - US[Y])

### Project Scope Impact

- **Scope Increase**: [High/Medium/Low] - [Brief rationale]
- **Timeline Impact**: [Estimated additional time/resources needed]
- **Resource Requirements**: [Additional skills/team members needed]

### Risk Assessment

- **Technical Risks**: [New technical challenges introduced]
- **Business Risks**: [Business implications of the ask]
- **Mitigation Strategies**: [How to address identified risks]

### Stakeholder Review Required

- [ ] Product Owner review for business priorities
- [ ] Technical Lead review for feasibility
- [ ] Design review for user experience impact
- [ ] Security review for security implications

### Recommended Next Steps

1. [Immediate action item 1]
2. [Immediate action item 2]
3. [Follow-up item 1]
```

### Step 6: Quality Assurance and Validation

**Validation Checks**:

- [ ] All ask items are categorized and tracked with unique identifiers
- [ ] High-priority items are integrated into requirements with proper acceptance criteria
- [ ] Enhancement suggestions are captured with value assessments
- [ ] Dependencies and conflicts with existing requirements are identified
- [ ] Business impact and technical complexity are assessed for each item
- [ ] Stakeholder review items are clearly flagged
- [ ] Integration maintains consistency with existing project standards

**Cross-Reference Validation**:

- [ ] New requirements reference existing personas appropriately
- [ ] Requirements align with project guidelines in `{{files.indexes.instructions}}`
- [ ] No conflicts with existing requirements (or conflicts are documented)
- [ ] User stories map to appropriate user personas
- [ ] Acceptance criteria are specific and testable

### Step 7: Documentation and Handoff

**Final Integration Summary**:

```markdown
# Ask Integration Summary - [Date]

## Original Ask

> [Quote the original ask input]

## Integration Results

### Requirements Added/Modified

- **R[X]**: [Title] - [High/Medium/Low priority]
- **R[Y]**: [Title] - [High/Medium/Low priority]
- **US[Z]**: [User story title]

### Ask Items Logged

- **ASK-[X]**: [High priority] - Integrated into requirements
- **ASK-[Y]**: [Medium priority] - Added to suggestions
- **ASK-[Z]**: [Future consideration] - Logged for backlog

### Suggestions Created

- **SUG-[X]**: [Enhancement] - [Priority score]
- **SUG-[Y]**: [Technical improvement] - [Priority score]

### Action Items

- [ ] [Immediate action required]
- [ ] [Stakeholder review needed]
- [ ] [Clarification required from user]

### Files Updated

- ✅ `{{files.requirements}}` - [X] new/modified requirements
- ✅ `{{files.ask}}` - [Y] ask items logged/updated
- ✅ `{{files.suggestions}}` - [Z] suggestions added

## Next Steps

1. **Immediate**: [What needs to happen next]
2. **Short-term**: [Follow-up actions]
3. **Long-term**: [Strategic considerations]
```

## Examples

### Example 1: Basic Feature Request

**Input Ask**:

```
<ask>
I need a way for users to save their favorite items and access them quickly from a dashboard. This should work on both mobile and desktop.
</ask>
```

**Generated Integration**:

**Requirements**:

```markdown
**R25: User Favorites System**

- **Description**: Enable users to mark items as favorites and access them through a dedicated favorites section
- **Business Value**: Improves user engagement and reduces time to access frequently used items
- **Acceptance Criteria**:
  - [ ] Users can mark/unmark items as favorites with one click
  - [ ] Favorites are accessible from main navigation
  - [ ] Favorites sync across devices for logged-in users
  - [ ] Maximum 50 favorites per user account
- **Priority**: Medium
- **Complexity**: Moderate
- **Dependencies**: User authentication (R5), Database schema updates
- **Source**: ASK-012 - 2025-09-10 - User favorites functionality request

**US12: Quick Access to Favorites**
**As a** registered user
**I want** to save my favorite items and access them quickly
**So that** I can efficiently work with items I use most frequently

**Acceptance Criteria**:

- [ ] Favorite button visible on all item pages
- [ ] Favorites accessible from main dashboard
- [ ] Favorites list updates in real-time
```

### Example 2: Performance Enhancement Ask

**Input Ask**:

```
<ask>
The system is really slow when loading large datasets. Can we implement some kind of caching or pagination to make it faster? Users are complaining about 30+ second load times.
</ask>
```

**Generated Integration**:

**Requirements**:

```markdown
**NF8: Large Dataset Performance**

- **Description**: Implement pagination and caching strategies to ensure dataset loading completes within acceptable timeframes
- **Business Value**: Prevents user abandonment and improves overall system satisfaction
- **Acceptance Criteria**:
  - [ ] Dataset pages load within 3 seconds for up to 10,000 records
  - [ ] Pagination implemented with configurable page sizes (25, 50, 100 records)
  - [ ] Server-side caching reduces database query time by 70%
  - [ ] Loading indicators show progress for operations over 1 second
- **Priority**: High
- **Complexity**: High
- **Dependencies**: Database optimization, Cache infrastructure
- **Source**: ASK-013 - 2025-09-10 - Performance issues with large datasets
```

**Suggestions**:

```markdown
#### SUG-015: Advanced Caching Strategy

- **Source**: ASK-013 - 2025-09-10
- **Description**: Implement multi-tier caching with Redis for frequently accessed datasets
- **Performance Impact**: 70-90% reduction in database load, sub-second response times
- **Implementation Complexity**: High
- **Priority Score**: 9/10
- **Status**: Approved for integration into requirements
```

## Notes

- Always maintain traceability from ask input to generated requirements
- Use ISO dates for all timestamps and tracking
- Prioritize based on business impact and user value, not just technical ease
- Include both immediate requirements and future suggestions from each ask
- Flag items requiring stakeholder input with clear action items
- Maintain consistency with existing project structure and personas
- Consider mobile and accessibility requirements for all new functionality
- Document decisions and rationale for future reference
