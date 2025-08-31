# OpenWrt — Embedded Linux for Routers and Edge

## Overview
OpenWrt is an open-source embedded Linux distribution targeting routers and edge devices. It provides a full package manager (opkg), UCI configuration system, netfilter (iptables/nftables), DNS, DHCP, and an extensive package ecosystem. Ideal for customizable CPE, lab networks, and edge IoT gateways.

## Core capabilities
- Firewalling (nftables/iptables), routing, VLANs, Wi‑Fi (hostapd/wpa_supplicant), PPPoE, SQM QoS (cake/fq_codel), WireGuard/OpenVPN.
- Services: dnsmasq, odhcpd, mwan3 (multi-WAN), adblock, ddns-scripts, uhttpd, collectd/telegraf.
- Config: Unified Configuration Interface (UCI), LuCI web UI, SSH shell.

## Deployment patterns
- Home/SMB edge, lab networks, mesh deployments (802.11s/batman-adv), captive portals.
- Multi-WAN with mwan3; per-VLAN segmentation; guest Wi‑Fi with isolation.

## Security hardening
- Change defaults: disable WAN SSH/Web, strong admin password/keys, HTTPS for LuCI, restrict management to LAN/VPN.
- Keep firmware updated; prefer stable releases; validate third-party package sources.
- Use firewall zones (lan/wan/guest) and explicit inter-zone policies; enable DNSSEC; prefer DoH/DoT upstream when feasible.

## Performance and QoS
- SQM with cake for bufferbloat control; measure baseline latency with and without SQM.
- Tune Wi‑Fi channels/bandwidth; consider 802.11k,v,r for roaming; isolate IoT on 2.4GHz guest VLAN.

## Packages and customization
- Use opkg with signed repos; pin critical package versions; backup `/etc/config` and package list before upgrades.
- Extend with Docker/Podman (on capable devices) or lightweight containers (LXC) when supported.

## High availability and mesh
- Use mwan3 with health checks for failover/load-balance; avoid flapping via sane thresholds.
- Mesh with batman-adv or 802.11s; plan channel/frequency; monitor link quality.

## Monitoring & observability
- Collectd/Telegraf to central TSDB; export interface stats, station counts, CPU/mem, WAN latency, SQM stats.
- Syslog to remote; rotate locally to preserve flash lifespan.

## Troubleshooting
- Use `logread`, `dmesg`, `ifstatus`, `ubus call`, `ubus list`, `uci show`; packet capture with tcpdump-mini.
- Wi‑Fi issues: survey spectrum, check DFS events, adjust transmit power/channel width.

## Backup/restore & upgrades
- Use `sysupgrade -b` to back up configs; test restores; stage firmware upgrades carefully with rollbacks.

## AI Assistant Guidelines
- Generate UCI/LuCI-friendly configs with explicit zones, interfaces, and DHCP/DNS policies; avoid broad allow rules.
- Include SQM recommendations with cake and realistic bandwidth settings.
- Prefer WireGuard for remote management; restrict LuCI/SSH to LAN/VPN.
- Add monitoring hooks (collectd/telegraf) and syslog forwarding suggestions.

