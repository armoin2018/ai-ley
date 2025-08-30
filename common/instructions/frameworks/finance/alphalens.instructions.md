# Alphalens — AI Assistant Guidelines (Factor Analysis)

Purpose: Evaluate predictive power of alpha factors with rigorous time alignment, forward return computation, and tearsheets.

## When to use
- You have factor values per asset per date and want to assess IC, turnover, and quantiles.
- You need standardized, reproducible factor research with tearsheets.

## When to avoid
- Live trading analytics (use production risk/analytics). Alphalens is research-focused.
- Non-panel data without consistent asset identifiers.

## Data contracts
- Inputs: factor_series (MultiIndex: date, asset), prices (wide DataFrame) with the same assets.
- Index alignment: factor timestamp t must map to forward returns window [t+1, t+H]. No leakage.
- Corporate actions: use adjusted prices; ensure calendars align to exchange sessions.

## Core workflow
1) Clean factor: winsorize/clip; neutralize by sector/market-cap if needed.
2) Compute forward returns via Alphalens utils using adjusted close.
3) Quantize factors (e.g., 5 or 10 buckets) with equal counts.
4) Run tearsheets: IC by horizon, quantile returns, turnover, decay.
5) Record results with seeds, versions, and hashes for reproducibility.

## Tests
- Synthetic factor with known correlation → expect positive IC at target horizon.
- Shift test: if factor uses future info, IC degrades after enforcing shift(+1).
- Stability test: minor noise shouldn’t flip sign of IC drastically.

## AI Assistant rules
- Always adjust prices for splits/dividends; document data vendor and adjustment method.
- Enforce timezone and trading calendars; avoid using calendar days for market returns.
- Maintain experiment tracking (params, IC, p-values, turnover).
- Provide guardrails for quantile sizes; ensure minimum assets per bucket.

## Pitfalls
- Factor computed on post-close data but evaluated on same-day close (leakage). Shift to next session.
- Sparse coverage causing unstable quantiles; require minimum N per date.
