# IPFire — Hardened Linux Firewall Distribution

## Overview
IPFire is a Linux-based firewall distribution focusing on simplicity, IDS/IPS, and add-on packages. It organizes networks into color zones (Green=LAN, Red=WAN, Blue=Wi‑Fi, Orange=DMZ) and provides web-based administration.

## Core capabilities
- Stateful firewall with zones, NAT, VLANs, QoS; proxy services (web proxy), URL filtering
- VPNs: IPsec and OpenVPN; user management and authentication backends
- IDS/IPS with Suricata; update rule sources regularly

## Deployment patterns
- Small/medium business edge, segmented networks with DMZ and guest Wi‑Fi (Blue)
- Multi‑WAN failover via policy routing; per‑zone firewall rules with least privilege

## Security hardening
- Lock admin UI to management networks; enforce HTTPS and strong passwords; enable 2FA where available
- Disable unused services; restrict SSH; keep system and rule sets updated
- DNS: prefer DNSSEC and DoT where feasible; log DNS queries for threat hunting within policy

## Observability
- Forward logs to central SIEM; monitor Suricata alerts, VPN peers, gateway status, CPU/mem
- Establish SLOs for gateway availability and alert on deviations

## Troubleshooting
- Packet captures for rule debugging; verify zone assignment and NAT behavior
- VPN issues: check phase settings, MTU, and routes; test with simple policies first

## AI Assistant Guidelines
- Generate explicit per‑zone policies and NAT examples; avoid broad any‑any rules
- Recommend Suricata in IDS first with tuning before IPS; include safe allowlists for infra
- Include log forwarding and health checks in proposed designs

