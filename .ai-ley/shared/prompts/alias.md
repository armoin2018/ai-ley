---
agentMode: general
applyTo: general
author: AI-LEY
description: Create command aliases that reference existing prompts across all platforms
extensions:
  - .md
guidelines: Follow AI-LEY project standards for command aliasing and cross-platform compatibility
instructionType: general
keywords: [command-alias, prompt-reference, cross-platform, command-shortcuts]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Command Alias Creator
version: 1.0.0
---

# Copilot Command: Command Alias Creator

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.prompts}}`.

## Goal

Given:

- An existing command name in `.ai-ley/shared/prompts/`
- A desired alias name for the command
- Cross-platform command reference requirements

Produce:

- Alias reference files in `.claude/commands/<alias-name>.md`
- Alias reference files in `.opencode/commands/<alias-name>.md`
- Alias reference files in `.github/prompts/<alias-name>.prompt.md`
- All aliases pointing to the original command in `.ai-ley/shared/prompts/`

## Command

You are a command aliasing specialist responsible for creating command shortcuts and alternative names that maintain consistency across all AI assistant platforms.

### Usage Syntax

```
alias <real-name> <alias-name>
```

**Parameters**:

- `<real-name>`: The existing command name (without .md extension)
- `<alias-name>`: The desired alias name for the command

**Examples**:

```
alias build-marketing-strategy mkt
alias build-revenue-projections revenue
alias learn research
alias optimize perf
```

### **Command Execution Process**

**Step 1: Validation and Setup**:

```markdown
**Validate Command Existence**:

- Check if `.ai-ley/shared/prompts/<real-name>.md` exists
- Verify the real command file is accessible and valid
- Ensure alias name doesn't conflict with existing commands
- Validate alias name follows naming conventions (lowercase, hyphens, no spaces)

**Alias Configuration**:

- Real command path: `.ai-ley/shared/prompts/<real-name>.md`
- Alias name validation: alphanumeric and hyphens only
- Cross-platform compatibility check
- Prevent circular aliasing (alias pointing to another alias)
```

**Step 2: Cross-Platform Alias Creation**:

````markdown
**Create GitHub Alias** (`.github/prompts/<alias-name>.prompt.md`):

```markdown
# Command: <Real-Command-Title>

## Your Task

- Follow the prompt instructions found in `.ai-ley/shared/prompts/<real-name>.md`

## Alias Information

This is an alias for the command `<real-name>`. The original command provides:
<brief-description-of-original-command>

## Usage
```
````

<alias-name>
```

This command functions identically to `<real-name>` with all the same capabilities and options.

````

**Create Claude Alias** (`.claude/commands/<alias-name>.md`):
```markdown
# Command: <Real-Command-Title>

Follow the prompt instructions found in `.ai-ley/shared/prompts/<real-name>.md`

## Alias: <alias-name> → <real-name>

This is a shortcut alias for the `<real-name>` command.
````

**Create OpenCode Alias** (`.opencode/commands/<alias-name>.md`):

```markdown
# Command: <Real-Command-Title>

Follow the prompt instructions found in `.ai-ley/shared/prompts/<real-name>.md`

## Alias: <alias-name> → <real-name>

This command is an alias for `<real-name>` and provides identical functionality.
```

````

**Step 3: Alias Documentation and Confirmation**:
```markdown
**Generate Alias Summary**:
- List all created alias files with their paths
- Confirm alias relationship: `<alias-name>` → `<real-name>`
- Verify cross-platform consistency
- Document alias purpose and usage

**Validation Checks**:
- Confirm all three platform files were created successfully
- Verify file contents reference the correct original command
- Test alias accessibility across platforms
- Update any relevant documentation or indexes
````

## Implementation Details

### File Content Templates

#### GitHub Prompt Template

```markdown
# Command: {Real-Command-Title}

## Your Task

- Follow the prompt instructions found in `.ai-ley/shared/prompts/{real-name}.md`

## Alias Information

**Original Command**: `{real-name}`
**Alias**: `{alias-name}`
**Purpose**: {brief-description}

This alias provides the same functionality as the original command with a shorter, more convenient name.
```

#### Claude Command Template

```markdown
# Command: {Real-Command-Title}

Follow the prompt instructions found in `.ai-ley/shared/prompts/{real-name}.md`

_Alias: `{alias-name}` → `{real-name}`_
```

#### OpenCode Command Template

```markdown
# Command: {Real-Command-Title}

Follow the prompt instructions found in `.ai-ley/shared/prompts/{real-name}.md`

---

**Alias**: This command (`{alias-name}`) is an alias for `{real-name}`
```

### Error Handling

**Invalid Real Command**:

```markdown
❌ Error: Command '{real-name}' not found

The command '.ai-ley/shared/prompts/{real-name}.md' does not exist.

Available commands:

- build-marketing-strategy
- build-revenue-projections
- learn
- optimize
- [list other available commands]

Usage: alias <existing-command> <alias-name>
```

**Invalid Alias Name**:

```markdown
❌ Error: Invalid alias name '{alias-name}'

Alias names must:

- Use lowercase letters, numbers, and hyphens only
- Not contain spaces or special characters
- Not conflict with existing commands
- Be between 2-50 characters long

Suggested alternatives:

- {sanitized-suggestion-1}
- {sanitized-suggestion-2}
```

**Existing Alias Conflict**:

```markdown
⚠️ Warning: Alias '{alias-name}' already exists

Current alias points to: .ai-ley/shared/prompts/{existing-target}.md
Requested alias points to: .ai-ley/shared/prompts/{real-name}.md

Options:

1. Choose a different alias name
2. Overwrite existing alias (use --force flag)
3. Remove existing alias first

Proceed with overwrite? [y/N]
```

## Examples

### Example 1: Create Marketing Strategy Alias

**Input**:

```
alias build-marketing-strategy mkt
```

**Expected Output**:

```markdown
🔗 Creating command alias...

✅ Validating command:

- Source: .ai-ley/shared/prompts/build-marketing-strategy.md ✓
- Target alias: mkt ✓
- No conflicts detected ✓

📝 Creating alias files:
✅ .github/prompts/mkt.prompt.md
✅ .claude/commands/mkt.md  
✅ .opencode/commands/mkt.md

🎯 Alias created successfully!

**Usage**: `mkt` now functions identically to `build-marketing-strategy`

**Command Summary**:

- Original: build-marketing-strategy (comprehensive marketing strategy generation)
- Alias: mkt (shorter command for quick access)
- Platforms: GitHub Copilot, Claude, OpenCode
- Reference: .ai-ley/shared/prompts/build-marketing-strategy.md
```

### Example 2: Create Performance Optimization Alias

**Input**:

```
alias optimize perf
```

**Expected Output**:

```markdown
🔗 Creating performance optimization alias...

✅ Command validation:

- Source command: optimize (Performance Optimization and Analysis)
- Alias name: perf
- Cross-platform compatibility: ✓

📁 Generated files:

- .github/prompts/perf.prompt.md → optimize
- .claude/commands/perf.md → optimize
- .opencode/commands/perf.md → optimize

🚀 Alias ready for use!

Now you can use `perf` as a shortcut for the comprehensive performance optimization command that includes:

- Database bottleneck analysis
- Memory leak detection
- Network optimization recommendations
- Performance profiling and monitoring setup

Quick access: `perf` = full performance analysis and optimization
```

### Example 3: Create Learning Command Alias

**Input**:

```
alias learn research
```

**Expected Output**:

```markdown
🧠 Creating research alias for learning command...

✅ Setup complete:

- Original: learn (Project Learning and Suggestions)
- Alias: research
- Function: Project analysis + web research + improvement suggestions

📋 Cross-platform files created:

1. GitHub: .github/prompts/research.prompt.md
2. Claude: .claude/commands/research.md
3. OpenCode: .opencode/commands/research.md

🎯 Alias active! Use `research` for:

- Project component scanning
- Web innovation research
- Intelligent improvement suggestions
- Market trend analysis
- Optimization recommendations

Both `learn` and `research` now provide identical functionality.
```

### Example 4: Error Handling - Invalid Command

**Input**:

```
alias non-existent-command shortcut
```

**Expected Output**:

```markdown
❌ Alias creation failed

**Error**: Command 'non-existent-command' not found
**Path**: .ai-ley/shared/prompts/non-existent-command.md does not exist

📚 Available commands for aliasing:

- build-marketing-strategy
- build-revenue-projections
- build-business-development
- build-launch-plan
- build-market-research
- learn
- optimize

**Usage**: `alias <existing-command> <alias-name>`
**Example**: `alias optimize perf`
```

## Notes

- **Source validation** ensures aliases only point to existing, valid commands
- **Cross-platform consistency** maintains identical functionality across all AI assistants
- **Naming conventions** enforce lowercase, hyphen-separated alias names for consistency
- **Conflict detection** prevents overwriting existing commands or aliases without confirmation
- **Reference integrity** maintains clear connection between alias and original command
- **Documentation** includes purpose and usage information in each alias file
- **Error handling** provides clear guidance for common issues and resolution steps
- **Flexibility** supports any existing command in the `.ai-ley/shared/prompts/` directory
