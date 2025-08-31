Title: QuantConnect — AI Agent Platform Guide

Scope
- Cloud research/backtesting/live trading on top of Lean with brokerage integrations.

Practices
- Use project templates; parameterize via environment variables; store secrets in platform vaults.
- Dataset licensing compliance; data cost awareness; minimize data footprint.

Backtest → live
- Validate on multiple periods/instruments; paper trade before live; configure brokerage models.
- Monitoring: order fills, slippage drift, data latency; incident runbooks and alerts.

AI Assistant Guidelines
- Provide config files and environment mappings; generate deploy-ready parameter sets.
- Include pre-live checklist and rollback plan; refuse designs without risk controls.


See also
- [frameworks/finance/lean-engine.instructions.md](../finance/lean-engine.instructions.md) — Open-source engine under the platform
- [frameworks/finance/zipline-reloaded.instructions.md](../finance/zipline-reloaded.instructions.md) — Offline research backtesting with pipelines
- [frameworks/finance/pyfolio.instructions.md](../finance/pyfolio.instructions.md) — Performance/risk analysis
- [frameworks/finance/alphalens.instructions.md](../finance/alphalens.instructions.md) — Factor analytics
- [frameworks/finance/ta-lib.instructions.md](../finance/ta-lib.instructions.md) — Technical indicators

