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