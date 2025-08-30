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

