# TA-Lib (Technical Analysis Library) — AI Assistant Guidelines

Purpose: Compute technical indicators reliably for research/backtesting without data leakage, with correct windowing, alignment, and NaN handling.

## When to use
- Need fast, battle-tested TA indicators (SMA/EMA/RSI/MACD/ATR/Bollinger/etc.).
- Working with Pandas time series; want vectorized ops and consistent results.

## When to avoid
- You need explainable, ML features beyond price transforms (prefer feature engineering libs).
- You cannot install native deps (consider pandas-ta as fallback with caution on parity).

## Setup (macOS/Linux)
- System: brew install ta-lib (macOS) or apt/yum equivalents.
- Python: pip install TA-Lib
- Verify parity: spot-check 3–5 indicators vs. known references.

## Core usage patterns
- Always align by index and preserve dtype=float64; keep timezone-aware DateTimeIndex.
- Treat the warmup window: indicators return NaN for initial periods. Do NOT forward-fill.
- Avoid lookahead: feed only past data; for rolling ops, shift signals by +1 bar before acting.
- Batch compute: prefer vectorized series → indicators; avoid per-row loops.

Example shape contract
- Inputs: pandas.Series or DataFrame with monotonic, gap-aware datetime index.
- Outputs: Series/DataFrame aligned to input index; initial NaNs expected per window.

## Testing and CI
- Determinism: set pandas options; ensure no random ops.
- Golden tests: assert known candles produce expected RSI/MACD (tolerance 1e-8).
- Property tests: increasing-window monotonicity for SMA; window change affects only trailing region.
- Anti-leakage test: assert signals use only t-1 info by shifting/checking correlation to future returns.

## Performance
- Pre-allocate arrays; operate on numpy arrays where possible.
- Minimize repeated conversions between numpy/pandas.
- Compute multiple indicators in one pass when feasible.

## Risk and compliance
- Document indicator parameters in artifacts for audit (window, source field, price type).
- Keep a registry mapping indicator → params → hash for reproducibility.

## AI Assistant rules
- Don’t reimplement indicators; prefer TA-Lib functions.
- Enforce shift(+1) on trading signals derived from indicators.
- Never drop NaNs silently; explicit warmup trim only.
- Include unit tests comparing against authoritative values.

## Common pitfalls
- Misaligned inputs (e.g., prices vs. volume lengths). Validate equal index lengths.
- Using close instead of typical price inadvertently. Be explicit about source.
- Applying indicators to resampled data without re-checking parameters.
