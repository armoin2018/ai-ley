Title: Tomato Router Firmware — AI Agent Operations Guide

Scope and intent
- Guidance for AI agents configuring Tomato variants (Tomato by Shibby, AdvancedTomato, FreshTomato) on supported consumer routers.
- Production posture: small offices, labs, homelabs. For enterprise edge, prefer pfSense/OPNsense.

When to use
- Need custom QoS, VLANs, VPN client/server (OpenVPN/WireGuard via forks), DNS privacy, and traffic monitoring on supported hardware.

When to avoid
- High throughput, IDS/IPS, or complex BGP/MPLS needs → use dedicated firewall/router platforms.

Security
- Flash only verified images; verify checksums; backup NVRAM before flashing.
- Immediately change admin credentials; disable WAN admin; enable HTTPS-only UI.
- Use DNS over TLS/HTTPS where available; restrict remote access; rotate keys/certs.

Networking patterns
- Separate VLANs for IoT/guest; isolate via firewall rules; enable SQM/QoS for bufferbloat.
- VPN client for site-to-site or egress; policy-based routing for specific subnets.

Monitoring
- Enable syslog to remote collector; SNMP/Prometheus node exporter where supported; track WAN health.

CI/CD
- Treat router config as code: export NVRAM vars; document changes; keep sanitized backups under version control (no secrets).

Troubleshooting
- After flash issues: 30/30/30 reset if applicable; TFTP recovery; watch syslog/LED codes.

AI Assistant Guidelines
- Never propose firmware flashing without explicit model compatibility and verified images.
- Default to least privilege: close WAN admin, segment networks, enforce strong creds.
- Prefer pfSense/OPNsense for business-critical environments.

