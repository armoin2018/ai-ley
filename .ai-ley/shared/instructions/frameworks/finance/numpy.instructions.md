Title: NumPy (Finance) — AI Agent Numerical Guide

Scope
- Vectorized numeric ops for time-series and portfolio analytics; reproducible pipelines.

Practices
- Set dtypes explicitly (float64 for money-sensitive calcs); avoid implicit up/down-casts.
- Use vectorization over Python loops; prefer broadcasting; leverage numba for hotspots.
- Numerical stability: log-returns over simple returns for compounding; add eps for divisions.
- Rolling windows: stride tricks or numba kernels; avoid Python loops.
- Memory: preallocate arrays; avoid unnecessary copies; be mindful of copy-on-write.

Time handling
- Use UTC timestamps; align arrays before ops; verify monotonic increasing indices.

Testing
- Property-based tests for invariants (e.g., no look-ahead, bounds, conservation checks).

AI Assistant Guidelines
- Always specify dtypes; avoid chained temporary arrays; propose vectorized patterns.
- Include numerically stable formulations and explain tradeoffs.

