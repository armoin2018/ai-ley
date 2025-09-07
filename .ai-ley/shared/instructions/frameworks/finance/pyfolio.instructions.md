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
lastUpdated: '2025-09-03T00:04:48.055083'
summaryScore: 3.0
title: Pyfolio.Instructions
version: 1.0.0
---

Title: PyFolio — AI Agent Performance Analytics Guide

Scope
- Tear sheets for performance/risk; interop with pandas and vectorbt outputs.

Practices
- Ensure returns series hygiene: tz-aware index, no NaNs/infs; corporate actions handled upstream.
- Use both absolute and risk-adjusted metrics; quantify drawdowns and tail risk.

AI Assistant Guidelines
- Provide reproducible analytics scripts; version inputs; snapshot results.
- Warn about overfitting; compare against baselines/benchmarks.