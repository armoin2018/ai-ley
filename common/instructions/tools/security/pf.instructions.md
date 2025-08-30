# pf (Packet Filter) — FreeBSD/OpenBSD Firewalling

## Overview
pf is the stateful packet filter used by OpenBSD and FreeBSD (and derivatives like pfSense/OPNsense). It provides NAT, QoS, tables (aliases), anchors, scrubbing, and flexible rule evaluation with high performance.

## Core concepts
- Ruleset order matters; last matching rule wins unless quick is used. Use anchors to modularize.
- Tables for large IP/domain sets; maintain via pfctl; useful for blocklists/allowlists.
- NAT (rdr/napd), BINAT, port forwards; set skip on management interfaces to avoid unintended filtering.

## Good defaults
- Normalize traffic with scrub; drop invalid states; antispoof on WAN; default deny inbound; allow established/related.
- Rate-limit noisy protocols; use max-src-conn-rate for brute-force mitigation.

## Example skeleton

```
set block-policy drop
set skip on lo

scrub in all

table <allowed_ssh> persist file "/etc/pf.allowed_ssh"

block in all
pass out quick inet proto { tcp udp icmp } from (self) to any keep state

# Allow SSH from trusted sources
pass in on egress proto tcp from <allowed_ssh> to (egress) port 22 flags S/SA modulate state

# Port forward example
rdr on egress proto tcp from any to (egress) port 8443 -> 10.0.0.10 port 443
pass in on egress proto tcp to 10.0.0.10 port 443
```

## Logging and monitoring
- Use pflog0 and tcpdump for rule hit analysis: `tcpdump -n -e -ttt -i pflog0`.
- Export counters via `pfctl -si` and tables sizes; ship logs to SIEM.

## Performance
- Keep tables and rules compact; prefer tables over many individual rules.
- Use stateful rules and `max-src-conn` limits thoughtfully; avoid excessive logging on hot paths.

## Troubleshooting
- `pfctl -sr` to show rules; `pfctl -sn` for NAT; `pfctl -sa` for all stats; use anchors for isolation.
- Check order and quick flags; verify route-to/reply-to semantics when policy routing.

## AI Assistant Guidelines
- Generate minimal, explicit rules with tables and anchors; default deny inbound, allow stateful outbound.
- Always accompany rdr with matching pass rules.
- Include logging for critical passes/blocks and suggest pflog analysis steps.
- Avoid suggesting overly broad any-any rules; tailor to interfaces and services.

