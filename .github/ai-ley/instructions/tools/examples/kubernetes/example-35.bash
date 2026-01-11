# falco-enterprise-setup.sh - Runtime security monitoring and threat detection
cat > ~/.local/bin/setup-falco-security.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [FALCO] $*"
}

# Install Falco with enterprise configuration
install_falco() {
    log "Installing Falco runtime security monitoring..."

    # Add Falco Helm repository
    helm repo add falcosecurity https://falcosecurity.github.io/charts
    helm repo update

    # Create Falco configuration
    cat > falco-values.yaml << 'FALCO_EOF'
driver:
  kind: modern_ebpf

falco:
  rules_file:
    - /etc/falco/falco_rules.yaml
    - /etc/falco/falco_rules.local.yaml
    - /etc/falco/k8s_audit_rules.yaml
    - /etc/falco/rules.d

  outputs:
    rate: 1
    max_burst: 1000

  outputs_queue:
    capacity: 0

  grpc:
    enabled: true
    bind_address: "0.0.0.0:5060"
    threadiness: 8

  grpc_output:
    enabled: true

customRules:
  rules-enterprise.yaml: |-
    - rule: Detect crypto miners
      desc: Detect cryptocurrency miners
      condition: spawned_process and proc.name in (xmrig, minergate)
      output: Crypto mining process detected (user=%user.name command=%proc.cmdline)
      priority: CRITICAL
      tags: [malware, crypto]

    - rule: Unauthorized privilege escalation
      desc: Detect unauthorized privilege escalation attempts
      condition: spawned_process and proc.name in (sudo, su) and not user.name in (admin, root)
      output: Unauthorized privilege escalation attempt (user=%user.name command=%proc.cmdline)
      priority: HIGH
      tags: [security, privilege]

    - rule: Suspicious network activity
      desc: Detect suspicious outbound network connections
      condition: outbound and fd.net and not proc.name in (curl, wget, ssh) and fd.rport in (6667, 6697, 8333, 4444)
      output: Suspicious outbound connection (process=%proc.name connection=%fd.name)
      priority: HIGH
      tags: [network, suspicious]

services:
  - name: falcosidekick
    type: ClusterIP
    ports:
      - port: 2801
        targetPort: 2801
        protocol: TCP
        name: http

falcosidekick:
  enabled: true
  config:
    slack:
      webhookurl: "${SLACK_WEBHOOK_URL}"
      channel: "#security-alerts"
      username: "Falco"
      icon: ":shield:"
    teams:
      webhookurl: "${TEAMS_WEBHOOK_URL}"
    elasticsearch:
      hostport: "elasticsearch:9200"
      index: "falco-security"
    prometheus:
      extralabels: "cluster:production"

nodeSelector:
  kubernetes.io/os: linux

tolerations:
  - effect: NoSchedule
    key: node-role.kubernetes.io/master
    operator: Exists
  - effect: NoSchedule
    key: node-role.kubernetes.io/control-plane
    operator: Exists

resources:
  requests:
    cpu: 100m
    memory: 256Mi
  limits:
    cpu: 500m
    memory: 1Gi
FALCO_EOF

    # Install Falco
    helm install falco falcosecurity/falco \
        --namespace falco-system \
        --create-namespace \
        --values falco-values.yaml

    log "✓ Falco installed successfully"
}

# Configure audit logging
setup_audit_logging() {
    log "Configuring Kubernetes audit logging..."

    cat > k8s-audit-policy.yaml << 'AUDIT_EOF'
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
# Log security-sensitive events
- level: Metadata
  namespaces: ["production", "staging"]
  resources:
  - group: ""
    resources: ["secrets", "serviceaccounts"]
  - group: "rbac.authorization.k8s.io"
    resources: ["roles", "rolebindings", "clusterroles", "clusterrolebindings"]

# Log all pod exec/attach operations
- level: RequestResponse
  resources:
  - group: ""
    resources: ["pods/exec", "pods/attach", "pods/portforward"]

# Log authentication/authorization failures
- level: Request
  users: ["system:anonymous"]

- level: RequestResponse
  resources:
  - group: ""
    resources: ["nodes", "persistentvolumes"]
  - group: "apps"
    resources: ["deployments", "daemonsets", "statefulsets"]
AUDIT_EOF

    log "✓ Audit policy configured"
}

# Main execution
install_falco
setup_audit_logging
log "Falco security monitoring setup completed"
EOF

chmod +x ~/.local/bin/setup-falco-security.sh