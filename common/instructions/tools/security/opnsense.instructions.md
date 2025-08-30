# OPNsense — Hardened Firewall/Router Platform

## Overview
OPNsense is a FreeBSD-based firewall/router using the pf packet filter, forked from pfSense with a focus on modern UI, frequent updates, and HardenedBSD (historically) security features. Provides firewalling, routing, VPNs, QoS, and an extensible plugin ecosystem.

## Core capabilities
- Stateful firewall, NAT, VLANs, LAGG, multi-WAN, traffic shaping.
- VPN: IPsec, OpenVPN, WireGuard (core), with MFA via TOTP/RADIUS/LDAP.
- Services: DHCP/DHCPv6, Unbound DNS (DNSSEC, DoT), NTP, Captive Portal, Sensei/Zenarmor filtering.
- Plugins: os-acme-client, os-wireguard, os-routes, os-telegraf, os-haproxy, os-frr, os-sensei/zenarmor.

## Deployment patterns
- Single-node edge, HA pairs via CARP + pfsync + config sync.
- Multi-WAN policy routing; per-VLAN segmentation with inter-VLAN firewalling.

## Security hardening
- Lock UI to mgmt network; HTTPS only; admin 2FA; restrict SSH; rotate API keys.
- DNSSEC with Unbound; use DoT upstream where possible. Disable UPnP unless required.
- Apply allowlist rules; use aliases; audit plugin permissions and keep system updated.

## IDS/IPS and web filtering
- Use Suricata in IDS mode to tune first; then IPS with careful rule set selection.
- Consider Zenarmor for L7 web filtering and app control with reports; exclude critical infra.

## Dynamic routing (FRR)
- Install os-frr; configure OSPF/BGP as needed; maintain route-maps and prefix-lists; document failover.

## High availability
- Configure CARP VIPs, pfsync, and config synchronization; use dedicated sync interfaces; maintain version parity.

## Backup/restore & automation
- Leverage built-in encrypted backups; export partial configs for specific services.
- Use API for automation; track configurations in version control repositories.

## Monitoring & observability
- Install os-telegraf to emit metrics; forward syslog to SIEM; set up health checks: gateway, CARP status, VPN peers, resolver.

## Troubleshooting
- Packet capture and live view; use `pfctl -sr`/`pfctl -si` for rules/stats; tcpdump for deep dives.
- Gateway flap remediation: adjust monitor targets and thresholds; verify ISP path.

## AI Assistant Guidelines
- Propose clear, least-privilege rule sets with aliases and interface-specific placement.
- Prefer Suricata with tune-first approach; include bypasses and safe defaults.
- For HA, include CARP/pfsync design and testing steps; document failback.
- Include metrics/syslog integration and alert thresholds.

