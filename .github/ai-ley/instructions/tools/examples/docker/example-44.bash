# registry-auth.sh - Enterprise registry authentication
cat > registry-auth.sh << 'EOF'
#!/bin/bash
set -euo pipefail

REGISTRY_URL="${1:-harbor.company.com}"
USERNAME="${2:-admin}"
PROJECT="${3:-enterprise}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [REGISTRY] $*"
}

# Login to registry
registry_login() {
    log "Authenticating with registry: $REGISTRY_URL"

    # Use credential helper for secure authentication
    echo "$REGISTRY_PASSWORD" | docker login "$REGISTRY_URL" -u "$USERNAME" --password-stdin

    log "✓ Successfully authenticated with registry"
}

# Create enterprise project with policies
create_enterprise_project() {
    local project_name="$1"

    log "Creating enterprise project: $project_name"

    # Create project with vulnerability scanning
    curl -X POST "https://$REGISTRY_URL/api/v2.0/projects" \
        -H "Authorization: Basic $(echo -n $USERNAME:$REGISTRY_PASSWORD | base64)" \
        -H "Content-Type: application/json" \
        -d '{
            "project_name": "'$project_name'",
            "public": false,
            "metadata": {
                "prevent_vul": "true",
                "severity": "high",
                "auto_scan": "true",
                "enable_content_trust": "true",
                "reuse_sys_cve_allowlist": "false"
            }
        }'

    log "✓ Enterprise project created with security policies"
}

# Configure image retention policies
configure_retention_policy() {
    local project_name="$1"

    log "Configuring retention policy for project: $project_name"

    curl -X POST "https://$REGISTRY_URL/api/v2.0/projects/$project_name/retentions" \
        -H "Authorization: Basic $(echo -n $USERNAME:$REGISTRY_PASSWORD | base64)" \
        -H "Content-Type: application/json" \
        -d '{
            "rules": [
                {
                    "disabled": false,
                    "action": "retain",
                    "template": "recentXImages",
                    "params": {"count": "10"},
                    "tag_selectors": [
                        {
                            "kind": "doublestar",
                            "decoration": "matches",
                            "pattern": "**"
                        }
                    ],
                    "scope_selectors": {
                        "repository": [
                            {
                                "kind": "doublestar",
                                "decoration": "repoMatches",
                                "pattern": "**"
                            }
                        ]
                    }
                }
            ]
        }'

    log "✓ Retention policy configured"
}

# Setup vulnerability scanning policy
setup_vulnerability_scanning() {
    local project_name="$1"

    log "Setting up vulnerability scanning for project: $project_name"

    # Configure scan trigger
    curl -X PUT "https://$REGISTRY_URL/api/v2.0/projects/$project_name" \
        -H "Authorization: Basic $(echo -n $USERNAME:$REGISTRY_PASSWORD | base64)" \
        -H "Content-Type: application/json" \
        -d '{
            "metadata": {
                "auto_scan": "true",
                "prevent_vul": "true",
                "severity": "critical",
                "reuse_sys_cve_allowlist": "false"
            }
        }'

    # Create scan schedule
    curl -X POST "https://$REGISTRY_URL/api/v2.0/system/scanAll/schedule" \
        -H "Authorization: Basic $(echo -n $USERNAME:$REGISTRY_PASSWORD | base64)" \
        -H "Content-Type: application/json" \
        -d '{
            "schedule": {
                "type": "Hourly",
                "cron": "0 0 * * * *"
            }
        }'

    log "✓ Vulnerability scanning configured"
}

# Main execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    registry_login
    create_enterprise_project "$PROJECT"
    configure_retention_policy "$PROJECT"
    setup_vulnerability_scanning "$PROJECT"

    log "Enterprise registry setup completed for project: $PROJECT"
fi
EOF

chmod +x registry-auth.sh