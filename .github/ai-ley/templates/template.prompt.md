---
name: 'Template Prompt Name'
description: 'Brief description of what this prompt does and its purpose'
keywords: [keyword1, keyword2, keyword3, prompt, ailey]
---

# Prompt Name

## Variables

- Folders, Files and Indexes are stored in `.github/ai-ley/ai-ley.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.github/ai-ley/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `.github/ai-ley/personas` and instructions in `.github/ai-ley/instructions` as needed.

## Recommended Personas

Consider leveraging these persona domains:

- `.github/ai-ley/personas/_general/**/*.md`
- `.github/ai-ley/personas/[domain]/**/*.md`

These personas provide specialized expertise and perspective.

## Recommended Instructions

Consider referencing these instruction files:

- `.github/ai-ley/instructions/_general/developer/**/*.md`
- `.github/ai-ley/instructions/[category]/**/*.md`

These provide domain-specific guidance and best practices.

## Recommended Agent

This prompt works best with the **ailey-orchestrator** agent from `.github/agents/ailey-orchestrator.agent.md`.

To use this agent, reference it in your chat or workflow configuration.

## Goal

**Given:**

- Input 1: Description
- Input 2: Description
- Input 3: Description

**Produce:**

- Output 1: Description
- Output 2: Description
- Clear, actionable results

## Command

You are an expert [role/domain] specialized in [specific expertise area].

### Step 1: [Action Name]

**[Sub-task Name]:**

- Task item 1
- Task item 2
- Task item 3

**Expected Output:**

```markdown
## [Output Section Name]

### [Subsection]

- [ ] Checklist item 1
- [ ] Checklist item 2

### [Another Subsection]

**Item Name**: Description
**Details**: Additional information
```

### Step 2: [Next Action]

**[Sub-task Name]:**

- Detailed instruction 1
- Detailed instruction 2

**Validation Checks:**

- [ ] Validation criterion 1
- [ ] Validation criterion 2
- [ ] Validation criterion 3

### Step 3: [Final Action]

**Quality Assurance:**

- [ ] QA check 1
- [ ] QA check 2
- [ ] QA check 3

**Handoff Summary:**

```markdown
# [Task] Summary - [Date]

## Inputs Processed

- Input 1: [Details]
- Input 2: [Details]

## Results Produced

- Output 1: [Location/Description]
- Output 2: [Location/Description]

## Next Steps

1. [Immediate action]
2. [Follow-up action]
3. [Long-term consideration]
```

## Examples

### Example 1: [Scenario Name]

**Input:**

```
[Example input]
```

**Output:**

```markdown
[Example output]
```

### Example 2: [Another Scenario]

**Input:**

```
[Example input]
```

**Output:**

```markdown
[Example output]
```

## Notes

- Important consideration 1
- Important consideration 2
- Best practice reminder
- Common pitfall to avoid

---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
