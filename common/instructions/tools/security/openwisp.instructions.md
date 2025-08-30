# OpenWISP — Centralized Network Management for OpenWrt and Edge

## Overview
OpenWISP is a modular, open-source platform for centralized management of OpenWrt-based devices and edge networks. It provides zero‑touch provisioning, configuration management, monitoring, and captive portal integrations. Suited for ISPs, municipal Wi‑Fi, campus networks, and large fleets of routers/APs.

## Core capabilities
- Zero‑touch provisioning with device auto‑registration and templates
- Hierarchical organizations, roles, and permissions (RBAC)
- Configuration management for OpenWrt (UCI/LuCI) via centralized templates and variables
- Monitoring and metrics collection (NetJSON, telemetry), alerting via integrations
- Captive portal/accounting: OpenWISP Controller, Radius integration, vouchers
- Map-based topology/asset tracking, firmware management and staged upgrades

## Architecture
- Components: OpenWISP Controller (Django), OpenWISP Firmware Upgrader, OpenWISP Monitoring, Radius/Portal
- Agents: netjsonconfig on devices; secure communication over HTTPS with mutual authentication where possible

## Onboarding & provisioning
- Define organizations and roles up front; apply least-privilege RBAC
- Create configuration templates with parameters (SSID, VLANs, firewall zones, WAN types)
- Use auto‑registration: generate device tokens or pre‑provision MAC/SN; restrict onboarding networks
- Tag devices by site/role; drive policies via tags and variables

## Configuration management
- Maintain golden templates mapped to device classes (indoor AP, CPE, gateway)
- Parameterize credentials, SSIDs, channels, VLAN IDs, addressing; store secrets in vaults, not in templates
- Validate UCI syntax and idempotency before rollout; stage changes to canary sites

## Firmware & upgrades
- Host signed firmware images; map device models to images
- Use staged rollouts with health checks and auto‑rollback policies; avoid mass upgrades during peak

## Security hardening
- Enforce device HTTPS with valid certs; rotate credentials periodically
- Restrict device mgmt access to VPN or management VLANs
- Disable unused services (telnet/wan ssh); prefer WireGuard for remote mgmt
- Maintain inventory with asset ownership and decommissioning playbooks

## Monitoring & observability
- Collect device health (CPU/mem, iface stats, Wi‑Fi clients), link quality, WAN status
- Export metrics to Prometheus/Influx via bridges; set SLOs (AP uptime, client failure rate)
- Alert on offline devices, high assoc failures, backhaul link loss, config drift

## CI/CD & automation
- Treat templates as code in VCS; code review changes; run schema linters and UCI validation tests
- Use Ansible/Terraform (where applicable) to orchestrate OpenWISP resources via API
- Canary deployments per site group; automated rollback on health check failure

## Troubleshooting
- Config not applied: verify device-controller connectivity, token validity, and UCI merge conflicts
- Device flapping: check power/PoE budgets, RF interference, and backhaul stability
- Captive portal/RADIUS failures: inspect certificate trust, time sync, and accounting endpoints

## AI Assistant Guidelines
- Generate parameterized templates, not per-device snowflakes; reference UCI sections explicitly
- Include staged rollout plans with health checks and rollback; never push mass updates without canaries
- Always propose RBAC, secrets management, and network segmentation for management access
- Provide monitoring hooks and alert thresholds tied to critical KPIs

