Title: PyMC (PyMC3) — AI Agent Bayesian Modeling Guide

Scope
- Probabilistic programming for Bayesian inference using NUTS and variational inference.

Rules of thumb
- Centered vs. non-centered parameterization; weakly informative priors by default.
- Convergence diagnostics: R-hat≈1.00, effective sample size, energy BFMI, divergences.

Performance
- Use aesara/numba acceleration; vectorize; reduce model dimension where possible.

Validation
- Prior predictive checks; posterior predictive checks; PSIS-LOO for model comparison.

AI Assistant Guidelines
- Provide full modeling workflow: data prep → model spec → sampling → diagnostics → PPC.
- Include reproducible seeds and summaries; refuse unsafe claims without diagnostics.

