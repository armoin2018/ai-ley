# AlphaPy (Finance) — AI Assistant Guidelines

Purpose: Build ML-based trading signals and portfolios with strict time-aware validation and risk controls.

## Data hygiene
- Use adjusted prices; align to trading calendars; ensure no gaps or duplicates.
- Label generation: horizon returns from t+1 to t+H; avoid same-bar labels.

## Modeling rules
- TimeSeriesSplit or PurgedKFold with embargo; record feature/label generation code hash.
- Evaluate with precision/recall for classification, IC/IR for factor models, and portfolio-level metrics.

## Backtesting
- Export signals to backtester (vectorbt/Zipline/Lean) with shift(+1) applied.
- Include slippage/fees; cap turnover; compare against naive baselines.

## Risk
- Max position, exposure caps, stop policies, and drawdown halts; log decisions with IDs.

## AI Assistant rules
- Output a full experiment config plus a minimal backtest harness; include acceptance criteria.
