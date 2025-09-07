---
agentMode: general
applyTo: general
author: AI-LEY
description: Awaiting summary.
extensions:
- .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:48.066017'
summaryScore: 3.0
title: Bt.Instructions
version: 1.0.0
---

Title: bt — AI Agent Portfolio Backtesting Guide

Scope
- Strategy composition with backtest framework built on pandas.

Patterns
- Define strategies from algos; enforce no look-ahead via lagged signals; evaluate turnover.

AI Assistant Guidelines
- Provide minimal strategy examples; include assertions for signal alignment and NaN handling.


See also
- [frameworks/finance/vectorbt.instructions.md](../finance/vectorbt.instructions.md) — Vectorized research/backtesting (signals → portfolio)
- [frameworks/finance/zipline-reloaded.instructions.md](../finance/zipline-reloaded.instructions.md) — Calendar-accurate event backtester
- [frameworks/finance/pyfolio.instructions.md](../finance/pyfolio.instructions.md) — Risk and performance analytics
- [frameworks/finance/ta-lib.instructions.md](../finance/ta-lib.instructions.md) — Technical indicators with warmup handling