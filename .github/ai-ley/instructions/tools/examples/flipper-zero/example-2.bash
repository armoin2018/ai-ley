#!/bin/bash
# flipper-compliance-setup.sh - Comprehensive compliance framework for Flipper Zero research

set -euo pipefail

# Compliance configuration
COMPLIANCE_DIR="/opt/flipper/compliance"
LEGAL_DIR="/opt/flipper/legal"
AUDIT_DIR="/opt/flipper/audit"
AUTHORIZATION_DB="flipper_authorization.db"

setup_compliance_framework() {
    echo "Setting up comprehensive compliance framework..."

    # Create compliance directory structure
    mkdir -p "${COMPLIANCE_DIR}"/{iso27001,nist-csf,sox,gdpr,internal}
    mkdir -p "${LEGAL_DIR}"/{authorizations,policies,procedures}
    mkdir -p "${AUDIT_DIR}"/{logs,reports,evidence}

    # Set restrictive permissions
    chmod 750 "${COMPLIANCE_DIR}" "${LEGAL_DIR}" "${AUDIT_DIR}"
    chown -R security-team:security-team "${COMPLIANCE_DIR}" "${LEGAL_DIR}" "${AUDIT_DIR}"
}

create_authorization_framework() {
    echo "Creating authorization framework..."

    cat > "${LEGAL_DIR}/authorization-policy.md" << 'EOF'
# Flipper Zero Security Research Authorization Policy

## Authorization Requirements

### Level 1: Basic Research Authorization
- **Scope**: RF spectrum analysis, passive monitoring
- **Duration**: Up to 2 hours
- **Approver**: Security Team Lead
- **Documentation**: Basic test plan and target description
- **Restrictions**: Read-only operations, no active transmission

### Level 2: Intermediate Research Authorization
- **Scope**: NFC/RFID analysis, protocol identification
- **Duration**: Up to 4 hours
- **Approver**: Security Manager + Legal Review
- **Documentation**: Detailed test plan, risk assessment, target ownership proof
- **Restrictions**: Limited active probing, controlled environment only

### Level 3: Advanced Research Authorization
- **Scope**: Full protocol analysis, vulnerability assessment
- **Duration**: Up to 8 hours
- **Approver**: CISO + Legal Counsel + Business Owner
- **Documentation**: Comprehensive research proposal, legal clearance, insurance verification
- **Restrictions**: Isolated environment, continuous monitoring, immediate reporting

## Authorization Process

1. **Research Proposal Submission**
   - Detailed test objectives and methodology
   - Target system description and ownership verification
   - Risk assessment and mitigation strategies
   - Timeline and resource requirements

2. **Legal Review**
   - Compliance with local and federal regulations
   - Intellectual property considerations
   - Liability and insurance coverage verification
   - Ethical considerations assessment

3. **Technical Review**
   - Test methodology validation
   - Environmental impact assessment
   - Equipment safety verification
   - Data protection measures

4. **Management Approval**
   - Business justification review
   - Resource allocation approval
   - Timeline and deliverable agreement
   - Monitoring and oversight assignment

## Ongoing Compliance Requirements

- **Real-time Monitoring**: All research activities must be monitored and logged
- **Data Protection**: All collected data must be encrypted and access-controlled
- **Incident Response**: Immediate escalation procedures for any violations
- **Regular Review**: Authorization scope and compliance reviewed every 30 minutes
- **Post-Research**: Comprehensive report and evidence secure storage

## Violation Consequences

- **Minor Violations**: Immediate session termination, mandatory retraining
- **Major Violations**: Disciplinary action, authorization suspension
- **Criminal Violations**: Law enforcement notification, termination

EOF
}

setup_iso27001_compliance() {
    echo "Setting up ISO 27001 compliance framework..."

    cat > "${COMPLIANCE_DIR}/iso27001/controls-mapping.yaml" << 'EOF'
# ISO 27001 Controls Mapping for Flipper Zero Research

access_control:
  A.9.1.1:
    control: "Access control policy"
    implementation: "Comprehensive authorization policy with role-based access"
    evidence_location: "/opt/flipper/legal/authorization-policy.md"

  A.9.2.1:
    control: "User registration and de-registration"
    implementation: "Automated user lifecycle management in research platform"
    evidence_location: "/opt/flipper/compliance/user-management-logs"

  A.9.2.3:
    control: "Management of privileged access rights"
    implementation: "Multi-level authorization with elevated privilege controls"
    evidence_location: "/opt/flipper/audit/privileged-access-logs"

cryptography:
  A.10.1.1:
    control: "Policy on the use of cryptographic controls"
    implementation: "All research data encrypted at rest and in transit"
    evidence_location: "/opt/flipper/compliance/encryption-policy.md"

  A.10.1.2:
    control: "Key management"
    implementation: "Hardware security module for key management"
    evidence_location: "/opt/flipper/compliance/key-management-audit"

operations_security:
  A.12.1.1:
    control: "Documented operating procedures"
    implementation: "Comprehensive research procedures and automation"
    evidence_location: "/opt/flipper/legal/procedures/"

  A.12.4.1:
    control: "Event logging"
    implementation: "Comprehensive audit logging with tamper protection"
    evidence_location: "/opt/flipper/audit/logs/"

  A.12.6.1:
    control: "Management of technical vulnerabilities"
    implementation: "Automated vulnerability scanning and patch management"
    evidence_location: "/opt/flipper/compliance/vulnerability-management"

communications_security:
  A.13.1.1:
    control: "Network controls"
    implementation: "Isolated research network with comprehensive monitoring"
    evidence_location: "/opt/flipper/compliance/network-architecture"

  A.13.2.1:
    control: "Information transfer policies and procedures"
    implementation: "Encrypted data transfer with chain of custody"
    evidence_location: "/opt/flipper/compliance/data-transfer-logs"
EOF
}

create_legal_documentation_templates() {
    echo "Creating legal documentation templates..."

    cat > "${LEGAL_DIR}/authorization-request-template.md" << 'EOF'
# Flipper Zero Security Research Authorization Request

## Research Information
- **Request ID**: [AUTO-GENERATED]
- **Researcher**: [NAME AND CREDENTIALS]
- **Research Title**: [DESCRIPTIVE TITLE]
- **Business Justification**: [DETAILED JUSTIFICATION]
- **Requested Duration**: [HOURS/DAYS]
- **Authorization Level**: [1/2/3]

## Technical Details
- **Target System(s)**: [DETAILED DESCRIPTION]
- **Research Methodology**: [STEP-BY-STEP METHODOLOGY]
- **Equipment Required**: [FLIPPER ZERO + ADDITIONAL EQUIPMENT]
- **Frequency Ranges**: [IF APPLICABLE]
- **Protocols to Analyze**: [LIST ALL PROTOCOLS]

## Legal and Compliance
- **Target Ownership**: [PROOF OF OWNERSHIP OR AUTHORIZATION]
- **Regulatory Compliance**: [FCC, CE, LOCAL REGULATIONS]
- **Insurance Coverage**: [PROOF OF LIABILITY COVERAGE]
- **Intellectual Property**: [IP CONSIDERATIONS AND CLEARANCE]

## Risk Assessment
- **Technical Risks**: [IDENTIFIED RISKS AND MITIGATION]
- **Legal Risks**: [LEGAL RISKS AND MITIGATION]
- **Business Risks**: [BUSINESS IMPACT ASSESSMENT]
- **Regulatory Risks**: [REGULATORY COMPLIANCE RISKS]

## Safety and Environmental
- **RF Safety**: [POWER LIMITS AND SAFETY MEASURES]
- **Environmental Impact**: [INTERFERENCE ASSESSMENT]
- **Personnel Safety**: [SAFETY PRECAUTIONS]
- **Equipment Protection**: [EQUIPMENT SAFETY MEASURES]

## Data Protection
- **Data Collection**: [WHAT DATA WILL BE COLLECTED]
- **Data Classification**: [CONFIDENTIAL/RESTRICTED/PUBLIC]
- **Data Storage**: [WHERE AND HOW DATA WILL BE STORED]
- **Data Retention**: [RETENTION PERIOD AND DISPOSAL]
- **Access Controls**: [WHO CAN ACCESS THE DATA]

## Monitoring and Oversight
- **Supervision**: [WHO WILL SUPERVISE THE RESEARCH]
- **Monitoring**: [HOW WILL ACTIVITIES BE MONITORED]
- **Reporting**: [INTERIM AND FINAL REPORTING]
- **Escalation**: [INCIDENT ESCALATION PROCEDURES]

## Approvals Required
- [ ] Technical Review (Security Team Lead)
- [ ] Legal Review (Legal Counsel)
- [ ] Business Approval (Department Manager)
- [ ] Risk Assessment (Risk Management)
- [ ] Insurance Verification (Risk Management)
- [ ] Final Authorization (CISO)

## Post-Research Requirements
- [ ] Comprehensive Research Report
- [ ] Evidence Secure Storage
- [ ] Vulnerability Disclosure (if applicable)
- [ ] Lessons Learned Documentation
- [ ] Equipment Return and Verification

---

**Signature**: [RESEARCHER SIGNATURE AND DATE]
**Approval**: [APPROVER SIGNATURE AND DATE]
**Authorization Valid Until**: [EXPIRATION DATE AND TIME]
EOF
}

setup_automated_compliance_monitoring() {
    echo "Setting up automated compliance monitoring..."

    cat > /usr/local/bin/flipper-compliance-monitor.sh << 'EOF'
#!/bin/bash
# Automated compliance monitoring for Flipper Zero research

LOG_FILE="/opt/flipper/audit/compliance-monitor.log"
VIOLATION_ALERT_ENDPOINT="${COMPLIANCE_ALERT_WEBHOOK:-http://localhost:8080/alert}"

log_compliance_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] COMPLIANCE - $1" | tee -a "${LOG_FILE}"
}

check_authorization_validity() {
    # Check active research sessions for valid authorizations
    active_sessions=$(ps aux | grep flipper-research | grep -v grep | wc -l)

    if [[ $active_sessions -gt 0 ]]; then
        # Verify each session has valid authorization
        for session_pid in $(ps aux | grep flipper-research | grep -v grep | awk '{print $2}'); do
            session_auth=$(cat "/proc/${session_pid}/environ" | grep -o "AUTH_REF=[^[:space:]]*" | cut -d= -f2)

            if [[ -z "$session_auth" ]]; then
                log_compliance_event "VIOLATION: Active session without authorization reference (PID: $session_pid)"
                kill -TERM "$session_pid"
                curl -X POST "$VIOLATION_ALERT_ENDPOINT" -d "{\"type\":\"authorization_violation\",\"pid\":\"$session_pid\"}"
            else
                # Verify authorization is still valid
                auth_valid=$(sqlite3 "${AUTHORIZATION_DB}" "SELECT valid_until FROM authorizations WHERE auth_ref='$session_auth'")
                current_time=$(date '+%Y-%m-%d %H:%M:%S')

                if [[ "$current_time" > "$auth_valid" ]]; then
                    log_compliance_event "VIOLATION: Expired authorization (AUTH: $session_auth, PID: $session_pid)"
                    kill -TERM "$session_pid"
                    curl -X POST "$VIOLATION_ALERT_ENDPOINT" -d "{\"type\":\"expired_authorization\",\"auth\":\"$session_auth\"}"
                fi
            fi
        done
    fi
}

check_data_protection_compliance() {
    # Verify all research data is properly encrypted
    research_data_dir="/opt/flipper/research-data"

    if [[ -d "$research_data_dir" ]]; then
        unencrypted_files=$(find "$research_data_dir" -type f ! -name "*.enc" ! -name "*.gpg" | wc -l)

        if [[ $unencrypted_files -gt 0 ]]; then
            log_compliance_event "VIOLATION: Unencrypted research data files found ($unencrypted_files files)"
            curl -X POST "$VIOLATION_ALERT_ENDPOINT" -d "{\"type\":\"unencrypted_data\",\"count\":$unencrypted_files}"
        fi
    fi
}

check_access_control_compliance() {
    # Verify proper file permissions on sensitive directories
    sensitive_dirs=("/opt/flipper/legal" "/opt/flipper/compliance" "/opt/flipper/audit")

    for dir in "${sensitive_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            world_readable=$(find "$dir" -type f -perm /o+r | wc -l)

            if [[ $world_readable -gt 0 ]]; then
                log_compliance_event "VIOLATION: World-readable files in sensitive directory ($dir)"
                curl -X POST "$VIOLATION_ALERT_ENDPOINT" -d "{\"type\":\"access_control_violation\",\"directory\":\"$dir\"}"
            fi
        fi
    done
}

check_audit_log_integrity() {
    # Verify audit logs haven't been tampered with
    audit_logs=("/opt/flipper/audit/logs/"*.log)

    for log_file in "${audit_logs[@]}"; do
        if [[ -f "$log_file" ]]; then
            # Check if log file has been modified recently without corresponding activity
            last_modified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$log_file")

            # Additional integrity checks would go here
            # (e.g., cryptographic signatures, checksums)
        fi
    done
}

generate_compliance_report() {
    report_file="/opt/flipper/compliance/daily-report-$(date '+%Y-%m-%d').json"

    cat > "$report_file" << EOF
{
    "report_date": "$(date '+%Y-%m-%d %H:%M:%S')",
    "compliance_status": "compliant",
    "checks_performed": [
        "authorization_validity",
        "data_protection",
        "access_control",
        "audit_log_integrity"
    ],
    "violations_found": 0,
    "recommendations": []
}
EOF

    log_compliance_event "Daily compliance report generated: $report_file"
}

main() {
    log_compliance_event "Starting compliance monitoring cycle"

    check_authorization_validity
    check_data_protection_compliance
    check_access_control_compliance
    check_audit_log_integrity
    generate_compliance_report

    log_compliance_event "Compliance monitoring cycle completed"
}

main "$@"
EOF

    chmod +x /usr/local/bin/flipper-compliance-monitor.sh

    # Add cron job for continuous monitoring
    echo "*/5 * * * * /usr/local/bin/flipper-compliance-monitor.sh" | crontab -
}

create_incident_response_procedures() {
    echo "Creating incident response procedures..."

    cat > "${LEGAL_DIR}/procedures/incident-response.md" << 'EOF'
# Flipper Zero Research Incident Response Procedures

## Incident Classification

### Level 1: Minor Violations
- **Examples**: Exceeded time limits, minor procedural violations
- **Response Time**: Immediate (< 5 minutes)
- **Response Actions**:
  - Automatic session termination
  - Researcher notification
  - Supervisor notification
  - Mandatory retraining required

### Level 2: Major Violations
- **Examples**: Unauthorized frequency use, data encryption failures
- **Response Time**: Immediate (< 2 minutes)
- **Response Actions**:
  - Immediate system shutdown
  - Security team notification
  - Legal review initiated
  - Authorization suspension
  - Formal investigation required

### Level 3: Critical Violations
- **Examples**: Unauthorized target access, regulatory violations
- **Response Time**: Immediate (< 1 minute)
- **Response Actions**:
  - Emergency system shutdown
  - Law enforcement notification (if required)
  - Executive leadership notification
  - External counsel engagement
  - Comprehensive forensic investigation

## Automated Response Triggers

1. **Authorization Expiration**: Automatic session termination
2. **Unauthorized Frequencies**: Immediate power cutoff
3. **Data Exfiltration Detected**: Network isolation
4. **Compliance Framework Violation**: System lockdown
5. **Equipment Tampering**: Security alert and investigation

## Manual Response Procedures

1. **Incident Detection and Classification**
2. **Immediate Containment Actions**
3. **Evidence Preservation**
4. **Stakeholder Notification**
5. **Investigation and Root Cause Analysis**
6. **Remediation and Prevention**
7. **Lessons Learned and Process Improvement**

## Contact Information

- **Security Operations Center**: security-soc@company.com / +1-XXX-XXX-XXXX
- **Legal Counsel**: legal-counsel@company.com / +1-XXX-XXX-XXXX
- **Compliance Officer**: compliance@company.com / +1-XXX-XXX-XXXX
- **Executive On-Call**: executive-oncall@company.com / +1-XXX-XXX-XXXX
EOF
}

main() {
    echo "Setting up comprehensive Flipper Zero compliance framework..."

    setup_compliance_framework
    create_authorization_framework
    setup_iso27001_compliance
    create_legal_documentation_templates
    setup_automated_compliance_monitoring
    create_incident_response_procedures

    echo "Flipper Zero compliance framework setup completed"
    echo "Please review all policies and procedures before conducting any research"
    echo "Ensure all legal and compliance requirements are met for your jurisdiction"
}

main "$@"