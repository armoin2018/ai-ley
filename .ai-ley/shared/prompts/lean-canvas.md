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
