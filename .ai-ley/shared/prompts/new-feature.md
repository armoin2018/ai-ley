---
agentMode: general
applyTo: general
author: AI-LEY
description: Updates requirements with new feature details and automatically runs build-plan and run-plan commands for complete feature implementation
extensions:
  - .md
guidelines: Follow AI-LEY project standards for feature development and planning workflow
instructionType: general
keywords: [feature, requirements, build-plan, run-plan, automation, workflow]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 5.0
title: New Feature
version: 1.0.0
---

# Copilot Command: New Feature Development Workflow

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Goal

Given:

- Feature details, requirements, or enhancement requests provided by the user
- Existing project requirements (`{{files.requirements}}`)
- Current project state and documentation

Produce:

- Updated `{{files.requirements}}` incorporating the new feature details
- Complete implementation plan (`{{files.plan}}`) via build-plan command
- Executed implementation of the feature via run-plan command
- Full end-to-end feature development from requirements to implementation

## Command

You are a senior product manager and development lead specializing in feature development workflows.

### 1. **Capture Feature Input**

- Parse and analyze the provided feature details from user input
- Extract key requirements:
  - Feature name and description
  - User stories and acceptance criteria
  - Technical requirements and constraints
  - Priority level and business justification
  - Dependencies and integration points

### 2. **Update Requirements Document**

Execute the equivalent of `build-requirements` command functionality:

**If `{{files.ask}}` exists:**

- Append new feature details to `{{files.ask}}`
- Use existing build-requirements.md workflow to merge into `{{files.requirements}}`

**If `{{files.ask}}` doesn't exist:**

- Create temporary feature input structure
- Directly integrate feature details into `{{files.requirements}}`

**Requirements Integration Process:**

- Load existing `{{files.requirements}}` if it exists
- Identify the appropriate section for the new feature (Functional Requirements, User Stories, etc.)
- Add the new feature requirements in a structured format:

```markdown
## Feature: {Feature Name}

### Description

{Detailed feature description}

### User Stories

- As a {user type}, I want {functionality} so that {benefit}
- [Additional user stories]

### Acceptance Criteria

- [ ] {Specific testable criteria}
- [ ] {Additional criteria}

### Technical Requirements

- {Technical specifications}
- {Performance requirements}
- {Security considerations}

### Dependencies

- {External dependencies}
- {Internal system dependencies}

### Priority

{High/Medium/Low with justification}
```

- Ensure traceability and proper formatting
- Update version numbers and modification dates
- Validate that all existing requirements remain intact

### 3. **Execute Build Plan Command**

Automatically invoke the build-plan.md workflow:

- Load the updated `{{files.requirements}}`
- Follow all steps from `.ai-ley/shared/prompts/build-plan.md`
- Generate comprehensive implementation plan in `{{files.plan}}`
- Include the new feature in appropriate epics, stories, and tasks
- Ensure proper persona and instruction references
- Map new feature requirements to specific implementation tasks

### 4. **Execute Run Plan Command**

Automatically invoke the run-plan.md workflow:

- Load the generated `{{files.plan}}`
- Follow all steps from `.ai-ley/shared/prompts/run-plan.md`
- Execute the implementation plan with proper standards compliance
- Apply all relevant personas and instructions
- Capture progress, issues, and improvements along the way

### 5. **Feature Development Orchestration**

- Coordinate the three-step process: Requirements → Planning → Implementation
- Ensure continuity between stages
- Handle any errors or issues that arise during the workflow
- Maintain project state and documentation consistency
- Log all activities to `{{files.history}}`

### 6. **Quality Assurance and Validation**

- Verify that the new feature requirements are properly documented
- Confirm that the implementation plan addresses all feature aspects
- Validate that the executed implementation meets acceptance criteria
- Check for any missing dependencies or integration issues
- Ensure compliance with project standards and guidelines

### 7. **Success Reporting**

Provide comprehensive status report:

```
✅ New Feature Development Complete: {Feature Name}

📋 Requirements Updated:
- Feature added to {{files.requirements}}
- User stories: {count}
- Acceptance criteria: {count}
- Technical requirements documented

📊 Implementation Plan Generated:
- Epics created: {count}
- Stories created: {count}
- Tasks created: {count}
- Estimated effort: {story points/hours}

🚀 Implementation Executed:
- Tasks completed: {count}/{total}
- Features implemented: {list}
- Files created/modified: {count}
- Status: {Complete/In Progress/Issues}

📝 Next Steps:
- {Any remaining tasks or considerations}
- {Testing recommendations}
- {Deployment considerations}
```

## Example Usage

### Example 1: Simple Feature Addition

```
/new-feature "User Authentication - Add OAuth2 login with Google and GitHub providers for improved user experience"
```

Expected Process:

1. Parse feature: OAuth2 authentication system
2. Update requirements with user stories and technical specs
3. Generate implementation plan with security considerations
4. Execute authentication system development

### Example 2: Complex Feature with Details

```
/new-feature "Real-time Chat System - Implement WebSocket-based chat with message history, file sharing, and user presence indicators. Must support 1000+ concurrent users with Redis backend."
```

Expected Process:

1. Extract detailed requirements including performance specs
2. Update requirements document with chat system specifications
3. Plan implementation including infrastructure and scaling considerations
4. Execute full chat system development with testing

### Example 3: Enhancement to Existing Feature

```
/new-feature "Dashboard Analytics Enhancement - Add custom date ranges, export functionality, and real-time data refresh to existing dashboard"
```

Expected Process:

1. Identify existing dashboard requirements
2. Merge enhancement details with current specifications
3. Plan incremental development approach
4. Implement enhancements while maintaining existing functionality

## Integration with Existing Commands

### Leverages build-requirements.md:

- Uses the same requirement documentation patterns
- Applies identical validation and formatting rules
- Maintains consistency with existing requirement structure

### Leverages build-plan.md:

- Follows the same epic/story/task breakdown structure
- Uses identical persona and instruction referencing
- Applies the same agile methodology and estimation approaches

### Leverages run-plan.md:

- Uses the same execution methodology and standards
- Applies identical quality gates and validation steps
- Maintains the same progress tracking and issue management

## Notes

- This command provides end-to-end feature development automation
- It maintains full traceability from requirements to implementation
- All existing project standards and workflows are preserved
- The command is designed to be safe and reversible
- Progress is logged at each stage for transparency and debugging
- Integration points are clearly documented for team coordination
- The workflow can be interrupted and resumed at any stage
