Title: vectorbt — AI Agent Backtesting Guide

Scope
- Vectorized portfolio/backtesting with pandas/NumPy; emphasize correctness over speed.

Controls
- No look-ahead; realistic slippage/fees; event alignment; liquidity filters.

Patterns
- Use entries/exits series; portfolio.from_signals; parameter sweeps with caching.

AI Assistant Guidelines
- Always declare data assumptions and evaluation horizon; expose config for fees/slippage.
- Provide assertions checking for look-ahead and NaN handling.

