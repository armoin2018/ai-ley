# Freqtrade — AI Assistant Guidelines (Crypto Trading Bot)

Purpose: Research → backtest → dry-run → live with strict risk controls, data hygiene, and configuration versioning.

## When to use
- Crypto markets with Freqtrade strategy plugins and exchange connectors.
- Need rapid iteration with hyperopt and backtesting.

## When to avoid
- Regulated securities without proper compliance and broker connectivity.
- Strategies needing custom order routing/latency guarantees beyond Freqtrade’s model.

## Core setup
- Config in YAML/JSON tracked in VCS; no secrets in repo. Use env vars/secret manager.
- Data: fetch via freqtrade download-data; document exchange, quote, timeframe, and adjustments.
- Modes: backtest → dry-run (paper) → live. Gate progress with acceptance checks.

## Risk and execution rules
- Position sizing: Kelly-fraction cap, max exposure per asset, portfolio-level VaR limits.
- Orders: always use stoploss and ROI tables; slippage models in backtests.
- Cooldowns/guards: prevent over-trading; enforce max concurrent trades.

## Anti-leakage and testing
- Walk-forward: split by time, not random. Keep validation periods strictly out-of-sample.
- Hyperopt: bound parameter space; forbid target using future returns.
- Golden tests: deterministic backtests for a known strategy/config; assert metrics within tolerance.

## Live operations
- Dry-run burn-in before real funds; alerting via Telegram/Slack with correlation IDs.
- Health checks: heartbeat, open orders drift, balance reconciliation.
- Rollback plan: feature flags, strategy version pinning.

## AI Assistant rules
- Never enable live trading by default; require explicit “live=true” gate.
- Generate configs with minimal privileges API keys; never commit keys.
- Emit a runbook for deployment, monitoring, and rollback.
