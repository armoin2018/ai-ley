Title: Zipline Reloaded — AI Agent Backtesting Guide

Scope
- Event-driven backtesting with accurate trading calendars and pipeline API.

Data and calendars
- Point-in-time equities; corporate actions adjustments; exchange calendars and sessions.

Pipeline
- Factor/Filter classifiers; rolling windows; beware of implicit look-ahead; cache intermediates.

Evaluation
- Include slippage/commissions; benchmark; out-of-sample periods and parameter sweeps.

AI Assistant Guidelines
- Enforce calendar/session correctness and anti-leakage tests; document data sources.
- Provide pipeline examples with unit tests verifying no future data usage.


See also
- [frameworks/finance/lean-engine.instructions.md](../finance/lean-engine.instructions.md) — Live-capable engine with modular models
- [frameworks/finance/quantconnect.instructions.md](../finance/quantconnect.instructions.md) — Cloud platform around Lean
- [frameworks/finance/alphalens.instructions.md](../finance/alphalens.instructions.md) — Factor evaluation on Zipline bundles
- [frameworks/finance/pyfolio.instructions.md](../finance/pyfolio.instructions.md) — Risk/performance analytics for backtests

