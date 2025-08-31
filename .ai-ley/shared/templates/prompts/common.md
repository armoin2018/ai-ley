# Command: <command-name>

_A short, clear identifier (e.g., `/build-plan` or `/generate-doc`)_

---

## Overview

**Description**:  
Explain what this command does in one or two sentences.

**Primary Use Case**:  
When and why this command should be invoked.

---

## Inputs

- **Required Inputs**:
  - Example: `REQUIREMENTS.md` file
- **Optional Inputs**:
  - Example: `ASK.md`, `SUGGESTIONS.md`

---

## Outputs

- **Expected Artifacts**:
  - Example: `PLAN.md`
  - Example: Updates `SUGGESTIONS.md` if missing info is detected

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
   - If missing context, append notes to `SUGGESTIONS.md`.

---

## Error Handling

- If a required file is missing → log to `ERRORS.md`.
- If instructions are ambiguous → add clarifying questions in `SUGGESTIONS.md`.

---

## Example Prompt

**Command:**

```bash
/copilot run /build-plan
```

**Behavior:**  
Reads `REQUIREMENTS.md` and produces `PLAN.md` with structured tasks.

---

## Metadata

- **Version**: v1.0.0
- **Last Updated**: YYYY-MM-DD
- **Tags**: planning, automation, copilot-command
