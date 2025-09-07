---
command: health-check
description: 'Evaluate {{files.requirements}}, {{files.plan}}, {{folders.personas}}, and {{folders.instructions}}; write a health report to {{files.health-check}} and suggestions to {{files.suggestions}}.'
audience: ['product', 'architecture', 'marketing', 'ops', 'leadership']
style: ['formal', 'professional', 'empathetic', 'forward-thinking']
principles:
  - human-first, win-win framing
  - clarity and measurability
  - explicit assumptions; no follow-up questions
inputs:
  - name: requirements_file
    required: true
    value: '{{files.requirements}}'
  - name: plan_file
    required: true
    value: '{{files.plan}}'
  - name: personas_dir
    required: true
    value: '{{folders.personas}}'
  - name: instructions_dir
    required: true
    value: '{{folders.instructions}}'
outputs:
  - path: '{{files.health-check}}'
    create_dirs: true
  - path: '{{files.suggestions}}'
    create_dirs: true
---

# Instruction

Evaluate the coherence and production-readiness of the current corpus:

- **Inputs:** `{{files.requirements}}`, `{{files.plan}}`, all files under `{{folders.personas}}` and `{{folders.instructions}}`.
- **Outputs:**
  1. Write a **Health Check Report** to `{{files.health-check}}`.
  2. Write an **Actionable Suggestions Backlog** to `{{files.suggestions}}`.

Operate deterministically. If information is missing, **state minimal assumptions** and proceed.

## Evaluation Dimensions (0–5 rubric; weight in parentheses)

- **Completeness (20%)**: Required sections, non-placeholder content, acceptance criteria, non-functional requirements (NFRs).
- **Consistency (15%)**: No contradictions across files (goals, dates, budgets, scope, terminology).
- **Traceability (20%)**: Requirements ↔ Plan tasks/milestones ↔ Personas (audience fit) ↔ Instructions (how-to).
- **Feasibility (10%)**: Technical/operational viability within constraints, capacity, budget, timeline.
- **Risk & Mitigation (10%)**: Identified risks with owners, triggers, and mitigations.
- **Governance (10%)**: Roles/RACI, decision rules, change control.
- **Measurement (10%)**: KPIs, targets, baselines, instrumentation.
- **Ethics/Safety/Compliance (5%)**: Privacy, security, regulatory and brand safeguards.

**Rubric anchors (per dimension):**  
0 = missing/contradictory; 1 = skeletal; 2 = partial; 3 = acceptable; 4 = strong; 5 = exemplary with evidence.

## Heuristics & Checks (non-exhaustive)

- **Requirements:** presence of problem statement, goals, out-of-scope, constraints, acceptance criteria, NFRs (e.g., performance, security, accessibility).
- **Plan:** milestones with ISO dates, owners, critical path, dependencies; budget and capacity alignment; risk register.
- **Personas:** ICP alignment, pains/goals, objections, buying roles, success criteria; mapping to requirements and content/instruction needs.
- **Instructions:** unambiguous steps, inputs/outputs, guardrails, references to real files/paths; no dead links; consistency with requirements/plan.
- **Conflicts:** date mismatches, budget sums ≠ allocations, KPI targets absent or inconsistent, persona needs not addressed in plan, instructions referencing non-existent artifacts.
- **Traceability:** build a matrix mapping **Requirement → Plan item(s) → Persona(s) → Instruction(s)** with coverage status (Covered/Partial/Gap).

## Deliverable 1 — Health Check Report (write to {{files.health-check}})

Format the report exactly as below.

# Health Check — {{project_name_or_context}}

> Date: {{iso_date}} | Source: {{files.requirements}}, {{files.plan}}, {{folders.personas}}, {{folders.instructions}}

## 1) Executive Summary (≤8 bullets)

- Key strengths, critical gaps, and top risks with business impact.

## 2) Scorecard (0–5; weighted)

| Dimension                | Score | Weight |                       Weighted |
| ------------------------ | ----: | -----: | -----------------------------: |
| Completeness             |       |   0.20 |                                |
| Consistency              |       |   0.15 |                                |
| Traceability             |       |   0.20 |                                |
| Feasibility              |       |   0.10 |                                |
| Risk & Mitigation        |       |   0.10 |                                |
| Governance               |       |   0.10 |                                |
| Measurement              |       |   0.10 |                                |
| Ethics/Safety/Compliance |       |   0.05 |                                |
| **Total**                |       |   1.00 | **{{overall_weighted_score}}** |

> Scoring notes: cite concrete evidence from the inputs.

## 3) Findings by Source

### 3.1 Requirements

- Strengths, gaps, contradictions; acceptance criteria & NFR adequacy.

### 3.2 Plan

- Milestones, owners, dependencies, budget/capacity validity; timeline cohesion.

### 3.3 Personas

- ICP alignment, pain/objection coverage, messaging implications.

### 3.4 Instructions

- Executability, guardrails, references, reproducibility, failure modes.

## 4) Traceability Matrix

| Req ID | Requirement | Plan Items | Persona(s) | Instruction(s) | Coverage                |
| ------ | ----------- | ---------- | ---------- | -------------- | ----------------------- |
| R-001  |             |            |            |                | Covered / Partial / Gap |

> If requirement IDs are absent, auto-assign R-### by heading order.

## 5) Risks & Mitigations

| ID  | Risk | Likelihood | Impact | Trigger | Owner | Mitigation | Status |
| --- | ---- | ---------- | ------ | ------- | ----- | ---------- | ------ |

## 6) KPI & Instrumentation Audit

- North Star, KPI tree, targets, baselines, telemetry plan, attribution model.

## 7) Governance & Decision Rules

- RACI, change control, escalation paths, review cadence.

## 8) Quality Gate Results

- ✅ No unresolved contradictions across files.
- ✅ All critical requirements mapped to at least one plan item and instruction.
- ✅ KPIs have numeric targets and timelines.
- ✅ Budgets/effort align with capacity; math verified.
- ✅ ISO dates/time zones consistent.
- ✅ No placeholder text without justified reason.

## 9) Assumptions

- Minimal, explicit assumptions used to complete the assessment.

## 10) Appendix

- Evidence excerpts (short quotes), file paths, glossary.

---

## Deliverable 2 — Suggestions Backlog (write to {{files.suggestions}})

Produce an actionable, prioritized backlog. Use the exact structure below.

# Suggestions Backlog — {{project_name_or_context}}

> Date: {{iso_date}} | Derived from Health Check

## A) Quick Wins (1–2 weeks)

| Item | Description | File/Section | Effort | Impact | Owner | Due (ISO) |
| ---- | ----------- | ------------ | -----: | -----: | ----- | --------- |

## B) Priority Fixes (≤6 weeks)

| Item | Description | File/Section | Effort | Impact | Owner | Due (ISO) |
| ---- | ----------- | ------------ | -----: | -----: | ----- | --------- |

## C) Structural Improvements

- Architecture, governance, measurement, or process refactors.

## D) Missing Artifacts / Stubs to Add

| Artifact | Purpose | Proposed Path | Minimal Template |
| -------- | ------- | ------------- | ---------------- |

## E) Content to Generate (if any)

- One-pagers, checklists, runbooks, dashboards, test plans.

## F) Follow-Up Reviews

- Cadence and entry/exit criteria for re-checks.

---

## Synthesis Procedure (internal)

1. **Parse & Normalize:** Load all inputs; extract headings, lists, tables, IDs, dates, KPIs, budgets. If IDs missing, **auto-number**.
2. **Run Checks:** Apply the Heuristics & Checks; log evidence for each dimension.
3. **Traceability Build:** Construct the matrix (Req → Plan → Persona → Instruction) and mark coverage.
4. **Score:** Assign 0–5 per dimension using rubric anchors; compute weighted total.
5. **Draft Outputs:** Populate all required sections verbatim by the templates above.
6. **Quality Gate:** Ensure all gates in “Quality Gate Results” are satisfied or call out exceptions with rationale.
7. **Write Files:**
   - Health report → `{{files.health-check}}`
   - Suggestions backlog → `{{files.suggestions}}`

## Output Rules

- Use **concise, evidence-backed prose** and tables.
- Use **ISO dates**, explicit time zones, and currency units where relevant.
- **No TBD** or placeholders unless unavoidable—justify briefly.
- Do **not** ask for missing info; make minimal assumptions and note them.
