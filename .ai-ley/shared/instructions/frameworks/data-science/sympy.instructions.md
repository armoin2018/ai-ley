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
lastUpdated: '2025-09-03T00:04:48.022836'
summaryScore: 3.0
title: Sympy.Instructions
version: 1.0.0
---

Title: SymPy — AI Agent Modeling Guide

Use cases
- Symbolic mathematics, simplification, differentiation/integration, equation solving.

Patterns
- Keep symbolic core separate from numeric; export lambdify to NumPy for performance.
- Use assumptions to constrain symbols and speed up simplification.

Testing
- Verify symbolic identities and numeric evaluations (via lambdify) over sampled domains.

AI Assistant Guidelines
- Prefer numeric libraries for runtime-critical paths; limit SymPy to modeling/derivation.
- Always provide unit tests for identities and edge conditions.