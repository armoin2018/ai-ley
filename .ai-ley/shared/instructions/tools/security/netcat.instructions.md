# Netcat (nc) — Network Swiss Army Knife

## Overview
Netcat provides simple TCP/UDP client/server operations for testing, debugging, and data transfer. Variants include GNU netcat, OpenBSD nc, and ncat. Use carefully with security in mind.

## Common use cases
- Port checks and banner grabbing
- Simple listeners for testing inbound connections
- Pipe data over sockets; ad-hoc file transfer (use encryption where possible)

## Examples
- Check a port: `nc -vz host 443`
- Listen TCP: `nc -l 8080`
- Send file (unencrypted): sender `nc -l 9000 < file.bin`, receiver `nc host 9000 > file.bin`
- UDP test: `nc -u -l 9999` and `echo test | nc -u host 9999`

## Security
- Prefer `ncat --ssl` or use `socat` with TLS for sensitive data; never expose listeners on untrusted networks
- Limit scope and duration; run under least-privilege user; firewall appropriately
- Logging: capture traffic with tcpdump where audit is required

## Troubleshooting
- Connection refused/timeouts: verify firewall/NAT and listening addresses (0.0.0.0 vs 127.0.0.1)
- Variant differences: flags differ between GNU, OpenBSD, and ncat; check `nc -h`

## AI Assistant Guidelines
- Default to safe examples using loopback or test VLANs; call out encryption requirements when transferring data
- Avoid suggesting use on production endpoints except for controlled diagnostics with approvals
- Include cleanup steps and firewall notes; prefer TLS-capable tools when confidentiality matters

