# pfSense — Enterprise Firewall/Router Platform

## Overview
pfSense CE/Plus is a FreeBSD-based firewall/router distribution using the pf packet filter. It provides robust routing, firewalling, VPNs, QoS, and add-on packages via a web UI and strong configuration backup/restore. Suitable for edge firewalls, branch routers, and lab environments.

## Core capabilities
- Stateful firewall (pf) with aliases, NAT (1:1, port forward, outbound), VLANs, LAGG, multi-WAN with failover/load balancing.
- VPN: IPsec, OpenVPN, WireGuard (package), site-to-site and remote-access with MFA via RADIUS/LDAP.
- Services: DHCP/DHCPv6, DNS Resolver (unbound) with DNSBL via pfBlockerNG, NTP, Captive Portal.
- Packages: pfBlockerNG, Snort/Suricata IDS/IPS, ACME for certs, HAProxy, FRR (BGP/OSPF), BandwidthD, Telegraf.

## Deployment patterns
- Single node edge firewall for SMB/branch.
- HA pair using CARP + pfsync + XMLRPC sync for stateful failover; isolate management.
- Multi-WAN with tiered gateways; policy-based routing for selected VLANs/subnets.

## Security hardening
- Lock down web UI: HTTPS only, unique admin, 2FA; restrict management to a secure mgmt VLAN.
- Disable unnecessary services (UPnP, unused packages). Apply clean allowlist rules. Use aliases for maintainability.
- DNS: enable DNSSEC validation; use DNS over TLS upstream where appropriate.
- Logging: forward firewall, DHCP, VPN, and IDS logs to a central syslog/SIEM; include correlation IDs.

## IDS/IPS
- Prefer Suricata (multi-threaded) over Snort on multi-core systems. Run in IDS first, tune, then enable IPS.
- Rule sources: ET Open, ET Pro, Abuse.ch; enable reputation/Bogon lists via pfBlockerNG.
- Bypass critical internal services and monitoring IPs to reduce false positives.

## VPN best practices
- OpenVPN/WireGuard for remote access; enforce MFA via RADIUS/LDAP; split-tunnel vs full-tunnel by policy.
- IPsec for site-to-site with IKEv2 and strong ciphers; use phase lifetimes and DPD.

## Routing and BGP/OSPF (FRR)
- Use FRR package for dynamic routing; maintain prefix-lists and route-maps; filter customer/partner routes.
- Document failover scenarios and route convergence expectations.

## NAT and policy routing
- Outbound NAT: use Hybrid/Manual for advanced control; map per-VLAN. Preserve source ports only if required.
- Use gateway groups for SLA-based routing; monitor targets per ISP and prefer multiple monitors.

## High availability
- HA pair: Sync states (pfsync), config (XMLRPC), and VIPs (CARP). Ensure version parity. Test failover routinely.
- Use dedicated sync interfaces; avoid asymmetric routing; pin management to physical interfaces.

## Backup/Restore & change management
- Use built-in config.xml backup with encryption; schedule off-box backups. Snapshot before major changes.
- Maintain Infrastructure-as-Code via API/SSH + pfSense config fragments where feasible; track in VCS.

## Monitoring & observability
- Export metrics via Telegraf → Influx/Prometheus; collect interface stats, gateway status, VPN peers, pf counters.
- Health checks: gateway latency/loss, CARP state, IDS alerts rate, DNS resolver health, cert renewals (ACME).

## Troubleshooting
- Packet capture (Diagnostics) and pf top/tcpdump via shell; rule evaluation with pfSense UI rule tester.
- Gateway flaps: check monitor IPs and ISP stability; adjust trigger thresholds.
- DNS issues: validate unbound resolver status, DNSBL lists, and upstream reachability.

## AI Assistant Guidelines
- Generate explicit firewall rule sets using aliases and per-interface tabs; avoid broad any-any rules.
- Prefer Suricata with IDS-first tuning then IPS; include safe default rules and bypasses for infra.
- For HA designs, always include CARP/pfsync design and state synchronization steps.
- Include syslog/metrics exports and concrete health checks in solutions.

