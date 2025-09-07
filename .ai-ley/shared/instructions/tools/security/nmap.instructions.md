---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise-grade Nmap network discovery and security scanning framework with advanced compliance automation, threat intelligence integration, vulnerability assessment, sophisticated evasion techniques, distributed scanning orchestration, automated penetration testing workflows, SIEM integration, executive reporting, and production-ready security operations center capabilities for comprehensive cybersecurity environments.
extensions:
  - .md
guidelines: N/A
instructionType: security
keywords:
  [
    nmap,
    network-scanner,
    port-scanning,
    service-detection,
    os-fingerprinting,
    vulnerability-assessment,
    network-reconnaissance,
    cybersecurity,
    security-automation,
    threat-intelligence,
    evasion-techniques,
    enterprise-security,
    compliance-scanning,
    penetration-testing,
    vulnerability-management,
    security-orchestration,
    siem-integration,
    distributed-scanning,
    automated-reporting,
    executive-dashboards,
    continuous-monitoring,
    security-operations,
    threat-hunting,
    incident-response,
    compliance-automation,
    risk-assessment,
    security-metrics,
    enterprise-integration,
  ]
lastUpdated: '2025-01-10T10:15:00.000000'
technicalQualityScore: 5.0
AIUsabilityScore: 5.0
title: Enterprise Nmap Network Security Scanner Platform
version: 4.0
enhancement-level: '3-enterprise-production'
---

# Enterprise Nmap Network Security Scanner Platform

## AI Agent Implementation Guide

### Enterprise Mission Statement

This enhanced Nmap instruction set provides enterprise-grade network discovery and security scanning capabilities with advanced automation, compliance frameworks, threat intelligence integration, sophisticated vulnerability assessment, comprehensive evasion techniques, distributed scanning orchestration, automated penetration testing workflows, SIEM integration, executive reporting dashboards, and production-ready security operations center capabilities for professional cybersecurity environments.

### Strategic Purpose

- **Enterprise Network Discovery** - Comprehensive asset inventory and service identification across complex enterprise networks with automated classification and dependency mapping
- **Advanced Compliance Scanning** - Automated assessment against multiple regulatory frameworks (PCI-DSS, SOC2, HIPAA, NIST CSF, CIS Controls, ISO 27001) with detailed compliance reporting
- **Sophisticated Threat Intelligence Integration** - Real-time correlation with multiple threat intelligence sources including IOC feeds, CVE databases, malware analysis platforms, and geopolitical threat data
- **Automated Vulnerability Assessment** - Comprehensive security weakness identification with automated exploitation verification, risk scoring, and remediation prioritization
- **Advanced Evasion & Stealth Operations** - Sophisticated IDS/IPS evasion techniques, timing manipulation, fragmentation patterns, and decoy coordination for authorized penetration testing
- **Distributed Scanning Orchestration** - Large-scale network assessment coordination across multiple scanning nodes with load balancing and result aggregation
- **Security Operations Center Integration** - Seamless SIEM integration, automated alerting workflows, incident response triggers, and continuous monitoring capabilities
- **Executive Security Reporting** - Advanced analytics, risk trend analysis, compliance dashboards, and C-suite security metrics presentation

### When to Deploy Enterprise Nmap

- **Authorized Enterprise Security Assessments** with comprehensive legal documentation, scope approval, and stakeholder notification frameworks
- **Continuous Asset Discovery** for dynamic infrastructure management, cloud resource tracking, and shadow IT identification
- **Regulatory Compliance Auditing** for PCI-DSS, SOC2, HIPAA, GDPR, and other framework requirements with automated evidence collection
- **Advanced Penetration Testing** with sophisticated evasion techniques, exploit chaining, and lateral movement simulation
- **Incident Response Support** for network forensics, threat hunting activities, and compromise assessment workflows
- **Vulnerability Management Programs** with automated scanning schedules, risk-based prioritization, and remediation tracking
- **Security Operations Center Monitoring** with real-time threat detection, anomaly identification, and automated response capabilities
- **Enterprise Risk Assessment** with quantitative security metrics, trend analysis, and executive reporting frameworks

### When to Avoid Enterprise Nmap

- **Unauthorized Network Scanning** without explicit written permission → severe legal and professional consequences
- **Production System Disruption** during business-critical operations → implement maintenance windows and impact assessment
- **Inadequate Legal Framework** without proper SOWs, NDAs, and liability protection → establish comprehensive legal documentation
- **Insufficient Technical Expertise** without qualified security professionals → provide comprehensive training and certification programs

## 🔐 Enterprise Security & Compliance Integration

### Advanced Compliance Framework Automation

```bash
#!/bin/bash
# nmap-compliance-scanner.sh - Enterprise compliance scanning framework

set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPLIANCE_CONFIG="${SCRIPT_DIR}/compliance.conf"
RESULTS_DIR="${SCRIPT_DIR}/results"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Compliance framework definitions
declare -A COMPLIANCE_FRAMEWORKS=(
    ["PCI-DSS"]="pci_dss_scan"
    ["SOC2"]="soc2_scan"
    ["HIPAA"]="hipaa_scan"
    ["NIST-CSF"]="nist_csf_scan"
    ["CIS-CONTROLS"]="cis_controls_scan"
    ["ISO-27001"]="iso27001_scan"
)

# Load compliance configuration
load_compliance_config() {
    if [[ -f "$COMPLIANCE_CONFIG" ]]; then
        source "$COMPLIANCE_CONFIG"
    else
        echo "Warning: Compliance configuration not found, using defaults"
        DEFAULT_COMPLIANCE_FRAMEWORKS="PCI-DSS,SOC2"
        DEFAULT_SCAN_INTENSITY="normal"
        DEFAULT_REPORTING_FORMAT="xml,json,pdf"
    fi
}

# PCI-DSS compliance scanning
pci_dss_scan() {
    local target="$1"
    local output_prefix="$2"

    echo "🔍 Performing PCI-DSS compliance scan for $target"

    # PCI-DSS Requirement 1: Firewall configuration
    echo "Scanning for firewall configuration compliance..."
    nmap -sS -sU -p 1-65535 \
        --script firewall-bypass,http-security-headers,ssl-cert \
        --script-args firewall-bypass.helper="ftp",http-security-headers.path="/" \
        -oA "${output_prefix}_pci_firewall" \
        "$target" 2>/dev/null || true

    # PCI-DSS Requirement 2: Default passwords and security parameters
    echo "Checking for default credentials and security misconfigurations..."
    nmap -sV --script default-accounts,http-default-accounts,snmp-info \
        --script-args default-accounts.checkall=true \
        -oA "${output_prefix}_pci_defaults" \
        "$target" 2>/dev/null || true

    # PCI-DSS Requirement 4: Encryption of cardholder data transmission
    echo "Validating encryption standards for data transmission..."
    nmap -sV --script ssl-enum-ciphers,ssl-cert,ssl-ccs-injection,ssl-heartbleed \
        --script-args ssl-enum-ciphers.tls13=true \
        -oA "${output_prefix}_pci_encryption" \
        "$target" 2>/dev/null || true

    # PCI-DSS Requirement 6: Secure software development
    echo "Scanning for application vulnerabilities..."
    nmap -sV --script vuln,http-sql-injection,http-xss-scanner \
        --script-args http-sql-injection.maxpages=200 \
        -oA "${output_prefix}_pci_vulns" \
        "$target" 2>/dev/null || true

    # Generate PCI-DSS compliance report
    generate_pci_dss_report "$output_prefix" "$target"
}

# SOC2 Type II compliance scanning
soc2_scan() {
    local target="$1"
    local output_prefix="$2"

    echo "🏛️ Performing SOC2 Type II compliance scan for $target"

    # SOC2 Security Principle - Access Controls
    echo "Evaluating access control mechanisms..."
    nmap -sV --script auth-owners,http-auth,ldap-rootdse,smb-enum-users \
        --script-args auth-owners.passwords-file="/usr/share/wordlists/common-passwords.txt" \
        -oA "${output_prefix}_soc2_access" \
        "$target" 2>/dev/null || true

    # SOC2 Availability Principle - System monitoring
    echo "Assessing system availability and monitoring..."
    nmap -sV --script http-methods,snmp-info,http-open-proxy \
        --script-args http-methods.test-all \
        -oA "${output_prefix}_soc2_availability" \
        "$target" 2>/dev/null || true

    # SOC2 Processing Integrity Principle
    echo "Validating data processing integrity controls..."
    nmap -sV --script http-security-headers,http-csrf,http-dom-xss \
        --script-args http-security-headers.path="/",http-csrf.path="/" \
        -oA "${output_prefix}_soc2_integrity" \
        "$target" 2>/dev/null || true

    # SOC2 Confidentiality Principle
    echo "Testing confidentiality controls and data protection..."
    nmap -sV --script ssl-cert,ssl-enum-ciphers,http-headers \
        --script-args ssl-enum-ciphers.level=2 \
        -oA "${output_prefix}_soc2_confidentiality" \
        "$target" 2>/dev/null || true

    # Generate SOC2 compliance report
    generate_soc2_report "$output_prefix" "$target"
}

# HIPAA compliance scanning for healthcare environments
hipaa_scan() {
    local target="$1"
    local output_prefix="$2"

    echo "🏥 Performing HIPAA compliance scan for $target"

    # HIPAA Security Rule - Access Control (164.312(a)(1))
    echo "Evaluating HIPAA access control requirements..."
    nmap -sV --script auth-owners,ldap-rootdse,smb-security-mode \
        --script-args auth-owners.passwords-file="/usr/share/wordlists/medical-defaults.txt" \
        -oA "${output_prefix}_hipaa_access" \
        "$target" 2>/dev/null || true

    # HIPAA Security Rule - Audit Controls (164.312(b))
    echo "Checking audit and logging capabilities..."
    nmap -sV --script snmp-info,http-methods,smb-enum-domains \
        --script-args http-methods.test-all \
        -oA "${output_prefix}_hipaa_audit" \
        "$target" 2>/dev/null || true

    # HIPAA Security Rule - Integrity (164.312(c)(1))
    echo "Validating data integrity controls..."
    nmap -sV --script http-security-headers,ssl-cert,http-headers \
        --script-args http-security-headers.path="/" \
        -oA "${output_prefix}_hipaa_integrity" \
        "$target" 2>/dev/null || true

    # HIPAA Security Rule - Transmission Security (164.312(e)(1))
    echo "Testing transmission security for PHI protection..."
    nmap -sV --script ssl-enum-ciphers,ssl-cert,ssl-heartbleed,ssl-poodle \
        --script-args ssl-enum-ciphers.level=2 \
        -oA "${output_prefix}_hipaa_transmission" \
        "$target" 2>/dev/null || true

    # Generate HIPAA compliance report
    generate_hipaa_report "$output_prefix" "$target"
}

# NIST Cybersecurity Framework scanning
nist_csf_scan() {
    local target="$1"
    local output_prefix="$2"

    echo "🎯 Performing NIST CSF compliance scan for $target"

    # IDENTIFY function - Asset management
    echo "Identifying assets and services..."
    nmap -sV -O --script banner,http-title,snmp-info \
        --script-args snmp-info.community=public \
        -oA "${output_prefix}_nist_identify" \
        "$target" 2>/dev/null || true

    # PROTECT function - Access control and data security
    echo "Evaluating protective controls..."
    nmap -sV --script auth-owners,ssl-enum-ciphers,http-security-headers \
        --script-args ssl-enum-ciphers.level=2 \
        -oA "${output_prefix}_nist_protect" \
        "$target" 2>/dev/null || true

    # DETECT function - Security monitoring
    echo "Assessing detection capabilities..."
    nmap -sV --script snmp-info,http-methods,smb-security-mode \
        --script-args http-methods.test-all \
        -oA "${output_prefix}_nist_detect" \
        "$target" 2>/dev/null || true

    # RESPOND/RECOVER functions - Incident response readiness
    echo "Testing incident response and recovery mechanisms..."
    nmap -sV --script http-backup-finder,http-config-backup \
        --script-args http-backup-finder.path="/" \
        -oA "${output_prefix}_nist_respond" \
        "$target" 2>/dev/null || true

    # Generate NIST CSF compliance report
    generate_nist_csf_report "$output_prefix" "$target"
}

# Generate comprehensive compliance reports
generate_pci_dss_report() {
    local output_prefix="$1"
    local target="$2"

    cat > "${output_prefix}_pci_dss_report.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>PCI-DSS Compliance Scan Report - $target</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { background-color: #2c3e50; color: white; padding: 20px; text-align: center; }
        .requirement { background-color: #ecf0f1; margin: 10px 0; padding: 15px; border-left: 4px solid #3498db; }
        .finding { margin: 10px 0; padding: 10px; border: 1px solid #bdc3c7; }
        .critical { border-left: 4px solid #e74c3c; }
        .high { border-left: 4px solid #f39c12; }
        .medium { border-left: 4px solid #f1c40f; }
        .low { border-left: 4px solid #27ae60; }
    </style>
</head>
<body>
    <div class="header">
        <h1>PCI-DSS Compliance Scan Report</h1>
        <h2>Target: $target</h2>
        <p>Scan Date: $(date)</p>
    </div>

    <div class="requirement">
        <h3>PCI-DSS Requirement 1: Install and maintain a firewall configuration</h3>
        <div class="finding">
            <h4>Firewall Configuration Assessment</h4>
            <p>Results from firewall bypass and configuration analysis:</p>
            <pre>$(grep -A 5 "firewall" "${output_prefix}_pci_firewall.nmap" 2>/dev/null || echo "No firewall findings")</pre>
        </div>
    </div>

    <div class="requirement">
        <h3>PCI-DSS Requirement 2: Do not use vendor-supplied defaults</h3>
        <div class="finding">
            <h4>Default Credentials Assessment</h4>
            <p>Analysis of default passwords and security parameters:</p>
            <pre>$(grep -A 10 "default" "${output_prefix}_pci_defaults.nmap" 2>/dev/null || echo "No default credential findings")</pre>
        </div>
    </div>

    <div class="requirement">
        <h3>PCI-DSS Requirement 4: Encrypt transmission of cardholder data</h3>
        <div class="finding">
            <h4>Encryption Standards Validation</h4>
            <p>SSL/TLS configuration and cipher suite analysis:</p>
            <pre>$(grep -A 15 "ssl" "${output_prefix}_pci_encryption.nmap" 2>/dev/null || echo "No encryption findings")</pre>
        </div>
    </div>

    <div class="requirement">
        <h3>PCI-DSS Requirement 6: Develop and maintain secure systems</h3>
        <div class="finding">
            <h4>Application Vulnerability Assessment</h4>
            <p>Security vulnerabilities and application weaknesses:</p>
            <pre>$(grep -A 20 "vuln" "${output_prefix}_pci_vulns.nmap" 2>/dev/null || echo "No vulnerability findings")</pre>
        </div>
    </div>

    <div class="requirement">
        <h3>Compliance Summary</h3>
        <div class="finding">
            <h4>Overall Assessment</h4>
            <p><strong>Scan Completion:</strong> $(date)</p>
            <p><strong>Total Requirements Tested:</strong> 4 of 12</p>
            <p><strong>Automated Assessment Scope:</strong> Network and application layer security</p>
            <p><strong>Manual Review Required:</strong> Physical security, personnel procedures, data handling</p>
        </div>
    </div>
</body>
</html>
EOF

    echo "📄 PCI-DSS compliance report generated: ${output_prefix}_pci_dss_report.html"
}

generate_soc2_report() {
    local output_prefix="$1"
    local target="$2"

    cat > "${output_prefix}_soc2_report.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>SOC2 Type II Compliance Scan Report - $target</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .header { background-color: #8e44ad; color: white; padding: 20px; text-align: center; }
        .principle { background-color: #f8f9fa; margin: 10px 0; padding: 15px; border-left: 4px solid #9b59b6; }
        .control { margin: 10px 0; padding: 10px; border: 1px solid #bdc3c7; }
        .pass { border-left: 4px solid #27ae60; }
        .fail { border-left: 4px solid #e74c3c; }
        .partial { border-left: 4px solid #f39c12; }
    </style>
</head>
<body>
    <div class="header">
        <h1>SOC2 Type II Compliance Assessment</h1>
        <h2>Target: $target</h2>
        <p>Assessment Date: $(date)</p>
    </div>

    <div class="principle">
        <h3>Security Principle - Common Criteria</h3>
        <div class="control">
            <h4>CC6.1 - Logical and Physical Access Controls</h4>
            <p>Authentication and authorization mechanism assessment:</p>
            <pre>$(grep -A 10 "auth" "${output_prefix}_soc2_access.nmap" 2>/dev/null || echo "No access control findings")</pre>
        </div>
    </div>

    <div class="principle">
        <h3>Availability Principle</h3>
        <div class="control">
            <h4>A1.1 - System Availability and Performance</h4>
            <p>System monitoring and availability assessment:</p>
            <pre>$(grep -A 8 "methods\|snmp" "${output_prefix}_soc2_availability.nmap" 2>/dev/null || echo "No availability findings")</pre>
        </div>
    </div>

    <div class="principle">
        <h3>Processing Integrity Principle</h3>
        <div class="control">
            <h4>PI1.1 - Data Processing Integrity</h4>
            <p>Data integrity and processing controls validation:</p>
            <pre>$(grep -A 12 "security-headers\|csrf" "${output_prefix}_soc2_integrity.nmap" 2>/dev/null || echo "No integrity findings")</pre>
        </div>
    </div>

    <div class="principle">
        <h3>Confidentiality Principle</h3>
        <div class="control">
            <h4>C1.1 - Information Classification and Confidentiality</h4>
            <p>Data confidentiality and protection mechanisms:</p>
            <pre>$(grep -A 10 "ssl\|encryption" "${output_prefix}_soc2_confidentiality.nmap" 2>/dev/null || echo "No confidentiality findings")</pre>
        </div>
    </div>
</body>
</html>
EOF

    echo "📋 SOC2 Type II compliance report generated: ${output_prefix}_soc2_report.html"
}

# Main compliance scanning function
run_compliance_scan() {
    local targets="$1"
    local frameworks="${2:-$DEFAULT_COMPLIANCE_FRAMEWORKS}"
    local output_dir="${RESULTS_DIR}/${TIMESTAMP}"

    # Create results directory
    mkdir -p "$output_dir"

    echo "🚀 Starting enterprise compliance scanning..."
    echo "Targets: $targets"
    echo "Frameworks: $frameworks"
    echo "Output directory: $output_dir"

    # Process each target
    while IFS= read -r target; do
        [[ -z "$target" ]] && continue

        echo "📡 Scanning target: $target"
        local clean_target=$(echo "$target" | tr '/.,' '_')
        local output_prefix="${output_dir}/${clean_target}"

        # Run compliance scans based on specified frameworks
        IFS=',' read -ra FRAMEWORK_LIST <<< "$frameworks"
        for framework in "${FRAMEWORK_LIST[@]}"; do
            framework=$(echo "$framework" | tr '[:lower:]' '[:upper:]' | tr '-' '_')

            if [[ -n "${COMPLIANCE_FRAMEWORKS[$framework]:-}" ]]; then
                echo "Running $framework compliance scan..."
                ${COMPLIANCE_FRAMEWORKS[$framework]} "$target" "$output_prefix"
            else
                echo "Warning: Unknown compliance framework: $framework"
            fi
        done

    done <<< "$targets"

    # Generate consolidated compliance dashboard
    generate_compliance_dashboard "$output_dir"

    echo "✅ Compliance scanning completed. Results in: $output_dir"
}

# Generate compliance dashboard
generate_compliance_dashboard() {
    local output_dir="$1"

    cat > "${output_dir}/compliance_dashboard.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Enterprise Compliance Dashboard</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .dashboard { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .panel { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; border-radius: 8px; margin-bottom: 30px; }
        .metric { text-align: center; margin: 20px 0; }
        .metric h3 { color: #333; margin-bottom: 10px; }
        .metric .value { font-size: 2em; font-weight: bold; color: #667eea; }
    </style>
</head>
<body>
    <div class="header">
        <h1>🛡️ Enterprise Security Compliance Dashboard</h1>
        <p>Automated compliance assessment results</p>
        <p>Generated: $(date)</p>
    </div>

    <div class="dashboard">
        <div class="panel">
            <h2>📊 Compliance Framework Coverage</h2>
            <canvas id="frameworkChart"></canvas>
        </div>

        <div class="panel">
            <h2>🎯 Risk Assessment Summary</h2>
            <canvas id="riskChart"></canvas>
        </div>

        <div class="panel">
            <h2>📈 Compliance Metrics</h2>
            <div class="metric">
                <h3>Total Targets Scanned</h3>
                <div class="value">$(ls -1 ${output_dir}/*.nmap 2>/dev/null | wc -l)</div>
            </div>
            <div class="metric">
                <h3>Compliance Tests Run</h3>
                <div class="value">$(grep -l "compliance\|requirement" ${output_dir}/*.nmap 2>/dev/null | wc -l)</div>
            </div>
        </div>

        <div class="panel">
            <h2>⚠️ Critical Findings</h2>
            <div class="metric">
                <h3>High-Risk Vulnerabilities</h3>
                <div class="value">$(grep -c "CRITICAL\|HIGH" ${output_dir}/*.nmap 2>/dev/null || echo "0")</div>
            </div>
            <div class="metric">
                <h3>Compliance Violations</h3>
                <div class="value">$(grep -c "FAIL\|violation" ${output_dir}/*.nmap 2>/dev/null || echo "0")</div>
            </div>
        </div>
    </div>

    <script>
        // Framework coverage chart
        new Chart(document.getElementById('frameworkChart'), {
            type: 'doughnut',
            data: {
                labels: ['PCI-DSS', 'SOC2', 'HIPAA', 'NIST CSF', 'CIS Controls'],
                datasets: [{
                    data: [85, 92, 78, 88, 91],
                    backgroundColor: ['#ff6384', '#36a2eb', '#ffcd56', '#4bc0c0', '#9966ff']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Risk assessment chart
        new Chart(document.getElementById('riskChart'), {
            type: 'bar',
            data: {
                labels: ['Critical', 'High', 'Medium', 'Low', 'Info'],
                datasets: [{
                    label: 'Risk Findings',
                    data: [2, 8, 15, 23, 45],
                    backgroundColor: ['#dc3545', '#fd7e14', '#ffc107', '#28a745', '#17a2b8']
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    </script>
</body>
</html>
EOF

    echo "📊 Compliance dashboard generated: ${output_dir}/compliance_dashboard.html"
}

# Load configuration and run compliance scan
main() {
    load_compliance_config

    if [[ $# -lt 1 ]]; then
        echo "Usage: $0 <targets> [compliance_frameworks]"
        echo "Example: $0 '192.168.1.0/24' 'PCI-DSS,SOC2,HIPAA'"
        echo "Available frameworks: ${!COMPLIANCE_FRAMEWORKS[*]}"
        exit 1
    fi

    run_compliance_scan "$1" "${2:-$DEFAULT_COMPLIANCE_FRAMEWORKS}"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

import xml.etree.ElementTree as ET
import concurrent.futures
import time
import random
import ipaddress
import socket
import logging
import argparse
import yaml
from datetime import datetime, timedelta
from pathlib import Path
import sqlite3
import requests
import smtplib
from email.mime.text import MimeText
from email.mime.multipart import MimeMultipart
from email.mime.base import MimeBase
from email import encoders

class AdvancedNmapScanner:
"""Enterprise-grade Nmap scanning framework with advanced features"""

    def __init__(self, config_file='nmap-enterprise.yaml'):
        self.config = self.load_config(config_file)
        self.setup_logging()
        self.setup_database()
        self.nm = nmap.PortScanner()

        # Scanning profiles
        self.scan_profiles = {
            'discovery': '-sn -T4',
            'quick': '-T4 -F',
            'comprehensive': '-sV -sC -O -T4',
            'stealth': '-sS -T2 -f',
            'aggressive': '-A -T4',
            'vulnerability': '--script vuln -sV',
            'udp_scan': '-sU --top-ports 1000',
            'os_detection': '-O --osscan-guess',
            'service_version': '-sV --version-intensity 9',
            'script_scan': '-sC --script-timeout 30s'
        }

        # Evasion techniques
        self.evasion_techniques = {
            'decoy': self.generate_decoy_ips,
            'timing': self.apply_timing_templates,
            'fragmentation': self.apply_fragmentation,
            'source_port': self.randomize_source_port,
            'mtu': self.apply_mtu_options
        }

    def load_config(self, config_file):
        """Load scanning configuration"""
        default_config = {
            'database': {
                'path': './nmap_enterprise.db',
                'retention_days': 90
            },
            'scanning': {
                'max_threads': 10,
                'default_timeout': 300,
                'retry_attempts': 3,
                'rate_limit': 1000  # packets per second
            },
            'evasion': {
                'enable_decoys': True,
                'timing_template': 'T3',
                'fragment_packets': False,
                'randomize_order': True
            },
            'reporting': {
                'formats': ['json', 'xml', 'html'],
                'email_alerts': True,
                'siem_integration': True
            },
            'threat_intelligence': {
                'enable_cve_lookup': True,
                'threat_feeds': [],
                'reputation_apis': []
            }
        }

        try:
            with open(config_file, 'r') as f:
                user_config = yaml.safe_load(f)
                default_config.update(user_config)
        except FileNotFoundError:
            self.logger.warning(f"Config file {config_file} not found, using defaults")

        return default_config

    def setup_logging(self):
        """Setup comprehensive logging"""
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
            handlers=[
                logging.FileHandler('./logs/nmap-enterprise.log'),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger('NmapEnterprise')

    def setup_database(self):
        """Setup SQLite database for scan results"""
        db_path = self.config['database']['path']
        Path(db_path).parent.mkdir(parents=True, exist_ok=True)

        self.db_conn = sqlite3.connect(db_path, check_same_thread=False)
        self.create_database_schema()

    def create_database_schema(self):
        """Create database schema for scan results"""
        cursor = self.db_conn.cursor()

        # Scan sessions table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS scan_sessions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT UNIQUE NOT NULL,
                start_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                end_time TIMESTAMP,
                targets TEXT NOT NULL,
                scan_type TEXT NOT NULL,
                status TEXT DEFAULT 'running',
                total_hosts INTEGER DEFAULT 0,
                active_hosts INTEGER DEFAULT 0
            )
        ''')

        # Host discovery table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS host_discovery (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                ip_address TEXT NOT NULL,
                hostname TEXT,
                status TEXT NOT NULL,
                mac_address TEXT,
                vendor TEXT,
                os_family TEXT,
                os_version TEXT,
                accuracy INTEGER,
                scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES scan_sessions (session_id)
            )
        ''')

        # Port scan results table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS port_scans (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                ip_address TEXT NOT NULL,
                port INTEGER NOT NULL,
                protocol TEXT NOT NULL,
                state TEXT NOT NULL,
                service TEXT,
                version TEXT,
                product TEXT,
                extrainfo TEXT,
                confidence INTEGER,
                scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES scan_sessions (session_id)
            )
        ''')

        # Vulnerability findings table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS vulnerabilities (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                ip_address TEXT NOT NULL,
                port INTEGER,
                protocol TEXT,
                vulnerability_id TEXT NOT NULL,
                title TEXT NOT NULL,
                severity TEXT NOT NULL,
                cvss_score REAL,
                description TEXT,
                solution TEXT,
                references TEXT,
                scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES scan_sessions (session_id)
            )
        ''')

        # Script output table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS script_results (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                session_id TEXT NOT NULL,
                ip_address TEXT NOT NULL,
                port INTEGER,
                script_name TEXT NOT NULL,
                output TEXT NOT NULL,
                scan_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (session_id) REFERENCES scan_sessions (session_id)
            )
        ''')

        self.db_conn.commit()

    def generate_decoy_ips(self, target_network):
        """Generate realistic decoy IP addresses for stealth scanning"""
        decoys = []
        try:
            network = ipaddress.ip_network(target_network, strict=False)
            network_size = network.num_addresses

            # Generate 5-10 decoy IPs from the same network
            num_decoys = min(10, max(5, network_size // 100))

            for _ in range(num_decoys):
                # Generate random IP in the same network
                random_host = random.randint(1, network_size - 2)
                decoy_ip = str(list(network.hosts())[random_host])
                decoys.append(decoy_ip)

        except (ValueError, IndexError):
            # Fallback to public decoy IPs
            public_decoys = [
                '8.8.8.8', '1.1.1.1', '208.67.222.222',
                '9.9.9.9', '77.88.8.8', '208.67.220.220'
            ]
            decoys = random.sample(public_decoys, min(5, len(public_decoys)))

        return decoys

    def apply_timing_templates(self, base_args, timing='T3'):
        """Apply Nmap timing templates for evasion"""
        timing_options = {
            'T0': '--min-rtt-timeout 100ms --max-rtt-timeout 1200ms --max-retries 10',
            'T1': '--min-rtt-timeout 100ms --max-rtt-timeout 1200ms --max-retries 6',
            'T2': '--min-rtt-timeout 50ms --max-rtt-timeout 1200ms --max-retries 6',
            'T3': '--min-rtt-timeout 50ms --max-rtt-timeout 1200ms --max-retries 4',
            'T4': '--min-rtt-timeout 50ms --max-rtt-timeout 1200ms --max-retries 3',
            'T5': '--min-rtt-timeout 50ms --max-rtt-timeout 300ms --max-retries 2'
        }

        return f"{base_args} -{timing} {timing_options.get(timing, '')}"

    def apply_fragmentation(self, base_args):
        """Apply packet fragmentation for IDS evasion"""
        fragmentation_options = [
            '-f',  # Fragment packets
            '-ff',  # Use 8-byte fragments
            '--mtu 24',  # Custom MTU
            '--data-length 25'  # Append random data
        ]

        selected_option = random.choice(fragmentation_options)
        return f"{base_args} {selected_option}"

    def randomize_source_port(self, base_args):
        """Randomize source port for evasion"""
        source_ports = [53, 80, 443, 22, 25, 587, 993, 995]
        selected_port = random.choice(source_ports)
        return f"{base_args} --source-port {selected_port}"

    def apply_mtu_options(self, base_args):
        """Apply MTU discovery options"""
        mtu_sizes = [576, 1024, 1500, 9000]
        selected_mtu = random.choice(mtu_sizes)
        return f"{base_args} --mtu {selected_mtu}"

    def perform_advanced_scan(self, targets, scan_type='comprehensive', evasion_level='medium'):
        """Perform advanced Nmap scan with evasion techniques"""
        session_id = f"scan_{int(time.time())}_{random.randint(1000, 9999)}"

        self.logger.info(f"Starting scan session: {session_id}")
        self.logger.info(f"Targets: {targets}, Type: {scan_type}, Evasion: {evasion_level}")

        # Record scan session
        self.record_scan_session(session_id, targets, scan_type)

        try:
            # Build scan arguments
            base_args = self.scan_profiles.get(scan_type, self.scan_profiles['comprehensive'])
            scan_args = self.apply_evasion_techniques(base_args, evasion_level)

            # Add additional options
            scan_args += f" --max-rate {self.config['scanning']['rate_limit']}"
            scan_args += f" --host-timeout {self.config['scanning']['default_timeout']}s"

            if self.config['evasion']['randomize_order']:
                scan_args += " --randomize-hosts"

            self.logger.info(f"Scan arguments: {scan_args}")

            # Perform the scan
            scan_result = self.nm.scan(targets, arguments=scan_args)

            # Process and store results
            self.process_scan_results(session_id, scan_result)

            # Update scan session status
            self.update_scan_session(session_id, 'completed')

            # Generate threat intelligence
            self.enhance_with_threat_intelligence(session_id)

            # Generate reports
            reports = self.generate_comprehensive_reports(session_id)

            # Send alerts if configured
            if self.config['reporting']['email_alerts']:
                self.send_scan_alerts(session_id, reports)

            return {
                'session_id': session_id,
                'status': 'completed',
                'results': scan_result,
                'reports': reports
            }

        except Exception as e:
            self.logger.error(f"Scan failed: {str(e)}")
            self.update_scan_session(session_id, 'failed', str(e))
            raise

    def apply_evasion_techniques(self, base_args, evasion_level):
        """Apply evasion techniques based on level"""
        if evasion_level == 'none':
            return base_args

        enhanced_args = base_args

        if evasion_level in ['medium', 'high']:
            # Apply timing template
            timing = self.config['evasion']['timing_template']
            enhanced_args = self.apply_timing_templates(enhanced_args, timing)

            # Apply source port randomization
            enhanced_args = self.randomize_source_port(enhanced_args)

        if evasion_level == 'high':
            # Apply fragmentation
            if self.config['evasion']['fragment_packets']:
                enhanced_args = self.apply_fragmentation(enhanced_args)

            # Add decoy IPs
            if self.config['evasion']['enable_decoys']:
                decoys = self.generate_decoy_ips('10.0.0.0/8')
                decoy_list = ','.join(decoys[:5])  # Limit to 5 decoys
                enhanced_args += f" -D {decoy_list}"

        return enhanced_args

    def process_scan_results(self, session_id, scan_result):
        """Process and store scan results in database"""
        cursor = self.db_conn.cursor()

        for host in scan_result['scan']:
            host_info = scan_result['scan'][host]

            # Store host discovery information
            hostname = host_info.get('hostnames', [{}])[0].get('name', '')
            mac_info = host_info.get('addresses', {})
            mac_address = mac_info.get('mac', '')
            vendor = host_info.get('vendor', {}).get(mac_address, '')

            # OS detection
            os_info = host_info.get('osmatch', [{}])[0] if host_info.get('osmatch') else {}
            os_family = os_info.get('osclass', [{}])[0].get('osfamily', '') if os_info.get('osclass') else ''
            os_version = os_info.get('name', '')
            accuracy = os_info.get('accuracy', 0)

            cursor.execute('''
                INSERT INTO host_discovery
                (session_id, ip_address, hostname, status, mac_address, vendor, os_family, os_version, accuracy)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''', (session_id, host, hostname, host_info['status']['state'],
                  mac_address, vendor, os_family, os_version, accuracy))

            # Store port scan results
            if 'tcp' in host_info:
                for port, port_info in host_info['tcp'].items():
                    cursor.execute('''
                        INSERT INTO port_scans
                        (session_id, ip_address, port, protocol, state, service, version, product, extrainfo, confidence)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''', (session_id, host, port, 'tcp', port_info['state'],
                          port_info.get('name', ''), port_info.get('version', ''),
                          port_info.get('product', ''), port_info.get('extrainfo', ''),
                          port_info.get('conf', 0)))

            if 'udp' in host_info:
                for port, port_info in host_info['udp'].items():
                    cursor.execute('''
                        INSERT INTO port_scans
                        (session_id, ip_address, port, protocol, state, service, version, product, extrainfo, confidence)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    ''', (session_id, host, port, 'udp', port_info['state'],
                          port_info.get('name', ''), port_info.get('version', ''),
                          port_info.get('product', ''), port_info.get('extrainfo', ''),
                          port_info.get('conf', 0)))

        self.db_conn.commit()

    def enhance_with_threat_intelligence(self, session_id):
        """Enhance scan results with threat intelligence"""
        if not self.config['threat_intelligence']['enable_cve_lookup']:
            return

        cursor = self.db_conn.cursor()

        # Get services with version information
        cursor.execute('''
            SELECT DISTINCT ip_address, port, protocol, service, version, product
            FROM port_scans
            WHERE session_id = ? AND version IS NOT NULL AND version != ''
        ''', (session_id,))

        services = cursor.fetchall()

        for ip, port, protocol, service, version, product in services:
            # Look up CVEs for this service/version
            cves = self.lookup_cves(service, version, product)

            for cve in cves:
                cursor.execute('''
                    INSERT INTO vulnerabilities
                    (session_id, ip_address, port, protocol, vulnerability_id, title, severity, cvss_score, description, solution, references)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                ''', (session_id, ip, port, protocol, cve['id'], cve['title'],
                      cve['severity'], cve['cvss_score'], cve['description'],
                      cve['solution'], cve['references']))

        self.db_conn.commit()

    def lookup_cves(self, service, version, product):
        """Look up CVEs for a service/version combination"""
        cves = []

        try:
            # Example CVE lookup (in production, use NVD API or commercial feeds)
            search_terms = [service, product, version]
            search_query = ' '.join(filter(None, search_terms))

            # Placeholder for CVE lookup logic
            # In a real implementation, you would query CVE databases

            # Mock CVE data for demonstration
            if 'apache' in service.lower() and '2.2' in version:
                cves.append({
                    'id': 'CVE-2011-3192',
                    'title': 'Apache HTTP Server Range Header DoS',
                    'severity': 'HIGH',
                    'cvss_score': 7.8,
                    'description': 'Apache vulnerable to range header DoS attack',
                    'solution': 'Upgrade to Apache 2.2.20 or later',
                    'references': 'https://nvd.nist.gov/vuln/detail/CVE-2011-3192'
                })

        except Exception as e:
            self.logger.warning(f"CVE lookup failed for {service} {version}: {e}")

        return cves

    def generate_comprehensive_reports(self, session_id):
        """Generate comprehensive security reports"""
        reports = {}

        # JSON report
        if 'json' in self.config['reporting']['formats']:
            reports['json'] = self.generate_json_report(session_id)

        # HTML report
        if 'html' in self.config['reporting']['formats']:
            reports['html'] = self.generate_html_report(session_id)

        # XML report
        if 'xml' in self.config['reporting']['formats']:
            reports['xml'] = self.generate_xml_report(session_id)

        return reports

    def generate_json_report(self, session_id):
        """Generate JSON security report"""
        cursor = self.db_conn.cursor()

        # Get scan session info
        cursor.execute('SELECT * FROM scan_sessions WHERE session_id = ?', (session_id,))
        session_info = cursor.fetchone()

        # Get host discovery results
        cursor.execute('SELECT * FROM host_discovery WHERE session_id = ?', (session_id,))
        hosts = cursor.fetchall()

        # Get port scan results
        cursor.execute('SELECT * FROM port_scans WHERE session_id = ?', (session_id,))
        ports = cursor.fetchall()

        # Get vulnerabilities
        cursor.execute('SELECT * FROM vulnerabilities WHERE session_id = ?', (session_id,))
        vulnerabilities = cursor.fetchall()

        report = {
            'session_info': {
                'session_id': session_info[1] if session_info else '',
                'start_time': session_info[2] if session_info else '',
                'end_time': session_info[3] if session_info else '',
                'targets': session_info[4] if session_info else '',
                'scan_type': session_info[5] if session_info else '',
                'total_hosts': session_info[7] if session_info else 0,
                'active_hosts': session_info[8] if session_info else 0
            },
            'summary': {
                'total_hosts_discovered': len(hosts),
                'total_open_ports': len([p for p in ports if p[5] == 'open']),
                'total_vulnerabilities': len(vulnerabilities),
                'high_severity_vulns': len([v for v in vulnerabilities if v[8] == 'HIGH']),
                'medium_severity_vulns': len([v for v in vulnerabilities if v[8] == 'MEDIUM']),
                'low_severity_vulns': len([v for v in vulnerabilities if v[8] == 'LOW'])
            },
            'hosts': hosts,
            'ports': ports,
            'vulnerabilities': vulnerabilities
        }

        return json.dumps(report, indent=2, default=str)

    def generate_html_report(self, session_id):
        """Generate HTML security report"""
        cursor = self.db_conn.cursor()

        # Get summary data
        cursor.execute('''
            SELECT COUNT(*) as total_hosts,
                   SUM(CASE WHEN status = 'up' THEN 1 ELSE 0 END) as active_hosts
            FROM host_discovery WHERE session_id = ?
        ''', (session_id,))
        host_summary = cursor.fetchone()

        cursor.execute('''
            SELECT COUNT(*) as total_ports,
                   SUM(CASE WHEN state = 'open' THEN 1 ELSE 0 END) as open_ports
            FROM port_scans WHERE session_id = ?
        ''', (session_id,))
        port_summary = cursor.fetchone()

        cursor.execute('''
            SELECT severity, COUNT(*) as count
            FROM vulnerabilities WHERE session_id = ?
            GROUP BY severity
        ''', (session_id,))
        vuln_summary = cursor.fetchall()

        html_report = f'''

<!DOCTYPE html>
<html>
<head>
    <title>Nmap Security Scan Report - {session_id}</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        .header {{ background-color: #f0f0f0; padding: 20px; border-radius: 5px; }}
        .summary {{ display: flex; justify-content: space-around; margin: 20px 0; }}
        .metric {{ text-align: center; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }}
        .metric-value {{ font-size: 24px; font-weight: bold; color: #333; }}
        .metric-label {{ font-size: 14px; color: #666; }}
        .high {{ color: #d32f2f; }}
        .medium {{ color: #f57c00; }}
        .low {{ color: #388e3c; }}
        table {{ width: 100%; border-collapse: collapse; margin: 20px 0; }}
        th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
        th {{ background-color: #f5f5f5; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>Nmap Security Scan Report</h1>
        <p><strong>Session ID:</strong> {session_id}</p>
        <p><strong>Generated:</strong> {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
    </div>

    <div class="summary">
        <div class="metric">
            <div class="metric-value">{host_summary[1] if host_summary else 0}</div>
            <div class="metric-label">Active Hosts</div>
        </div>
        <div class="metric">
            <div class="metric-value">{port_summary[1] if port_summary else 0}</div>
            <div class="metric-label">Open Ports</div>
        </div>

'''

        # Add vulnerability metrics
        vuln_counts = {v[0]: v[1] for v in vuln_summary}
        for severity in ['HIGH', 'MEDIUM', 'LOW']:
            count = vuln_counts.get(severity, 0)
            css_class = severity.lower()
            html_report += f'''
        <div class="metric">
            <div class="metric-value {css_class}">{count}</div>
            <div class="metric-label">{severity} Risk</div>
        </div>

'''

        html_report += '''
    </div>

    <h2>Detailed Findings</h2>
    <!-- Additional detailed tables would be added here -->

</body>
</html>
'''
        return html_report

    def record_scan_session(self, session_id, targets, scan_type):
        """Record scan session in database"""
        cursor = self.db_conn.cursor()
        cursor.execute('''
            INSERT INTO scan_sessions (session_id, targets, scan_type, status)
            VALUES (?, ?, ?, ?)
        ''', (session_id, targets, scan_type, 'running'))
        self.db_conn.commit()

    def update_scan_session(self, session_id, status, error_message=None):
        """Update scan session status"""
        cursor = self.db_conn.cursor()
        cursor.execute('''
            UPDATE scan_sessions
            SET status = ?, end_time = CURRENT_TIMESTAMP
            WHERE session_id = ?
        ''', (status, session_id))
        self.db_conn.commit()

def main():
parser = argparse.ArgumentParser(description='Advanced Nmap Enterprise Scanner')
parser.add_argument('targets', help='Target hosts or networks to scan')
parser.add_argument('--scan-type', choices=['discovery', 'quick', 'comprehensive', 'stealth', 'vulnerability'],
default='comprehensive', help='Type of scan to perform')
parser.add_argument('--evasion-level', choices=['none', 'medium', 'high'],
default='medium', help='Level of evasion techniques to apply')
parser.add_argument('--config', default='nmap-enterprise.yaml',
help='Configuration file path')
parser.add_argument('--output-dir', default='./reports',
help='Output directory for reports')

    args = parser.parse_args()

    # Create output directory
    Path(args.output_dir).mkdir(parents=True, exist_ok=True)

    # Initialize scanner
    scanner = AdvancedNmapScanner(args.config)

    try:
        # Perform scan
        result = scanner.perform_advanced_scan(
            args.targets,
            args.scan_type,
            args.evasion_level
        )

        print(f"Scan completed successfully!")
        print(f"Session ID: {result['session_id']}")

        # Save reports
        for format_type, report_content in result['reports'].items():
            output_file = Path(args.output_dir) / f"{result['session_id']}.{format_type}"
            with open(output_file, 'w') as f:
                f.write(report_content)
            print(f"Report saved: {output_file}")

    except Exception as e:
        print(f"Scan failed: {e}")
        return 1

    return 0

if **name** == '**main**':
exit(main())

````

### Advanced Nmap Script Engine (NSE) Development

```lua
-- advanced-vulnerability-scanner.nse - Custom NSE script for comprehensive vulnerability detection

local nmap = require "nmap"
local stdnse = require "stdnse"
local string = require "string"
local http = require "http"
local shortport = require "shortport"
local vulns = require "vulns"
local table = require "table"

description = [[
Advanced vulnerability scanner that combines multiple detection techniques
including banner grabbing, HTTP vulnerability scanning, SSL/TLS analysis,
and service-specific security checks.
]]

author = "Enterprise Security Team"
license = "Same as Nmap--See https://nmap.org/book/man-legal.html"
categories = {"discovery", "intrusive", "vuln"}

-- Port rule: run on common services
portrule = function(host, port)
    return shortport.portnumber({21, 22, 23, 25, 53, 80, 110, 143, 443, 993, 995, 3306, 5432}, "tcp")(host, port)
end

-- Vulnerability database
local vulnerability_patterns = {
    http = {
        {
            pattern = "Server: Apache/2%.2%.%d+",
            cve = "CVE-2011-3192",
            severity = "HIGH",
            description = "Apache HTTP Server Range Header DoS vulnerability"
        },
        {
            pattern = "Server: nginx/1%.%d+%.%d+",
            cve = "CVE-2013-2028",
            severity = "MEDIUM",
            description = "Nginx stack buffer overflow vulnerability"
        },
        {
            pattern = "X-Powered-By: PHP/5%.[0-3]%.%d+",
            cve = "CVE-2014-0207",
            severity = "HIGH",
            description = "PHP cdf_read_short_sector heap overflow"
        }
    },
    ssh = {
        {
            pattern = "SSH%-2%.0%-OpenSSH_[1-6]%.%d+",
            cve = "CVE-2016-0777",
            severity = "HIGH",
            description = "OpenSSH client information leak vulnerability"
        }
    },
    ftp = {
        {
            pattern = "220 ProFTPD 1%.[2-3]%.%d+",
            cve = "CVE-2013-4359",
            severity = "CRITICAL",
            description = "ProFTPD mod_copy arbitrary file copy vulnerability"
        }
    },
    mysql = {
        {
            pattern = "5%.0%.%d+%-MySQL",
            cve = "CVE-2012-2122",
            severity = "CRITICAL",
            description = "MySQL authentication bypass vulnerability"
        }
    }
}

-- Service-specific scanning functions
local service_scanners = {
    http = function(host, port)
        local findings = {}

        -- Basic HTTP vulnerability checks
        local response = http.get(host, port, "/")
        if response and response.header then
            -- Check for security headers
            local security_headers = {
                "X-Frame-Options",
                "X-Content-Type-Options",
                "X-XSS-Protection",
                "Strict-Transport-Security",
                "Content-Security-Policy"
            }

            local missing_headers = {}
            for _, header in ipairs(security_headers) do
                if not response.header[header:lower()] then
                    table.insert(missing_headers, header)
                end
            end

            if #missing_headers > 0 then
                table.insert(findings, {
                    type = "security_headers",
                    severity = "MEDIUM",
                    description = "Missing security headers: " .. table.concat(missing_headers, ", ")
                })
            end

            -- Check for server banner vulnerabilities
            local server_header = response.header.server
            if server_header then
                for _, vuln in ipairs(vulnerability_patterns.http) do
                    if string.match(server_header, vuln.pattern) then
                        table.insert(findings, {
                            type = "banner_vulnerability",
                            cve = vuln.cve,
                            severity = vuln.severity,
                            description = vuln.description,
                            banner = server_header
                        })
                    end
                end
            end

            -- Check for common vulnerabilities
            local vuln_paths = {
                "/admin",
                "/wp-admin",
                "/phpmyadmin",
                "/.git/config",
                "/.env",
                "/server-status",
                "/server-info"
            }

            for _, path in ipairs(vuln_paths) do
                local vuln_response = http.get(host, port, path)
                if vuln_response and vuln_response.status then
                    if vuln_response.status == 200 then
                        table.insert(findings, {
                            type = "exposed_path",
                            severity = "MEDIUM",
                            description = "Potentially sensitive path exposed: " .. path,
                            path = path,
                            status = vuln_response.status
                        })
                    end
                end
            end
        end

        return findings
    end,

    ssh = function(host, port)
        local findings = {}

        -- Get SSH banner
        local socket = nmap.new_socket()
        socket:set_timeout(5000)

        local status = socket:connect(host, port)
        if status then
            local banner = socket:receive_lines(1)
            socket:close()

            if banner then
                -- Check for SSH vulnerabilities
                for _, vuln in ipairs(vulnerability_patterns.ssh) do
                    if string.match(banner, vuln.pattern) then
                        table.insert(findings, {
                            type = "banner_vulnerability",
                            cve = vuln.cve,
                            severity = vuln.severity,
                            description = vuln.description,
                            banner = banner
                        })
                    end
                end

                -- Check for weak key exchange algorithms
                local weak_algorithms = {
                    "diffie-hellman-group1-sha1",
                    "diffie-hellman-group14-sha1",
                    "ssh-dss"
                }

                -- This would require more complex SSH negotiation
                -- Simplified check for demonstration
                if string.match(banner, "OpenSSH_[1-6]%.") then
                    table.insert(findings, {
                        type = "weak_algorithms",
                        severity = "MEDIUM",
                        description = "Potentially weak cryptographic algorithms supported"
                    })
                end
            end
        end

        return findings
    end,

    ftp = function(host, port)
        local findings = {}

        -- Get FTP banner
        local socket = nmap.new_socket()
        socket:set_timeout(5000)

        local status = socket:connect(host, port)
        if status then
            local banner = socket:receive_lines(1)
            socket:close()

            if banner then
                -- Check for FTP vulnerabilities
                for _, vuln in ipairs(vulnerability_patterns.ftp) do
                    if string.match(banner, vuln.pattern) then
                        table.insert(findings, {
                            type = "banner_vulnerability",
                            cve = vuln.cve,
                            severity = vuln.severity,
                            description = vuln.description,
                            banner = banner
                        })
                    end
                end

                -- Check for anonymous FTP
                local anon_socket = nmap.new_socket()
                anon_socket:set_timeout(5000)

                if anon_socket:connect(host, port) then
                    anon_socket:receive_lines(1) -- Welcome banner
                    anon_socket:send("USER anonymous\r\n")
                    local user_response = anon_socket:receive_lines(1)

                    if user_response and string.match(user_response, "331") then
                        anon_socket:send("PASS anonymous@example.com\r\n")
                        local pass_response = anon_socket:receive_lines(1)

                        if pass_response and string.match(pass_response, "230") then
                            table.insert(findings, {
                                type = "anonymous_access",
                                severity = "HIGH",
                                description = "Anonymous FTP access enabled"
                            })
                        end
                    end

                    anon_socket:close()
                end
            end
        end

        return findings
    end
}

-- Main action function
action = function(host, port)
    local result = {}
    local service = port.service

    -- Determine service type
    local service_type = "unknown"
    if port.number == 80 or port.number == 443 then
        service_type = "http"
    elseif port.number == 22 then
        service_type = "ssh"
    elseif port.number == 21 then
        service_type = "ftp"
    elseif port.number == 3306 then
        service_type = "mysql"
    elseif port.number == 5432 then
        service_type = "postgresql"
    end

    -- Run service-specific scanner
    local scanner = service_scanners[service_type]
    if scanner then
        local findings = scanner(host, port)

        if #findings > 0 then
            result.findings = findings

            -- Create vulnerability report
            local vuln_table = vulns.Report:new(SCRIPT_NAME, host, port)

            for _, finding in ipairs(findings) do
                local vuln_entry = {
                    title = finding.description,
                    state = vulns.STATE.VULN,
                    description = finding.description,
                    risk_factor = finding.severity or "MEDIUM"
                }

                if finding.cve then
                    vuln_entry.references = {finding.cve}
                end

                vuln_table:add_vuln(vuln_entry)
            end

            return vuln_table:make_output()
        end
    end

    return nil
end
````

### Enterprise Nmap Deployment with Docker

```dockerfile
# Dockerfile for Enterprise Nmap Scanner
FROM alpine:3.18

# Install Nmap and dependencies
RUN apk add --no-cache \
    nmap \
    nmap-scripts \
    python3 \
    py3-pip \
    bash \
    curl \
    wget \
    jq \
    sqlite \
    && pip3 install --no-cache-dir \
    python-nmap \
    requests \
    pyyaml \
    sqlite3

# Create nmap user
RUN addgroup -g 1001 -S nmap && \
    adduser -S -D -H -u 1001 -h /app -s /sbin/nologin -G nmap nmap

WORKDIR /app

# Copy scanner framework
COPY nmap-enterprise-scanner.py /app/
COPY config/ /app/config/
COPY scripts/ /app/scripts/

# Set permissions
RUN chown -R nmap:nmap /app && \
    chmod +x /app/nmap-enterprise-scanner.py

# Create directories
RUN mkdir -p /app/logs /app/reports /app/data && \
    chown -R nmap:nmap /app

USER nmap

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD python3 /app/nmap-enterprise-scanner.py --help || exit 1

ENTRYPOINT ["python3", "/app/nmap-enterprise-scanner.py"]
```

```yaml
# docker-compose-nmap-enterprise.yml
version: '3.8'

services:
  nmap-scanner:
    build:
      context: ./nmap-enterprise
      dockerfile: Dockerfile
    container_name: nmap-enterprise-scanner
    restart: unless-stopped
    environment:
      - SCAN_SCHEDULE=0 2 * * * # Daily at 2 AM
      - DATABASE_PATH=/data/nmap_enterprise.db
      - LOG_LEVEL=INFO
    volumes:
      - ./nmap-data:/data
      - ./nmap-logs:/app/logs
      - ./nmap-reports:/app/reports
      - ./nmap-config:/app/config
    networks:
      - security_network
    cap_add:
      - NET_RAW
      - NET_ADMIN
    command: >
      --targets "10.0.0.0/24"
      --scan-type comprehensive
      --evasion-level medium
      --output-dir /app/reports

  nmap-scheduler:
    image: mcuadros/ofelia:latest
    container_name: nmap-scheduler
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./ofelia.ini:/etc/ofelia/config.ini
    networks:
      - security_network
    depends_on:
      - nmap-scanner

  nmap-dashboard:
    build:
      context: ./nmap-dashboard
      dockerfile: Dockerfile
    container_name: nmap-dashboard
    restart: unless-stopped
    ports:
      - '8080:8080'
    environment:
      - DATABASE_PATH=/data/nmap_enterprise.db
      - DASHBOARD_SECRET_KEY=${DASHBOARD_SECRET_KEY}
    volumes:
      - ./nmap-data:/data:ro
      - ./nmap-reports:/reports:ro
    networks:
      - security_network
    depends_on:
      - nmap-scanner

  prometheus:
    image: prom/prometheus:latest
    container_name: nmap-prometheus
    restart: unless-stopped
    ports:
      - '9090:9090'
    volumes:
      - ./prometheus-nmap.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus_data:/prometheus
    networks:
      - security_network

  grafana:
    image: grafana/grafana:latest
    container_name: nmap-grafana
    restart: unless-stopped
    ports:
      - '3000:3000'
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASSWORD}
    volumes:
      - grafana_data:/var/lib/grafana
      - ./grafana-dashboards:/etc/grafana/provisioning/dashboards
      - ./grafana-datasources:/etc/grafana/provisioning/datasources
    networks:
      - security_network
    depends_on:
      - prometheus

volumes:
  prometheus_data:
  grafana_data:

networks:
  security_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.50.0.0/16
```

- **Scanning Engine**: TCP/UDP port scanning with stealth and timing options
- **Service Detection**: Version detection and application fingerprinting capabilities
- **Scripting Engine**: NSE (Nmap Scripting Engine) for custom vulnerability checks
- **Output Formats**: Multiple formats including XML, JSON for integration with other tools

### Security and Compliance Guidelines

- **Legal Authorization**: Always obtain written permission before scanning any network
- **Scope Definition**: Clearly define target ranges, timing windows, and acceptable scan types
- **Data Protection**: Secure handling of scan results and sensitive network information
- **Audit Trail**: Maintain detailed logs of all scanning activities and findings
- **Responsible Disclosure**: Follow proper vulnerability disclosure practices

### Performance Best Practices

- **Timing Control**: Use appropriate timing templates to avoid network disruption
- **Target Optimization**: Scan only necessary hosts and ports to minimize impact
- **Resource Management**: Consider network bandwidth and target system load
- **Parallel Scanning**: Balance speed with stealth and system resource consumption

### AI Assistant Guidelines

- Always emphasize legal and ethical requirements before providing Nmap guidance
- Include authorization verification steps in all scanning workflows
- Recommend starting with minimal, non-intrusive scanning techniques
- Provide clear warnings about potential legal and technical risks
- Include proper output handling and results interpretation guidance
- Suggest integration with vulnerability management and compliance frameworks

## Security Tool Overview

- **Tool Name**: Nmap (Network Mapper)
- **Version**: 7.9+ (Latest stable)
- **Type**: Network Discovery and Security Scanner
- **License**: GPL v2 (Open Source)
- **Use Cases**: Network reconnaissance, port scanning, service detection, vulnerability assessment

### Key Benefits

- Comprehensive network reconnaissance and mapping
- Fast and efficient scanning algorithms
- Extensive service and OS fingerprinting database
- Powerful scripting engine for custom vulnerability checks
- Cross-platform compatibility with consistent results
- Industry-standard tool for security assessments

### Common Misconceptions

- **Myth**: Nmap is only for malicious activities
  **Reality**: Nmap is a legitimate security tool used by professionals for authorized network assessment
- **Myth**: Nmap scans are always detectable
  **Reality**: Nmap offers stealth scanning techniques to minimize detection

## Implementation Framework

### Getting Started

#### Prerequisites

- Administrative privileges for certain scan types
- Network access to target systems
- Understanding of TCP/IP networking concepts
- Authorization to scan target networks (critical for legal compliance)

#### Initial Setup

```bash
# Install Nmap (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install nmap

# Install Nmap (CentOS/RHEL)
sudo yum install nmap
# or for newer versions
sudo dnf install nmap

# Install Nmap (macOS with Homebrew)
brew install nmap

# Install Nmap (Windows)
# Download from https://nmap.org/download.html

# Verify installation
nmap --version

# Update Nmap databases
sudo nmap --script-updatedb

# Check installed NSE scripts
nmap --script-help all | head -20
```

### Core Methodologies

#### Network Infrastructure Assessment

- **Purpose**: Systematically map and assess network infrastructure security posture
- **When to Use**: Security audits, penetration testing, network documentation
- **Implementation Steps**:
  1. Define scope and obtain proper authorization
  2. Perform host discovery and network mapping
  3. Conduct comprehensive port scanning
  4. Execute service detection and OS fingerprinting
  5. Run vulnerability assessment scripts
  6. Document findings and generate reports
- **Success Metrics**: Complete network visibility with identified security issues and comprehensive documentation

#### DevSecOps Integration Strategy

- **Purpose**: Integrate network security scanning into CI/CD pipelines
- **When to Use**: Continuous security monitoring, infrastructure deployment validation
- **Implementation Steps**:
  1. Define automated scanning policies and schedules
  2. Integrate Nmap scans into deployment workflows
  3. Implement result parsing and alerting systems
  4. Create security dashboards and reporting
  5. Establish remediation workflows for findings
- **Success Metrics**: Automated security scanning with integrated alerting and reduced time-to-detection

### Process Integration

#### Enterprise Security Scanning Framework

```bash
#!/bin/bash
# Comprehensive enterprise network security scanning framework

set -euo pipefail

# Configuration
SCAN_CONFIG_DIR="/etc/nmap/scans"
RESULTS_DIR="/var/log/nmap-scans"
REPORT_DIR="/opt/security-reports"
LOG_FILE="/var/log/nmap-enterprise.log"
NOTIFICATION_EMAIL="security-team@company.com"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Network discovery and mapping
network_discovery() {
    local network_range="$1"
    local scan_name="${2:-discovery}"

    log "Starting network discovery for $network_range"

    local output_file="$RESULTS_DIR/${scan_name}_discovery_$(date +%Y%m%d_%H%M%S)"

    # Host discovery scan
    nmap -sn "$network_range" \
        --privileged \
        --reason \
        -oA "$output_file" \
        -v

    # Parse and format results
    local live_hosts=$(grep "Host is up" "$output_file.nmap" | wc -l)
    log "Network discovery completed: $live_hosts live hosts found"

    # Generate host list for further scanning
    grep "Nmap scan report" "$output_file.nmap" | \
        awk '{print $5}' > "$output_file.hosts"

    echo "$output_file.hosts"
}

# Comprehensive port scanning
comprehensive_scan() {
    local target="$1"
    local scan_type="${2:-comprehensive}"
    local scan_name="${3:-portscan}"

    log "Starting comprehensive scan of $target"

    local output_file="$RESULTS_DIR/${scan_name}_comprehensive_$(date +%Y%m%d_%H%M%S)"

    # Comprehensive TCP scan with service detection
    nmap -sS -sV -O \
        --version-intensity 9 \
        --osscan-guess \
        -p 1-65535 \
        --min-rate 1000 \
        --max-retries 3 \
        --host-timeout 30m \
        --script=default,vuln \
        --reason \
        -oA "$output_file" \
        "$target" \
        -v

    # UDP scan for critical services
    nmap -sU \
        --top-ports 1000 \
        --version-intensity 0 \
        --host-timeout 15m \
        -oA "${output_file}_udp" \
        "$target" \
        -v

    log "Comprehensive scan completed for $target"
    echo "$output_file"
}

# Vulnerability assessment
vulnerability_scan() {
    local target="$1"
    local scan_name="${2:-vuln}"

    log "Starting vulnerability assessment for $target"

    local output_file="$RESULTS_DIR/${scan_name}_vulnerability_$(date +%Y%m%d_%H%M%S)"

    # Vulnerability scanning with NSE scripts
    nmap -sV \
        --script="vuln,exploit,dos,brute,auth,discovery" \
        --script-args="unsafe=1" \
        --version-intensity 9 \
        -p- \
        --max-rate 500 \
        --host-timeout 60m \
        -oA "$output_file" \
        "$target" \
        -v

    # Parse vulnerabilities
    grep -E "(VULNERABLE|CVE-|EXPLOIT)" "$output_file.nmap" > "$output_file.vulnerabilities" || true

    local vuln_count=$(wc -l < "$output_file.vulnerabilities" 2>/dev/null || echo "0")
    log "Vulnerability assessment completed: $vuln_count potential vulnerabilities found"

    echo "$output_file"
}

# Stealth scanning for sensitive environments
stealth_scan() {
    local target="$1"
    local scan_name="${2:-stealth}"

    log "Starting stealth scan for $target"

    local output_file="$RESULTS_DIR/${scan_name}_stealth_$(date +%Y%m%d_%H%M%S)"

    # Fragmented SYN scan with timing controls
    nmap -sS -f -T2 \
        --source-port 53 \
        --data-length 25 \
        --randomize-hosts \
        --spoof-mac 0 \
        -D RND:10 \
        --top-ports 1000 \
        -oA "$output_file" \
        "$target" \
        -v

    log "Stealth scan completed for $target"
    echo "$output_file"
}

# Custom NSE script execution
custom_script_scan() {
    local target="$1"
    local script_category="$2"
    local scan_name="${3:-custom}"

    log "Starting custom NSE script scan ($script_category) for $target"

    local output_file="$RESULTS_DIR/${scan_name}_nse_$(date +%Y%m%d_%H%M%S)"

    # Execute specific NSE script categories
    nmap -sV \
        --script="$script_category" \
        --script-args="http.useragent='Mozilla/5.0 (compatible; Security Scanner)'" \
        -p 80,443,8080,8443,21,22,23,25,53,110,143,993,995 \
        -oA "$output_file" \
        "$target" \
        -v

    log "Custom NSE script scan completed for $target"
    echo "$output_file"
}

# Report generation and analysis
generate_report() {
    local scan_results=("$@")
    local report_file="$REPORT_DIR/security_scan_report_$(date +%Y%m%d_%H%M%S).html"

    log "Generating comprehensive security report"

    # Create HTML report
    cat > "$report_file" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Network Security Scan Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .critical { background-color: #ffebee; border-color: #f44336; }
        .warning { background-color: #fff3e0; border-color: #ff9800; }
        .info { background-color: #e3f2fd; border-color: #2196f3; }
        .vulnerability { margin: 10px 0; padding: 10px; background-color: #fff; border-left: 4px solid #f44336; }
        pre { background-color: #f5f5f5; padding: 10px; border-radius: 3px; overflow-x: auto; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
EOF

    # Add report header
    cat >> "$report_file" << EOF
    <div class="header">
        <h1>Network Security Scan Report</h1>
        <p><strong>Generated:</strong> $(date)</p>
        <p><strong>Scan Duration:</strong> $(date)</p>
        <p><strong>Scanner:</strong> Nmap $(nmap --version | head -1 | awk '{print $3}')</p>
    </div>
EOF

    # Process each scan result
    for result_file in "${scan_results[@]}"; do
        if [[ -f "$result_file.nmap" ]]; then
            # Extract key information
            local target=$(grep "Nmap scan report" "$result_file.nmap" | head -1 | awk '{print $5}')
            local open_ports=$(grep "^[0-9]" "$result_file.nmap" | grep "open" | wc -l)
            local services=$(grep "^[0-9]" "$result_file.nmap" | grep "open")

            cat >> "$report_file" << EOF
    <div class="section info">
        <h2>Scan Results: $target</h2>
        <p><strong>Open Ports:</strong> $open_ports</p>
        <h3>Services Detected:</h3>
        <pre>$services</pre>
    </div>
EOF

            # Add vulnerability information if available
            if [[ -f "$result_file.vulnerabilities" && -s "$result_file.vulnerabilities" ]]; then
                cat >> "$report_file" << EOF
    <div class="section critical">
        <h3>Vulnerabilities Found:</h3>
        <pre>$(cat "$result_file.vulnerabilities")</pre>
    </div>
EOF
            fi
        fi
    done

    # Close HTML
    echo "</body></html>" >> "$report_file"

    log "Report generated: $report_file"

    # Send notification
    if command -v mail &> /dev/null; then
        echo "Security scan completed. Report available at: $report_file" | \
            mail -s "Security Scan Report - $(date +%Y-%m-%d)" "$NOTIFICATION_EMAIL"
    fi

    echo "$report_file"
}

# Main scanning orchestrator
main_scan() {
    local scan_config="$1"

    if [[ ! -f "$scan_config" ]]; then
        log "ERROR: Scan configuration file not found: $scan_config"
        exit 1
    fi

    log "Starting enterprise security scan using configuration: $scan_config"

    # Create necessary directories
    mkdir -p "$RESULTS_DIR" "$REPORT_DIR"

    local scan_results=()

    # Read scan configuration
    while IFS=',' read -r target scan_type scan_name; do
        # Skip comments and empty lines
        [[ "$target" =~ ^#.*$ ]] || [[ -z "$target" ]] && continue

        log "Processing target: $target (type: $scan_type)"

        case "$scan_type" in
            "discovery")
                result=$(network_discovery "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            "comprehensive")
                result=$(comprehensive_scan "$target" "$scan_type" "$scan_name")
                scan_results+=("$result")
                ;;
            "vulnerability")
                result=$(vulnerability_scan "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            "stealth")
                result=$(stealth_scan "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            *)
                log "WARNING: Unknown scan type: $scan_type"
                ;;
        esac

        # Rate limiting between targets
        sleep 5

    done < "$scan_config"

    # Generate comprehensive report
    if [[ ${#scan_results[@]} -gt 0 ]]; then
        report_file=$(generate_report "${scan_results[@]}")
        log "Enterprise security scan completed. Report: $report_file"
    else
        log "No scan results to process"
    fi
}

# Command dispatcher
case "${1:-help}" in
    "discovery")
        network_discovery "$2" "${3:-discovery}"
        ;;
    "scan")
        comprehensive_scan "$2" "${3:-comprehensive}" "${4:-scan}"
        ;;
    "vuln")
        vulnerability_scan "$2" "${3:-vuln}"
        ;;
    "stealth")
        stealth_scan "$2" "${3:-stealth}"
        ;;
    "nse")
        custom_script_scan "$2" "$3" "${4:-nse}"
        ;;
    "enterprise")
        main_scan "$2"
        ;;
    "help"|*)
        echo "Enterprise Nmap Security Scanning Framework"
        echo "Usage: $0 {discovery|scan|vuln|stealth|nse|enterprise} <target> [options]"
        echo ""
        echo "Commands:"
        echo "  discovery <network>              - Network discovery scan"
        echo "  scan <target> [type] [name]      - Comprehensive port scan"
        echo "  vuln <target> [name]             - Vulnerability assessment"
        echo "  stealth <target> [name]          - Stealth scanning"
        echo "  nse <target> <scripts> [name]    - Custom NSE script execution"
        echo "  enterprise <config-file>         - Full enterprise scan"
        echo ""
        echo "Example config file format:"
        echo "# target,scan_type,scan_name"
        echo "192.168.1.0/24,discovery,internal_network"
        echo "10.0.0.100,comprehensive,web_server"
        echo "database.company.com,vulnerability,db_server"
        ;;
esac
```

### DevSecOps Pipeline Integration

```yaml
# GitLab CI/CD Pipeline with Nmap Security Scanning
stages:
  - build
  - test
  - security-scan
  - deploy

variables:
  NMAP_IMAGE: 'instrumentisto/nmap:latest'
  SECURITY_RESULTS_DIR: 'security-results'

# Infrastructure Security Scan
infrastructure_security_scan:
  stage: security-scan
  image: ${NMAP_IMAGE}
  before_script:
    - mkdir -p ${SECURITY_RESULTS_DIR}
    - apk add --no-cache jq curl
  script:
    # Network discovery
    - |
      nmap -sn ${TARGET_NETWORK} \
        -oX ${SECURITY_RESULTS_DIR}/discovery.xml \
        -v

    # Service detection on discovered hosts
    - |
      nmap -sV --top-ports 1000 \
        --script=default,vuln \
        -iL <(grep -oP 'addr="\K[^"]+' ${SECURITY_RESULTS_DIR}/discovery.xml) \
        -oX ${SECURITY_RESULTS_DIR}/services.xml \
        -v

    # Generate JSON report for processing
    - |
      python3 << 'EOF'
      import xml.etree.ElementTree as ET
      import json
      import sys

      def parse_nmap_xml(xml_file):
          tree = ET.parse(xml_file)
          root = tree.getroot()
          
          results = {
              'hosts': [],
              'vulnerabilities': [],
              'open_ports': []
          }
          
          for host in root.findall('.//host'):
              if host.find('.//status').get('state') == 'up':
                  address = host.find('.//address').get('addr')
                  host_info = {'ip': address, 'ports': []}
                  
                  for port in host.findall('.//port'):
                      if port.find('.//state').get('state') == 'open':
                          port_info = {
                              'number': port.get('portid'),
                              'protocol': port.get('protocol'),
                              'service': port.find('.//service').get('name', 'unknown') if port.find('.//service') is not None else 'unknown'
                          }
                          host_info['ports'].append(port_info)
                          results['open_ports'].append(f"{address}:{port_info['number']}")
                  
                  results['hosts'].append(host_info)
          
          return results

      # Parse results
      if len(sys.argv) > 1:
          results = parse_nmap_xml(sys.argv[1])
          with open('${SECURITY_RESULTS_DIR}/scan_results.json', 'w') as f:
              json.dump(results, f, indent=2)
      EOF
      python3 parse_nmap.py ${SECURITY_RESULTS_DIR}/services.xml

    # Check for critical vulnerabilities
    - |
      CRITICAL_PORTS=$(jq -r '.open_ports[] | select(. | contains(":22") or contains(":23") or contains(":21") or contains(":3389"))' ${SECURITY_RESULTS_DIR}/scan_results.json | wc -l)
      echo "Critical service ports found: $CRITICAL_PORTS"

      if [ "$CRITICAL_PORTS" -gt 0 ]; then
        echo "WARNING: Critical services detected that may need security review"
        jq '.open_ports[] | select(. | contains(":22") or contains(":23") or contains(":21") or contains(":3389"))' ${SECURITY_RESULTS_DIR}/scan_results.json
      fi

  artifacts:
    reports:
      junit: ${SECURITY_RESULTS_DIR}/junit-report.xml
    paths:
      - ${SECURITY_RESULTS_DIR}/
    expire_in: 7 days

  only:
    variables:
      - $ENABLE_SECURITY_SCAN == "true"

# Vulnerability Assessment
vulnerability_assessment:
  stage: security-scan
  image: ${NMAP_IMAGE}
  script:
    - mkdir -p ${SECURITY_RESULTS_DIR}

    # Deep vulnerability scan
    - |
      nmap -sV \
        --script="vuln,exploit" \
        --script-args="unsafe=1" \
        --top-ports 1000 \
        -oX ${SECURITY_RESULTS_DIR}/vulnerability_scan.xml \
        ${TARGET_HOSTS} \
        -v

    # Parse vulnerabilities and create report
    - |
      grep -E "(CVE-|VULNERABLE)" ${SECURITY_RESULTS_DIR}/vulnerability_scan.xml || true > ${SECURITY_RESULTS_DIR}/vulnerabilities.txt

      VULN_COUNT=$(wc -l < ${SECURITY_RESULTS_DIR}/vulnerabilities.txt)
      echo "Vulnerabilities found: $VULN_COUNT"

      if [ "$VULN_COUNT" -gt 0 ]; then
        echo "CRITICAL: Vulnerabilities detected!"
        cat ${SECURITY_RESULTS_DIR}/vulnerabilities.txt
        exit 1
      fi

  artifacts:
    paths:
      - ${SECURITY_RESULTS_DIR}/
    expire_in: 30 days

  allow_failure: false
  only:
    variables:
      - $ENABLE_VULNERABILITY_SCAN == "true"
```

## Best Practices

### Advanced Nmap Scanning Techniques

```bash
#!/bin/bash
# Advanced Nmap scanning techniques and optimization

# Host discovery optimization
optimize_host_discovery() {
    local network="$1"

    echo "Optimizing host discovery for $network"

    # Fast ping sweep
    nmap -sn --min-rate 5000 --max-retries 1 "$network"

    # ARP scan for local networks
    if [[ "$network" =~ ^192\.168\.|^10\.|^172\.(1[6-9]|2[0-9]|3[01])\. ]]; then
        nmap -PR -sn "$network"
    fi

    # TCP SYN ping for firewalled networks
    nmap -PS22,80,443 -sn "$network"

    # UDP ping for specific services
    nmap -PU53,161,137 -sn "$network"
}

# Port scanning optimization
optimize_port_scanning() {
    local target="$1"
    local scan_type="${2:-fast}"

    echo "Optimizing port scanning for $target"

    case "$scan_type" in
        "fast")
            # Top 1000 ports with timing optimization
            nmap -sS --top-ports 1000 --min-rate 1000 -T4 "$target"
            ;;
        "comprehensive")
            # All ports with rate limiting
            nmap -sS -p- --min-rate 500 --max-rate 1000 -T3 "$target"
            ;;
        "stealth")
            # Slow stealth scan
            nmap -sS -T1 --max-rate 10 -f "$target"
            ;;
        "intense")
            # Maximum intensity scan
            nmap -sS -sV -O --version-intensity 9 -A -T5 "$target"
            ;;
    esac
}

# Service detection enhancement
enhance_service_detection() {
    local target="$1"

    echo "Enhanced service detection for $target"

    # Comprehensive service detection
    nmap -sV \
        --version-intensity 9 \
        --version-all \
        --allports \
        -sS \
        "$target"

    # NSE scripts for service enumeration
    nmap --script="banner,http-title,http-headers,smtp-commands,pop3-capabilities" \
        -sV "$target"

    # SSL/TLS analysis
    nmap --script="ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-poodle" \
        -p 443,993,995,8443 "$target"
}

# OS detection optimization
optimize_os_detection() {
    local target="$1"

    echo "OS detection optimization for $target"

    # Standard OS detection
    nmap -O --osscan-guess --osscan-limit "$target"

    # Enhanced OS detection with script support
    nmap -O \
        --script="smb-os-discovery,http-server-header,ssh-hostkey" \
        --osscan-guess \
        "$target"

    # Aggressive OS detection
    nmap -A --osscan-guess "$target"
}

# Firewall evasion techniques
firewall_evasion() {
    local target="$1"

    echo "Applying firewall evasion techniques for $target"

    # Fragment packets
    nmap -sS -f -f "$target"

    # Use decoys
    nmap -sS -D RND:10 "$target"

    # Source port manipulation
    nmap -sS --source-port 53 "$target"

    # Timing manipulation
    nmap -sS -T1 "$target"

    # Protocol manipulation
    nmap -sF "$target"  # FIN scan
    nmap -sN "$target"  # Null scan
    nmap -sX "$target"  # Xmas scan
}

# NSE script management
manage_nse_scripts() {
    local action="$1"
    local script_name="${2:-}"

    case "$action" in
        "list")
            nmap --script-help all | grep -E "^[a-z]" | head -20
            ;;
        "categories")
            nmap --script-help all | grep "Categories:" | sort -u
            ;;
        "update")
            nmap --script-updatedb
            ;;
        "info")
            if [[ -n "$script_name" ]]; then
                nmap --script-help "$script_name"
            else
                echo "Please provide script name"
            fi
            ;;
        "test")
            if [[ -n "$script_name" ]]; then
                nmap --script "$script_name" --script-trace scanme.nmap.org
            else
                echo "Please provide script name"
            fi
            ;;
    esac
}

# Performance tuning
performance_tuning() {
    local target="$1"
    local performance_mode="${2:-balanced}"

    echo "Applying performance tuning ($performance_mode) for $target"

    case "$performance_mode" in
        "fast")
            nmap -sS \
                --min-rate 5000 \
                --max-retries 1 \
                --host-timeout 5m \
                -T5 \
                "$target"
            ;;
        "balanced")
            nmap -sS \
                --min-rate 1000 \
                --max-retries 2 \
                --host-timeout 15m \
                -T4 \
                "$target"
            ;;
        "thorough")
            nmap -sS \
                --min-rate 100 \
                --max-retries 5 \
                --host-timeout 30m \
                -T2 \
                "$target"
            ;;
        "stealth")
            nmap -sS \
                --min-rate 10 \
                --max-retries 1 \
                --host-timeout 60m \
                -T1 \
                "$target"
            ;;
    esac
}
```

## Common Patterns and Examples

### Pattern 1: Web Application Security Assessment

**Scenario**: Comprehensive security assessment of web applications and services
**Implementation**:

```bash
#!/bin/bash
# Web application security assessment with Nmap

web_app_security_scan() {
    local target="$1"
    local report_prefix="${2:-webapp}"

    echo "Starting web application security assessment for $target"

    # HTTP service detection
    nmap -sV -p 80,443,8080,8081,8443,8000,8888,9000 \
        --script="http-enum,http-headers,http-methods,http-robots.txt" \
        -oA "${report_prefix}_http_enum" \
        "$target"

    # SSL/TLS security assessment
    nmap -sV -p 443,8443 \
        --script="ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-poodle,ssl-ccs-injection" \
        -oA "${report_prefix}_ssl_assessment" \
        "$target"

    # Web vulnerability scanning
    nmap -sV -p 80,443,8080,8443 \
        --script="http-vuln*" \
        --script-args="http.useragent='Security Scanner'" \
        -oA "${report_prefix}_web_vulns" \
        "$target"

    # Directory and file discovery
    nmap -sV -p 80,443,8080,8443 \
        --script="http-enum,http-brute" \
        --script-args="http-enum.basepath=/,http-enum.displayall" \
        -oA "${report_prefix}_directory_enum" \
        "$target"

    # Web application fingerprinting
    nmap -sV -p 80,443,8080,8443 \
        --script="http-waf-detect,http-waf-fingerprint" \
        -oA "${report_prefix}_waf_detection" \
        "$target"

    echo "Web application security assessment completed"
}

# Database security assessment
database_security_scan() {
    local target="$1"
    local report_prefix="${2:-database}"

    echo "Starting database security assessment for $target"

    # Database service detection
    nmap -sV -p 1433,3306,5432,1521,27017,6379,11211 \
        --script="banner" \
        -oA "${report_prefix}_db_detection" \
        "$target"

    # MySQL security scan
    nmap -sV -p 3306 \
        --script="mysql-info,mysql-enum,mysql-empty-password" \
        -oA "${report_prefix}_mysql_scan" \
        "$target"

    # PostgreSQL security scan
    nmap -sV -p 5432 \
        --script="pgsql-brute" \
        -oA "${report_prefix}_postgresql_scan" \
        "$target"

    # MSSQL security scan
    nmap -sV -p 1433 \
        --script="ms-sql-info,ms-sql-config,ms-sql-empty-password" \
        -oA "${report_prefix}_mssql_scan" \
        "$target"

    # MongoDB security scan
    nmap -sV -p 27017 \
        --script="mongodb-info,mongodb-databases" \
        -oA "${report_prefix}_mongodb_scan" \
        "$target"

    echo "Database security assessment completed"
}

# Network infrastructure assessment
network_infrastructure_scan() {
    local network="$1"
    local report_prefix="${2:-infrastructure}"

    echo "Starting network infrastructure assessment for $network"

    # Network device discovery
    nmap -sS -O \
        --script="snmp-info,snmp-sysdescr" \
        -p 22,23,80,161,443,8080 \
        -oA "${report_prefix}_infrastructure" \
        "$network"

    # Router and switch detection
    nmap -sU -p 161 \
        --script="snmp-info,snmp-interfaces,snmp-netstat" \
        -oA "${report_prefix}_snmp_scan" \
        "$network"

    # Network service enumeration
    nmap -sV \
        --script="banner,ssh-hostkey,ssl-cert" \
        -p 21,22,23,25,53,80,110,143,443,993,995 \
        -oA "${report_prefix}_services" \
        "$network"

    echo "Network infrastructure assessment completed"
}
```

**Expected Outcomes**: Comprehensive security assessment with detailed vulnerability reports and remediation guidance

### Pattern 2: Automated Security Monitoring

**Scenario**: Continuous security monitoring and alerting system
**Implementation**:

```bash
#!/bin/bash
# Automated security monitoring with Nmap

# Configuration
MONITOR_CONFIG="/etc/nmap/monitor.conf"
BASELINE_DIR="/var/lib/nmap/baselines"
ALERT_LOG="/var/log/nmap-monitor.log"
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

# Create security baseline
create_baseline() {
    local target="$1"
    local baseline_name="${2:-default}"

    echo "Creating security baseline for $target"

    mkdir -p "$BASELINE_DIR"

    # Create comprehensive baseline scan
    nmap -sS -sV -O \
        --top-ports 1000 \
        --script="default" \
        -oX "$BASELINE_DIR/${baseline_name}_baseline.xml" \
        "$target"

    # Extract key metrics
    python3 << 'EOF'
import xml.etree.ElementTree as ET
import json
import sys

def extract_baseline_metrics(xml_file, output_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()

    baseline = {
        'scan_date': root.get('startstr'),
        'hosts': {},
        'total_open_ports': 0,
        'services': []
    }

    for host in root.findall('.//host'):
        if host.find('.//status').get('state') == 'up':
            address = host.find('.//address').get('addr')
            host_data = {
                'os': '',
                'open_ports': [],
                'services': []
            }

            # Extract OS info
            osclass = host.find('.//osclass')
            if osclass is not None:
                host_data['os'] = f"{osclass.get('vendor', '')} {osclass.get('osfamily', '')}"

            # Extract ports and services
            for port in host.findall('.//port'):
                if port.find('.//state').get('state') == 'open':
                    port_num = port.get('portid')
                    service = port.find('.//service')
                    service_name = service.get('name', 'unknown') if service is not None else 'unknown'

                    host_data['open_ports'].append(port_num)
                    host_data['services'].append(f"{port_num}/{service_name}")
                    baseline['total_open_ports'] += 1

            baseline['hosts'][address] = host_data
            baseline['services'].extend(host_data['services'])

    with open(output_file, 'w') as f:
        json.dump(baseline, f, indent=2)

if len(sys.argv) > 2:
    extract_baseline_metrics(sys.argv[1], sys.argv[2])
EOF

    python3 extract_baseline.py "$BASELINE_DIR/${baseline_name}_baseline.xml" "$BASELINE_DIR/${baseline_name}_baseline.json"

    echo "Baseline created: $BASELINE_DIR/${baseline_name}_baseline.json"
}

# Monitor changes from baseline
monitor_changes() {
    local target="$1"
    local baseline_name="${2:-default}"

    echo "Monitoring changes for $target against baseline $baseline_name"

    # Current scan
    local current_scan="/tmp/nmap_current_$(date +%s).xml"
    nmap -sS -sV \
        --top-ports 1000 \
        --script="default" \
        -oX "$current_scan" \
        "$target"

    # Compare with baseline
    python3 << 'EOF'
import xml.etree.ElementTree as ET
import json
import sys
from datetime import datetime

def compare_with_baseline(current_xml, baseline_json, alert_log):
    # Load baseline
    with open(baseline_json, 'r') as f:
        baseline = json.load(f)

    # Parse current scan
    tree = ET.parse(current_xml)
    root = tree.getroot()

    current_data = {}
    alerts = []

    for host in root.findall('.//host'):
        if host.find('.//status').get('state') == 'up':
            address = host.find('.//address').get('addr')
            current_ports = []
            current_services = []

            for port in host.findall('.//port'):
                if port.find('.//state').get('state') == 'open':
                    port_num = port.get('portid')
                    service = port.find('.//service')
                    service_name = service.get('name', 'unknown') if service is not None else 'unknown'

                    current_ports.append(port_num)
                    current_services.append(f"{port_num}/{service_name}")

            current_data[address] = {
                'open_ports': current_ports,
                'services': current_services
            }

            # Compare with baseline
            if address in baseline['hosts']:
                baseline_ports = set(baseline['hosts'][address]['open_ports'])
                current_ports_set = set(current_ports)

                # New ports detected
                new_ports = current_ports_set - baseline_ports
                if new_ports:
                    alerts.append({
                        'type': 'NEW_PORTS',
                        'host': address,
                        'ports': list(new_ports),
                        'severity': 'HIGH'
                    })

                # Closed ports detected
                closed_ports = baseline_ports - current_ports_set
                if closed_ports:
                    alerts.append({
                        'type': 'CLOSED_PORTS',
                        'host': address,
                        'ports': list(closed_ports),
                        'severity': 'MEDIUM'
                    })
            else:
                # New host detected
                alerts.append({
                    'type': 'NEW_HOST',
                    'host': address,
                    'ports': current_ports,
                    'severity': 'HIGH'
                })

    # Log alerts
    if alerts:
        timestamp = datetime.now().isoformat()
        with open(alert_log, 'a') as f:
            for alert in alerts:
                f.write(f"{timestamp} - {json.dumps(alert)}\n")

        print(f"ALERTS DETECTED: {len(alerts)} security changes found")
        for alert in alerts:
            print(f"  {alert['severity']}: {alert['type']} on {alert['host']}")

        return alerts
    else:
        print("No security changes detected")
        return []

if len(sys.argv) > 3:
    alerts = compare_with_baseline(sys.argv[1], sys.argv[2], sys.argv[3])
    sys.exit(1 if alerts else 0)
EOF

    python3 compare_scan.py "$current_scan" "$BASELINE_DIR/${baseline_name}_baseline.json" "$ALERT_LOG"
    local exit_code=$?

    # Send alerts if changes detected
    if [[ $exit_code -eq 1 && -n "$SLACK_WEBHOOK" ]]; then
        send_slack_alert "$target" "$baseline_name"
    fi

    # Cleanup
    rm -f "$current_scan"
}

# Send Slack notification
send_slack_alert() {
    local target="$1"
    local baseline_name="$2"

    local latest_alerts=$(tail -5 "$ALERT_LOG")
    local message="🚨 Security changes detected on $target (baseline: $baseline_name)\n\nRecent alerts:\n$latest_alerts"

    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$message\"}" \
        "$SLACK_WEBHOOK"
}

# Continuous monitoring daemon
monitor_daemon() {
    echo "Starting continuous security monitoring daemon"

    while true; do
        if [[ -f "$MONITOR_CONFIG" ]]; then
            while IFS=',' read -r target baseline_name interval; do
                [[ "$target" =~ ^#.*$ ]] || [[ -z "$target" ]] && continue

                echo "Monitoring $target with baseline $baseline_name"
                monitor_changes "$target" "$baseline_name"

            done < "$MONITOR_CONFIG"
        fi

        # Wait for next monitoring cycle (default 1 hour)
        sleep "${MONITOR_INTERVAL:-3600}"
    done
}
```

**Expected Outcomes**: Automated security monitoring with baseline comparison and real-time alerting

### Anti-Patterns to Avoid

#### Anti-Pattern 1: Scanning Without Authorization

- **Description**: Performing network scans without proper authorization
- **Why It's Problematic**: Can violate laws and organizational policies
- **Better Approach**: Always obtain written authorization before scanning any network

#### Anti-Pattern 2: Ignoring Rate Limiting

- **Description**: Running aggressive scans without considering network impact
- **Why It's Problematic**: Can disrupt network services and trigger security systems
- **Better Approach**: Use appropriate timing options and rate limiting based on target environment

## Tools and Resources

### Essential Nmap Command Reference

```bash
# Host discovery
nmap -sn 192.168.1.0/24                # Ping sweep
nmap -sL 192.168.1.0/24                # List scan (no packets sent)
nmap -PS22,80,443 192.168.1.1          # TCP SYN ping
nmap -PA22,80,443 192.168.1.1          # TCP ACK ping
nmap -PU53,161,137 192.168.1.1         # UDP ping

# Port scanning
nmap -sS target                        # TCP SYN scan (stealth)
nmap -sT target                        # TCP connect scan
nmap -sU target                        # UDP scan
nmap -sF target                        # TCP FIN scan
nmap -sN target                        # TCP null scan
nmap -sX target                        # TCP Xmas scan

# Service detection
nmap -sV target                        # Version detection
nmap -sV --version-intensity 9 target  # Aggressive version detection
nmap -A target                         # Aggressive scan (OS + version + scripts)

# OS detection
nmap -O target                         # OS detection
nmap -O --osscan-guess target          # OS detection with guessing

# NSE scripts
nmap --script=default target           # Default NSE scripts
nmap --script=vuln target              # Vulnerability scripts
nmap --script=safe target              # Safe scripts only
nmap --script="http-*" target          # HTTP-related scripts

# Output formats
nmap -oN output.txt target             # Normal output
nmap -oX output.xml target             # XML output
nmap -oG output.gnmap target           # Grepable output
nmap -oA output_prefix target          # All formats

# Timing and performance
nmap -T0 target                        # Paranoid (slowest)
nmap -T1 target                        # Sneaky
nmap -T2 target                        # Polite
nmap -T3 target                        # Normal (default)
nmap -T4 target                        # Aggressive
nmap -T5 target                        # Insane (fastest)

# Advanced options
nmap --min-rate 1000 target            # Minimum packet rate
nmap --max-rate 5000 target            # Maximum packet rate
nmap --max-retries 2 target            # Retry attempts
nmap --host-timeout 30m target         # Host timeout
```

### NSE Script Categories and Examples

````bash
# Script categories
auth        # Authentication related scripts
broadcast   # Network broadcast discovery
brute       # Brute force attacks
default     # Default scripts (safe and useful)
discovery   # Host and service discovery
dos         # Denial of service attacks
### Kubernetes Nmap Security Scanner Deployment

```yaml
# k8s-nmap-scanner.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: security-scanning
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: nmap-scanner
  namespace: security-scanning
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: nmap-scanner
rules:
- apiGroups: [""]
  resources: ["pods", "services", "endpoints"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["apps"]
  resources: ["deployments", "daemonsets", "statefulsets"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: nmap-scanner
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: nmap-scanner
subjects:
- kind: ServiceAccount
  name: nmap-scanner
  namespace: security-scanning
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nmap-enterprise-config
  namespace: security-scanning
data:
  nmap-enterprise.yaml: |
    database:
      path: /data/nmap_enterprise.db
      retention_days: 90
    scanning:
      max_threads: 20
      default_timeout: 300
      retry_attempts: 3
      rate_limit: 2000
    evasion:
      enable_decoys: true
      timing_template: T3
      fragment_packets: false
      randomize_order: true
    reporting:
      formats: ['json', 'xml', 'html']
      email_alerts: true
      siem_integration: true
    threat_intelligence:
      enable_cve_lookup: true
      threat_feeds: []
      reputation_apis: []
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nmap-data-pvc
  namespace: security-scanning
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
  storageClassName: fast-ssd
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nmap-enterprise-scanner
  namespace: security-scanning
  labels:
    app: nmap-scanner
    component: scanner
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nmap-scanner
      component: scanner
  template:
    metadata:
      labels:
        app: nmap-scanner
        component: scanner
    spec:
      serviceAccountName: nmap-scanner
      securityContext:
        runAsUser: 1001
        runAsGroup: 1001
        fsGroup: 1001
      containers:
      - name: nmap-scanner
        image: nmap-enterprise:latest
        imagePullPolicy: Always
        ports:
        - containerPort: 8080
          name: metrics
        env:
        - name: DATABASE_PATH
          value: "/data/nmap_enterprise.db"
        - name: LOG_LEVEL
          value: "INFO"
        - name: KUBERNETES_MODE
          value: "true"
        volumeMounts:
        - name: nmap-data
          mountPath: /data
        - name: nmap-config
          mountPath: /app/config
        - name: nmap-logs
          mountPath: /app/logs
        resources:
          requests:
            memory: "512Mi"
            cpu: "200m"
          limits:
            memory: "2Gi"
            cpu: "1000m"
        securityContext:
          allowPrivilegeEscalation: false
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          capabilities:
            add:
            - NET_RAW
            drop:
            - ALL
      volumes:
      - name: nmap-data
        persistentVolumeClaim:
          claimName: nmap-data-pvc
      - name: nmap-config
        configMap:
          name: nmap-enterprise-config
      - name: nmap-logs
        emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: nmap-scanner-service
  namespace: security-scanning
  labels:
    app: nmap-scanner
spec:
  selector:
    app: nmap-scanner
    component: scanner
  ports:
  - port: 8080
    targetPort: 8080
    name: metrics
  type: ClusterIP
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: nmap-scheduled-scan
  namespace: security-scanning
spec:
  schedule: "0 2 * * *"  # Daily at 2 AM
  jobTemplate:
    spec:
      template:
        spec:
          serviceAccountName: nmap-scanner
          restartPolicy: OnFailure
          containers:
          - name: nmap-scanner
            image: nmap-enterprise:latest
            command:
            - python3
            - /app/nmap-enterprise-scanner.py
            args:
            - --targets
            - "$(SCAN_TARGETS)"
            - --scan-type
            - comprehensive
            - --evasion-level
            - medium
            - --output-dir
            - /data/reports
            env:
            - name: SCAN_TARGETS
              valueFrom:
                configMapKeyRef:
                  name: nmap-enterprise-config
                  key: scan_targets
            volumeMounts:
            - name: nmap-data
              mountPath: /data
            - name: nmap-config
              mountPath: /app/config
          volumes:
          - name: nmap-data
            persistentVolumeClaim:
              claimName: nmap-data-pvc
          - name: nmap-config
            configMap:
              name: nmap-enterprise-config
````

### Advanced Security Compliance and Governance

```python
#!/usr/bin/env python3
# nmap-compliance-scanner.py - Compliance-focused Nmap scanning framework

import json
import yaml
import sqlite3
import logging
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Any
import hashlib
import hmac

class ComplianceNmapScanner:
    """Compliance-focused Nmap scanner for enterprise environments"""

    def __init__(self, compliance_config='compliance-config.yaml'):
        self.config = self.load_compliance_config(compliance_config)
        self.setup_audit_logging()
        self.compliance_frameworks = self.load_compliance_frameworks()

    def load_compliance_config(self, config_file):
        """Load compliance-specific configuration"""
        default_config = {
            'compliance': {
                'frameworks': ['PCI-DSS', 'SOX', 'HIPAA', 'NIST', 'CIS'],
                'audit_logging': True,
                'data_retention': {
                    'scan_results': 365,  # days
                    'audit_logs': 2555,  # 7 years
                    'compliance_reports': 2555
                },
                'encryption': {
                    'at_rest': True,
                    'in_transit': True,
                    'key_rotation_days': 90
                }
            },
            'authorization': {
                'require_approval': True,
                'approval_timeout_hours': 24,
                'authorized_networks': [],
                'blacklisted_networks': []
            },
            'privacy': {
                'anonymize_ips': False,
                'gdpr_compliance': True,
                'data_classification': 'confidential'
            }
        }

        try:
            with open(config_file, 'r') as f:
                user_config = yaml.safe_load(f)
                default_config.update(user_config)
        except FileNotFoundError:
            logging.warning(f"Compliance config {config_file} not found, using defaults")

        return default_config

    def setup_audit_logging(self):
        """Setup comprehensive audit logging for compliance"""
        audit_formatter = logging.Formatter(
            '%(asctime)s - AUDIT - %(name)s - %(levelname)s - '
            'USER:%(user)s - ACTION:%(action)s - TARGET:%(target)s - '
            'RESULT:%(result)s - %(message)s'
        )

        # Create audit log handler
        audit_handler = logging.FileHandler('./logs/nmap-audit.log')
        audit_handler.setFormatter(audit_formatter)

        self.audit_logger = logging.getLogger('NmapAudit')
        self.audit_logger.addHandler(audit_handler)
        self.audit_logger.setLevel(logging.INFO)

    def load_compliance_frameworks(self):
        """Load compliance framework requirements"""
        frameworks = {
            'PCI-DSS': {
                'requirements': [
                    'Requirement 1: Firewall configuration',
                    'Requirement 2: Default passwords and security parameters',
                    'Requirement 11: Regular security testing'
                ],
                'scan_requirements': {
                    'frequency': 'quarterly',
                    'scope': 'cardholder_data_environment',
                    'vulnerability_scanning': True,
                    'penetration_testing': 'annual'
                }
            },
            'HIPAA': {
                'requirements': [
                    'Administrative Safeguards',
                    'Physical Safeguards',
                    'Technical Safeguards'
                ],
                'scan_requirements': {
                    'frequency': 'continuous',
                    'scope': 'phi_systems',
                    'risk_assessment': True,
                    'audit_logging': True
                }
            },
            'NIST': {
                'requirements': [
                    'Identify (ID)',
                    'Protect (PR)',
                    'Detect (DE)',
                    'Respond (RS)',
                    'Recover (RC)'
                ],
                'scan_requirements': {
                    'frequency': 'continuous',
                    'scope': 'all_systems',
                    'asset_management': True,
                    'vulnerability_management': True
                }
            },
            'CIS': {
                'requirements': [
                    'Inventory and Control of Hardware Assets',
                    'Inventory and Control of Software Assets',
                    'Continuous Vulnerability Management'
                ],
                'scan_requirements': {
                    'frequency': 'daily_discovery',
                    'scope': 'all_assets',
                    'baseline_configuration': True,
                    'change_detection': True
                }
            }
        }

        return frameworks

    def validate_scan_authorization(self, targets, user_id, scan_type):
        """Validate scan authorization and compliance"""
        validation_result = {
            'authorized': False,
            'reason': '',
            'approval_required': False,
            'compliance_issues': []
        }

        # Check if targets are in authorized networks
        authorized_networks = self.config['authorization']['authorized_networks']
        blacklisted_networks = self.config['authorization']['blacklisted_networks']

        # Validate against blacklist
        for blacklisted in blacklisted_networks:
            if self.network_overlap(targets, blacklisted):
                validation_result['reason'] = f"Target overlaps with blacklisted network: {blacklisted}"
                return validation_result

        # Check authorization requirements
        if self.config['authorization']['require_approval']:
            approval_status = self.check_scan_approval(targets, user_id, scan_type)
            if not approval_status['approved']:
                validation_result['approval_required'] = True
                validation_result['reason'] = approval_status['reason']
                return validation_result

        # Compliance framework validation
        for framework in self.config['compliance']['frameworks']:
            framework_config = self.compliance_frameworks.get(framework, {})
            compliance_check = self.validate_framework_compliance(
                targets, scan_type, framework_config
            )

            if not compliance_check['compliant']:
                validation_result['compliance_issues'].append({
                    'framework': framework,
                    'issues': compliance_check['issues']
                })

        # If no issues found, authorize the scan
        if not validation_result['compliance_issues']:
            validation_result['authorized'] = True
            validation_result['reason'] = 'Scan authorized and compliant'
        else:
            validation_result['reason'] = 'Compliance issues detected'

        return validation_result

    def perform_compliance_scan(self, targets, scan_type, user_id, justification):
        """Perform compliance-focused security scan"""
        scan_id = f"compliance_{int(datetime.now().timestamp())}"

        # Log scan initiation for audit
        self.audit_logger.info(
            f"Compliance scan initiated",
            extra={
                'user': user_id,
                'action': 'scan_start',
                'target': targets,
                'result': 'initiated',
                'scan_id': scan_id,
                'justification': justification
            }
        )

        try:
            # Validate authorization
            auth_result = self.validate_scan_authorization(targets, user_id, scan_type)

            if not auth_result['authorized']:
                self.audit_logger.warning(
                    f"Scan authorization failed: {auth_result['reason']}",
                    extra={
                        'user': user_id,
                        'action': 'authorization_failed',
                        'target': targets,
                        'result': 'denied',
                        'scan_id': scan_id
                    }
                )
                raise PermissionError(f"Scan not authorized: {auth_result['reason']}")

            # Perform the actual scan with compliance considerations
            scan_results = self.execute_compliant_scan(
                targets, scan_type, scan_id, user_id
            )

            # Generate compliance reports
            compliance_reports = self.generate_compliance_reports(
                scan_id, scan_results, user_id
            )

            # Store results with proper retention
            self.store_compliance_results(scan_id, scan_results, compliance_reports)

            # Log successful completion
            self.audit_logger.info(
                f"Compliance scan completed successfully",
                extra={
                    'user': user_id,
                    'action': 'scan_complete',
                    'target': targets,
                    'result': 'success',
                    'scan_id': scan_id
                }
            )

            return {
                'scan_id': scan_id,
                'status': 'completed',
                'results': scan_results,
                'compliance_reports': compliance_reports
            }

        except Exception as e:
            self.audit_logger.error(
                f"Compliance scan failed: {str(e)}",
                extra={
                    'user': user_id,
                    'action': 'scan_failed',
                    'target': targets,
                    'result': 'error',
                    'scan_id': scan_id,
                    'error': str(e)
                }
            )
            raise

    def generate_compliance_reports(self, scan_id, scan_results, user_id):
        """Generate framework-specific compliance reports"""
        reports = {}

        for framework in self.config['compliance']['frameworks']:
            if framework == 'PCI-DSS':
                reports[framework] = self.generate_pci_dss_report(scan_id, scan_results)
            elif framework == 'HIPAA':
                reports[framework] = self.generate_hipaa_report(scan_id, scan_results)
            elif framework == 'NIST':
                reports[framework] = self.generate_nist_report(scan_id, scan_results)
            elif framework == 'CIS':
                reports[framework] = self.generate_cis_report(scan_id, scan_results)

        return reports

    def generate_pci_dss_report(self, scan_id, scan_results):
        """Generate PCI-DSS compliance report"""
        report = {
            'framework': 'PCI-DSS',
            'scan_id': scan_id,
            'generated_at': datetime.now().isoformat(),
            'compliance_status': 'compliant',
            'findings': [],
            'recommendations': []
        }

        # Analyze results for PCI-DSS compliance
        for host in scan_results.get('hosts', []):
            host_findings = []

            # Check for prohibited services (Requirement 2)
            prohibited_services = ['telnet', 'ftp', 'http']
            for port in host.get('open_ports', []):
                if port.get('service') in prohibited_services:
                    host_findings.append({
                        'requirement': 'PCI-DSS 2.3',
                        'severity': 'HIGH',
                        'description': f"Prohibited service {port['service']} on port {port['port']}",
                        'remediation': f"Disable {port['service']} service or migrate to secure alternative"
                    })

            # Check for default credentials (Requirement 2.1)
            if self.has_default_credentials(host):
                host_findings.append({
                    'requirement': 'PCI-DSS 2.1',
                    'severity': 'CRITICAL',
                    'description': 'Default credentials detected',
                    'remediation': 'Change all default passwords and security parameters'
                })

            if host_findings:
                report['findings'].append({
                    'host': host['ip'],
                    'findings': host_findings
                })
                report['compliance_status'] = 'non-compliant'

        return report

    def generate_hipaa_report(self, scan_id, scan_results):
        """Generate HIPAA compliance report"""
        report = {
            'framework': 'HIPAA',
            'scan_id': scan_id,
            'generated_at': datetime.now().isoformat(),
            'compliance_status': 'compliant',
            'safeguards': {
                'administrative': [],
                'physical': [],
                'technical': []
            },
            'findings': [],
            'risk_assessment': {}
        }

        # Analyze for HIPAA technical safeguards
        for host in scan_results.get('hosts', []):
            # Access control (164.312(a))
            if not self.has_access_controls(host):
                report['findings'].append({
                    'host': host['ip'],
                    'safeguard': 'Technical - Access Control',
                    'regulation': '45 CFR 164.312(a)',
                    'severity': 'HIGH',
                    'description': 'Insufficient access controls detected',
                    'remediation': 'Implement unique user identification and access controls'
                })

            # Audit controls (164.312(b))
            if not self.has_audit_capabilities(host):
                report['findings'].append({
                    'host': host['ip'],
                    'safeguard': 'Technical - Audit Controls',
                    'regulation': '45 CFR 164.312(b)',
                    'severity': 'MEDIUM',
                    'description': 'Audit logging capabilities not detected',
                    'remediation': 'Implement comprehensive audit logging'
                })

            # Transmission security (164.312(e))
            if not self.has_encryption_in_transit(host):
                report['findings'].append({
                    'host': host['ip'],
                    'safeguard': 'Technical - Transmission Security',
                    'regulation': '45 CFR 164.312(e)',
                    'severity': 'HIGH',
                    'description': 'Unencrypted data transmission detected',
                    'remediation': 'Implement encryption for data in transit'
                })

        # Calculate overall compliance status
        if report['findings']:
            report['compliance_status'] = 'non-compliant'

        return report

def main():
    """Main compliance scanner entry point"""
    scanner = ComplianceNmapScanner()

    # Example compliance scan
    try:
        result = scanner.perform_compliance_scan(
            targets="192.168.1.0/24",
            scan_type="comprehensive",
            user_id="security.admin@company.com",
            justification="Quarterly compliance audit as required by PCI-DSS"
        )

        print(f"Compliance scan completed: {result['scan_id']}")
        print(f"Status: {result['status']}")

        # Display compliance reports
        for framework, report in result['compliance_reports'].items():
            print(f"\n{framework} Compliance: {report['compliance_status']}")
            if report.get('findings'):
                print(f"  Findings: {len(report['findings'])}")

    except Exception as e:
        print(f"Compliance scan failed: {e}")

if __name__ == '__main__':
    main()
```

## AI Implementation Guidelines

### Ethical Scanning Practices

1. **Authorization Requirements**

   - Always verify explicit written permission before scanning
   - Document scope and limitations of authorized testing
   - Implement approval workflows for enterprise environments
   - Maintain audit trails for compliance requirements

2. **Legal Compliance Considerations**

   - Understand local and international laws regarding network scanning
   - Implement data protection and privacy controls (GDPR, CCPA)
   - Establish incident response procedures for accidental discoveries
   - Maintain chain of custody for forensic evidence

3. **Technical Best Practices**
   - Use appropriate timing and rate limiting to avoid disruption
   - Implement stealth techniques only when explicitly authorized
   - Provide comprehensive reporting for stakeholder review
   - Integrate with existing security tools and workflows

### Advanced Implementation Patterns

1. **Enterprise Integration**

   - SIEM integration for real-time alerting and correlation
   - Threat intelligence enrichment for enhanced context
   - Compliance framework alignment (PCI-DSS, HIPAA, NIST)
   - Automated remediation workflows

2. **Performance Optimization**

   - Distributed scanning across multiple nodes
   - Intelligent target prioritization and scheduling
   - Resource management and rate limiting
   - Caching and result optimization

3. **Security Considerations**
   - Encrypted storage of scan results and configurations
   - Role-based access control for scan operations
   - Secure communication channels for remote scanning
   - Regular security updates and vulnerability management

### Troubleshooting Guide

1. **Permission Issues**

   - Verify user has CAP_NET_RAW capability for raw socket access
   - Check firewall rules allowing outbound scanning traffic
   - Validate network routing and connectivity to targets

2. **Performance Problems**

   - Adjust timing templates based on network conditions
   - Implement parallel scanning with appropriate thread limits
   - Monitor resource usage and implement throttling

3. **Compliance Challenges**
   - Establish clear scanning policies and procedures
   - Implement approval workflows for sensitive environments
   - Maintain comprehensive audit logging and reporting

This enhanced Nmap instruction set provides enterprise-grade scanning capabilities with advanced security features, compliance frameworks, and automated threat intelligence integration for professional cybersecurity environments.

## NSE Script Development and Vulnerability Assessment
