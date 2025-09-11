---
command: build-test-plan
description: 'Create a detailed test plan and generate traceable test scripts from requirements, plan, personas, and instructions.'
audience: ['engineering', 'qa', 'product', 'security', 'ops']
style: ['formal', 'professional', 'forward-thinking', 'empathetic']
principles:
  - coverage and traceability over anecdotal testing
  - measurable quality gates
  - minimal assumptions when info is missing
---

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

# Instruction

Evaluate the corpus:

- **Inputs:** `{{files.requirements}}`, `{{files.plan}}`, all files under `{{folders.personas}}` and `{{folders.instructions}}`.
- **Outputs:**
  1. Write a **Test Plan** to `{{files.test-plan}}`.
  2. Generate **test scripts & scaffolding** under `{{folders.tests}}`, traceable to requirements.

Operate deterministically. If information is missing, **state minimal assumptions** and proceed.

## Operating Rules

- Build explicit **traceability**: each requirement (R-###) maps to ≥1 test case (TC-###). Critical requirements require ≥1 **E2E** test.
- Use **ISO dates**, explicit time zones, and units. Keep math/checks consistent.
- No placeholders like “TBD” unless unavoidable; justify briefly.
- Prefer **language/tool auto-detection** from inputs. If unclear, default to **TypeScript + Playwright** (E2E/UI), **Node/Jest** (unit), **REST via HTTPie** (API), **k6** (performance), **OWASP ZAP Baseline** (security), **pa11y-ci** (accessibility), and **pytest** stubs for Python services mentioned.
- Every generated script/file must include a short header with: purpose, mapped requirement IDs, preconditions, expected result.

---

## Deliverable 1 — Test Plan (write to {{files.test-plan}})

Produce **exactly** this structure:

# Test Plan — {{project_or_product_name}}

> Date: {{iso_date}} | Source: {{files.requirements}}, {{files.plan}}, {{folders.personas}}, {{folders.instructions}} | Owner: QA

## 1) Objectives & Scope

- **Objectives:** (quality goals, risk reduction, acceptance)
- **In Scope:** features/modules, platforms, environments
- **Out of Scope:** (with rationale)

## 2) References & Inputs

- Requirements sections & IDs, plan milestones, personas, runbooks/instructions

## 3) Strategy & Levels

- **Levels:** unit, component, integration, API, E2E, UX, performance, security, accessibility, data quality
- **Entry/Exit Criteria** per level
- **Defect Severity & SLA:** S0–S3, triage rules

## 4) Environments & Tooling

- **Envs:** dev, test, staging, prod-like (configs, data, secrets)
- **Tools:** runners, frameworks, linters, scanners, reporters (justify choices)

## 5) Test Data & Fixtures

- Synthetic vs. masked prod data, generation approach, refresh cadence, privacy/compliance notes

## 6) Requirements Traceability Matrix (RTM)

| Req ID | Requirement | Test IDs       | Level    | Status  | Notes |
| ------ | ----------- | -------------- | -------- | ------- | ----- |
| R-001  | ...         | TC-001, TC-045 | E2E, API | Planned |       |

> If requirement IDs missing, assign R-### by heading order.

## 7) Test Design Catalog

- **By level:** counts, themes, edge cases, negative paths, persona-driven scenarios
- **Non-functional:** performance SLAs, security controls, accessibility criteria (WCAG), reliability targets

## 8) Schedule & Milestones

- Phases, gates, dates (ISO), owners; alignment to plan’s critical path

## 9) Metrics & Reporting

- **KPI Tree:** coverage %, pass rate, defect leakage, MTTR, flake rate, P95 latency error budget burn
- Dashboards & cadence

## 10) Risks & Mitigations

| ID  | Risk | Likelihood | Impact | Mitigation | Owner | Trigger |
| --- | ---- | ---------- | ------ | ---------- | ----- | ------- |

## 11) Governance & RACI

- Roles, approvals, change control

## 12) Quality Gates

- ✅ 100% critical requirement coverage with ≥1 E2E
- ✅ ≥80% statement coverage (unit) unless justified
- ✅ Perf: P95 latency within X ms at Y RPS, error rate < Z%
- ✅ No open Sev-0/Sev-1 before release
- ✅ Security baseline scan passes; accessibility issues ≤ AA thresholds

## 13) Assumptions

- Minimal, explicit assumptions enabling this plan

## 14) Appendices

- Glossary, enumerated test IDs, environment variables, tooling configs

---

## Deliverable 2 — Test Scripts & Scaffolding (under {{folders.tests}})

Create the following structure and populate initial files:

```
{{folders.tests}}/
  README.md
  CATALOG.md                 # index of all TC-### with links
  fixtures/
    data/                    # seed data, anonymized samples
    env/                     # .env.example, config templates
  unit/
    README.md
    tc-{{NNN}}-*.spec.ts     # Jest (TypeScript) unit tests
  integration/
    README.md
    tc-{{NNN}}-*.spec.ts     # cross-module tests
  api/
    README.md
    collections/             # Postman collections OR HTTPie scripts
    http/
      tc-{{NNN}}-*.http      # HTTPie-style scripts with assertions in comments
  e2e/
    README.md
    playwright.config.ts     # if JS/TS stack inferred; else document fallback
    tc-{{NNN}}-*.e2e.spec.ts
  performance/
    README.md
    tc-{{NNN}}-baseline.js   # k6 scripts (thresholds from requirements/NFRs)
  security/
    README.md
    zap-baseline.yaml        # OWASP ZAP Baseline config
    tc-{{NNN}}-security.md   # checks mapped to controls
  accessibility/
    README.md
    pa11yci.config.json
    tc-{{NNN}}-a11y.md
  ux/
    README.md
    tc-{{NNN}}-persona-journey.md  # persona-driven scenarios
```

### Script Header Template (include atop every test file)

```
/*
Test ID: TC-{{NNN}}
Maps To: R-{{IDs}}
Level: unit | integration | api | e2e | performance | security | accessibility | ux
Preconditions: ...
Steps: ...
Expected: ...
Notes: ...
*/
```

### Autodetect & Default Tooling

- **If Node/TS detected:** Jest + Playwright; add minimal `package.json` test scripts under `{{folders.tests}}/README.md`.
- **If Python detected:** generate `pytest` stubs mirroring TC-### with `conftest.py`.
- **If services expose HTTP:** generate `.http` scripts (HTTPie) and Postman JSON.
- **Performance:** generate `k6` scripts with thresholds from NFRs or reasonable defaults (document assumptions).
- **Security:** include OWASP ZAP Baseline config and a simple runner instruction.
- **Accessibility:** include `pa11y-ci` config and sample targets derived from plan/instructions (e.g., key pages/flows).

### Traceability Artifacts

- Update `CATALOG.md` with a table:
  | Test ID | Title | Level | Req IDs | Status | Path |
  |---|---|---|---|---|---|

---

## Synthesis Procedure (internal)

1. **Parse & Normalize:** Extract requirement IDs/titles, acceptance criteria, NFRs; plan milestones; persona tasks/flows; operational instructions.
2. **ID Assignment:** If missing, auto-assign `R-###` and derive initial **criticality** (High/Med/Low) using signals: deadlines, budget, risk.
3. **Design Tests:** For each requirement, produce ≥1 test (more for critical/complex), selecting appropriate **level** and **tool**; include negative & edge cases.
4. **Derive Non-Functional Tests:** From NFRs/instructions, generate perf/security/a11y/data-quality tests with thresholds.
5. **Generate Files:** Write the **Test Plan** to `{{files.test-plan}}`. Create the folder tree and test files under `{{folders.tests}}` using the naming and header templates above.
6. **Fill RTM:** Emit the RTM in the plan and embed Req→Test links in each test header.
7. **Quality Gate:** Ensure all **Quality Gates** in the plan are satisfied or annotate exceptions with rationale.

## Output Rules

- Keep prose concise and evidence-backed.
- Use ISO dates and explicit time zones.
- No placeholder “TBD” unless justified.
- Ensure every generated test file has a clear **purpose** and **Req mapping**.
