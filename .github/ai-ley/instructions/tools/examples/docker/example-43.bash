# harbor-setup.sh - Deploy Harbor enterprise registry
cat > harbor-setup.sh << 'EOF'
#!/bin/bash
set -euo pipefail

HARBOR_VERSION="${HARBOR_VERSION:-v2.9.0}"
HARBOR_DOMAIN="${HARBOR_DOMAIN:-harbor.company.com}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-Harbor12345}"

# Download and configure Harbor
wget -O harbor.tar.gz "https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/harbor-offline-installer-${HARBOR_VERSION}.tgz"
tar xvf harbor.tar.gz
cd harbor

# Generate SSL certificates
mkdir -p certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/$HARBOR_DOMAIN.key \
  -x509 -days 365 -out certs/$HARBOR_DOMAIN.crt \
  -subj "/C=US/ST=CA/L=San Francisco/O=Company/CN=$HARBOR_DOMAIN"

# Configure Harbor
cat > harbor.yml << HARBOR_EOF
hostname: $HARBOR_DOMAIN
http:
  port: 80
https:
  port: 443
  certificate: /data/cert/$HARBOR_DOMAIN.crt
  private_key: /data/cert/$HARBOR_DOMAIN.key
harbor_admin_password: $ADMIN_PASSWORD
database:
  password: rootpassword
  max_idle_conns: 100
  max_open_conns: 900
data_volume: /data
trivy:
  ignore_unfixed: false
  skip_update: false
  offline_scan: false
  security_check: vuln
  insecure: false
jobservice:
  max_job_workers: 10
notification:
  webhook_job_max_retry: 10
chart:
  absolute_url: disabled
log:
  level: info
  local:
    rotate_count: 50
    rotate_size: 200M
    location: /var/log/harbor
_version: 2.9.0
HARBOR_EOF

# Install Harbor with security scanning
./install.sh --with-trivy --with-chartmuseum
EOF

chmod +x harbor-setup.sh