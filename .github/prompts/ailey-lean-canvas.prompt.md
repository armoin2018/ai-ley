---
name: 'Lean Canvas'
description: 'AI-ley prompt for lean canvas'
keywords: [lean, canvas, prompt, ailey]
---

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

This prompt works best with the **ailey-entrepreneur** agent from `.github/agents/ailey-entrepreneur.agent.md`.

To use this agent, reference it in your chat or workflow configuration.


## References

**Personas:** Leverage domain expertise from `.github/ai-ley/personas/**/*.md`

**Instructions:** Follow best practices from `.github/ai-ley/instructions/**/*.md`

**Agents:** This prompt is designed for the agent system. See the Recommended Agent section below.

## Objective

Transform the structured requirements from **`{{files.requirements}}`** into a **Lean Canvas** format that highlights business model fundamentals.

## Inputs

- `{{files.requirements}}` (Markdown file containing context, goals, non-goals, scope, constraints, etc.)

## Process

1. Parse the requirements file and extract:
   - Problem statements
   - Target customer segments
   - Value propositions
   - Key features/solutions
   - Channels (distribution, acquisition)
   - Revenue streams and cost structures
   - Key metrics
   - Unfair advantages or differentiators
2. Normalize the extracted items into **Lean Canvas** categories.
3. Where gaps exist, mark as **TODO / Open Question**.
4. Keep entries concise (1–3 bullet points each).

## Expected Output

A Markdown table with Lean Canvas categories:

```markdown
# Lean Canvas

| Section           | Notes (from {files.requirements}) |
| ----------------- | --------------------------------- |
| Problem           | ...                               |
| Customer Segments | ...                               |
| Unique Value Prop | ...                               |
| Solution          | ...                               |
| Channels          | ...                               |
| Revenue Streams   | ...                               |
| Cost Structure    | ...                               |
| Key Metrics       | ...                               |
| Unfair Advantage  | ...                               |
```

## Acceptance Criteria

- Each Lean Canvas section is filled with **extracted, evidence-based entries** from `{{files.requirements}}`.
- Missing data clearly flagged as **TODO**.
- Output written in `{{folders.plan}}/business/lean-canvas.md`
---

version: 1.0.0
updated: 2026-01-11
reviewed: 2026-01-11
score: 4.0
