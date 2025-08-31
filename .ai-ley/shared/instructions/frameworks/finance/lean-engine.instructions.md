Title: Lean Engine — AI Agent Trading System Guide

Scope
- Open-source QuantConnect Lean engine for research, backtesting, paper/live trading.

Core concepts
- QCAlgorithm lifecycle; Universe Selection; Alpha, PortfolioConstruction, Execution, Risk models.
- Time zones and trading calendars; consolidators and warm-up windows.

Data hygiene
- Vendor calendars/sessions; no look-ahead; point-in-time fundamentals; corporate actions handling.
- Cache raw inputs; version datasets; record hashes for reproducibility.

Strategy design
- Start with simple baselines; define explicit hypotheses; isolate alpha from execution.
- Use indicators with sufficient warmup; parameterize; avoid overfitting via walk-forward splits.

Evaluation
- Include transaction costs, slippage, borrow fees; stress tests; monte-carlo resampling.
- Report drawdowns, turnover, capacity constraints; benchmark vs. appropriate index.

Deployment
- Separate research notebooks, backtest configs, and live settings; secrets via env/KeyVault.
- Health checks and circuit breakers for live; alerts on order failures and data stalls.

AI Assistant Guidelines
- Enforce anti-leakage: time-aware splits, warmup, and calendar alignment.
- Generate QCAlgorithm scaffolds with Universe/Alpha/Portfolio/Execution/Risk wiring and tests.
- Provide parameter sweep harness and logging of PnL attribution; prefer simple before complex.


See also
- [frameworks/finance/quantconnect.instructions.md](../finance/quantconnect.instructions.md) — Platform workflows for cloud research/backtests/live
- [frameworks/finance/zipline-reloaded.instructions.md](../finance/zipline-reloaded.instructions.md) — Event-driven research backtester with pipelines
- [frameworks/finance/vectorbt.instructions.md](../finance/vectorbt.instructions.md) — Vectorized backtesting and indicator research
- [frameworks/finance/ta-lib.instructions.md](../finance/ta-lib.instructions.md) — Reliable technical indicators with warmup handling
- [frameworks/finance/alphalens.instructions.md](../finance/alphalens.instructions.md) — Factor evaluation (IC, quantiles, turnover)
- [frameworks/finance/pandas.instructions.md](../finance/pandas.instructions.md) — Time-series hygiene and data handling

