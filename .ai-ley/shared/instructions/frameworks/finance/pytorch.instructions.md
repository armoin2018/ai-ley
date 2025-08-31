Title: PyTorch (Finance) — AI Agent Modeling Guide

Scope
- Deep learning for tabular/time-series in finance; strict controls to avoid leakage.

Data hygiene
- Train/val/test splits by time; no shuffling across time; rolling-origin evaluation.
- Feature scaling fit on train only; apply to val/test; document vendor/licensing.

Modeling
- Prefer simple baselines; only escalate to complex models with measured uplift.
- Use torch.compile (when stable) and AMP cautiously; deterministic seeds for audits.

Evaluation
- Metrics aligned to use-case (e.g., directional accuracy, drawdown, hit ratio);
 Include uncertainty estimates or calibration where decisions have risk.

AI Assistant Guidelines
- Refuse to suggest models without leakage controls; include rigorous evaluation plan.
- Provide training loop, early stopping, and test-time evaluation with time splits.
