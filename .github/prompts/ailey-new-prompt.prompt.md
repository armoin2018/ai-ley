---
name: 'New Prompt Command'
description: 'Creates a new command prompt with consistent structure across multiple AI platforms'
keywords: [prompt, command, automation, ai-platforms, standardization, ailey]
---



# Copilot Command: Create New Prompt

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

**Personas:** Leverage domain expertise from `.github/ai-ley/personas/**/*.md`

**Instructions:** Follow best practices from `.github/ai-ley/instructions/**/*.md`

**Agents:** This prompt is designed for the agent system. See the Recommended Agent section below.




## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-orchestrator** agent from `.github/agents/ailey-orchestrator.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

Given:

- A command name and description provided by the user (e.g., `/new-prompt my-command-name "Description of what this command does"`)

Produce:

- A new prompt file in `.github/prompts/{command-name}.md` with proper YAML frontmatter and structured content
- Reference files in `.github/prompts/{command-name}.prompt.md`
- Reference files in `.claude/commands/{command-name}.md`
- Reference files in `.opencode/commands/{command-name}.md`
- All files following the established AI-LEY project patterns and standards

## Command

You are an AI prompt engineer and project automation specialist.

### 1. **Parse User Input**

- Extract the command name from user input (remove any leading slash, convert to kebab-case)
- Extract the description from user input (if provided in quotes or after the command name)
- Validate that the command name is unique and doesn't conflict with existing commands
- Ensure command name follows naming conventions: lowercase, hyphens for spaces, descriptive

### 2. **Create Main Prompt File**

Create `.github/prompts/{command-name}.md` with:

```markdown
---
agentMode: general
applyTo: general
author: AI-LEY
description: { extracted-description }
extensions:
  - .md
guidelines: Follow AI-LEY project standards and best practices
instructionType: general
keywords: [{ relevant-keywords }]
lastUpdated: '{current-iso-timestamp}'
summaryScore: 3.0
title: { Proper Case Title }
version: 1.0.0
---

# Copilot Command: {Proper Case Title}

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.




## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-orchestrator** agent from `.github/agents/ailey-orchestrator.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

Given:

- {Define what inputs this command expects}

Produce:

- {Define what outputs this command should generate}
- {List specific deliverables and file locations}

## Command

You are a {role-description} specialist.

### 1. **{First Major Step}**

{Detailed instructions for the first step}

### 2. **{Second Major Step}**

{Detailed instructions for the second step}

### 3. **Validation**

- {Validation criteria}
- {Quality checks}
- {Success indicators}

### 4. **Deliver**

- {Final deliverables}
- {File locations}
- {Success confirmation}

## Examples

### Example 1: {Basic Usage}
```

{Example command usage}

```

Expected Output:
```

{Example output format}

```

### Example 2: {Advanced Usage}
```

{Advanced example}

```

## Notes

- {Important considerations}
- {Best practices}
- {Common pitfalls to avoid}
```

### 3. **Create Reference Files**

Create `.github/prompts/{command-name}.prompt.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.github/prompts/{command-name}.md`
```

Create `.claude/commands/{command-name}.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.github/prompts/{command-name}.md`
```

Create `.opencode/commands/{command-name}.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.github/prompts/{command-name}.md`
```

### 4. **Ensure Directory Structure**

- Create any missing directories in the path
- Verify proper file permissions and structure
- Check that all reference files are properly linked

### 5. **Validation and Quality Assurance**

- Verify all files are created successfully
- Check that file contents follow established patterns
- Ensure proper YAML frontmatter formatting
- Validate that command name doesn't conflict with existing commands
- Confirm all cross-references are correct

### 6. **Success Confirmation**

Provide a summary of created files:

```
✅ Created new prompt command: {command-name}

Files created:
- .github/prompts/{command-name}.md (main prompt)
- .github/prompts/{command-name}.prompt.md (GitHub reference)
- .claude/commands/{command-name}.md (Claude reference)
- .opencode/commands/{command-name}.md (OpenCode reference)

Usage: /{command-name}
Description: {description}
```

## Example Usage

### Basic Command Creation

```
/new-prompt analyze-logs "Analyze system logs for errors and patterns"
```

### Advanced Command Creation

```
/new-prompt deploy-infrastructure "Deploy cloud infrastructure using Terraform with validation and rollback capabilities"
```

## Notes

- Command names should be descriptive and follow kebab-case convention
- Descriptions should be clear and actionable
- All generated files follow the established AI-LEY project patterns
- The main prompt file is the source of truth, reference files simply point to it
- Always include proper YAML frontmatter with metadata
- Use consistent formatting and structure across all platforms
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
