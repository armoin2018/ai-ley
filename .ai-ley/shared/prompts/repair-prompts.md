---
agentMode: general
applyTo: general
author: AI-LEY
description: Repairs missing prompt reference files across AI platforms by analyzing existing prompts and generating missing references
extensions:
  - .md
guidelines: Follow AI-LEY project standards for prompt creation and file organization
instructionType: general
keywords: [repair, prompt, synchronization, ai-platforms, maintenance, automation]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 4.0
title: Repair Prompts
version: 1.0.0
---

# Copilot Command: Repair Prompts

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- Existing prompt files in `.ai-ley/shared/prompts/*.md`
- Potentially missing reference files in other platform directories

Produce:

- Complete set of reference files in `.github/prompts/{command-name}.prompt.md`
- Complete set of reference files in `.claude/commands/{command-name}.md`
- Complete set of reference files in `.opencode/commands/{command-name}.md`
- All reference files properly pointing to their source prompts
- Summary report of created and existing files

## Command

You are a project maintenance specialist and automation engineer.

### 1. **Scan Source Prompts**

- List all existing files in `.ai-ley/shared/prompts/*.md`
- Extract command names from filenames (remove .md extension)
- Parse each prompt file to extract the title from YAML frontmatter or H1 heading
- Create a master list of all available prompts with their metadata

### 2. **Audit Existing Reference Files**

- Check `.github/prompts/` for existing `.prompt.md` files
- Check `.claude/commands/` for existing `.md` files
- Check `.cursor/commands/` for existing `.md` files
- Check `.opencode/commands/` for existing `.md` files
- Compare against the master list to identify missing references
- Validate that existing reference files have correct content format

### 3. **Create Missing GitHub References**

For each missing file in `.github/prompts/{command-name}.prompt.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.ai-ley/shared/prompts/{command-name}.md`
```

Where:

- `{command-name}` = filename without .md extension
- `{Proper Case Title}` = extracted from YAML frontmatter `title` field or H1 heading

### 4. **Create Missing Claude References**

For each missing file in `.claude/commands/{command-name}.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.ai-ley/shared/prompts/{command-name}.md`
```

### 5. **Create Missing OpenCode References**

For each missing file in `.opencode/commands/{command-name}.md`:

```markdown
# Command: {Proper Case Title}

## Your Task

- Follow the prompt instructions found in `.ai-ley/shared/prompts/{command-name}.md`
```

### 6. **Ensure Directory Structure**

- Create `.github/prompts/` directory if it doesn't exist
- Create `.claude/commands/` directory if it doesn't exist
- Create `.cursor/commands/` directory if it doesn't exist
- Create `.opencode/commands/` directory if it doesn't exist
- Verify proper file permissions and structure

### 7. **Validation**

- Verify all reference files are created successfully
- Check that file contents follow established patterns
- Ensure all cross-references point to valid source prompt files
- Validate file naming conventions are consistent
- Confirm directory structure is complete

### 8. **Generate Report**

Provide a comprehensive summary:

```
🔧 Prompt Repair Complete

Source Prompts Found: {count}
- .ai-ley/shared/prompts/*.md

GitHub References:
- Existing: {existing-count}
- Created: {created-count}
- Total: {total-count}

Claude References:
- Existing: {existing-count}
- Created: {created-count}
- Total: {total-count}

OpenCode References:
- Existing: {existing-count}
- Created: {created-count}
- Total: {total-count}

📁 Directories Verified:
✅ .github/prompts/
✅ .claude/commands/
✅ .cursor/commands/
✅ .opencode/commands/

🎯 All prompt references synchronized successfully!
```

## Examples

### Example 1: Basic Repair

```
/repair-prompts
```

Expected Output:

```
🔧 Scanning .ai-ley/shared/prompts/ for source files...
Found 12 prompt files

📋 Auditing reference files...
- GitHub: 8 existing, 4 missing
- Claude: 10 existing, 2 missing
- Cursor: 7 existing, 3 missing
- OpenCode: 5 existing, 7 missing

✅ Creating missing reference files...
Created 13 new reference files

🎯 All prompt references synchronized!
```

### Example 2: Clean Environment

```
/repair-prompts
```

Expected Output:

```
🔧 Scanning .ai-ley/shared/prompts/ for source files...
Found 12 prompt files

📋 All reference files already exist and are properly formatted
🎯 No repairs needed - system is synchronized!
```

## Implementation Logic

### Title Extraction Priority

1. First, try to extract from YAML frontmatter `title` field
2. If not found, extract from first H1 heading (`# Title`)
3. If neither exists, convert filename to proper case (kebab-case → Title Case)

### File Name Mapping

- Source: `.ai-ley/shared/prompts/build-plan.md`
- GitHub: `.github/prompts/build-plan.prompt.md`
- Claude: `.claude/commands/build-plan.md`
- Cursor: `.cursor/commands/build-plan.md`
- OpenCode: `.opencode/commands/build-plan.md`

### Error Handling

- Skip files that cannot be read
- Log warnings for files with missing titles
- Continue processing even if individual files fail
- Provide detailed error reporting in final summary

## Notes

- This command is idempotent - safe to run multiple times
- Existing reference files are preserved and not overwritten
- Only creates missing files, does not modify existing ones
- Validates directory structure and creates missing directories
- Follows the established AI-LEY project patterns exactly
- Source prompts in `.ai-ley/shared/prompts/` are considered the single source of truth
- Reference files are lightweight pointers to the main prompt files
