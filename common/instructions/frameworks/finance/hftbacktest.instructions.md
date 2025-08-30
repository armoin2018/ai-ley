# hftbacktest — AI Assistant Guidelines

Purpose: Ultra-fast event-driven backtests on intraday tick/LOB data with reproducibility and slippage realism.

## When to use
- High-frequency strategies needing microstructure-aware simulation.

## When to avoid
- End-of-day strategies; use Zipline/Lean/etc.

## Data contracts
- Inputs: timestamped ticks/order book events with nanosecond-level ordering guarantees where available.
- Timezones: exchange-local session calendars; handle DST transitions explicitly.
- Integrity: no duplicates; strictly monotonic ts per symbol; validate schema.

## Simulation realism
- Slippage/latency: model queue priority, partial fills, and exchange fees.
- Market impact: optional; document assumptions.
- Clock model: discrete event; ensure no future state leaks into decision logic.

## Performance
- Pre-allocate arrays; use numpy/numba where provided; avoid Python loops in hot paths.
- Chunk by day/symbol to constrain memory footprint; mmap large files when feasible.

## Testing
- Deterministic replay on a tiny synthetic tape with known fills; assert PnL and positions.
- Stress tests on large days; watch memory and runtime budgets.
- Edge cases: halts, auction opens/closes, crossed/locked markets.

## AI Assistant rules
- Keep strategy logic pure and side-effect free; inject data and broker models.
- Separate signal generation from order execution; shift signals by one event.
- Provide benchmarks vs. naive buy/hold and simple market-making baselines.
