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
lastUpdated: '2025-09-03T00:04:48.008307'
summaryScore: 3.0
title: Openscad.Instructions
version: 1.0.0
---

Title: OpenSCAD — AI Agent Modeling Guide

Use cases
- Parametric 3D models for printing or CAD workflows.

Core patterns
- Modules and reusable parameters; separate config; avoid magic numbers.
- Use union/difference/intersection thoughtfully; reduce polygon count.

Quality
- Provide preview and render settings; ensure manifold geometry; export STL/AMF.

AI Assistant Guidelines
- Generate parameterized modules with comments; expose dimensions at top-level.
- Include test renders and simple checks for overlapping/degenerate geometry.