# terraform-compliance-validator.sh - Automated compliance validation
cat > terraform-compliance-validator.sh << 'EOF'
#!/bin/bash
set -euo pipefail

COMPLIANCE_FRAMEWORK="${1:-SOC2}"
ENVIRONMENT="${2:-dev}"
TERRAFORM_DIR="${3:-.}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [COMPLIANCE] $*"
}

# SOC2 compliance validation
validate_soc2_compliance() {
    log "Validating SOC2 compliance requirements..."

    local violations=0

    # Security - Encryption at rest
    if ! grep -r "encrypted.*=.*true" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ SOC2 VIOLATION: Encryption at rest not enforced"
        ((violations++))
    else
        log "✅ SOC2: Encryption at rest validated"
    fi

    # Availability - Multi-AZ deployment
    if ! grep -r "availability_zone" "$TERRAFORM_DIR" | grep -E "(1[a-z]|2[a-z])" >/dev/null 2>&1; then
        log "❌ SOC2 VIOLATION: Multi-AZ deployment not configured"
        ((violations++))
    else
        log "✅ SOC2: Multi-AZ deployment validated"
    fi

    # Processing Integrity - Backup enabled
    if ! grep -r "backup" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ SOC2 VIOLATION: Backup strategy not implemented"
        ((violations++))
    else
        log "✅ SOC2: Backup strategy validated"
    fi

    # Confidentiality - Access control
    if ! grep -r "policy.*=.*" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ SOC2 VIOLATION: Access control policies not defined"
        ((violations++))
    else
        log "✅ SOC2: Access control validated"
    fi

    # Privacy - Data classification tags
    if ! grep -r "DataClassification" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ SOC2 VIOLATION: Data classification tags missing"
        ((violations++))
    else
        log "✅ SOC2: Data classification validated"
    fi

    return $violations
}

# PCI-DSS compliance validation
validate_pci_compliance() {
    log "Validating PCI-DSS compliance requirements..."

    local violations=0

    # Requirement 3: Protect stored cardholder data
    if ! grep -r "kms_key_id" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ PCI-DSS VIOLATION: KMS encryption not implemented"
        ((violations++))
    else
        log "✅ PCI-DSS: Data encryption validated"
    fi

    # Requirement 1: Install and maintain a firewall
    if ! grep -r "security_group\|network_acl" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ PCI-DSS VIOLATION: Network security controls missing"
        ((violations++))
    else
        log "✅ PCI-DSS: Network security validated"
    fi

    # Requirement 8: Identify and authenticate access
    if ! grep -r "iam_role\|iam_policy" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ PCI-DSS VIOLATION: Identity management not implemented"
        ((violations++))
    else
        log "✅ PCI-DSS: Identity management validated"
    fi

    # Requirement 10: Track and monitor access
    if ! grep -r "cloudtrail\|logging" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ PCI-DSS VIOLATION: Audit logging not enabled"
        ((violations++))
    else
        log "✅ PCI-DSS: Audit logging validated"
    fi

    return $violations
}

# HIPAA compliance validation
validate_hipaa_compliance() {
    log "Validating HIPAA compliance requirements..."

    local violations=0

    # Physical and Technical Safeguards
    if ! grep -r "encryption" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ HIPAA VIOLATION: Encryption safeguards missing"
        ((violations++))
    else
        log "✅ HIPAA: Encryption safeguards validated"
    fi

    # Access Control
    if ! grep -r "access.*control\|iam" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ HIPAA VIOLATION: Access control not implemented"
        ((violations++))
    else
        log "✅ HIPAA: Access control validated"
    fi

    # Audit Controls
    if ! grep -r "audit\|log" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ HIPAA VIOLATION: Audit controls missing"
        ((violations++))
    else
        log "✅ HIPAA: Audit controls validated"
    fi

    # Integrity Controls
    if ! grep -r "backup\|versioning" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ HIPAA VIOLATION: Data integrity controls missing"
        ((violations++))
    else
        log "✅ HIPAA: Data integrity controls validated"
    fi

    return $violations
}

# CIS Benchmarks validation
validate_cis_benchmarks() {
    log "Validating CIS benchmarks compliance..."

    local violations=0

    # CIS AWS Foundations Benchmark

    # 1.3 - Ensure credentials are rotated
    if ! grep -r "rotation" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ CIS VIOLATION: Credential rotation not configured"
        ((violations++))
    else
        log "✅ CIS: Credential rotation validated"
    fi

    # 1.22 - Ensure IAM policies are attached only to groups or roles
    if grep -r "aws_iam_user_policy_attachment" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ CIS VIOLATION: Policies attached directly to users"
        ((violations++))
    else
        log "✅ CIS: IAM policy attachment validated"
    fi

    # 2.1 - Ensure CloudTrail is enabled
    if ! grep -r "aws_cloudtrail" "$TERRAFORM_DIR" >/dev/null 2>&1; then
        log "❌ CIS VIOLATION: CloudTrail not enabled"
        ((violations++))
    else
        log "✅ CIS: CloudTrail validated"
    fi

    # 2.6 - Ensure S3 bucket access logging is enabled
    if ! grep -r "logging" "$TERRAFORM_DIR" | grep -i s3 >/dev/null 2>&1; then
        log "❌ CIS VIOLATION: S3 access logging not enabled"
        ((violations++))
    else
        log "✅ CIS: S3 access logging validated"
    fi

    return $violations
}

# Generate compliance report
generate_compliance_report() {
    local framework="$1"
    local violations="$2"
    local timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)

    log "Generating compliance report for $framework..."

    local compliance_score=0
    local total_checks=0

    case "$framework" in
        "SOC2")
            total_checks=5
            ;;
        "PCI-DSS")
            total_checks=4
            ;;
        "HIPAA")
            total_checks=4
            ;;
        "CIS")
            total_checks=4
            ;;
    esac

    compliance_score=$(echo "scale=2; (($total_checks - $violations) * 100) / $total_checks" | bc)

    cat > "compliance-report-$framework-$(date +%Y%m%d-%H%M%S).json" << EOF
{
  "compliance_report": {
    "framework": "$framework",
    "environment": "$ENVIRONMENT",
    "scan_timestamp": "$timestamp",
    "terraform_directory": "$TERRAFORM_DIR",
    "summary": {
      "total_checks": $total_checks,
      "violations": $violations,
      "compliance_score": "$compliance_score%",
      "status": $([ $violations -eq 0 ] && echo '"COMPLIANT"' || echo '"NON_COMPLIANT"')
    },
    "recommendations": [
      $([ $violations -gt 0 ] && echo '"Review and remediate identified violations",' || echo '')
      "Implement automated compliance monitoring",
      "Schedule regular compliance audits",
      "Update policies based on regulatory changes",
      "Provide compliance training to development teams"
    ],
    "next_scan_recommended": "$(date -u -d '+7 days' +%Y-%m-%dT%H:%M:%SZ)"
  }
}
EOF

    log "✓ Compliance report generated: compliance-report-$framework-$(date +%Y%m%d-%H%M%S).json"
    log "Compliance Score: $compliance_score%"

    if [ $violations -eq 0 ]; then
        log "🎉 $framework compliance validation PASSED"
        return 0
    else
        log "❌ $framework compliance validation FAILED ($violations violations)"
        return 1
    fi
}

# Main compliance validation
main() {
    log "Starting Terraform compliance validation..."
    log "Framework: $COMPLIANCE_FRAMEWORK"
    log "Environment: $ENVIRONMENT"
    log "Directory: $TERRAFORM_DIR"

    local violations=0

    case "$COMPLIANCE_FRAMEWORK" in
        "SOC2")
            validate_soc2_compliance || violations=$?
            ;;
        "PCI-DSS")
            validate_pci_compliance || violations=$?
            ;;
        "HIPAA")
            validate_hipaa_compliance || violations=$?
            ;;
        "CIS")
            validate_cis_benchmarks || violations=$?
            ;;
        "ALL")
            validate_soc2_compliance || violations=$((violations + $?))
            validate_pci_compliance || violations=$((violations + $?))
            validate_hipaa_compliance || violations=$((violations + $?))
            validate_cis_benchmarks || violations=$((violations + $?))
            ;;
        *)
            log "❌ Unknown compliance framework: $COMPLIANCE_FRAMEWORK"
            log "Supported frameworks: SOC2, PCI-DSS, HIPAA, CIS, ALL"
            exit 1
            ;;
    esac

    generate_compliance_report "$COMPLIANCE_FRAMEWORK" "$violations"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
EOF

chmod +x terraform-compliance-validator.sh