---
agentMode: general
applyTo: general
author: AI-LEY
description: Interactive intake template to gather project requirements and record them in INTAKE.md with optional REQUIREMENTS.md generation
extensions:
  - .md
guidelines: Follow AI-LEY project standards for interactive intake and requirements gathering
instructionType: general
keywords: [intake, requirements, interactive, template, questions, gathering, discovery]
lastUpdated: '2025-11-09T00:00:00.000000'
summaryScore: 5.0
title: Interactive Project Intake
version: 1.0.0
---

# Copilot Command: Interactive Project Intake

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- A template type corresponding to `.ai-ley/shared/templates/intake/<type>.md`
- User responses to interactive questions
- Existing AI-Ley indexes for suggestions

Produce:

- `.project/INTAKE.md` with all questions and user responses
- Referenced assets created (personas, instructions, agents, chatmodes) if needed
- Updated indexes for any new assets created
- Optional `.project/REQUIREMENTS.md` or `.project/REQUIREMENTS.generated.md`
- Provenance tracking in `.project/GENERATED_CHANGES.md`

## Command

You are an expert business analyst and requirements engineer specializing in interactive discovery, structured elicitation, and requirements documentation. Your expertise includes stakeholder interviewing, gap analysis, and knowledge base enhancement.

### Step 1: Template Selection & Loading

**Parse Command Parameters**:

- `type` = Template type (e.g., `web-app`, `api`, `mobile`, `ml-pipeline`, `general`)
- `template_path` = `.ai-ley/shared/templates/intake/{{type}}.md`

**Load Template**:

1. **Check if template exists** at `{{template_path}}`

2. **If template exists**:

   - Load template content
   - Parse questions and sections
   - Prepare for interactive loop

3. **If template is missing**:

   - Ask user if they want to create a new template:

     ```
     ⚠️  Template not found: .ai-ley/shared/templates/intake/{{type}}.md

     Would you like to create a new intake template for "{{type}}"?

     Options:
     1. Create from base skeleton (recommended)
     2. Use "general" template instead
     3. Cancel and choose different template

     Your choice (1/2/3):
     ```

4. **If creating new template**:
   - Use base skeleton template:

```markdown
---
templateType: intake
category: { { type } }
version: 1.0.0
author: AI-LEY
created: { { timestamp } }
---

# {{Type}} Project Intake

## Project Overview

### Q1: Project Name

**Question**: What is the name of your project?
**Type**: text
**Required**: yes

### Q2: Project Description

**Question**: Provide a brief description of the project (1-2 paragraphs).
**Type**: textarea
**Required**: yes

### Q3: Project Goals

**Question**: What are the primary goals and objectives?
**Type**: list
**Required**: yes
**Suggestions**:

- Increase revenue
- Improve efficiency
- Enhance user experience
- Reduce costs
- Enter new market

## Technical Context

### Q4: Technology Stack

**Question**: What technologies will be used? (frontend, backend, database, infrastructure)
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

### Q5: Target Platforms

**Question**: What platforms will the project target?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Web (desktop)
- Web (mobile)
- iOS
- Android
- API/Backend only

## Team & Resources

### Q6: Team Composition

**Question**: What roles and expertise are available?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)

### Q7: Required Instructions

**Question**: What technical guidance will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)

## Constraints & Requirements

### Q8: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: text
**Required**: yes

### Q9: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no

### Q10: Constraints

**Question**: Are there any technical, regulatory, or business constraints?
**Type**: textarea
**Required**: no
```

- Save new template to `.ai-ley/shared/templates/intake/{{type}}.md`
- Register in `.ai-ley/shared/indexes/templates.md`:

```markdown
### intake/{{type}}

- **Path**: `.ai-ley/shared/templates/intake/{{type}}.md`
- **Category**: intake
- **Synopsis**: {{Type}} project intake template
- **Version**: 1.0.0
- **Created**: {{timestamp}}
```

### Step 2: Initialize INTAKE.md

**Create or Append to `.project/INTAKE.md`**:

```markdown
# Project Intake

<!-- generated-by: ai-ley intake | timestamp: 2025-11-09T12:34:56Z | template:{{type}} -->

**Template**: {{type}}
**Started**: {{timestamp}}
**Status**: In Progress

---
```

**If INTAKE.md already exists**:

- Preserve existing content
- Append new session with separator
- Add session header with timestamp

### Step 3: Interactive Question Loop

**For each question in the template**:

#### 3.1: Display Question

Present question to user with context:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question 4 of 10: Technology Stack
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What technologies will be used? (frontend, backend, database, infrastructure)

Type: multi-select
Required: Yes
```

#### 3.2: Provide Suggestions

**If question references indexed items** (tech stacks, personas, instructions, agents, chatmodes):

1. **Load relevant index** (e.g., `.ai-ley/shared/indexes/tech-stack.md`)

2. **Display categorized suggestions**:

```
Suggested options (from AI-Ley knowledge base):

Frontend:
  1. React
  2. Vue.js
  3. Angular
  4. Svelte
  5. Next.js

Backend:
  6. Node.js/Express
  7. Python/FastAPI
  8. Python/Django
  9. Ruby on Rails
  10. Java/Spring Boot

Database:
  11. PostgreSQL
  12. MongoDB
  13. MySQL
  14. Redis
  15. Elasticsearch

Infrastructure:
  16. Docker
  17. Kubernetes
  18. AWS
  19. Azure
  20. GCP

Enter numbers (comma-separated), or type custom values:
```

**If no index exists or index is empty**:

- Provide standard categorized examples
- Note: "These are standard options. Custom entries will be added to the knowledge base."

#### 3.3: Capture User Response

**Accept user input**:

- For multi-select: Parse comma-separated numbers or custom text
- For text/textarea: Accept freeform input
- For required fields: Validate non-empty response
- Allow "skip" for non-required fields

**Example user input**:

```
> 1, 6, 11, 16, Tailwind CSS
```

**Parsed response**:

- React (from suggestion #1)
- Node.js/Express (from suggestion #6)
- PostgreSQL (from suggestion #11)
- Docker (from suggestion #16)
- Tailwind CSS (custom entry)

#### 3.4: Handle Custom/Missing Assets

**For each custom or missing item referenced**:

1. **Check if asset exists** in appropriate index

2. **If asset does NOT exist**:

```
⚠️  "Tailwind CSS" is not in the tech stack knowledge base.

Would you like to add it?
1. Yes - Create tech stack entry
2. No - Just record as freeform text

Your choice (1/2):
```

3. **If user chooses to create**:

   a. **For Tech Stack**:

   - Add entry to `.ai-ley/shared/indexes/tech-stack.md`:

   ```markdown
   ### Tailwind CSS

   - **Category**: Frontend / CSS Framework
   - **Description**: Utility-first CSS framework
   - **Version**: 3.x
   - **Source**: User intake ({{timestamp}})
   ```

   b. **For Personas**:

   - Check if template exists at `{{folders.templates.personas}}/persona-template.md`
   - If template exists, create new persona:

   ```markdown
   ---
   agentMode: technical
   personaType: developer
   expertiseLevel: senior
   communicationStyle: technical
   ---

   # Persona: [User-Specified Role]

   (Generated from intake - requires completion)
   ```

   - Save to `{{folders.personas}}/[category]/[name].md`
   - Add to `.ai-ley/shared/indexes/personas.md`

   c. **For Instructions**:

   - Check if template exists at `{{folders.templates.instructions}}/instruction-template.md`
   - Create new instruction following template
   - Save to `{{folders.instructions}}/[category]/[name].md`
   - Add to `.ai-ley/shared/indexes/instructions.md`

   d. **For Agents/Chatmodes**:

   - Similar pattern using appropriate templates
   - Register in corresponding indexes

4. **Record provenance**:

   - Log creation in `.project/GENERATED_CHANGES.md`:

   ```markdown
   ## Created During Intake ({{timestamp}})

   ### Tech Stack Entry

   - **Name**: Tailwind CSS
   - **Index**: `.ai-ley/shared/indexes/tech-stack.md`
   - **Reason**: User-specified during intake Q4
   ```

#### 3.5: Append to INTAKE.md

**After each question, append formatted response**:

```markdown
## Q4: Technology Stack

**Question**: What technologies will be used? (frontend, backend, database, infrastructure)

**Answer**:

- React (frontend framework)
- Node.js/Express (backend runtime/framework)
- PostgreSQL (database)
- Docker (containerization)
- Tailwind CSS (CSS framework) _[newly added to knowledge base]_

**Referenced Assets**:

- Tech stack entries: 5 items
- New entries created: 1 (Tailwind CSS)

**Answered**: 2025-11-09T12:45:23Z

---
```

**Format Guidelines**:

- Use consistent heading levels (## for questions)
- Include question text for context
- Format answers as lists, paragraphs, or structured data as appropriate
- Note any newly created assets with asterisk
- Include timestamp
- Add separator between questions

### Step 4: Handle Uncertainty & Questions

**If ambiguity or uncertainty occurs during intake**:

1. **Identify the uncertainty**:

   - Unclear user response
   - Conflicting information
   - Missing critical context
   - Undefined capability referenced

2. **Append to `.ai-ley/shared/QUESTIONS.md`**:

```markdown
## Q-INTAKE-001: Unclear Technology Stack Selection

**Context**: User mentioned "React Native" but also selected "Web (desktop)" as platform
**Question**: Is React Native intended for web or mobile? Or both?
**Impact**: Affects technology stack recommendations and project structure
**Source**: Intake session 2025-11-09T12:34:56Z
**Status**: Open
**Assigned To**: Project Lead
**Decision By**: 2025-11-16

**Options**:

1. React Native for mobile + React for web (separate codebases)
2. React Native for Web (unified codebase)
3. Clarify requirements with stakeholder

**Next Steps**:

- [ ] Clarify with user
- [ ] Update INTAKE.md with clarification
- [ ] Adjust technology stack accordingly
```

3. **Continue with best guess or skip**:
   - Document assumption in INTAKE.md
   - Flag for follow-up

### Step 5: Completion & Requirements Generation

**After the last question**:

1. **Mark intake as complete** in `.project/INTAKE.md`:

```markdown
---

## Intake Summary

**Status**: ✅ Complete
**Completed**: 2025-11-09T13:15:42Z
**Duration**: 41 minutes
**Questions Answered**: 10/10
**Assets Created**: 3 (1 tech stack, 1 persona, 1 instruction)
**Open Questions**: 1 (see QUESTIONS.md)

---
```

2. **Prompt user for requirements generation**:

```
✅ Intake complete!

Summary:
- 10 questions answered
- 3 new assets created
- 1 open question for follow-up

Would you like to generate or update `.project/REQUIREMENTS.md` using the `/requirements` prompt?

This will use your intake responses to create structured requirements.

Options:
1. Yes - Generate REQUIREMENTS.md from intake
2. No - I'll create requirements manually later
3. Preview - Show what requirements would be generated

Your choice (1/2/3):
```

3. **If user chooses "Yes" or "Preview"**:

   a. **Check if REQUIREMENTS.md exists**:

   b. **If REQUIREMENTS.md exists**:

   ```
   ⚠️  .project/REQUIREMENTS.md already exists.

   Options:
   1. Update existing file (merge with intake data)
   2. Create REQUIREMENTS.generated.md (preserve existing)
   3. Show diff first

   Your choice (1/2/3):
   ```

   c. **Trigger `/requirements` command**:

   - Pass `.project/INTAKE.md` as input basis
   - Use `mode=apply` (or `mode=preview` if user selected preview)
   - Generate structured requirements from intake responses

   d. **If creating REQUIREMENTS.generated.md**:

   - Write to sibling file
   - Generate diff summary:

   ```markdown
   # Requirements Diff Summary

   ## Additions (from intake)

   - Functional requirements based on project goals
   - Non-functional requirements inferred from constraints
   - Technology stack requirements from Q4

   ## Modifications

   ~ Updated team composition section
   ~ Added budget constraints

   ## Preserved (from existing)

   = Previous requirements R-001 through R-015
   ```

### Step 6: Provenance & Documentation

**Update `.project/GENERATED_CHANGES.md`**:

```markdown
# Generated Changes Log

## 2025-11-09T13:15:42Z - Intake Session ({{type}})

### Files Created/Updated

1. **`.project/INTAKE.md`**

   - Session: {{type}} intake
   - Questions: 10/10 answered
   - Status: Complete

2. **`.ai-ley/shared/indexes/tech-stack.md`**

   - Added: Tailwind CSS
   - Reason: User-specified during intake

3. **`{{folders.personas}}/developer/tailwind-specialist.md`**

   - Created: New persona for Tailwind CSS expertise
   - Template: persona-template.md
   - Status: Generated (requires review)

4. **`{{folders.instructions}}/frontend/tailwind-best-practices.md`**
   - Created: Tailwind CSS best practices
   - Template: instruction-template.md
   - Status: Generated (requires completion)

### Assets Referenced

- Existing personas: 5
- Existing instructions: 8
- Existing tech stack items: 15

### Next Steps

- [ ] Review and complete generated persona: tailwind-specialist.md
- [ ] Complete instruction: tailwind-best-practices.md
- [ ] Resolve open question Q-INTAKE-001
- [ ] Generate REQUIREMENTS.md from intake (if selected)
```

**Add metadata header to all generated files**:

```markdown
<!-- generated-by: ai-ley intake | timestamp: 2025-11-09T13:15:42Z | template:{{type}} -->
```

### Step 7: Idempotency & Safety

**Ensure idempotent behavior**:

- **Never delete** user-provided content without explicit confirmation
- **Append-only** to INTAKE.md (never overwrite previous sessions)
- **Use `-generated` suffix** for updated files to preserve originals
- **Track all changes** in GENERATED_CHANGES.md
- **Confirm before creating assets**: Always ask before generating personas, instructions, etc.

**Safety Checks**:

- [ ] INTAKE.md preserves all previous content
- [ ] No hand-edited files overwritten
- [ ] All new assets use templates
- [ ] Indexes updated atomically
- [ ] Provenance documented
- [ ] Open questions captured in QUESTIONS.md

## Quality Gates

**Intake Session Quality**:

- [ ] All required questions answered
- [ ] Responses formatted consistently
- [ ] Referenced assets identified and created/linked
- [ ] Provenance tracked for all generated assets
- [ ] Open questions documented
- [ ] Session marked as complete

**Asset Creation Quality**:

- [ ] Templates used for all new assets
- [ ] YAML frontmatter valid and complete
- [ ] File naming follows AI-LEY conventions
- [ ] Indexes updated with alphabetical ordering
- [ ] Generated file headers included

**Requirements Generation Quality** (if applicable):

- [ ] REQUIREMENTS.md generated from intake
- [ ] Existing requirements preserved (if any)
- [ ] Diff summary provided for review
- [ ] Structured requirements aligned with intake responses

## Success Metrics

**Intake Success**:

- All questions answered or intentionally skipped
- User responses captured accurately
- Required assets created successfully
- Session completed without errors

**Knowledge Base Enhancement**:

- New assets properly registered in indexes
- Templates used consistently
- Provenance tracked for traceability
- Quality standards maintained

**Requirements Alignment**:

- Requirements generated align with intake
- No information loss from intake to requirements
- Structured and actionable requirements

## Examples

### Example 1: Basic Web App Intake

**Command**:

```
intake type=web-app
```

**Expected Flow**:

```
Loading template: .ai-ley/shared/templates/intake/web-app.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question 1 of 10: Project Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What is the name of your project?

Type: text
Required: Yes

> TaskMaster Pro

✅ Recorded

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question 2 of 10: Project Description
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Provide a brief description of the project (1-2 paragraphs).

Type: textarea
Required: Yes

> A modern task management application for teams...
> [continues]

✅ Recorded

[... continues through all questions ...]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Intake Complete
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Summary:
- 10 questions answered
- 2 new assets created (1 persona, 1 instruction)
- 0 open questions

Would you like to generate .project/REQUIREMENTS.md? (y/n)

> y

Generating requirements from intake...
✅ Created .project/REQUIREMENTS.md

Next steps:
1. Review INTAKE.md for accuracy
2. Validate REQUIREMENTS.md completeness
3. Complete generated assets (see GENERATED_CHANGES.md)
```

### Example 2: API Project Intake with Missing Template

**Command**:

```
intake type=graphql-api
```

**Expected Flow**:

```
⚠️  Template not found: .ai-ley/shared/templates/intake/graphql-api.md

Would you like to create a new intake template for "graphql-api"?

Options:
1. Create from base skeleton (recommended)
2. Use "api" template instead
3. Cancel and choose different template

Your choice (1/2/3): 1

Creating new template from skeleton...
✅ Created .ai-ley/shared/templates/intake/graphql-api.md
✅ Registered in .ai-ley/shared/indexes/templates.md

Loading template...

[... continues with questions ...]
```

### Example 3: Intake with Custom Asset Creation

**Command**:

```
intake type=general
```

**During Q6 (Team Composition)**:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Question 6 of 10: Team Composition
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

What roles and expertise are available?

Suggested personas (from AI-Ley knowledge base):
  1. Senior Developer
  2. Backend Developer
  3. Frontend Developer
  4. DevOps Engineer
  5. QA Engineer

Enter numbers (comma-separated), or type custom roles:

> 1, 3, GraphQL API Specialist

⚠️  "GraphQL API Specialist" is not in the persona knowledge base.

Would you like to create it?
1. Yes - Create persona from template
2. No - Just record as freeform text

Your choice (1/2): 1

Creating persona: GraphQL API Specialist...
✅ Created {{folders.personas}}/developer/graphql-api-specialist.md
✅ Registered in personas index

Recorded:
- Senior Developer (existing)
- Frontend Developer (existing)
- GraphQL API Specialist (newly created)
```

## Notes

### Important Considerations

- **Interactive Experience**: Maintain conversational, helpful tone throughout
- **Flexibility**: Allow users to skip, go back, or modify responses
- **Suggestions First**: Always offer indexed options before accepting custom input
- **Create Mindfully**: Confirm before creating new assets; avoid bloat
- **Preserve Context**: Never lose user input; append-only approach
- **Document Uncertainty**: Capture ambiguities in QUESTIONS.md immediately

### Best Practices

- **Review Before Requirements**: Always review INTAKE.md before generating REQUIREMENTS.md
- **Complete Generated Assets**: Review and complete stub personas/instructions promptly
- **Update Indexes Regularly**: Keep indexes current as knowledge base grows
- **Use Appropriate Templates**: Match intake template to project type for relevant questions
- **Iterate**: Allow users to run intake multiple times to refine responses

### Common Pitfalls to Avoid

- **Don't Overwhelm**: Keep question sets focused (10-15 questions max)
- **Don't Skip Validation**: Validate required fields; guide users to complete answers
- **Don't Create Duplicates**: Check indexes before creating new assets
- **Don't Lose Data**: Always preserve previous intake sessions when appending
- **Don't Auto-Generate Without Consent**: Always ask before creating requirements

### Extensibility

- **Custom Templates**: Users can create domain-specific intake templates
- **Template Inheritance**: Templates can reference base templates for common questions
- **Multi-Stage Intake**: Support progressive intake over multiple sessions
- **Integration**: Intake can feed other commands (plan, design, architecture)

## Troubleshooting

### Issue: Template not found

**Solution**: Offer to create from skeleton or use alternative template

### Issue: Index file missing

**Solution**: Create index file from template; populate with intake-generated items

### Issue: User provides ambiguous response

**Solution**: Ask clarifying question; log uncertainty in QUESTIONS.md

### Issue: Requirements generation fails

**Solution**: Save intake; allow manual requirements creation; log error

### Issue: Asset creation template missing

**Solution**: Generate minimal version; flag for review and completion
