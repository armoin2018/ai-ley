# Command: <command-name>

_A short, clear identifier (e.g., `/build-plan` or `/generate-doc`)_

---

## Variables

- Folders, Files and Indexes are defined in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## Overview

**Description**:  
Explain what this command does in one or two sentences.

**Primary Use Case**:  
When and why this command should be invoked.

---

## Inputs

- **Required Inputs**:
  - Example: `{{files.requirements}}` file
- **Optional Inputs**:
  - Example: `{{files.ask}}`, `{{files.suggestions}}`

---

## Outputs

- **Expected Artifacts**:
  - Example: `{{files.plan}}`
  - Example: Updates `{{files.suggestions}}` if missing info is detected

---

## Instructions

1. **Preparation**

   - Load context from `<files>` if present.
   - Validate required inputs exist.

2. **Execution**

   - Apply steps in order.
   - Follow formatting standards (e.g., Markdown tables, JSON blocks).
   - Keep responses concise but complete.

3. **Post-Processing**
   - Write output to `<target file>`.
   - If missing context, append notes to `{{files.suggestions}}`.

---

## Error Handling

- If a required file is missing → log to `{{files.errors}}`.
- If instructions are ambiguous → add clarifying questions in `{{files.suggestions}}`.

---

## Example Prompt

**Command:**

```bash
/copilot run /build-plan
```

**Behavior:**  
Reads `{{files.requirements}}` and produces `{{files.plan}}` with structured tasks. Taking into account all defined instructions, personas, and standards.

---

## Metadata

- **Version**: v1.0.0
- **Last Updated**: YYYY-MM-DD
- **Tags**: planning, automation, copilot-command
