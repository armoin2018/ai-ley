# UFW (Uncomplicated Firewall) Instructions

## Overview

UFW (Uncomplicated Firewall) is a simplified interface for managing netfilter/iptables firewall rules on Linux. It provides sane defaults, easy allow/deny syntax, application profiles, IPv6 support, and logging. It’s ideal for servers and workstations where simple, auditable firewall policies are required.

## Core Principles

- Secure by default: deny inbound, allow outbound
- Explicit allow-listing of necessary services and ports
- Idempotent, predictable commands with clear status output
- Application profiles to avoid memorizing port numbers
- Order-aware rules with before/after hooks for advanced needs
- IPv4 and IPv6 parity for dual-stack environments

## Implementation Framework

### Safe bootstrap on a remote server

```bash
# 1) Allow SSH BEFORE enabling the firewall (adjust port if not 22)
sudo ufw allow OpenSSH   # or: sudo ufw allow 22/tcp

# 2) Enable and set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# 3) Verify
sudo ufw status verbose
```

### Common service rules

```bash
# Allow common services
sudo ufw allow 80/tcp           # HTTP
sudo ufw allow 443/tcp          # HTTPS
sudo ufw allow 53/udp           # DNS (UDP)
sudo ufw allow 25/tcp           # SMTP
sudo ufw allow 3306/tcp         # MySQL
sudo ufw allow 5432/tcp         # PostgreSQL

# Allow by application profile
sudo ufw app list               # See available profiles
sudo ufw allow 'Nginx Full'     # Typically 80,443
sudo ufw allow 'OpenSSH'

# Allow by range and protocol
sudo ufw allow 6000:6100/tcp
sudo ufw allow proto udp from any to any port 1194  # e.g., OpenVPN

# Restrict to source
sudo ufw allow from 203.0.113.10 to any port 22 proto tcp
sudo ufw allow from 10.0.0.0/24 to any port 9200 proto tcp

# Deny or reject explicitly
sudo ufw deny 23/tcp            # Deny telnet
sudo ufw reject 113/tcp         # Send reject instead of silent drop
```

### Administration and policy

```bash
# Enable/Disable
sudo ufw enable
sudo ufw disable

# Defaults
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed

# Logging levels: off, low, medium, high, full
sudo ufw logging medium

# Status
sudo ufw status
sudo ufw status numbered    # Useful for deleting by number

# Delete rules
sudo ufw delete 3           # Delete rule number 3
sudo ufw delete allow 80/tcp

# Reset all rules
sudo ufw reset
```

## Best Practices

- Always allow SSH (or your remote admin port) before enabling
- Prefer application profiles over raw port numbers when available
- Mirror IPv4 and IPv6 rules to avoid asymmetric exposure
- Use “deny by default”; allow only what’s required
- Log at “medium” in production; higher levels only temporarily
- Periodically review rules with “status numbered” and prune
- Restrict admin ports by source IP when practical

## Common Patterns

### Role-based example policies

```bash
# Web server (Nginx)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 'Nginx Full'
sudo ufw allow from 203.0.113.10 to any port 22 proto tcp  # admin IP

# Database server (internal-only)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from 10.0.0.0/24 to any port 5432 proto tcp
sudo ufw allow from 10.0.0.0/24 to any port 9100 proto tcp  # node exporter

# VPN gateway
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 1194/udp
sudo ufw allow from 10.8.0.0/24 to any
```

### Temporarily tightening exposure

```bash
# Maintenance window: allow admin IPs only
sudo ufw deny 80/tcp
sudo ufw deny 443/tcp
sudo ufw allow from 203.0.113.10 to any port 22 proto tcp
# Revert afterwards with saved baseline (document baseline rules)
```

## Tools and Resources

- UFW man pages: ufw(8), ufw-framework(8)
- Application profiles: /etc/ufw/applications.d
- Netfilter insights: iptables-nft(8), nft(8)
- Logs: /var/log/ufw.log, journalctl -u ufw

## Quality and Compliance

- Change control: document rule intent, ticket link, and owner
- Least privilege: expose minimum necessary ports/sources
- Dual-stack parity: identical v4/v6 exposure
- Logging: retain ufw.log for audit; rotate appropriately
- Backup: export current rules and app profiles to VCS where feasible

## Troubleshooting

```bash
# See verbose status and order
sudo ufw status verbose

# Check kernel packet path and conflicts
sudo iptables -S | head -50           # or: sudo nft list ruleset

# Inspect logs
sudo tail -f /var/log/ufw.log

# Common fixes
sudo ufw reload                       # Apply changes
sudo ufw reset                        # Clean slate (requires re-allowing SSH)
```

## Metrics and Monitoring

- Block/allow counts per period from ufw.log
- Unexpected source attempts on sensitive ports
- Drift from golden baseline rules
- v6 parity coverage vs. v4

Example log scrape (rsyslog or Prometheus node exporter textfile)

```bash
grep "UFW BLOCK" /var/log/ufw.log | wc -l
```

## Integration Patterns

- CI for baseline rule files stored as scripts or templates
- Config management (Ansible, Puppet) to enforce rules idempotently
- Cloud firewall alignment (e.g., Security Groups) to avoid conflicts

Ansible example:

```yaml
- name: Enforce UFW rules
  hosts: linux
  become: yes
  tasks:
    - ufw:
        state: enabled
        policy: deny
        direction: incoming
    - ufw:
        rule: allow
        name: OpenSSH
    - ufw:
        rule: allow
        port: "80,443"
        proto: tcp
```

## Advanced Topics

- Before/after hooks: /etc/ufw/before.rules, /etc/ufw/after.rules for raw iptables/nft
- Rate-limiting: sudo ufw limit ssh/tcp
- DNAT/SNAT via before.rules (advanced; test carefully)
- Containers: coordinate with Docker/Podman which also program netfilter

## AI Assistant Guidelines

When to use UFW:
- Host-level firewalling for simple, auditable policies
- Quick hardening of individual VMs or bare-metal hosts
- Complement to, not replacement for, network firewalls

Avoid when:
- Complex multi-tenant NAT, advanced routing, deep packet inspection
- You already manage netfilter via other tools (Firewalld, raw nftables) to avoid conflicts

Code generation rules:
- Always allow remote admin port before enable
- Use application profiles when possible
- Mirror IPv4/IPv6 rules unless intentionally different
- Favor ‘status numbered’ and delete by number for safety
- Include verification steps (status, test from client)

Quality enforcement:
- Deny-by-default baseline present
- Admin access restricted by source where possible
- Logging set to medium and validated
- Changes documented and reversible with a baseline script
