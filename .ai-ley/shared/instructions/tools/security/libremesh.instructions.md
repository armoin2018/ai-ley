# LibreMesh — Community Mesh Networking on OpenWrt

## Overview
LibreMesh is a framework of packages and configurations for building community mesh networks on OpenWrt. It standardizes routing protocols, auto-configuration, and services for resilient, decentralized wireless networks.

## Core capabilities
- Mesh routing: BMX6, BMX7, BATMAN-adv, OLSR/OLSRv2 depending on deployment choice
- Auto-configuration of interfaces, SSIDs, and routing; layer-2 or layer-3 meshes
- Captive portal integration, DHCP/DNS services, monitoring tools

## Planning & design
- Select routing protocol based on scale and mobility: BATMAN-adv for L2 simplicity; OLSR/BMX for L3 scalability
- RF planning: channel allocation, TX power, antenna selection; backhaul vs access separation where possible
- Power: ensure stable power/PoE; consider solar for remote nodes; battery backup sizing

## Deployment patterns
- Supernodes/gateways for upstream internet and services; leaf/relay nodes for coverage
- VLANs for management vs user traffic; QoS for fairness and VoIP
- Use site-specific profiles; keep SSIDs and channels consistent within sites

## Operations & monitoring
- Monitor link quality (ETX), neighbor tables, client counts; visualize topology
- Automate config distribution using site profiles; prefer signed images and controlled upgrades

## Security considerations
- Isolate management plane; use VPN for remote administration; rotate credentials
- Minimize open services; enforce HTTPS where available; filter inbound at gateways

## Troubleshooting
- Instability: survey spectrum, adjust channel widths, reduce TX power, improve line-of-sight
- Route oscillation: review metrics and hysteresis; pin critical links if necessary

## AI Assistant Guidelines
- Propose protocol choice explicitly with trade-offs; include channel plans and QoS suggestions
- Generate site profiles and staged rollout steps; avoid suggesting mass upgrades without canaries
- Include monitoring hooks (ETX thresholds, client caps) and alerting recommendations

