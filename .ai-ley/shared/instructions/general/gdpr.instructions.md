Title: GDPR — AI Agent Compliance Guide

Scope
- Rules for AI agents generating or operating systems that process personal data of EU residents.

Core principles to enforce
- Lawful basis: document purpose and basis (consent, contract, legitimate interest).
- Data minimization: collect only necessary fields; avoid free-text PII where possible.
- Purpose limitation: no secondary use without new basis.
- Storage limitation: define and implement retention + deletion workflows.
- Integrity & confidentiality: encrypt in transit and at rest; access via least privilege.

Operational requirements
- Records of processing (RoPA): generate/update on new data flows.
- DPIA: trigger when high risk to rights/freedoms; document outcomes.
- DSRs: implement APIs/processes for access, rectification, deletion, portability.
- Consent: explicit, granular, revocable; store consent receipts; respect preferences.
- Cross-border transfers: SCCs or adequacy; avoid hardcoding vendor regions.

Engineering controls
- Pseudonymization: use stable tokens; keep key-material separate; never log raw identifiers.
- Logging: structured, no sensitive fields; sampling/aggregation for analytics.
- Security: OWASP ASVS L2+ for apps; rotate keys; audit trails with tamper evidence.

Testing & CI
- GDPR unit tests: verify redaction, retention, and DSR handlers.
- Synthetic data only in non-prod; protect fixtures.

AI Assistant Guidelines
- Refuse to generate designs that store unnecessary PII.
- Always propose a DSR API surface when personal data is introduced.
- Include retention config, consent registry integration, and audit logging in designs.

