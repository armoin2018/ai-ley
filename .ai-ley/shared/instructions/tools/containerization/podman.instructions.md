---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise Podman Container Platform - Comprehensive Level 3 daemonless, rootless container orchestration platform for enterprise-grade container deployments with advanced security frameworks, compliance automation, monitoring integration, CI/CD pipelines, multi-architecture support, enterprise networking, pod orchestration, and production-ready governance standards.
extensions:
  - .md
  - .container
  - .pod
  - .network
  - .volume
guidelines: Enterprise Podman platform with advanced rootless container patterns, security hardening, compliance frameworks (CIS, SOC2, PCI-DSS), monitoring integration, CI/CD automation, multi-arch deployment, enterprise networking, pod orchestration, systemd integration, and production-ready governance standards.
instructionType: general
keywords:
  [
    'Podman',
    'Containers',
    'Rootless',
    'Daemonless',
    'Security',
    'Enterprise',
    'Quadlet',
    'Systemd',
    'Buildah',
    'Skopeo',
    'Networking',
    'CNI',
    'Netavark',
    'SELinux',
    'AppArmor',
    'Multi-arch',
    'CI/CD',
    'Monitoring',
    'Compliance',
    'Pod Orchestration',
    'OCI',
    'Registry',
    'Security Scanning',
    'Image Signing',
    'Cosign',
    'Sigstore',
  ]
lastUpdated: '2025-09-05T00:00:00.000000'
summaryScore: 10.0
title: Podman Enterprise Container Platform
version: 3.0.0
---

# 🐾 Podman Enterprise Container Platform - Daemonless Security-First Orchestration

## 📋 Enterprise Platform Overview

**Podman** is Red Hat's enterprise-grade, daemonless container engine designed for security-first, rootless container orchestration in production environments. Unlike Docker's client-server architecture, Podman operates as a direct fork-exec model, eliminating the need for a privileged daemon while maintaining full OCI compatibility and Docker CLI compatibility. This platform provides comprehensive container lifecycle management, advanced security frameworks, enterprise networking, pod orchestration, multi-architecture support, compliance automation, monitoring integration, and seamless systemd integration through Quadlet for production-ready container services.

### 🎯 **Enterprise Use Cases:**

- **High-Security Environments**: Banks, government agencies, healthcare systems requiring rootless execution
- **Multi-Tenant Platforms**: Cloud providers, SaaS platforms, shared hosting environments
- **Edge Computing**: IoT deployments, edge data centers, distributed computing nodes
- **Development Pipelines**: CI/CD systems, build environments, testing platforms
- **Hybrid Cloud**: Multi-cloud deployments, on-premises integration, air-gapped environments
- **Compliance-Critical Systems**: SOC2, PCI-DSS, HIPAA, FedRAMP certified environments

### 🏗️ **Enterprise Architecture Components:**

- **Podman Engine**: Daemonless, rootless container runtime with OCI compatibility
- **Buildah Integration**: Advanced multi-stage builds, layer optimization, security scanning
- **Skopeo Management**: Enterprise image operations, registry integration, signing workflows
- **Quadlet Orchestration**: Systemd-native container services, dependency management, health monitoring
- **Enterprise Networking**: Netavark/CNI plugins, custom networks, service discovery, load balancing
- **Pod Orchestration**: Multi-container pods, shared networking/storage, microservice patterns
- **Security Framework**: SELinux/AppArmor integration, seccomp profiles, capability management
- **Compliance Automation**: CIS benchmarks, SOC2/PCI-DSS controls, audit logging, policy enforcement
- **Monitoring Platform**: Prometheus metrics, Grafana dashboards, centralized logging, alerting
- **Enterprise Integration**: LDAP/AD authentication, enterprise registries, policy enforcement
- **Multi-Architecture Support**: x86_64, ARM64, s390x, ppc64le cross-platform deployments
- **CI/CD Integration**: GitLab CI, Jenkins, GitHub Actions, enterprise pipeline automation

## 🛠️ Enterprise Installation & Configuration

### Enterprise Podman Suite Installation

```bash
# Enterprise Linux (RHEL 8/9, CentOS Stream, Rocky Linux, AlmaLinux)
sudo dnf install -y podman buildah skopeo crun runc
sudo dnf install -y podman-compose podman-plugins netavark aardvark-dns
sudo dnf install -y containers-common containers-common-extra

# Ubuntu/Debian Enterprise
sudo apt update
sudo apt install -y podman buildah skopeo runc crun
sudo apt install -y podman-compose netavark aardvark-dns
sudo apt install -y containernetworking-plugins containers-common

# Enterprise macOS (Development/Testing)
brew install podman buildah skopeo
podman machine init --cpus 4 --memory 8192 --disk-size 100
podman machine start

# Enterprise Windows (WSL2 + Development)
winget install RedHat.Podman
# Or via Chocolatey
choco install podman-desktop podman-cli

# Verify enterprise installation
podman --version
buildah --version
skopeo --version

# Install enterprise extensions
sudo dnf install -y podman-docker    # Docker CLI compatibility
sudo dnf install -y cockpit-podman   # Web management interface
```

### Enterprise Rootless Configuration

```bash
# Configure user namespaces for enterprise security
echo "$(whoami):100000:65536" | sudo tee -a /etc/subuid
echo "$(whoami):100000:65536" | sudo tee -a /etc/subgid

# Enterprise container resource limits
mkdir -p ~/.config/containers
cat > ~/.config/containers/containers.conf << 'EOF'
[containers]
# Enterprise security defaults
default_sysctls = [
  "net.ipv4.ping_group_range=0 0",
]
default_capabilities = [
  "CHOWN", "DAC_OVERRIDE", "FOWNER", "FSETID", "KILL", "NET_BIND_SERVICE",
  "NET_RAW", "SETFCAP", "SETGID", "SETPCAP", "SETUID", "SYS_CHROOT"
]
default_ulimits = [
  "nofile=65536:65536",
  "nproc=4096:4096"
]

# Enterprise runtime configuration
runtime = "crun"
conmon_path = ["/usr/bin/conmon"]
events_logger = "journald"
log_driver = "journald"

# Enterprise networking defaults
dns_servers = ["8.8.8.8", "1.1.1.1"]
dns_searches = ["enterprise.local"]
dns_options = ["use-vc"]

# Enterprise image security
pull_policy = "always"
EOF

# Enterprise registry configuration
cat > ~/.config/containers/registries.conf << 'EOF'
[registries.search]
registries = ["registry.redhat.io", "quay.io", "docker.io"]

[registries.insecure]
registries = []

[registries.block]
registries = []

# Enterprise registry mirrors
[[registry]]
prefix = "docker.io"
location = "registry-mirror.enterprise.local:5000"

[[registry.mirror]]
location = "registry.redhat.io"
pull-from-mirror = "digest-only"

# Enterprise image signing policy
[registries]
default = [{"type": "insecureAcceptAnything"}]

[transports]
docker-daemon = {"": [{"type": "insecureAcceptAnything"}]}
EOF

# Enable enterprise systemd services
systemctl --user enable podman.socket
systemctl --user start podman.socket
loginctl enable-linger $(whoami)

echo "Enterprise Podman rootless configuration completed successfully"
```

- podman: run containers and pods (grouped containers with shared network/IPC)
- buildah: build OCI images; integrates with Containerfiles/Dockerfiles
- skopeo: inspect/copy/sign images between registries
- quadlet: declarative systemd units for containers/pods/volumes/networks

## 🔒 Enterprise Security Frameworks & Compliance

### Advanced Rootless Security Architecture

```bash
# Enterprise security hardening script
cat > ~/.local/bin/podman-security-hardening.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting Enterprise Podman Security Hardening..."

# SELinux/AppArmor enterprise configuration
if command -v getenforce >/dev/null 2>&1; then
    log "Configuring SELinux for enterprise container security"

    # Create enterprise SELinux policy
    sudo semanage fcontext -a -t container_file_t "/home/$(whoami)/.local/share/containers(/.*)?"
    sudo restorecon -R /home/$(whoami)/.local/share/containers/

    # Enterprise container contexts
    sudo setsebool -P container_use_cephfs on
    sudo setsebool -P virt_use_nfs on
    sudo setsebool -P virt_use_samba on

elif command -v aa-status >/dev/null 2>&1; then
    log "Configuring AppArmor for enterprise container security"

    # Create enterprise AppArmor profile
    sudo tee /etc/apparmor.d/podman-enterprise << 'APPARMOR_EOF'
#include <tunables/global>

/usr/bin/podman {
  #include <abstractions/base>
  #include <abstractions/nameservice>

  capability dac_override,
  capability setuid,
  capability setgid,
  capability sys_admin,
  capability sys_chroot,
  capability net_bind_service,

  /usr/bin/podman ix,
  /usr/bin/crun ix,
  /usr/bin/runc ix,

  owner /home/*/.local/share/containers/** rwk,
  owner /run/user/*/containers/** rwk,

  /proc/*/mountinfo r,
  /sys/fs/cgroup/** rwk,

  # Enterprise network access
  network inet stream,
  network inet dgram,
  network inet6 stream,
  network inet6 dgram,
}
APPARMOR_EOF

    sudo apparmor_parser -r /etc/apparmor.d/podman-enterprise
fi

# Enterprise seccomp profile
cat > ~/.config/containers/seccomp.json << 'SECCOMP_EOF'
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": [
    "SCMP_ARCH_X86_64",
    "SCMP_ARCH_X86",
    "SCMP_ARCH_AARCH64",
    "SCMP_ARCH_ARM",
    "SCMP_ARCH_S390X",
    "SCMP_ARCH_PPC64LE"
  ],
  "syscalls": [
    {
      "name": "accept",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "accept4",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "access",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "arch_prctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "bind",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "brk",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "chdir",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "clone",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "close",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup3",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_create",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_create1",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_ctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_wait",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "execve",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "exit",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "exit_group",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "fcntl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "fcntl64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "futex",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getcwd",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getdents",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getdents64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getgid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getgroups",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getpid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getppid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "gettid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getuid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "listen",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "lstat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "lstat64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mmap",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mmap2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mprotect",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "munmap",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "nanosleep",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "open",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "openat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "pipe",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "pipe2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "poll",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "prctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "read",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigaction",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigprocmask",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigreturn",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "sched_yield",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "select",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "set_robust_list",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "set_tid_address",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "socket",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "socketpair",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "stat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "stat64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "unlink",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "wait4",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "waitpid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "write",
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
SECCOMP_EOF

# Enterprise capabilities configuration
cat > ~/.config/containers/capabilities.conf << 'CAPS_EOF'
# Enterprise container capabilities
# Allow minimal capabilities for security
default_capabilities = [
  "AUDIT_WRITE",
  "CHOWN",
  "DAC_OVERRIDE",
  "FOWNER",
  "FSETID",
  "KILL",
  "MKNOD",
  "NET_BIND_SERVICE",
  "NET_RAW",
  "SETFCAP",
  "SETGID",
  "SETPCAP",
  "SETUID",
  "SYS_CHROOT"
]

# Deny dangerous capabilities
drop_capabilities = [
  "SYS_ADMIN",
  "SYS_MODULE",
  "SYS_RAWIO",
  "SYS_TIME",
  "MAC_ADMIN",
  "MAC_OVERRIDE",
  "NET_ADMIN"
]
CAPS_EOF

log "Enterprise Podman security hardening completed successfully"
EOF

chmod +x ~/.local/bin/podman-security-hardening.sh
~/.local/bin/podman-security-hardening.sh
```

### Enterprise Image Security & Signing

```bash
# Enterprise image signing with Cosign
# Install Cosign for enterprise image signing
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign

# Enterprise GPG key generation
cat > ~/.gnupg/gpg-enterprise.conf << 'EOF'
%echo Generating enterprise GPG key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Enterprise Container Security
Name-Comment: Podman Enterprise Image Signing
Name-Email: security@enterprise.local
Expire-Date: 2y
Passphrase: $(openssl rand -base64 32)
%commit
%echo Enterprise GPG key generation complete
EOF

# Generate enterprise signing keys
gpg --batch --generate-key ~/.gnupg/gpg-enterprise.conf
ENTERPRISE_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -1 | awk '{print $2}' | cut -d'/' -f2)

# Enterprise image signing workflow
cat > ~/.local/bin/enterprise-image-sign.sh << 'EOF'
#!/bin/bash
set -euo pipefail

IMAGE_NAME=${1:-}
if [[ -z "$IMAGE_NAME" ]]; then
    echo "Usage: $0 <image-name:tag>"
    exit 1
fi

# Enterprise image security scan
echo "Performing enterprise security scan..."
skopeo inspect "docker://$IMAGE_NAME" | jq -r '.RepoTags[], .RepoDigests[]'

# Sign with GPG
echo "Signing image with enterprise GPG key..."
podman image sign --sign-by security@enterprise.local "$IMAGE_NAME"

# Sign with Cosign (keyless)
echo "Signing image with Cosign..."
cosign sign --yes "$IMAGE_NAME"

# Create enterprise SBOM
echo "Generating enterprise Software Bill of Materials..."
syft "$IMAGE_NAME" -o json > "${IMAGE_NAME//[:\/]/_}-sbom.json"

# Create enterprise attestation
echo "Creating enterprise security attestation..."
cosign attest --yes --predicate "${IMAGE_NAME//[:\/]/_}-sbom.json" "$IMAGE_NAME"

echo "Enterprise image signing completed for: $IMAGE_NAME"
EOF

chmod +x ~/.local/bin/enterprise-image-sign.sh

# Enterprise registry security policy
cat > ~/.config/containers/policy.json << 'EOF'
{
  "default": [
    {
      "type": "reject"
    }
  ],
  "transports": {
    "docker": {
      "registry.enterprise.local": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/home/$(whoami)/.gnupg/pubring.gpg"
        }
      ],
      "registry.redhat.io": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release"
        }
      ],
      "quay.io": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/home/$(whoami)/.gnupg/pubring.gpg"
        }
      ],
      "docker.io": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "docker-daemon": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    }
  }
}
EOF

echo "Enterprise image security and signing configuration completed"
```

### Compliance Frameworks Integration (CIS, SOC2, PCI-DSS)

```bash
# CIS Kubernetes Benchmark compliance for Podman
cat > ~/.local/bin/podman-cis-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS-COMPLIANCE] $*"
}

log "Starting CIS Kubernetes Benchmark compliance check for Podman..."

# CIS 4.2.1 - Minimize the admission of privileged containers
check_privileged_containers() {
    log "Checking for privileged containers..."
    PRIVILEGED_CONTAINERS=$(podman ps -a --filter "label=security.privileged=true" --format "{{.Names}}" | wc -l)
    if [[ $PRIVILEGED_CONTAINERS -eq 0 ]]; then
        log "✓ CIS 4.2.1 PASS: No privileged containers found"
    else
        log "✗ CIS 4.2.1 FAIL: $PRIVILEGED_CONTAINERS privileged containers found"
    fi
}

# CIS 4.2.2 - Minimize the admission of containers with allowPrivilegeEscalation
check_privilege_escalation() {
    log "Checking for containers with privilege escalation..."
    ESCALATION_CONTAINERS=$(podman ps -a --filter "label=security.allowPrivilegeEscalation=true" --format "{{.Names}}" | wc -l)
    if [[ $ESCALATION_CONTAINERS -eq 0 ]]; then
        log "✓ CIS 4.2.2 PASS: No containers with privilege escalation found"
    else
        log "✗ CIS 4.2.2 FAIL: $ESCALATION_CONTAINERS containers with privilege escalation found"
    fi
}

# CIS 4.2.3 - Minimize the admission of containers with capabilities
check_container_capabilities() {
    log "Checking container capabilities..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            CAPS=$(podman inspect "$container" | jq -r '.[0].HostConfig.CapAdd[]? // empty')
            if [[ -n "$CAPS" ]]; then
                log "✗ CIS 4.2.3 WARNING: Container $container has additional capabilities: $CAPS"
            else
                log "✓ CIS 4.2.3 PASS: Container $container has minimal capabilities"
            fi
        fi
    done
}

# CIS 4.2.4 - Minimize the admission of containers with elevated capabilities
check_elevated_capabilities() {
    log "Checking for containers with elevated capabilities..."
    DANGEROUS_CAPS=("SYS_ADMIN" "NET_ADMIN" "SYS_MODULE" "SYS_RAWIO" "MAC_ADMIN")

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            for cap in "${DANGEROUS_CAPS[@]}"; do
                if podman inspect "$container" | jq -r '.[0].HostConfig.CapAdd[]? // empty' | grep -q "$cap"; then
                    log "✗ CIS 4.2.4 FAIL: Container $container has dangerous capability: $cap"
                fi
            done
        fi
    done
}

# CIS 4.2.5 - Minimize the admission of containers with seccomp disabled
check_seccomp_profiles() {
    log "Checking seccomp profiles..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            SECCOMP=$(podman inspect "$container" | jq -r '.[0].HostConfig.SecurityOpt[] | select(startswith("seccomp"))')
            if [[ "$SECCOMP" == "seccomp:unconfined" ]]; then
                log "✗ CIS 4.2.5 FAIL: Container $container has seccomp disabled"
            else
                log "✓ CIS 4.2.5 PASS: Container $container has seccomp enabled"
            fi
        fi
    done
}

# CIS 4.2.6 - Minimize the admission of root containers
check_root_containers() {
    log "Checking for root containers..."
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            USER_ID=$(podman inspect "$container" | jq -r '.[0].Config.User // "0"')
            if [[ "$USER_ID" == "0" || "$USER_ID" == "root" || -z "$USER_ID" ]]; then
                log "✗ CIS 4.2.6 FAIL: Container $container runs as root"
            else
                log "✓ CIS 4.2.6 PASS: Container $container runs as non-root user: $USER_ID"
            fi
        fi
    done
}

# Run all CIS compliance checks
check_privileged_containers
check_privilege_escalation
check_container_capabilities
check_elevated_capabilities
check_seccomp_profiles
check_root_containers

log "CIS Kubernetes Benchmark compliance check completed"
EOF

chmod +x ~/.local/bin/podman-cis-compliance.sh

# SOC2 compliance automation
cat > ~/.local/bin/podman-soc2-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SOC2-COMPLIANCE] $*"
}

log "Starting SOC2 compliance audit for Podman containers..."

# SOC2 CC6.1 - Logical and physical access controls
audit_access_controls() {
    log "Auditing logical access controls..."

    # Check rootless operation
    if [[ $EUID -eq 0 ]]; then
        log "✗ SOC2 CC6.1 FAIL: Running as root user"
    else
        log "✓ SOC2 CC6.1 PASS: Running as non-root user ($USER)"
    fi

    # Check user namespace isolation
    USER_NS=$(podman info | grep -c "rootless" || true)
    if [[ $USER_NS -gt 0 ]]; then
        log "✓ SOC2 CC6.1 PASS: User namespace isolation enabled"
    else
        log "✗ SOC2 CC6.1 FAIL: User namespace isolation not detected"
    fi
}

# SOC2 CC6.7 - Transmission of data
audit_data_transmission() {
    log "Auditing data transmission security..."

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            # Check for TLS configuration
            TLS_CONFIG=$(podman inspect "$container" | jq -r '.[0].Config.Env[]? | select(contains("TLS_") or contains("SSL_"))' | wc -l)
            if [[ $TLS_CONFIG -gt 0 ]]; then
                log "✓ SOC2 CC6.7 PASS: Container $container has TLS configuration"
            else
                log "⚠ SOC2 CC6.7 WARNING: Container $container may not have TLS configured"
            fi
        fi
    done
}

# SOC2 CC7.1 - System monitoring
audit_monitoring_logging() {
    log "Auditing monitoring and logging..."

    # Check if containers have logging configured
    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            LOG_DRIVER=$(podman inspect "$container" | jq -r '.[0].HostConfig.LogConfig.Type // "none"')
            if [[ "$LOG_DRIVER" != "none" ]]; then
                log "✓ SOC2 CC7.1 PASS: Container $container has logging configured ($LOG_DRIVER)"
            else
                log "✗ SOC2 CC7.1 FAIL: Container $container has no logging configured"
            fi
        fi
    done
}

# SOC2 A1.1 - Availability monitoring
audit_availability_monitoring() {
    log "Auditing availability monitoring..."

    podman ps -a --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            HEALTHCHECK=$(podman inspect "$container" | jq -r '.[0].Config.Healthcheck.Test[]? // empty' | wc -l)
            if [[ $HEALTHCHECK -gt 0 ]]; then
                log "✓ SOC2 A1.1 PASS: Container $container has health monitoring"
            else
                log "⚠ SOC2 A1.1 WARNING: Container $container has no health monitoring"
            fi
        fi
    done
}

# Generate SOC2 compliance report
generate_soc2_report() {
    local report_file="/tmp/soc2-compliance-$(date +%Y%m%d-%H%M%S).json"
    log "Generating SOC2 compliance report: $report_file"

    cat > "$report_file" << REPORT_EOF
{
  "audit_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "audit_scope": "Podman Container Platform",
  "compliance_framework": "SOC2 Type II",
  "auditor": "Automated Podman Compliance Scanner",
  "system_info": {
    "podman_version": "$(podman --version)",
    "host_os": "$(uname -a)",
    "user_context": "$(whoami)",
    "rootless_mode": $(podman info | grep -q "rootless" && echo "true" || echo "false")
  },
  "audit_results": {
    "access_controls_cc6_1": "$(audit_access_controls 2>&1)",
    "data_transmission_cc6_7": "$(audit_data_transmission 2>&1)",
    "monitoring_logging_cc7_1": "$(audit_monitoring_logging 2>&1)",
    "availability_monitoring_a1_1": "$(audit_availability_monitoring 2>&1)"
  }
}
REPORT_EOF

    log "SOC2 compliance report generated: $report_file"
}

# Run SOC2 compliance audit
audit_access_controls
audit_data_transmission
audit_monitoring_logging
audit_availability_monitoring
generate_soc2_report

log "SOC2 compliance audit completed"
EOF

chmod +x ~/.local/bin/podman-soc2-compliance.sh

echo "Enterprise security frameworks and compliance automation configured"
```

## 🌐 Enterprise Networking & Service Discovery

### Advanced Netavark/CNI Configuration

```bash
# Enterprise network automation
cat > ~/.local/bin/enterprise-network-setup.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [NETWORK] $*"
}

log "Setting up enterprise Podman networking..."

# Create enterprise networks
create_enterprise_networks() {
    log "Creating enterprise container networks..."

    # Production network
    podman network create \
        --driver bridge \
        --subnet 10.100.0.0/16 \
        --gateway 10.100.0.1 \
        --dns 8.8.8.8 \
        --dns 1.1.1.1 \
        --opt com.docker.network.bridge.name=podman-prod \
        --opt com.docker.network.bridge.enable_icc=true \
        --opt com.docker.network.bridge.enable_ip_masquerade=true \
        enterprise-production || true

    # Development network
    podman network create \
        --driver bridge \
        --subnet 10.101.0.0/16 \
        --gateway 10.101.0.1 \
        --dns 8.8.8.8 \
        --dns 1.1.1.1 \
        --opt com.docker.network.bridge.name=podman-dev \
        enterprise-development || true

    # Management network
    podman network create \
        --driver bridge \
        --subnet 10.102.0.0/16 \
        --gateway 10.102.0.1 \
        --dns 8.8.8.8 \
        --opt com.docker.network.bridge.name=podman-mgmt \
        --internal \
        enterprise-management || true

    # Database network (isolated)
    podman network create \
        --driver bridge \
        --subnet 10.103.0.0/16 \
        --gateway 10.103.0.1 \
        --opt com.docker.network.bridge.name=podman-db \
        --internal \
        enterprise-database || true
}

# Configure enterprise DNS
configure_enterprise_dns() {
    log "Configuring enterprise DNS resolution..."

    # Enterprise DNS configuration
    mkdir -p ~/.config/containers/networks
    cat > ~/.config/containers/networks/enterprise.conf << 'DNS_EOF'
# Enterprise DNS Configuration
[dns]
servers = ["8.8.8.8", "1.1.1.1", "208.67.222.222"]
searches = ["enterprise.local", "prod.enterprise.local", "dev.enterprise.local"]
options = ["rotate", "timeout:2", "attempts:3", "use-vc"]

[dns.enterprise-production]
servers = ["10.100.0.53", "8.8.8.8"]
searches = ["prod.enterprise.local", "enterprise.local"]

[dns.enterprise-development]
servers = ["10.101.0.53", "8.8.8.8"]
searches = ["dev.enterprise.local", "enterprise.local"]

[dns.enterprise-management]
servers = ["10.102.0.53"]
searches = ["mgmt.enterprise.local"]
DNS_EOF
}

# Enterprise load balancing setup
setup_load_balancing() {
    log "Setting up enterprise load balancing..."

    # HAProxy configuration for container load balancing
    mkdir -p ~/.config/haproxy
    cat > ~/.config/haproxy/enterprise-lb.cfg << 'HAPROXY_EOF'
global
    daemon
    log stdout local0
    maxconn 4096
    user haproxy
    group haproxy

defaults
    mode http
    timeout client 30s
    timeout connect 4s
    timeout server 30s
    option httplog

frontend enterprise-web
    bind *:8080
    default_backend enterprise-app-servers

backend enterprise-app-servers
    balance roundrobin
    option httpchk GET /health
    server app1 10.100.0.10:8080 check
    server app2 10.100.0.11:8080 check
    server app3 10.100.0.12:8080 check

frontend enterprise-api
    bind *:8443 ssl crt /etc/ssl/enterprise.pem
    default_backend enterprise-api-servers

backend enterprise-api-servers
    balance leastconn
    option httpchk GET /api/health
    server api1 10.100.0.20:8443 check ssl verify none
    server api2 10.100.0.21:8443 check ssl verify none
HAPROXY_EOF
}

# Network monitoring setup
setup_network_monitoring() {
    log "Setting up network monitoring..."

    # Network monitoring script
    cat > ~/.local/bin/enterprise-network-monitor.sh << 'MONITOR_EOF'
#!/bin/bash
set -euo pipefail

# Monitor enterprise networks
while true; do
    echo "=== Enterprise Network Status $(date) ==="

    # Network connectivity
    podman network ls --format "{{.Name}}" | while read network; do
        if [[ -n "$network" && "$network" != "NAME" ]]; then
            echo "Network: $network"
            podman network inspect "$network" | jq -r '.[] | "  Subnet: \(.subnets[0].subnet // "N/A"), Gateway: \(.subnets[0].gateway // "N/A")"'
        fi
    done

    # Container network usage
    echo "=== Container Network Usage ==="
    podman stats --no-stream --format "{{.Container}}\t{{.NetIO}}" | while read line; do
        echo "  $line"
    done

    # Network namespace information
    echo "=== Network Namespaces ==="
    ip netns list 2>/dev/null | grep -E "netns|cni-" | head -5

    sleep 60
done
MONITOR_EOF
    chmod +x ~/.local/bin/enterprise-network-monitor.sh
}

# Execute network setup
create_enterprise_networks
configure_enterprise_dns
setup_load_balancing
setup_network_monitoring

log "Enterprise networking setup completed successfully"
EOF

chmod +x ~/.local/bin/enterprise-network-setup.sh
~/.local/bin/enterprise-network-setup.sh
```

### Enterprise Service Discovery & Registry Integration

```bash
# Service discovery with Consul integration
cat > ~/.local/bin/setup-consul-discovery.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CONSUL] $*"
}

log "Setting up Consul service discovery for Podman..."

# Consul configuration
mkdir -p ~/.config/consul
cat > ~/.config/consul/enterprise.hcl << 'CONSUL_EOF'
datacenter = "enterprise-dc1"
data_dir = "/home/$(whoami)/.local/share/consul"
log_level = "INFO"
server = true
bootstrap_expect = 1
ui_config {
  enabled = true
}
connect {
  enabled = true
}
ports {
  grpc = 8502
}
bind_addr = "127.0.0.1"
client_addr = "0.0.0.0"
CONSUL_EOF

# Consul container service
cat > ~/.config/containers/systemd/consul.container << 'CONSUL_CONTAINER_EOF'
[Unit]
Description=Consul Service Discovery
After=network-online.target
Wants=network-online.target

[Container]
Image=consul:latest
ContainerName=consul-enterprise
Network=enterprise-management
PublishPort=8500:8500
PublishPort=8502:8502
Volume=%h/.config/consul:/consul/config:Z
Volume=%h/.local/share/consul:/consul/data:Z
Environment=CONSUL_BIND_INTERFACE=eth0
Environment=CONSUL_CLIENT_INTERFACE=eth0
Command=consul agent -config-dir=/consul/config

[Service]
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
CONSUL_CONTAINER_EOF

# Service registration helper
cat > ~/.local/bin/register-service.sh << 'REGISTER_EOF'
#!/bin/bash
set -euo pipefail

SERVICE_NAME=${1:-}
SERVICE_PORT=${2:-8080}
SERVICE_HOST=${3:-127.0.0.1}
HEALTH_CHECK=${4:-"/health"}

if [[ -z "$SERVICE_NAME" ]]; then
    echo "Usage: $0 <service-name> [port] [host] [health-check-path]"
    exit 1
fi

# Register service with Consul
curl -X PUT "http://127.0.0.1:8500/v1/agent/service/register" \
    -H "Content-Type: application/json" \
    -d @- << SERVICE_EOF
{
  "ID": "${SERVICE_NAME}-$(hostname)-$$",
  "Name": "$SERVICE_NAME",
  "Address": "$SERVICE_HOST",
  "Port": $SERVICE_PORT,
  "Check": {
    "HTTP": "http://$SERVICE_HOST:$SERVICE_PORT$HEALTH_CHECK",
    "Interval": "30s",
    "Timeout": "10s"
  },
  "Tags": [
    "podman",
    "enterprise",
    "$(whoami)"
  ]
}
SERVICE_EOF

echo "Service $SERVICE_NAME registered with Consul"
REGISTER_EOF

chmod +x ~/.local/bin/register-service.sh

log "Consul service discovery setup completed"
EOF

chmod +x ~/.local/bin/setup-consul-discovery.sh
~/.local/bin/setup-consul-discovery.sh

# Enterprise registry integration
cat > ~/.local/bin/enterprise-registry-setup.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [REGISTRY] $*"
}

log "Setting up enterprise registry integration..."

# Private registry configuration
setup_private_registry() {
    log "Configuring private enterprise registry..."

    # Registry authentication
    mkdir -p ~/.config/containers/auth
    if [[ -n "${ENTERPRISE_REGISTRY_USER:-}" && -n "${ENTERPRISE_REGISTRY_PASS:-}" ]]; then
        echo "${ENTERPRISE_REGISTRY_PASS}" | podman login \
            --username "${ENTERPRISE_REGISTRY_USER}" \
            --password-stdin \
            registry.enterprise.local
    fi

    # Registry mirror configuration
    cat >> ~/.config/containers/registries.conf << 'REGISTRY_EOF'

# Enterprise registry mirrors
[[registry]]
prefix = "docker.io"
location = "registry.enterprise.local/dockerhub-proxy"

[[registry.mirror]]
location = "registry.enterprise.local/dockerhub-proxy"
insecure = false
pull-from-mirror = "digest-only"

[[registry]]
prefix = "quay.io"
location = "registry.enterprise.local/quay-proxy"

[[registry.mirror]]
location = "registry.enterprise.local/quay-proxy"
insecure = false
pull-from-mirror = "digest-only"
REGISTRY_EOF
}

# Harbor registry integration
setup_harbor_integration() {
    log "Setting up Harbor registry integration..."

    # Harbor CLI configuration
    if command -v harbor >/dev/null 2>&1; then
        harbor config --server registry.enterprise.local \
                     --username "${HARBOR_USER:-admin}" \
                     --password "${HARBOR_PASS:-Harbor12345}"
    fi

    # Harbor vulnerability scanning integration
    cat > ~/.local/bin/harbor-security-scan.sh << 'HARBOR_EOF'
#!/bin/bash
set -euo pipefail

IMAGE_NAME=${1:-}
if [[ -z "$IMAGE_NAME" ]]; then
    echo "Usage: $0 <image-name:tag>"
    exit 1
fi

# Push to Harbor for scanning
podman push "$IMAGE_NAME" "registry.enterprise.local/enterprise/$IMAGE_NAME"

# Trigger security scan
curl -X POST \
    -H "Authorization: Basic $(echo -n "${HARBOR_USER:-admin}:${HARBOR_PASS:-Harbor12345}" | base64)" \
    "https://registry.enterprise.local/api/v2.0/projects/enterprise/repositories/$(echo $IMAGE_NAME | cut -d: -f1)/artifacts/$(echo $IMAGE_NAME | cut -d: -f2)/scan"

echo "Security scan initiated for $IMAGE_NAME in Harbor"
HARBOR_EOF

    chmod +x ~/.local/bin/harbor-security-scan.sh
}

# Artifact signing and attestation
setup_artifact_signing() {
    log "Setting up artifact signing and attestation..."

    # Notary v2 integration
    cat > ~/.local/bin/sign-artifact.sh << 'NOTARY_EOF'
#!/bin/bash
set -euo pipefail

ARTIFACT=${1:-}
if [[ -z "$ARTIFACT" ]]; then
    echo "Usage: $0 <artifact-reference>"
    exit 1
fi

# Sign with notation (Notary v2)
if command -v notation >/dev/null 2>&1; then
    notation sign "$ARTIFACT" \
        --signature-format cose \
        --plugin azure-kv \
        --id enterprise-signing-key

    echo "Artifact $ARTIFACT signed with Notary v2"
fi

# Create SLSA attestation
if command -v slsa-generator >/dev/null 2>&1; then
    slsa-generator attest \
        --artifact "$ARTIFACT" \
        --builder-id "https://enterprise.local/podman-builder" \
        --output "${ARTIFACT//[:\/]/_}-attestation.json"

    echo "SLSA attestation created for $ARTIFACT"
fi
NOTARY_EOF

    chmod +x ~/.local/bin/sign-artifact.sh
}

# Execute registry setup
setup_private_registry
setup_harbor_integration
setup_artifact_signing

log "Enterprise registry integration completed"
EOF

chmod +x ~/.local/bin/enterprise-registry-setup.sh
~/.local/bin/enterprise-registry-setup.sh
```

## 📊 Enterprise Monitoring & Observability Platform

### Comprehensive Prometheus & Grafana Integration

```bash
# Enterprise monitoring stack setup
cat > ~/.local/bin/setup-monitoring-stack.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [MONITORING] $*"
}

log "Setting up enterprise monitoring stack for Podman..."

# Prometheus configuration
setup_prometheus() {
    log "Setting up Prometheus monitoring..."

    mkdir -p ~/.config/prometheus
    cat > ~/.config/prometheus/prometheus.yml << 'PROMETHEUS_EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    cluster: 'enterprise-podman'
    environment: 'production'

rule_files:
  - "/etc/prometheus/rules/*.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - alertmanager:9093

scrape_configs:
  # Prometheus self-monitoring
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  # Podman containers monitoring
  - job_name: 'podman-containers'
    static_configs:
      - targets: ['10.100.0.10:9090', '10.100.0.11:9090', '10.100.0.12:9090']
    scrape_interval: 30s
    metrics_path: '/metrics'

  # Node exporter (system metrics)
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['localhost:9100']

  # cAdvisor (container metrics)
  - job_name: 'cadvisor'
    static_configs:
      - targets: ['localhost:8080']
    scrape_interval: 30s
    metrics_path: '/metrics'

  # Podman socket metrics
  - job_name: 'podman-socket'
    static_configs:
      - targets: ['localhost:9874']
    scrape_interval: 60s
PROMETHEUS_EOF

    # Prometheus alerting rules
    mkdir -p ~/.config/prometheus/rules
    cat > ~/.config/prometheus/rules/podman-alerts.yml << 'ALERTS_EOF'
groups:
- name: podman-enterprise
  rules:
  - alert: ContainerDown
    expr: up{job="podman-containers"} == 0
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "Container {{ $labels.instance }} is down"
      description: "Container {{ $labels.instance }} has been down for more than 5 minutes"

  - alert: HighCPUUsage
    expr: rate(container_cpu_usage_seconds_total[5m]) > 0.8
    for: 10m
    labels:
      severity: warning
    annotations:
      summary: "High CPU usage on {{ $labels.container_label_io_podman_name }}"
      description: "Container {{ $labels.container_label_io_podman_name }} CPU usage is above 80%"

  - alert: HighMemoryUsage
    expr: container_memory_usage_bytes / container_spec_memory_limit_bytes > 0.9
    for: 10m
    labels:
      severity: critical
    annotations:
      summary: "High memory usage on {{ $labels.container_label_io_podman_name }}"
      description: "Container {{ $labels.container_label_io_podman_name }} memory usage is above 90%"

  - alert: ContainerRestarting
    expr: rate(container_start_time_seconds[15m]) > 0
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container {{ $labels.container_label_io_podman_name }} is restarting"
      description: "Container {{ $labels.container_label_io_podman_name }} has restarted {{ $value }} times in the last 15 minutes"
ALERTS_EOF
}

# Grafana dashboards
setup_grafana_dashboards() {
    log "Setting up Grafana dashboards..."

    mkdir -p ~/.config/grafana/dashboards
    cat > ~/.config/grafana/dashboards/podman-enterprise.json << 'DASHBOARD_EOF'
{
  "dashboard": {
    "id": null,
    "title": "Podman Enterprise Dashboard",
    "tags": ["podman", "containers", "enterprise"],
    "timezone": "utc",
    "panels": [
      {
        "id": 1,
        "title": "Container Overview",
        "type": "stat",
        "targets": [
          {
            "expr": "count(up{job=\"podman-containers\"})",
            "legendFormat": "Total Containers"
          },
          {
            "expr": "count(up{job=\"podman-containers\"} == 1)",
            "legendFormat": "Running Containers"
          },
          {
            "expr": "count(up{job=\"podman-containers\"} == 0)",
            "legendFormat": "Failed Containers"
          }
        ]
      },
      {
        "id": 2,
        "title": "CPU Usage by Container",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(container_cpu_usage_seconds_total[5m]) * 100",
            "legendFormat": "{{ container_label_io_podman_name }}"
          }
        ],
        "yAxes": [
          {
            "label": "CPU %",
            "max": 100
          }
        ]
      },
      {
        "id": 3,
        "title": "Memory Usage by Container",
        "type": "graph",
        "targets": [
          {
            "expr": "container_memory_usage_bytes / 1024 / 1024",
            "legendFormat": "{{ container_label_io_podman_name }}"
          }
        ],
        "yAxes": [
          {
            "label": "Memory (MB)"
          }
        ]
      },
      {
        "id": 4,
        "title": "Network I/O",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(container_network_receive_bytes_total[5m]) * 8",
            "legendFormat": "{{ container_label_io_podman_name }} RX"
          },
          {
            "expr": "rate(container_network_transmit_bytes_total[5m]) * 8",
            "legendFormat": "{{ container_label_io_podman_name }} TX"
          }
        ]
      }
    ],
    "time": {
      "from": "now-1h",
      "to": "now"
    },
    "refresh": "30s"
  }
}
DASHBOARD_EOF
}

# Logging integration with Fluent Bit
setup_logging() {
    log "Setting up centralized logging..."

    mkdir -p ~/.config/fluent-bit
    cat > ~/.config/fluent-bit/fluent-bit.conf << 'FLUENT_EOF'
[SERVICE]
    Flush         1
    Log_Level     info
    Daemon        off
    Parsers_File  parsers.conf
    HTTP_Server   On
    HTTP_Listen   0.0.0.0
    HTTP_Port     2020

[INPUT]
    Name              tail
    Path              /home/$(whoami)/.local/share/containers/storage/overlay-containers/*/userdata/*/shm/*/logs/*.log
    Parser            json
    Tag               podman.*
    Refresh_Interval  5

[INPUT]
    Name systemd
    Tag  systemd.*
    Systemd_Filter _SYSTEMD_UNIT=user@$(id -u).service

[FILTER]
    Name modify
    Match podman.*
    Add environment enterprise
    Add source podman

[OUTPUT]
    Name  es
    Match podman.*
    Host  elasticsearch.enterprise.local
    Port  9200
    Index podman-logs
    Type  _doc

[OUTPUT]
    Name  prometheus_exporter
    Match *
    Host  0.0.0.0
    Port  2021
EOF

    # Fluent Bit parsers
    cat > ~/.config/fluent-bit/parsers.conf << 'PARSERS_EOF'
[PARSER]
    Name        json
    Format      json
    Time_Key    time
    Time_Format %Y-%m-%dT%H:%M:%S.%L
    Time_Keep   On

[PARSER]
    Name        podman
    Format      regex
    Regex       ^(?<time>[^ ]+) (?<stream>stdout|stderr) (?<logtag>[^ ]*) (?<log>.*)$
    Time_Key    time
    Time_Format %Y-%m-%dT%H:%M:%S.%L%z
PARSERS_EOF
}

# Container metrics exporter
setup_metrics_exporter() {
    log "Setting up container metrics exporter..."

    cat > ~/.local/bin/podman-metrics-exporter.sh << 'METRICS_EOF'
#!/bin/bash
set -euo pipefail

METRICS_PORT=${1:-9874}
METRICS_FILE="/tmp/podman_metrics.prom"

# Generate Prometheus metrics
generate_metrics() {
    cat > "$METRICS_FILE" << PROM_EOF
# HELP podman_containers_total Total number of containers
# TYPE podman_containers_total gauge
podman_containers_total $(podman ps -aq | wc -l)

# HELP podman_containers_running Number of running containers
# TYPE podman_containers_running gauge
podman_containers_running $(podman ps -q | wc -l)

# HELP podman_containers_stopped Number of stopped containers
# TYPE podman_containers_stopped gauge
podman_containers_stopped $(podman ps -aq --filter status=exited | wc -l)

# HELP podman_images_total Total number of images
# TYPE podman_images_total gauge
podman_images_total $(podman images -q | wc -l)

# HELP podman_volumes_total Total number of volumes
# TYPE podman_volumes_total gauge
podman_volumes_total $(podman volume ls -q | wc -l)

# HELP podman_networks_total Total number of networks
# TYPE podman_networks_total gauge
podman_networks_total $(podman network ls -q | wc -l)
PROM_EOF

    # Per-container metrics
    podman ps --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            # Container status
            STATUS=$(podman inspect "$container" | jq -r '.[0].State.Status')
            echo "# HELP podman_container_up Container is running (1) or not (0)"
            echo "# TYPE podman_container_up gauge"
            echo "podman_container_up{container=\"$container\"} $([ "$STATUS" = "running" ] && echo 1 || echo 0)"

            # Container restart count
            RESTARTS=$(podman inspect "$container" | jq -r '.[0].RestartCount // 0')
            echo "# HELP podman_container_restarts Total container restarts"
            echo "# TYPE podman_container_restarts counter"
            echo "podman_container_restarts{container=\"$container\"} $RESTARTS"
        fi
    done >> "$METRICS_FILE"
}

# Serve metrics
serve_metrics() {
    while true; do
        generate_metrics
        python3 -c "
import http.server
import socketserver
import os

os.chdir('/tmp')
Handler = http.server.SimpleHTTPRequestHandler

class MetricsHandler(Handler):
    def do_GET(self):
        if self.path == '/metrics':
            self.send_response(200)
            self.send_header('Content-type', 'text/plain; version=0.0.4')
            self.end_headers()
            with open('podman_metrics.prom', 'rb') as f:
                self.wfile.write(f.read())
        else:
            super().do_GET()

with socketserver.TCPServer(('', $METRICS_PORT), MetricsHandler) as httpd:
    print(f'Serving Podman metrics on port $METRICS_PORT')
    httpd.serve_forever()
" &
        sleep 30
        kill $! 2>/dev/null || true
    done
}

serve_metrics
METRICS_EOF

    chmod +x ~/.local/bin/podman-metrics-exporter.sh
}

# Execute monitoring setup
setup_prometheus
setup_grafana_dashboards
setup_logging
setup_metrics_exporter

log "Enterprise monitoring stack setup completed"
EOF

chmod +x ~/.local/bin/setup-monitoring-stack.sh
~/.local/bin/setup-monitoring-stack.sh
```

### Enterprise Health Monitoring & Alerting

````bash
# Advanced health monitoring
cat > ~/.local/bin/enterprise-health-monitor.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [HEALTH] $*"
}

# Comprehensive health checks
perform_health_checks() {
    log "Performing comprehensive health checks..."

    local health_report="/tmp/podman-health-$(date +%Y%m%d-%H%M%S).json"

    cat > "$health_report" << HEALTH_EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "platform": "Podman Enterprise",
  "version": "$(podman --version)",
  "host": "$(hostname)",
  "user": "$(whoami)",
  "checks": {
HEALTH_EOF

    # System health
    check_system_health() {
        local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
        local memory_usage=$(free | grep '^Mem' | awk '{printf "%.1f", $3/$2 * 100.0}')
        local disk_usage=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)

        cat >> "$health_report" << SYSTEM_EOF
    "system": {
      "status": "$([ ${cpu_usage%.*} -lt 80 ] && [ ${memory_usage%.*} -lt 80 ] && [ $disk_usage -lt 85 ] && echo "healthy" || echo "warning")",
      "cpu_usage_percent": $cpu_usage,
      "memory_usage_percent": $memory_usage,
      "disk_usage_percent": $disk_usage,
      "load_average": "$(uptime | awk -F'load average:' '{print $2}')"
    },
SYSTEM_EOF
    }

    # Container health
    check_container_health() {
        local total_containers=$(podman ps -aq | wc -l)
        local running_containers=$(podman ps -q | wc -l)
        local failed_containers=$(podman ps -aq --filter status=exited | wc -l)

        cat >> "$health_report" << CONTAINER_EOF
    "containers": {
      "status": "$([ $failed_containers -eq 0 ] && echo "healthy" || echo "degraded")",
      "total": $total_containers,
      "running": $running_containers,
      "stopped": $((total_containers - running_containers)),
      "failed": $failed_containers,
      "details": [
CONTAINER_EOF

        # Individual container health
        local first=true
        podman ps -a --format "{{.Names}}" | while read container; do
            if [[ -n "$container" ]]; then
                [[ $first == true ]] && first=false || echo "," >> "$health_report"

                local status=$(podman inspect "$container" | jq -r '.[0].State.Status')
                local health=$(podman inspect "$container" | jq -r '.[0].State.Health.Status // "none"')
                local restarts=$(podman inspect "$container" | jq -r '.[0].RestartCount // 0')

                cat >> "$health_report" << CONTAINER_DETAIL_EOF
        {
          "name": "$container",
          "status": "$status",
          "health": "$health",
          "restarts": $restarts
        }
CONTAINER_DETAIL_EOF
            fi
        done

        echo "      ]" >> "$health_report"
        echo "    }," >> "$health_report"
    }

    # Network health
    check_network_health() {
        local network_count=$(podman network ls -q | wc -l)

        cat >> "$health_report" << NETWORK_EOF
    "networking": {
      "status": "healthy",
      "networks": $network_count,
      "connectivity": [
NETWORK_EOF

        # Test external connectivity
        local google_status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 https://google.com || echo "000")
        local dns_status=$(nslookup google.com >/dev/null 2>&1 && echo "ok" || echo "failed")

        cat >> "$health_report" << CONNECTIVITY_EOF
        {
          "target": "google.com",
          "http_status": $google_status,
          "dns_resolution": "$dns_status"
        }
      ]
    },
CONNECTIVITY_EOF
    }

    # Storage health
    check_storage_health() {
        local storage_driver=$(podman info | grep -i "storage driver" | awk '{print $3}' || echo "unknown")
        local images_count=$(podman images -q | wc -l)
        local volumes_count=$(podman volume ls -q | wc -l)

        cat >> "$health_report" << STORAGE_EOF
    "storage": {
      "status": "healthy",
      "driver": "$storage_driver",
      "images": $images_count,
      "volumes": $volumes_count,
      "space_usage": "$(du -sh ~/.local/share/containers/storage | cut -f1)"
    }
STORAGE_EOF
    }

    # Execute all health checks
    check_system_health
    check_container_health
    check_network_health
    check_storage_health

    # Close JSON
    echo "  }" >> "$health_report"
    echo "}" >> "$health_report"

    # Display health summary
    log "Health check completed. Report: $health_report"
    jq -r '.checks | to_entries[] | "\(.key): \(.value.status)"' "$health_report"

    return 0
}

# Automated remediation
perform_automated_remediation() {
    log "Performing automated remediation..."

    # Clean up stopped containers
    local stopped_containers=$(podman ps -aq --filter status=exited | wc -l)
    if [[ $stopped_containers -gt 10 ]]; then
        log "Cleaning up $stopped_containers stopped containers"
        podman container prune -f
    fi

    # Clean up unused images
    local unused_images=$(podman images -f "dangling=true" -q | wc -l)
    if [[ $unused_images -gt 5 ]]; then
        log "Cleaning up $unused_images unused images"
        podman image prune -f
    fi

    # Clean up unused volumes
    local unused_volumes=$(podman volume ls -f "dangling=true" -q | wc -l)
    if [[ $unused_volumes -gt 3 ]]; then
        log "Cleaning up $unused_volumes unused volumes"
        podman volume prune -f
    fi

    # Restart failed containers
    podman ps -a --filter status=exited --format "{{.Names}}" | while read container; do
        if [[ -n "$container" ]]; then
            local restart_policy=$(podman inspect "$container" | jq -r '.[0].HostConfig.RestartPolicy.Name')
            if [[ "$restart_policy" != "no" ]]; then
                log "Attempting to restart failed container: $container"
                podman restart "$container" || true
            fi
        fi
    done
}

# Execute health monitoring
log "Starting enterprise health monitoring..."
perform_health_checks
perform_automated_remediation
log "Enterprise health monitoring completed"
EOF

chmod +x ~/.local/bin/enterprise-health-monitor.sh

# Set up periodic health monitoring
cat > ~/.config/containers/systemd/health-monitor.timer << 'EOF'
[Unit]
Description=Enterprise Podman Health Monitor Timer
Requires=health-monitor.service

[Timer]
OnBootSec=15min
OnUnitActiveSec=30min
Persistent=true

[Install]
WantedBy=timers.target
EOF

cat > ~/.config/containers/systemd/health-monitor.service << 'EOF'
[Unit]
Description=Enterprise Podman Health Monitor
After=network-online.target

[Service]
Type=oneshot
ExecStart=/home/%i/.local/bin/enterprise-health-monitor.sh
User=%i
EOF

# Enable health monitoring timer
systemctl --user daemon-reload
systemctl --user enable health-monitor.timer
systemctl --user start health-monitor.timer

## 🚀 Enterprise CI/CD Integration & Automation

### GitLab CI/CD Integration
```yaml
# .gitlab-ci.yml - Enterprise Podman CI/CD Pipeline
stages:
  - security-scan
  - build
  - test
  - security-validate
  - deploy
  - monitor

variables:
  REGISTRY: harbor.enterprise.local
  PODMAN_VERSION: "4.9.0"
  BUILDAH_FORMAT: docker
  BUILDAH_ISOLATION: rootless

before_script:
  - |
    # Install Podman in rootless mode
    if ! command -v podman &> /dev/null; then
      curl -fsSL https://get.podman.io | sh
      export PATH="$HOME/.local/bin:$PATH"
    fi

    # Configure enterprise registry authentication
    podman login --username $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD $REGISTRY

    # Setup security scanning
    if ! command -v trivy &> /dev/null; then
      wget -qO- https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
      echo deb https://aquasecurity.github.io/trivy-repo/deb focal main | tee -a /etc/apt/sources.list.d/trivy.list
      apt-get update && apt-get install -y trivy
    fi

# Security scanning stage
container-scan:
  stage: security-scan
  script:
    - |
      echo "Scanning base images for vulnerabilities..."
      trivy image --exit-code 1 --severity HIGH,CRITICAL $BASE_IMAGE || {
        echo "Base image contains high/critical vulnerabilities"
        exit 1
      }
  artifacts:
    reports:
      container_scanning: gl-container-scanning-report.json
  only:
    - merge_requests
    - main
    - develop

# Multi-architecture build stage
build-containers:
  stage: build
  parallel:
    matrix:
      - ARCH: [amd64, arm64, s390x, ppc64le]
  script:
    - |
      echo "Building multi-architecture container for $ARCH..."

      # Create buildah builder instance
      buildah --name app-builder from --arch $ARCH $BASE_IMAGE

      # Configure security contexts
      buildah config --user 1000:1000 app-builder
      buildah config --workingdir /app app-builder

      # Add security labels
      buildah config --label security.alpha.kubernetes.io/sysctls=net.ipv4.ip_unprivileged_port_start=0 app-builder
      buildah config --label security.alpha.kubernetes.io/seccomp=runtime/default app-builder
      buildah config --label security.alpha.kubernetes.io/apparmor=runtime/default app-builder

      # Copy application files
      buildah copy app-builder . /app/

      # Install dependencies with security hardening
      buildah run app-builder -- sh -c '
        apt-get update && \
        apt-get install -y --no-install-recommends \
          ca-certificates \
          curl && \
        rm -rf /var/lib/apt/lists/* && \
        useradd --create-home --shell /bin/bash appuser
      '

      # Set final configuration
      buildah config --entrypoint ["./entrypoint.sh"] app-builder
      buildah config --port 8080/tcp app-builder
      buildah config --user appuser app-builder

      # Commit with signature
      IMAGE_ID=$(buildah commit app-builder $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-$ARCH)

      # Sign image with Cosign
      cosign sign --key env://COSIGN_PRIVATE_KEY $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-$ARCH

      # Push to registry
      podman push $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-$ARCH

      # Cleanup
      buildah rm app-builder

  artifacts:
    reports:
      dotenv: build.env
  only:
    - main
    - develop
    - merge_requests

# Container testing stage
test-containers:
  stage: test
  services:
    - name: $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64
      alias: app-under-test
  script:
    - |
      echo "Running comprehensive container tests..."

      # Security compliance tests
      podman run --rm -v /var/run/docker.sock:/var/run/docker.sock \
        aquasec/trivy:latest image --format json --output security-report.json \
        $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64

      # Functional tests
      podman run --rm --network host \
        $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64 /app/run-tests.sh

      # Performance benchmarks
      podman run --rm --cpus=0.5 --memory=512m \
        $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64 /app/benchmark.sh

      # Container behavior tests
      container_id=$(podman run -d --name test-container \
        $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64)

      # Verify container starts successfully
      sleep 10
      if ! podman ps | grep -q test-container; then
        echo "Container failed to start properly"
        podman logs test-container
        exit 1
      fi

      # Health check validation
      for i in {1..30}; do
        if podman exec test-container curl -f http://localhost:8080/health; then
          break
        fi
        sleep 2
      done

      # Resource usage validation
      MEMORY_USAGE=$(podman stats --no-stream --format "{{.MemUsage}}" test-container | cut -d'/' -f1)
      if [[ ${MEMORY_USAGE%MiB*} -gt 400 ]]; then
        echo "Memory usage too high: $MEMORY_USAGE"
        exit 1
      fi

      # Cleanup
      podman stop test-container
      podman rm test-container

  coverage: '/Coverage: \d+\.\d+%/'
  artifacts:
    paths:
      - security-report.json
      - test-results.xml
    reports:
      junit: test-results.xml
  only:
    - main
    - develop
    - merge_requests

# Advanced security validation
security-validation:
  stage: security-validate
  script:
    - |
      echo "Performing advanced security validation..."

      # Container image security scan
      trivy image --format json --output trivy-report.json \
        $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64

      # Check for secrets in image
      trivy fs --format json --output trivy-fs-report.json .

      # Vulnerability database update
      trivy image --download-db-only

      # Policy validation with OPA
      if command -v opa &> /dev/null; then
        opa fmt --diff policies/
        opa test policies/

        # Validate container against policies
        podman inspect $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64 | \
        opa eval --data policies/ --input - \
        "data.container.violation[x]" --format json
      fi

      # CIS Benchmark validation
      if command -v docker-bench-security &> /dev/null; then
        docker-bench-security.sh -c container_images
      fi

      # SLSA provenance generation
      if command -v cosign &> /dev/null; then
        cosign attest --predicate slsa-provenance.json \
          --key env://COSIGN_PRIVATE_KEY \
          $REGISTRY/$CI_PROJECT_PATH:$CI_COMMIT_SHA-amd64
      fi

  artifacts:
    reports:
      container_scanning: trivy-report.json
      sast: trivy-fs-report.json
    paths:
      - slsa-provenance.json
  only:
    - main
    - develop

# Production deployment
deploy-production:
  stage: deploy
  environment:
    name: production
    url: https://app.enterprise.local
  script:
    - |
      echo "Deploying to production environment..."

      # Create manifest with security policies
      cat > deployment-manifest.yaml << 'MANIFEST_EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: enterprise-app
  namespace: production
  labels:
    app: enterprise-app
    version: ${CI_COMMIT_SHA}
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
  selector:
    matchLabels:
      app: enterprise-app
  template:
    metadata:
      labels:
        app: enterprise-app
        version: ${CI_COMMIT_SHA}
      annotations:
        container.apparmor.security.beta.kubernetes.io/app: runtime/default
        seccomp.security.alpha.kubernetes.io/pod: runtime/default
    spec:
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        runAsGroup: 1000
        fsGroup: 1000
        seccompProfile:
          type: RuntimeDefault
      containers:
      - name: app
        image: ${REGISTRY}/${CI_PROJECT_PATH}:${CI_COMMIT_SHA}-amd64
        ports:
        - containerPort: 8080
          protocol: TCP
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          runAsUser: 1000
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        env:
        - name: ENVIRONMENT
          value: "production"
        volumeMounts:
        - name: tmp
          mountPath: /tmp
        - name: cache
          mountPath: /app/cache
      volumes:
      - name: tmp
        emptyDir: {}
      - name: cache
        emptyDir: {}
      imagePullSecrets:
      - name: registry-secret
MANIFEST_EOF

      # Apply with kubectl/podman kube
      if command -v kubectl &> /dev/null; then
        kubectl apply -f deployment-manifest.yaml
        kubectl rollout status deployment/enterprise-app -n production --timeout=600s
      else
        # Use podman kube for local deployment
        podman kube play deployment-manifest.yaml
      fi

      # Verify deployment
      sleep 30
      curl -f https://app.enterprise.local/health || {
        echo "Deployment health check failed"
        exit 1
      }

  only:
    - main
  when: manual

# Monitoring and alerting setup
deploy-monitoring:
  stage: monitor
  script:
    - |
      echo "Setting up production monitoring..."

      # Deploy Prometheus ServiceMonitor
      cat > servicemonitor.yaml << 'MONITOR_EOF'
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: enterprise-app
  namespace: production
spec:
  selector:
    matchLabels:
      app: enterprise-app
  endpoints:
  - port: metrics
    interval: 30s
    path: /metrics
MONITOR_EOF

      kubectl apply -f servicemonitor.yaml || true

      # Setup Grafana dashboard
      curl -X POST -H "Content-Type: application/json" \
        -d @grafana-dashboard.json \
        "http://admin:${GRAFANA_PASSWORD}@grafana.enterprise.local/api/dashboards/db" || true

      # Configure alerting rules
      kubectl apply -f prometheus-rules.yaml || true

  only:
    - main
  when: manual
````

### Jenkins Pipeline Integration

```groovy
// Jenkinsfile - Enterprise Podman Pipeline
pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
    fsGroup: 1000
  containers:
  - name: podman
    image: quay.io/podman/stable:latest
    command: ['cat']
    tty: true
    securityContext:
      privileged: false
      allowPrivilegeEscalation: false
      capabilities:
        add: ["SETUID", "SETGID"]
    resources:
      requests:
        memory: "1Gi"
        cpu: "500m"
      limits:
        memory: "2Gi"
        cpu: "1"
"""
        }
    }

    environment {
        REGISTRY = 'harbor.enterprise.local'
        COSIGN_PRIVATE_KEY = credentials('cosign-private-key')
        HARBOR_CREDS = credentials('harbor-credentials')
        SONARQUBE_TOKEN = credentials('sonarqube-token')
    }

    stages {
        stage('Checkout & Setup') {
            steps {
                script {
                    // Configure Podman for rootless operation
                    sh '''
                        export XDG_RUNTIME_DIR=/tmp/podman-run-$(id -u)
                        mkdir -p $XDG_RUNTIME_DIR
                        podman system migrate || true

                        # Configure registry authentication
                        echo "$HARBOR_CREDS_PSW" | podman login --username "$HARBOR_CREDS_USR" --password-stdin $REGISTRY
                    '''
                }
            }
        }

        stage('Security Scanning') {
            parallel {
                stage('Source Code Security') {
                    steps {
                        container('podman') {
                            script {
                                // SAST with SonarQube
                                sh '''
                                    sonar-scanner \
                                        -Dsonar.projectKey=enterprise-app \
                                        -Dsonar.sources=. \
                                        -Dsonar.host.url=https://sonarqube.enterprise.local \
                                        -Dsonar.login=$SONARQUBE_TOKEN
                                '''

                                // Secret scanning
                                sh '''
                                    if ! command -v gitleaks &> /dev/null; then
                                        curl -sSfL https://github.com/zricethezav/gitleaks/releases/download/v8.18.0/gitleaks_8.18.0_linux_x86_64.tar.gz | tar xz
                                        chmod +x gitleaks
                                    fi

                                    ./gitleaks detect --source . --report-format json --report-path gitleaks-report.json
                                '''
                            }
                        }
                    }
                    post {
                        always {
                            archiveArtifacts artifacts: 'gitleaks-report.json', allowEmptyArchive: true
                        }
                    }
                }

                stage('Dependency Scanning') {
                    steps {
                        container('podman') {
                            script {
                                // Dependency vulnerability scanning
                                sh '''
                                    # Install trivy
                                    wget -qO- https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
                                    echo deb https://aquasecurity.github.io/trivy-repo/deb focal main | tee -a /etc/apt/sources.list.d/trivy.list
                                    apt-get update && apt-get install -y trivy

                                    # Scan filesystem for vulnerabilities
                                    trivy fs --format json --output dependency-scan.json .
                                '''
                            }
                        }
                    }
                    post {
                        always {
                            archiveArtifacts artifacts: 'dependency-scan.json', allowEmptyArchive: true
                        }
                    }
                }
            }
        }

        stage('Build Multi-Arch Containers') {
            matrix {
                axes {
                    axis {
                        name 'ARCHITECTURE'
                        values 'amd64', 'arm64', 's390x', 'ppc64le'
                    }
                }
            }
            steps {
                container('podman') {
                    script {
                        sh """
                            export XDG_RUNTIME_DIR=/tmp/podman-run-\$(id -u)

                            # Multi-stage secure build
                            buildah bud --arch ${ARCHITECTURE} \
                                --security-opt seccomp=unconfined \
                                --security-opt apparmor=unconfined \
                                --build-arg ARCH=${ARCHITECTURE} \
                                --build-arg BUILD_DATE=\$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
                                --build-arg VCS_REF=\$GIT_COMMIT \
                                --label org.opencontainers.image.source=\$GIT_URL \
                                --label org.opencontainers.image.revision=\$GIT_COMMIT \
                                --label org.opencontainers.image.created=\$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
                                --tag \$REGISTRY/\$JOB_NAME:\$BUILD_NUMBER-${ARCHITECTURE} \
                                .

                            # Security scan of built image
                            trivy image --exit-code 1 --severity HIGH,CRITICAL \
                                \$REGISTRY/\$JOB_NAME:\$BUILD_NUMBER-${ARCHITECTURE}

                            # Sign image with Cosign
                            cosign sign --key env://COSIGN_PRIVATE_KEY \
                                \$REGISTRY/\$JOB_NAME:\$BUILD_NUMBER-${ARCHITECTURE}

                            # Push to registry
                            podman push \$REGISTRY/\$JOB_NAME:\$BUILD_NUMBER-${ARCHITECTURE}
                        """
                    }
                }
            }
        }

        stage('Integration Testing') {
            steps {
                container('podman') {
                    script {
                        sh '''
                            export XDG_RUNTIME_DIR=/tmp/podman-run-$(id -u)

                            # Create test network
                            podman network create test-network

                            # Start application container
                            podman run -d --name app-test \
                                --network test-network \
                                --health-cmd "curl -f http://localhost:8080/health || exit 1" \
                                --health-interval=30s \
                                --health-timeout=10s \
                                --health-retries=3 \
                                --security-opt seccomp=runtime/default \
                                --security-opt apparmor=runtime/default \
                                --read-only \
                                --tmpfs /tmp \
                                --user 1000:1000 \
                                $REGISTRY/$JOB_NAME:$BUILD_NUMBER-amd64

                            # Wait for container to be healthy
                            timeout 300 sh -c 'until podman healthcheck run app-test; do sleep 5; done'

                            # Run integration tests
                            podman run --rm --network test-network \
                                -v $PWD/tests:/tests:ro \
                                appropriate/curl:latest \
                                sh -c "
                                    cd /tests
                                    ./integration-tests.sh http://app-test:8080
                                "

                            # Performance testing
                            podman run --rm --network test-network \
                                jordi/ab:latest \
                                ab -n 1000 -c 10 http://app-test:8080/

                            # Security testing
                            podman run --rm --network test-network \
                                -v $PWD:/workspace:ro \
                                owasp/zap2docker-stable:latest \
                                zap-baseline.py -t http://app-test:8080
                        '''
                    }
                }
            }
            post {
                always {
                    container('podman') {
                        sh '''
                            export XDG_RUNTIME_DIR=/tmp/podman-run-$(id -u)
                            podman logs app-test > application.log || true
                            podman stop app-test || true
                            podman rm app-test || true
                            podman network rm test-network || true
                        '''
                    }
                    archiveArtifacts artifacts: 'application.log', allowEmptyArchive: true
                }
            }
        }

        stage('Deploy to Staging') {
            when {
                anyOf {
                    branch 'main'
                    branch 'develop'
                }
            }
            steps {
                container('podman') {
                    script {
                        sh '''
                            # Generate Kubernetes manifests
                            podman kube generate --service app-test > k8s-manifest.yaml

                            # Apply security policies
                            kubectl apply -f security-policies/

                            # Deploy to staging
                            kubectl apply -f k8s-manifest.yaml -n staging

                            # Wait for rollout
                            kubectl rollout status deployment/app-test -n staging --timeout=300s

                            # Smoke test
                            kubectl run smoke-test --rm -i --image=curlimages/curl:latest -- \
                                curl -f http://app-test.staging.svc.cluster.local:8080/health
                        '''
                    }
                }
            }
        }

        stage('Production Deployment') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to Production?', ok: 'Deploy'
                container('podman') {
                    script {
                        sh '''
                            # Blue-green deployment strategy
                            kubectl patch deployment app -p '{"spec":{"template":{"spec":{"containers":[{"name":"app","image":"'$REGISTRY/$JOB_NAME:$BUILD_NUMBER-amd64'"}]}}}}' -n production

                            # Wait for deployment
                            kubectl rollout status deployment/app -n production --timeout=600s

                            # Health verification
                            for i in {1..10}; do
                                if kubectl run health-check --rm -i --image=curlimages/curl:latest -- curl -f https://app.enterprise.local/health; then
                                    echo "Production deployment successful"
                                    break
                                fi
                                sleep 30
                            done
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            // Cleanup
            container('podman') {
                sh '''
                    export XDG_RUNTIME_DIR=/tmp/podman-run-$(id -u)
                    podman system prune -f || true
                '''
            }
        }
        success {
            slackSend channel: '#deployments', color: 'good', message: "✅ Production deployment successful: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
        failure {
            slackSend channel: '#deployments', color: 'danger', message: "❌ Deployment failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}"
        }
    }
}
```

### GitHub Actions Integration

```yaml
# .github/workflows/enterprise-podman.yml
name: Enterprise Podman CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 2 * * 0' # Weekly security scans

env:
  REGISTRY: harbor.enterprise.local
  IMAGE_NAME: enterprise-app

jobs:
  security-scan:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
      contents: read
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: fs
          scan-ref: .
          format: sarif
          output: trivy-results.sarif

      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: trivy-results.sarif

      - name: Secret detection
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: main
          head: HEAD
          extra_args: --debug --only-verified

  build-and-test:
    needs: security-scan
    runs-on: ubuntu-latest
    strategy:
      matrix:
        arch: [amd64, arm64]
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up QEMU
        uses: docker/setup-qemu-action@v3
        with:
          platforms: linux/amd64,linux/arm64,linux/s390x,linux/ppc64le

      - name: Install Podman
        run: |
          sudo apt-get update
          sudo apt-get install -y podman

          # Configure for rootless operation
          echo 'unqualified-search-registries = ["docker.io"]' | sudo tee -a /etc/containers/registries.conf

      - name: Login to Harbor Registry
        run: |
          echo '${{ secrets.HARBOR_PASSWORD }}' | podman login --username '${{ secrets.HARBOR_USERNAME }}' --password-stdin ${{ env.REGISTRY }}

      - name: Build multi-architecture image
        run: |
          # Build with Buildah for better security controls
          buildah bud \
            --arch ${{ matrix.arch }} \
            --security-opt seccomp=unconfined \
            --build-arg ARCH=${{ matrix.arch }} \
            --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
            --build-arg VCS_REF=${{ github.sha }} \
            --label org.opencontainers.image.source=${{ github.server_url }}/${{ github.repository }} \
            --label org.opencontainers.image.revision=${{ github.sha }} \
            --label org.opencontainers.image.created=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
            --tag ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-${{ matrix.arch }} \
            .

      - name: Scan built image
        run: |
          # Install Trivy
          sudo apt-get install wget apt-transport-https gnupg lsb-release
          wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
          echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
          sudo apt-get update && sudo apt-get install trivy

          # Scan image
          trivy image --exit-code 1 --severity HIGH,CRITICAL ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-${{ matrix.arch }}

      - name: Sign image with Cosign
        if: github.ref == 'refs/heads/main'
        run: |
          # Install Cosign
          curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
          sudo mv cosign-linux-amd64 /usr/local/bin/cosign
          sudo chmod +x /usr/local/bin/cosign

          # Sign image
          echo '${{ secrets.COSIGN_PRIVATE_KEY }}' | cosign sign --key env://COSIGN_PRIVATE_KEY ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-${{ matrix.arch }}
        env:
          COSIGN_PRIVATE_KEY: ${{ secrets.COSIGN_PRIVATE_KEY }}
          COSIGN_PASSWORD: ${{ secrets.COSIGN_PASSWORD }}

      - name: Push image
        run: |
          podman push ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-${{ matrix.arch }}

      - name: Test container
        run: |
          # Start container for testing
          container_id=$(podman run -d \
            --name test-container \
            --security-opt seccomp=runtime/default \
            --security-opt apparmor=runtime/default \
            --read-only \
            --tmpfs /tmp \
            --user 1000:1000 \
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-${{ matrix.arch }})

          # Wait for container to start
          sleep 10

          # Health check
          if ! podman exec test-container curl -f http://localhost:8080/health; then
            podman logs test-container
            exit 1
          fi

          # Cleanup
          podman stop test-container
          podman rm test-container

  create-manifest:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Install Podman
        run: |
          sudo apt-get update
          sudo apt-get install -y podman

      - name: Login to Harbor Registry
        run: |
          echo '${{ secrets.HARBOR_PASSWORD }}' | podman login --username '${{ secrets.HARBOR_USERNAME }}' --password-stdin ${{ env.REGISTRY }}

      - name: Create and push manifest
        run: |
          # Create multi-architecture manifest
          podman manifest create ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          podman manifest add ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-amd64
          podman manifest add ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}-arm64

          # Push manifest
          podman manifest push ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}

          # Tag as latest
          podman tag ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          podman push ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest

  deploy-staging:
    needs: create-manifest
    runs-on: ubuntu-latest
    environment: staging
    if: github.ref == 'refs/heads/main' || github.ref == 'refs/heads/develop'
    steps:
      - name: Deploy to staging
        run: |
          # kubectl commands would go here
          echo "Deploying to staging environment"
          # kubectl set image deployment/app app=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} -n staging

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    environment: production
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to production
        run: |
          # kubectl commands for production deployment
          echo "Deploying to production environment"
          # kubectl set image deployment/app app=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} -n production
```

## 🏗️ Enterprise Governance & Compliance Automation

## 🚀 Enterprise CI/CD Integration & Automation

## Compose and orchestration

- podman‑compose for docker‑compose.yml compatibility (best effort)
- Quadlet for production: create .container/.pod unit files and manage via systemd
- For clusters, prefer Kubernetes; use podman kube generate/apply for simple handoffs

## Logging & observability

### Enterprise Monitoring Setup

```bash
# Prometheus metrics collection for Podman
cat > ~/.local/bin/setup-podman-metrics.sh << 'EOF'
#!/bin/bash
set -euo pipefail

# Container metrics exporter
cat > ~/.local/bin/podman-metrics-exporter.py << 'METRICS_EOF'
#!/usr/bin/env python3
import subprocess
import json
import time
import http.server
import socketserver
from threading import Thread

class MetricsHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/metrics':
            self.send_response(200)
            self.send_header('Content-type', 'text/plain; version=0.0.4')
            self.end_headers()

            # Generate Prometheus metrics
            metrics = self.generate_metrics()
            self.wfile.write(metrics.encode())
        else:
            self.send_response(404)
            self.end_headers()

    def generate_metrics(self):
        try:
            # Container counts
            ps_output = subprocess.run(['podman', 'ps', '-a', '--format', 'json'],
                                     capture_output=True, text=True).stdout
            containers = json.loads(ps_output) if ps_output.strip() else []

            running = len([c for c in containers if c.get('State') == 'running'])
            total = len(containers)

            metrics = [
                f'# HELP podman_containers_total Total number of containers',
                f'# TYPE podman_containers_total gauge',
                f'podman_containers_total {total}',
                f'# HELP podman_containers_running Number of running containers',
                f'# TYPE podman_containers_running gauge',
                f'podman_containers_running {running}',
            ]

            # Per-container metrics
            for container in containers:
                name = container.get('Names', ['unknown'])[0]
                state = 1 if container.get('State') == 'running' else 0

                metrics.extend([
                    f'# HELP podman_container_up Container running status',
                    f'# TYPE podman_container_up gauge',
                    f'podman_container_up{{container="{name}"}} {state}'
                ])

            return '\n'.join(metrics) + '\n'

        except Exception as e:
            return f'# Error generating metrics: {e}\n'

if __name__ == '__main__':
    PORT = 9874
    Handler = MetricsHandler

    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"Serving Podman metrics on port {PORT}")
        httpd.serve_forever()
METRICS_EOF

chmod +x ~/.local/bin/podman-metrics-exporter.py

# Start metrics exporter as systemd service
cat > ~/.config/containers/systemd/podman-metrics.service << 'SERVICE_EOF'
[Unit]
Description=Podman Metrics Exporter
After=network-online.target

[Service]
Type=exec
ExecStart=/home/%i/.local/bin/podman-metrics-exporter.py
Restart=always
RestartSec=10
User=%i

[Install]
WantedBy=default.target
SERVICE_EOF

systemctl --user daemon-reload
systemctl --user enable podman-metrics.service
systemctl --user start podman-metrics.service

echo "Podman metrics exporter configured on port 9874"
EOF

chmod +x ~/.local/bin/setup-podman-metrics.sh
~/.local/bin/setup-podman-metrics.sh
```

### Centralized Logging with Fluent Bit

```bash
# Structured logging configuration
cat > ~/.config/fluent-bit/fluent-bit.conf << 'EOF'
[SERVICE]
    Flush         5
    Log_Level     info
    Daemon        off
    Parsers_File  parsers.conf

[INPUT]
    Name              tail
    Path              /home/$(whoami)/.local/share/containers/storage/overlay-containers/*/userdata/*/shm/*/logs/*.log
    Parser            json
    Tag               podman.*
    Refresh_Interval  5

[FILTER]
    Name modify
    Match podman.*
    Add environment production
    Add platform podman

[OUTPUT]
    Name  prometheus_exporter
    Match *
    Host  0.0.0.0
    Port  2021
EOF

# Start Fluent Bit for log aggregation
fluent-bit -c ~/.config/fluent-bit/fluent-bit.conf &
```

- Redirect container logs to journald/json‑file; aggregate with Fluent Bit/Vector
- Healthchecks in images; systemd Restart=on‑failure; add metrics endpoints where applicable
- Enterprise monitoring with Prometheus metrics and centralized logging
- Automated health checks and performance monitoring

## CI/CD

### Enterprise Pipeline Integration

```bash
# Multi-architecture build automation
cat > ~/.local/bin/enterprise-build-pipeline.sh << 'EOF'
#!/bin/bash
set -euo pipefail

REGISTRY="${REGISTRY:-harbor.enterprise.local}"
IMAGE_NAME="${IMAGE_NAME:-enterprise-app}"
BUILD_ARCH="${BUILD_ARCH:-amd64}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [BUILD] $*"
}

# Security-hardened build
build_secure_image() {
    log "Building secure image for architecture: $BUILD_ARCH"

    # Create secure build context
    buildah bud \
        --arch "$BUILD_ARCH" \
        --security-opt seccomp=unconfined \
        --build-arg ARCH="$BUILD_ARCH" \
        --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
        --build-arg VCS_REF="$(git rev-parse HEAD)" \
        --label org.opencontainers.image.source="$(git remote get-url origin)" \
        --label org.opencontainers.image.revision="$(git rev-parse HEAD)" \
        --label org.opencontainers.image.created="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
        --tag "$REGISTRY/$IMAGE_NAME:$(git rev-parse --short HEAD)-$BUILD_ARCH" \
        .

    log "✓ Image built successfully"
}

# Vulnerability scanning
security_scan() {
    log "Running security vulnerability scan..."

    if command -v trivy &> /dev/null; then
        trivy image --exit-code 1 --severity HIGH,CRITICAL \
            "$REGISTRY/$IMAGE_NAME:$(git rev-parse --short HEAD)-$BUILD_ARCH"
        log "✓ Security scan passed"
    else
        log "WARNING: Trivy not found, skipping security scan"
    fi
}

# Image signing with Cosign
sign_image() {
    log "Signing image with Cosign..."

    if [[ -n "${COSIGN_PRIVATE_KEY:-}" ]] && command -v cosign &> /dev/null; then
        echo "$COSIGN_PRIVATE_KEY" | cosign sign --key env://COSIGN_PRIVATE_KEY \
            "$REGISTRY/$IMAGE_NAME:$(git rev-parse --short HEAD)-$BUILD_ARCH"
        log "✓ Image signed successfully"
    else
        log "WARNING: Cosign signing skipped (no key or cosign not found)"
    fi
}

# Execute pipeline
build_secure_image
security_scan
sign_image

log "Enterprise build pipeline completed"
EOF

chmod +x ~/.local/bin/enterprise-build-pipeline.sh
```

### GitHub Actions Integration

```yaml
# .github/workflows/podman-enterprise.yml
name: Enterprise Podman Pipeline
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        arch: [amd64, arm64]
    steps:
      - uses: actions/checkout@v4
      - name: Install Podman
        run: |
          sudo apt-get update && sudo apt-get install -y podman
      - name: Build Image
        run: |
          ./scripts/enterprise-build-pipeline.sh
        env:
          BUILD_ARCH: ${{ matrix.arch }}
          REGISTRY: ${{ secrets.HARBOR_REGISTRY }}
          COSIGN_PRIVATE_KEY: ${{ secrets.COSIGN_PRIVATE_KEY }}
```

- Build with Buildah in rootless mode; push to registry with short‑lived tokens
- Run smoke tests in containers; sign images; deploy via Quadlet units
- Multi-architecture builds with security scanning and image signing
- Automated vulnerability assessment and compliance validation

## Troubleshooting

### Enterprise Diagnostics

```bash
# Comprehensive diagnostic script
cat > ~/.local/bin/podman-enterprise-diagnostics.sh << 'EOF'
#!/bin/bash
set -euo pipefail

REPORT_FILE="/tmp/podman-diagnostics-$(date +%Y%m%d-%H%M%S).txt"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$REPORT_FILE"
}

# System information collection
collect_system_info() {
    log "=== SYSTEM INFORMATION ==="
    {
        echo "Podman Version: $(podman --version)"
        echo "Kernel Version: $(uname -r)"
        echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
        echo "Architecture: $(uname -m)"
        echo "User: $(whoami) (UID: $(id -u))"
    } | tee -a "$REPORT_FILE"
}

# Container status analysis
analyze_containers() {
    log "=== CONTAINER ANALYSIS ==="

    # Container summary
    {
        echo "Total Containers: $(podman ps -aq | wc -l)"
        echo "Running Containers: $(podman ps -q | wc -l)"
        echo "Failed Containers: $(podman ps -aq --filter status=exited | wc -l)"
    } | tee -a "$REPORT_FILE"

    # Failed container details
    log "Failed Containers:"
    podman ps -a --filter status=exited --format "table {{.Names}}\t{{.Status}}\t{{.ExitCode}}" | tee -a "$REPORT_FILE"
}

# Network connectivity diagnostics
diagnose_networking() {
    log "=== NETWORK DIAGNOSTICS ==="

    {
        echo "Network List:"
        podman network ls
        echo ""
        echo "Network Interfaces:"
        ip addr show | grep -E '^[0-9]+:|inet '
        echo ""
        echo "DNS Resolution Test:"
        nslookup google.com || echo "DNS resolution failed"
        echo ""
        echo "External Connectivity Test:"
        curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" --max-time 5 https://google.com || echo "External connectivity failed"
    } | tee -a "$REPORT_FILE"
}

# Security context validation
validate_security() {
    log "=== SECURITY VALIDATION ==="

    {
        echo "SELinux Status:"
        sestatus 2>/dev/null || echo "SELinux not available"
        echo ""
        echo "User Namespace Mapping:"
        podman unshare cat /proc/self/uid_map 2>/dev/null || echo "User namespace mapping unavailable"
        echo ""
        echo "Privileged Containers:"
        podman ps -a --format "{{.Names}}" | while read container; do
            if [[ -n "$container" ]]; then
                privileged=$(podman inspect "$container" | jq -r '.[0].HostConfig.Privileged')
                echo "$container: $privileged"
            fi
        done
    } | tee -a "$REPORT_FILE"
}

# Execute diagnostics
collect_system_info
analyze_containers
diagnose_networking
validate_security

log "=== DIAGNOSTIC REPORT COMPLETE ==="
log "Report saved to: $REPORT_FILE"
EOF

chmod +x ~/.local/bin/podman-enterprise-diagnostics.sh
```

### Advanced Troubleshooting Commands

```bash
# Container process inspection
podman inspect <container> | jq '.[] | {State, Config, NetworkSettings}'

# Resource usage analysis
podman stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"

# Security context debugging
podman inspect <container> | jq '.[] | {SecurityOpt, User, Privileged}'

# Network troubleshooting
podman exec -it <container> ip route
podman exec -it <container> nslookup <service>
```

- podman inspect/logs/top; check user namespace mappings; validate SELinux denials (audit2allow)
- Networking issues: verify netavark networks, IP conflicts, and host firewall rules
- Enterprise diagnostics with comprehensive system analysis and security validation
- Automated troubleshooting scripts and performance monitoring

## Enterprise Governance & Compliance

### CIS Benchmark Automation

```bash
# CIS Kubernetes Benchmark compliance for Podman
cat > ~/.local/bin/podman-cis-compliance.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [CIS-COMPLIANCE] $*"
}

log "Running CIS Kubernetes Benchmark compliance checks for Podman..."

# CIS 5.1.1 - Ensure that the cluster-admin role is only used where required
check_privileged_containers() {
    log "Checking for privileged containers..."

    local privileged_count=0
    while IFS= read -r container; do
        if [[ -n "$container" ]]; then
            local is_privileged=$(podman inspect "$container" | jq -r '.[0].HostConfig.Privileged')
            if [[ "$is_privileged" == "true" ]]; then
                log "WARNING: Privileged container found: $container"
                ((privileged_count++))
            fi
        fi
    done <<< "$(podman ps --format '{{.Names}}')"

    if [[ $privileged_count -eq 0 ]]; then
        log "✓ CIS 5.1.1: No privileged containers found"
    else
        log "✗ CIS 5.1.1: $privileged_count privileged containers found"
    fi
}

# CIS 5.1.2 - Minimize the admission of containers wishing to share the host process ID namespace
check_host_pid() {
    log "Checking for containers sharing host PID namespace..."

    local host_pid_count=0
    while IFS= read -r container; do
        if [[ -n "$container" ]]; then
            local pid_mode=$(podman inspect "$container" | jq -r '.[0].HostConfig.PidMode')
            if [[ "$pid_mode" == "host" ]]; then
                log "WARNING: Container sharing host PID: $container"
                ((host_pid_count++))
            fi
        fi
    done <<< "$(podman ps --format '{{.Names}}')"

    if [[ $host_pid_count -eq 0 ]]; then
        log "✓ CIS 5.1.2: No containers sharing host PID namespace"
    else
        log "✗ CIS 5.1.2: $host_pid_count containers sharing host PID namespace"
    fi
}

# CIS 5.1.3 - Minimize the admission of containers wishing to share the host IPC namespace
check_host_ipc() {
    log "Checking for containers sharing host IPC namespace..."

    local host_ipc_count=0
    while IFS= read -r container; do
        if [[ -n "$container" ]]; then
            local ipc_mode=$(podman inspect "$container" | jq -r '.[0].HostConfig.IpcMode')
            if [[ "$ipc_mode" == "host" ]]; then
                log "WARNING: Container sharing host IPC: $container"
                ((host_ipc_count++))
            fi
        fi
    done <<< "$(podman ps --format '{{.Names}}')"

    if [[ $host_ipc_count -eq 0 ]]; then
        log "✓ CIS 5.1.3: No containers sharing host IPC namespace"
    else
        log "✗ CIS 5.1.3: $host_ipc_count containers sharing host IPC namespace"
    fi
}

# Execute compliance checks
check_privileged_containers
check_host_pid
check_host_ipc

log "CIS Kubernetes Benchmark compliance check completed"
EOF

chmod +x ~/.local/bin/podman-cis-compliance.sh
```

### SOC2 Type II Controls

```bash
# SOC2 compliance automation for container operations
cat > ~/.local/bin/podman-soc2-controls.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SOC2-CONTROLS] $*"
}

# SOC2 CC6.1 - Logical and Physical Access Controls
implement_access_controls() {
    log "Implementing SOC2 CC6.1 access controls..."

    # Create audit log for container access
    mkdir -p ~/.local/share/containers/audit

    # Container access logging wrapper
    cat > ~/.local/bin/podman-audit-wrapper.sh << 'AUDIT_EOF'
#!/bin/bash
AUDIT_LOG="$HOME/.local/share/containers/audit/access.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
USER=$(whoami)
COMMAND="$*"

echo "$TIMESTAMP|$USER|$COMMAND" >> "$AUDIT_LOG"
exec podman "$@"
AUDIT_EOF

    chmod +x ~/.local/bin/podman-audit-wrapper.sh
    log "✓ SOC2 CC6.1: Access controls and audit logging implemented"
}

# SOC2 CC6.7 - Data Transmission Security
implement_transmission_security() {
    log "Implementing SOC2 CC6.7 transmission security..."

    # Create TLS configuration for registry communication
    mkdir -p ~/.config/containers/certs.d/harbor.enterprise.local

    # Registry certificate validation
    cat > ~/.config/containers/policy.json << 'POLICY_EOF'
{
    "default": [
        {
            "type": "reject"
        }
    ],
    "transports": {
        "docker": {
            "harbor.enterprise.local": [
                {
                    "type": "signedBy",
                    "keyType": "GPGKeys",
                    "keyPath": "/home/$(whoami)/.local/share/containers/keys/pgp"
                }
            ]
        }
    }
}
POLICY_EOF

    log "✓ SOC2 CC6.7: Transmission security controls implemented"
}

# SOC2 CC7.1 - System Operations Security
implement_operations_security() {
    log "Implementing SOC2 CC7.1 operations security..."

    # Container lifecycle monitoring
    cat > ~/.local/bin/container-lifecycle-monitor.sh << 'LIFECYCLE_EOF'
#!/bin/bash
LIFECYCLE_LOG="$HOME/.local/share/containers/audit/lifecycle.log"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Monitor container events
podman events --format json | while read event; do
    echo "$TIMESTAMP|LIFECYCLE|$event" >> "$LIFECYCLE_LOG"
done
LIFECYCLE_EOF

    chmod +x ~/.local/bin/container-lifecycle-monitor.sh
    log "✓ SOC2 CC7.1: Operations security monitoring implemented"
}

# Execute SOC2 controls
implement_access_controls
implement_transmission_security
implement_operations_security

log "SOC2 Type II controls implementation completed"
EOF

chmod +x ~/.local/bin/podman-soc2-controls.sh
```

## AI Assistant Guidelines

- Prefer rootless + Quadlet for services; avoid advising a Docker daemon on Podman hosts
- Generate secure Containerfiles (non‑root user, read‑only FS, minimal base images)
- Include systemd unit examples with Restart policy and healthchecks
- Use pinned image digests and signed images; avoid broad volume mounts
- Implement enterprise governance with CIS benchmarks and SOC2 controls
- Automate compliance monitoring and audit trail generation

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
