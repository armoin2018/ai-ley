# Podman — Daemonless, Rootless Containers for Production

## Overview
Podman is a daemonless container engine compatible with the Docker CLI UX. It supports rootless
containers, pods, and integrates with Buildah (build) and Skopeo (image copy/sign/inspect). It
uses Netavark/CNI for networking and systemd (via Quadlet) for robust service management.

When to use: security‑sensitive hosts, systemd‑managed services, mixed rootless/rootful
deployments, and environments avoiding a long‑running Docker daemon.

## Key components
- podman: run containers and pods (grouped containers with shared network/IPC)
- buildah: build OCI images; integrates with Containerfiles/Dockerfiles
- skopeo: inspect/copy/sign images between registries
- quadlet: declarative systemd units for containers/pods/volumes/networks

## Security hardening
- Prefer rootless containers; map container UID/GID to host namespaces
- Enable SELinux/AppArmor confinement; keep seccomp profiles; drop unnecessary capabilities
- Read‑only root FS, tmpfs for sensitive paths, least‑privilege volume mounts
- Use signed images (cosign/sigstore) and registry policies; restrict registries in registries.conf

## Networking
- Netavark default (or CNI); create custom networks with explicit subnets and DNS
- Expose via published ports or systemd socket activation; document firewall/NAT rules

## Image management
- Use trusted registries; pin digests for immutability
- Multi‑stage builds with Buildah; cache mounts; minimize layers and package managers

## Compose and orchestration
- podman‑compose for docker‑compose.yml compatibility (best effort)
- Quadlet for production: create .container/.pod unit files and manage via systemd
- For clusters, prefer Kubernetes; use podman kube generate/apply for simple handoffs

## Logging & observability
- Redirect container logs to journald/json‑file; aggregate with Fluent Bit/Vector
- Healthchecks in images; systemd Restart=on‑failure; add metrics endpoints where applicable

## CI/CD
- Build with Buildah in rootless mode; push to registry with short‑lived tokens
- Run smoke tests in containers; sign images; deploy via Quadlet units

## Troubleshooting
- podman inspect/logs/top; check user namespace mappings; validate SELinux denials (audit2allow)
- Networking issues: verify netavark networks, IP conflicts, and host firewall rules

## AI Assistant Guidelines
- Prefer rootless + Quadlet for services; avoid advising a Docker daemon on Podman hosts
- Generate secure Containerfiles (non‑root user, read‑only FS, minimal base images)
- Include systemd unit examples with Restart policy and healthchecks
- Use pinned image digests and signed images; avoid broad volume mounts

---

### Quadlet example (container)

```
# /etc/containers/systemd/myapp.container
[Unit]
Description=My App (Podman)
After=network-online.target
Wants=network-online.target

[Container]
Image=registry.example.com/myapp@sha256:deadbeef...
Name=myapp
User=1000:1000
PublishPort=8080:8080
Env=NODE_ENV=production
ReadOnly=true
Volume=/var/lib/myapp:/data:Z
HealthCmd=curl -f http://127.0.0.1:8080/health || exit 1
HealthInterval=30s

[Install]
WantedBy=multi-user.target
```

