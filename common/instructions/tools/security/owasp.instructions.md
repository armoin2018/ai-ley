# OWASP — Practical AppSec Guidance (Top 10, ASVS, Cheat Sheets)

## Overview
OWASP provides vendor‑neutral security guidance including the Top 10 risks, ASVS verification
standard, MASVS for mobile, and extensive Cheat Sheet Series. Use OWASP as the baseline for
application security requirements, testing, and validation.

## Core artifacts
- OWASP Top 10: risk taxonomy and mitigation themes
- ASVS: detailed security requirements at Levels 1‑3 for web applications
- MASVS/MSTG: mobile security standard and testing guide
- Cheat Sheets: concise, prescriptive hardening and coding guidance

## How to apply in projects
- Derive security requirements from ASVS matching your assurance level
- Map user stories to ASVS controls; include acceptance criteria and test cases
- Integrate Top 10 checks into design and threat modeling; use cheat sheets for implementation details
- Add static/dynamic testing gates (SAST/DAST/IAST), dependency scanning (SCA), and secure code review

## CI/CD integration
- Security unit tests for authZ/N, input validation, crypto; linters and secret scanners
- Break builds on critical vulnerabilities; track risk acceptance with approvals and expiry
- SBOM generation and policy enforcement; periodic re‑validation

## Developer enablement
- Provide secure coding training mapped to Top 10 and language/framework cheat sheets
- Offer secure-by-default scaffolds and libraries with centralized configs

## AI Assistant Guidelines
- Default to ASVS‑aligned requirements and test cases when generating features
- Include threat modeling prompts and abuse cases; propose mitigations mapped to Top 10 categories
- Recommend layered defenses (validation, encoding, authZ, logging, rate limiting, CSP, headers)
- Avoid generating insecure examples; flag dangerous APIs and suggest safer alternatives

