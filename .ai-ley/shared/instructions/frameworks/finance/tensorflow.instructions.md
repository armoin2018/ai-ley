Title: TensorFlow (Finance) — AI Agent Modeling Guide

Scope
- Time-aware modeling with Keras; leakage controls and reproducibility.

Data hygiene
- Time-split datasets; windowed sequences with careful target alignment.

Modeling
- Start with simple CNN/TCN/GRU baselines; regularization; early stopping; model checkpointing.
- Mixed precision on supported hardware; set seeds and enable determinism where possible.

Evaluation
- Backtest-like evaluation; walk-forward validation; economic metrics as appropriate.

AI Assistant Guidelines
- Include data pipeline with windowing; refuse designs without leakage prevention.
- Provide training/eval code with deterministic configs and clear metrics.

