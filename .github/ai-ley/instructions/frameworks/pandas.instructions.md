---
name: 'Pandas.Instructions'
description: 'Development guidelines and best practices for Pandas.Instructions'
keywords: [frameworks, pandas.instructions, gui, testing]
---



Title: pandas (Finance) — AI Agent Data Handling Guide

Scope
- Time-series, market data, and portfolio datasets with strict reproducibility.

Practices
- Use explicit dtypes; timezone-aware DateTimeIndex; immutable raw data snapshots.
- Vectorize ops; avoid chained assignments; copy-on-write awareness.
- Large data: chunked IO, pyarrow/parquet; downcast numerics; categoricals.

Risk and compliance
- No look-ahead bias; align timestamps; document data vendors/licensing.
- Audit trails: persist transforms; checksum inputs/outputs; version datasets.

Testing
- Golden datasets, property-based tests for invariants (e.g., pnl monotonicity conditions).

AI Assistant Guidelines
- Always enforce timezone/index hygiene; avoid SettingWithCopy pitfalls.
- Provide memory/perf estimates and chunking strategies; prefer vectorized solutions.

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
