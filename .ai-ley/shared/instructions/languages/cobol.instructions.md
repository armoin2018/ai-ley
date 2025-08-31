Title: COBOL — AI Agent Implementation Guide

Scope
- Maintain/modernize legacy mainframe and batch systems; strict change control.

Key practices
- Isolate I/O; keep business rules pure; add unit tests via cobol-check where possible.
- Document copybook schemas; version control interfaces; generate mappings.

Interop
- Expose services via CICS/IMS transactions or API gateways; avoid direct DB changes.

Testing/CI
- Synthetic datasets; golden-file comparisons; regression test packs.

Modernization
- Strangle pattern: wrap with services; incrementally replace modules.

AI Assistant Guidelines
- Never invent financial rules; require specs; preserve record layouts.
- Propose safety nets: backups, canaries, and rollback procedures.

