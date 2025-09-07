---
command: build-marketing-strategy
description: 'Generate a complete, metrics-driven marketing strategy from {{files.requirements}} and write it to {{folders.plan}}/business/marketing-strategy.md.'
audience: ['innovators', 'entrepreneurs', 'product leaders', 'marketing']
style: ['formal', 'professional', 'empathetic', 'forward-thinking']
principles:
  - human-first, win-win framing
  - clarity > cleverness
  - measurable outcomes
inputs:
  - name: requirements_file
    required: true
    value: '{{files.requirements}}'
outputs:
  - path: '{{folders.plan}}/business/marketing-strategy.md'
    create_dirs: true
---

# Instruction

Read **{{files.requirements}}** and synthesize a comprehensive, actionable **Marketing Strategy**.  
Then **write the final deliverable to**: `{{folders.plan}}/business/marketing-strategy.md`.

### Operating Rules

- If any information is missing, **state explicit assumptions** and continue—do not ask follow-ups.
- Prefer concise, scannable writing with clear tables, bullets, and headings.
- Use **ISO dates**, explicit time zones, and units; use **USD** for costs unless requirements specify otherwise.
- Align to stated brand voice, ICP, constraints, budget, and timeline.
- Provide **KPIs with targets**, not just metrics.
- Include **at least one creative alternative** per major recommendation.

### Deliverable Structure (must follow exactly)

# Marketing Strategy — {{product_or_initiative_name}}

> Version: {{iso_date}} | Owner: Marketing | Source: {{files.requirements}}

## 1) Executive Summary (≤10 bullets)

- Top objectives, time horizon, and expected business impact.

## 2) Inputs & Assumptions

- **Key Inputs:** (cite requirements sections, constraints, budgets, timelines)
- **Assumptions (explicit):** (numbered list—only those necessary to proceed)

## 3) Ideal Customer Profile (ICP) & Personas

- **Primary ICP:** industry/segment, company size, jobs-to-be-done, pains, buying triggers
- **Personas:** role, success criteria, objections, decision authority/influence
- **Priority Segments & TAM/SAM/SOM (if available)**

## 4) Positioning & Value Proposition

- **Positioning Statement:** For `<ICP>`, `<product>` is the `<category>` that `<core benefit>` because `<unique proof>`.
- **Messaging Pillars (3–5) & Proof Points**
- **Differentiators vs. Competitors (table)**

## 5) Go-To-Market Strategy

### 5.1 Channel Mix (Owned / Earned / Paid / Partnerships / Community)

- Objectives, core message, CTA, cadence, cost range, expected reach & conversion

### 5.2 Tactics Backlog (table)

| Channel | Tactic | Audience | Message/Offer | Asset(s) | Owner | Est. Cost | Effort | KPI Target |
| ------- | ------ | -------- | ------------- | -------- | ----- | --------: | -----: | ---------- |

### 5.3 Launch Plan & Timeline (phased)

- **Milestones:** Alpha → Beta → GA (dates, exit criteria)
- **Critical Path & Dependencies**

## 6) Content Strategy & Calendar (first 12 weeks, table)

| Week (ISO) | Theme | Asset Type | Title/Angle | ICP/Persona | Distribution | CTA | KPI Target |
| ---------- | ----- | ---------- | ----------- | ----------- | ------------ | --- | ---------- |

## 7) Demand Gen & Lifecycle

- **Top-of-Funnel:** SEO topics, social playbook, events/webinars, PR
- **Mid-Funnel:** lead magnets, email nurture (3-stage outline), retargeting
- **Bottom-of-Funnel:** trials, ROI calculators, customer references

## 8) Budget & Capacity

- **Budget Summary (table)**
- **Allocation by Channel (%)**
- **Capacity & Constraints** (people, tooling, agencies)

## 9) Measurement & Instrumentation

- **North Star Metric:** definition & target
- **KPI Tree:** acquisition → activation → revenue → retention → referral
- **Instrumentation Plan:** analytics, dashboards, attribution model, data hygiene

## 10) Experiments & Learning Agenda

- **Experiment Backlog (table):** hypothesis, metric, MDE, sample, duration, decision rule
- **Quarterly Review Cadence & Decision Rules**

## 11) Risks & Mitigations

- Market, compliance, brand, execution, data—mitigation owners and triggers

## 12) Governance & RACI

- **RACI Table** for strategy, content, campaigns, analytics, budget approvals

## 13) Asset Checklist

- Brand guide, messaging sheet, one-pagers, decks, website pages, email templates, tracking plan

## 14) Appendices

- Glossary, competitor snapshots, requirements excerpts, research notes

---

### Synthesis Procedure (internal)

1. Parse `{{files.requirements}}` to extract: product, audiences, constraints, brand voice, success metrics, budget, timeline, legal/compliance.
2. Map inputs → ICP, positioning, messaging, channels, tactics, and KPIs. Resolve conflicts by prioritizing stated business goals.
3. Quantify targets using available baselines; if absent, provide **reasoned ranges** with assumptions.
4. Produce the deliverable exactly as structured above—**no extra sections**.
5. Run the **Quality Gate** below; then write to `{{folders.plan}}/business/marketing-strategy.md`.

### Quality Gate (must pass before writing)

- ✅ Every required section is present and populated.
- ✅ All KPIs have numeric targets and timeframes.
- ✅ Budgets align with channel/tactic totals; math checked.
- ✅ Assumptions are explicit and minimal.
- ✅ Timeline dates are ISO and internally consistent.
- ✅ No placeholder text (e.g., “TBD”) unless truly unavoidable—justify if used.

### Output

Write the final Markdown to:
`{{folders.plan}}/business/marketing-strategy.md`
