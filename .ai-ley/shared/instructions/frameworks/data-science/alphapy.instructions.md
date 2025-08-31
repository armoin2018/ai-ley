# AlphaPy — AI Assistant Guidelines (ML Pipeline Framework)

Purpose: Supervised learning pipelines for tabular/time-series data with experiment tracking, leakage prevention, and reproducibility.

## When to use
- Rapid ML iterations with standardized configs for features, models, and validation.

## When to avoid
- Custom deep learning architectures or non-tabular modalities.

## Data and leakage control
- Split by time for financial data; no random shuffles across time.
- Feature windows must not peek forward; use lagged features only.
- Keep transformation fit only on training folds; apply to validation/test separately.

## Configuration and runs
- YAML-driven experiments; pin random seeds; log versions and data hashes.
- Register metrics (AUC, F1, IC, IR) and compare via dashboards.

## Testing
- Unit tests for feature builders; property tests for monotonic transformations.
- Integration tests for full pipeline on a tiny sample, asserting metrics within tolerance.

## AI Assistant rules
- Emit a complete config with train/validation/test splits and leakage guards.
- Provide a run script, artifact paths, and cleanup steps.
