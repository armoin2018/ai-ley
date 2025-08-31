# SciPy (Finance) — AI Assistant Guidelines

Purpose: Optimization, statistics, and signal processing for portfolio construction and factor analysis with reproducible, bounded computations.

## Use cases
- Optimize portfolios (scipy.optimize), hypothesis tests (scipy.stats), filters (scipy.signal).

## Rules
- Fix seeds; specify tolerances and bounds; check solver status and KKT conditions where applicable.
- Use robust statistics for heavy tails; avoid parametric assumptions without tests.
- No lookahead: filters applied causally; document lags.

## Testing
- Analytical cases with known solutions; numerical benchmarks with tolerance.
- Sensitivity analysis for constraints/penalties; record results.

## AI Assistant rules
- Emit full optimization problem spec (objective, constraints, bounds) and verification steps.
