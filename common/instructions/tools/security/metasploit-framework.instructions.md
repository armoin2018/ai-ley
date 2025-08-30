# Metasploit Framework — Penetration Testing Platform

## Overview
Metasploit Framework is a modular platform for exploit development, payload delivery, and post‑exploitation. Use only with explicit authorization in controlled environments. Integrates with Nmap, Nessus, and other scanners.

## Ethics and scope
- Legal authorization is mandatory; define scope, targets, and time windows
- Use isolated networks or labs; snapshot targets when possible; follow rules of engagement

## Core workflow
- Recon: import scans (`db_import`) from Nmap; validate services
- Exploit selection: match module to service/version; prefer safe checks first
- Payloads: choose staged/stageless based on network constraints; use encrypted channels when possible
- Post: leverage Meterpreter for privilege escalation and lateral movement within allowed scope only

## Modules and database
- Use `msfdb`/built‑in DB to track hosts, services, and loot; tag and report findings
- Keep modules updated; pin tool versions during engagements for reproducibility

## Automation & CI
- Script repeatable tasks with `msfconsole -r` resource scripts; parameterize targets
- Integrate into red team pipelines with containers; store artifacts securely; never embed secrets in scripts

## Defense & blue team collaboration
- Share IOCs with defenders; assist in validation of detections; propose hardening steps

## AI Assistant Guidelines
- Always include an “authorization and scope” preface; refuse to generate harmful or unauthorized steps
- Prefer safe modules and enumeration before exploitation; avoid zero‑day or unverifiable code
- Include cleanup: sessions closed, services restored, credentials rotated as needed

