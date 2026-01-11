---
name: 'Scipy.Instructions'
description: 'Purpose: Optimization, statistics, and signal processing for portfolio construction and factor analysis with reproducible, bounded computations.'
keywords: [guidelines, gui, cases, frameworks, scipy.instructions, assistant, rules, scipy, (finance), optimization]
---



# SciPy (Finance) — AI Assistant Guidelines

Purpose: Optimization, statistics, and signal processing for portfolio construction and factor analysis with reproducible, bounded computations.

## Use cases
- Optimize portfolios (scipy.optimize), hypothesis tests (scipy.stats), filters (scipy.signal).

## Rules
- Fix seeds; specify tolerances and bounds; check solver status and KKT conditions where applicable.
- Use robust statistics for heavy tails; avoid parametric assumptions without tests.
- No lookahead: filters applied causally; document lags.

## Testing
- Analytical cases with known solutions; numerical benchmarks with tolerance.
- Sensitivity analysis for constraints/penalties; record results.

## AI Assistant rules
- Emit full optimization problem spec (objective, constraints, bounds) and verification steps.

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
