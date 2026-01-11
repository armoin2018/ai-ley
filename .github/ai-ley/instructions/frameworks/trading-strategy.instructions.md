---
name: 'Trading Strategy.Instructions'
description: 'Purpose: Research and execute strategies with datasets, pipelines, and execution models while maintaining anti-leakage and auditability.'
keywords: [(python, guidelines, gui, library), library, frameworks, assistant, rules, contracts, strategy]
---



# trading-strategy — AI Assistant Guidelines (Python library)

Purpose: Research and execute strategies with datasets, pipelines, and execution models while maintaining anti-leakage and auditability.

## Data contracts
- Use vendor datasets with schema checks; timezones and calendars enforced.
- Adjusted prices, realistic slippage/fee models; document assumptions.

## Strategy dev
- Separate signal generation from portfolio/exec; shift signals; cap turnover.
- Store experiment metadata (params, seeds, metrics) with hashes for reproducibility.

## Testing
- Golden backtest on small dataset; assert metrics; test edge cases (halts, missing data).

## AI Assistant rules
- Provide ready-to-run notebooks/scripts with configs; forbid live trading by default; add runbook.

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
