---
agentMode: general
applyTo:
  - '**/.husky/**'
  - '**/package.json'
  - '**/.huskyrc*'
  - '**/husky.config.*'
  - '**/.gitignore'
author: AI-LEY
category: Development Tools
description: Enterprise-grade Husky platform with advanced Git hooks automation, security-focused commit validation, comprehensive policy enforcement, automated security scanning integration, enterprise workflow orchestration, and advanced developer productivity optimization for complete enterprise Git workflow management and security automation.
extensions:
  - .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:47.927488'
last_updated: '2025-08-14'
summaryScore: 3.0
tags:
  - husky
  - git-hooks
  - code-quality
  - pre-commit
  - development-workflow
  - automation
  - lint-staged
  - enterprise-security
  - policy-enforcement
  - compliance-validation
  - workflow-orchestration
  - security-automation
  - developer-productivity
title: Husky Enterprise Git Hooks Security & Workflow Automation Platform
version: '2.0'
---

# Husky Enterprise Git Hooks Security & Workflow Automation Platform

## Enterprise Platform Overview

- **Platform Name**: Husky Enterprise Security & Workflow Engine
- **Version**: 2.0+ (Advanced enterprise platform with comprehensive security automation)
- **Category**: Enterprise Development Security & Workflow Orchestration
- **Core Purpose**: Advanced Git hooks automation, security-focused commit validation, policy enforcement, automated security scanning, and comprehensive enterprise workflow orchestration
- **Enterprise Capabilities**: Security validation, compliance enforcement, threat detection, automated remediation, workflow optimization, productivity analytics
- **Prerequisites**: Enterprise Git environment, Node.js 18+, advanced security toolchain integration

# === Enterprise Husky Security & Workflow Automation Framework ===

import logging
import json
import yaml
import os
import re
import subprocess
import hashlib
import sqlite3
from datetime import datetime, timedelta
from typing import Dict, List, Any, Optional, Union, Callable
from pathlib import Path
from dataclasses import dataclass, field
from enum import Enum
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor
import asyncio

logger = logging.getLogger(**name**)

class SecurityThreatLevel(Enum):
"""Security threat levels for Git operations"""
CRITICAL = "CRITICAL"
HIGH = "HIGH"
MEDIUM = "MEDIUM"
LOW = "LOW"
INFO = "INFO"

class WorkflowStage(Enum):
"""Enterprise workflow stages"""
PRE_COMMIT = "pre-commit"
PRE_PUSH = "pre-push"
POST_COMMIT = "post-commit"
POST_MERGE = "post-merge"
PRE_REBASE = "pre-rebase"
COMMIT_MSG = "commit-msg"

class ComplianceFramework(Enum):
"""Compliance frameworks for development workflows"""
SOX = "SOX"
PCI_DSS = "PCI-DSS"
HIPAA = "HIPAA"
GDPR = "GDPR"
ISO_27001 = "ISO-27001"
NIST_CYBERSECURITY = "NIST-Cybersecurity"
SOC2_TYPE2 = "SOC2-Type2"

@dataclass
class EnterpriseRepository:
"""Represents an enterprise Git repository"""
repo_id: str
name: str
path: Path
owner: str
team: str
security_classification: str
compliance_requirements: List[ComplianceFramework]
technology_stack: List[str]
business_criticality: str = "medium"
data_sensitivity: str = "internal"
regulatory_scope: List[str] = field(default_factory=list)

@dataclass
class SecurityPolicy:
"""Enterprise security policy for Git operations"""
policy_id: str
name: str
description: str
threat_level: SecurityThreatLevel
workflow_stages: List[WorkflowStage]
validation_rules: Dict[str, Any]
compliance_frameworks: List[ComplianceFramework]
remediation_actions: List[str]
business_justification: str

@dataclass
class CommitValidationResult:
"""Result of commit validation process"""
commit_hash: str
validation_timestamp: datetime
overall_status: str
security_score: float
compliance_score: float
violations: List[Dict[str, Any]]
security_issues: List[Dict[str, Any]]
performance_metrics: Dict[str, Any]

class EnterpriseHuskySecurityEngine:
"""Advanced enterprise Husky security and workflow automation engine"""

    def __init__(self, config: Dict[str, Any] = None):
        self.config = config or self._load_default_enterprise_config()
        self.security_policies = self._initialize_security_policies()
        self.workflow_engine = self._initialize_workflow_engine()
        self.compliance_validator = self._initialize_compliance_validator()
        self.threat_detector = self._initialize_threat_detector()
        self.analytics_engine = self._initialize_analytics_engine()
        self.db_connection = self._initialize_database()
        logger.info("Enterprise Husky Security Engine initialized")

    def _load_default_enterprise_config(self) -> Dict[str, Any]:
        """Load comprehensive enterprise security configuration"""
        return {
            "security_settings": {
                "threat_detection": True,
                "vulnerability_scanning": True,
                "secret_detection": True,
                "malware_scanning": True,
                "compliance_validation": True,
                "behavioral_analysis": True
            },
            "workflow_automation": {
                "automated_testing": True,
                "code_quality_gates": True,
                "security_scanning": True,
                "compliance_checks": True,
                "dependency_validation": True,
                "performance_testing": True
            },
            "enterprise_integrations": {
                "siem_systems": ["Splunk", "QRadar", "ArcSight", "Sentinel"],
                "security_tools": ["SonarQube", "Veracode", "Checkmarx", "Snyk"],
                "compliance_tools": ["Rapid7", "Qualys", "Nessus", "OpenVAS"],
                "communication_platforms": ["Slack", "Teams", "PagerDuty", "Jira"]
            },
            "performance_optimization": {
                "parallel_execution": True,
                "caching_enabled": True,
                "resource_optimization": True,
                "load_balancing": True
            },
            "monitoring_and_analytics": {
                "performance_metrics": True,
                "security_analytics": True,
                "compliance_reporting": True,
                "developer_productivity": True,
                "executive_dashboards": True
            }
        }

    def setup_enterprise_git_hooks(self, repository: EnterpriseRepository) -> Dict[str, Any]:
        """Setup comprehensive enterprise Git hooks with security automation"""
        logger.info(f"Setting up enterprise Git hooks for {repository.name}")

        setup_result = {
            "repository_id": repository.repo_id,
            "setup_timestamp": datetime.now().isoformat(),
            "hooks_configured": [],
            "security_policies_applied": [],
            "compliance_checks_enabled": [],
            "workflow_automation": {},
            "performance_optimizations": {}
        }

        try:
            # Setup security-focused Git hooks
            security_hooks = self._setup_security_git_hooks(repository)
            setup_result["hooks_configured"].extend(security_hooks)

            # Configure compliance validation hooks
            compliance_hooks = self._setup_compliance_git_hooks(repository)
            setup_result["hooks_configured"].extend(compliance_hooks)

            # Setup workflow automation hooks
            workflow_hooks = self._setup_workflow_automation_hooks(repository)
            setup_result["hooks_configured"].extend(workflow_hooks)

            # Configure performance optimization hooks
            performance_hooks = self._setup_performance_optimization_hooks(repository)
            setup_result["hooks_configured"].extend(performance_hooks)

            # Apply security policies
            applied_policies = self._apply_security_policies(repository)
            setup_result["security_policies_applied"] = applied_policies

            # Enable compliance checks
            compliance_checks = self._enable_compliance_checks(repository)
            setup_result["compliance_checks_enabled"] = compliance_checks

            # Configure workflow automation
            workflow_config = self._configure_workflow_automation(repository)
            setup_result["workflow_automation"] = workflow_config

            # Setup monitoring and analytics
            monitoring_config = self._setup_monitoring_analytics(repository)
            setup_result["monitoring_config"] = monitoring_config

            logger.info(f"Enterprise Git hooks setup completed with {len(setup_result['hooks_configured'])} hooks")

        except Exception as e:
            logger.error(f"Enterprise Git hooks setup failed: {e}")
            setup_result["error"] = str(e)

        return setup_result

    def _setup_security_git_hooks(self, repository: EnterpriseRepository) -> List[str]:
        """Setup security-focused Git hooks"""
        security_hooks = []

        # Pre-commit security validation hook
        pre_commit_security = self._create_pre_commit_security_hook(repository)
        self._install_git_hook(repository.path, "pre-commit", pre_commit_security)
        security_hooks.append("pre-commit-security-validation")

        # Pre-push security scanning hook
        pre_push_security = self._create_pre_push_security_hook(repository)
        self._install_git_hook(repository.path, "pre-push", pre_push_security)
        security_hooks.append("pre-push-security-scanning")

        # Commit message security validation hook
        commit_msg_security = self._create_commit_msg_security_hook(repository)
        self._install_git_hook(repository.path, "commit-msg", commit_msg_security)
        security_hooks.append("commit-msg-security-validation")

        # Post-merge security analysis hook
        post_merge_security = self._create_post_merge_security_hook(repository)
        self._install_git_hook(repository.path, "post-merge", post_merge_security)
        security_hooks.append("post-merge-security-analysis")

        return security_hooks

    def _create_pre_commit_security_hook(self, repository: EnterpriseRepository) -> str:
        """Create comprehensive pre-commit security validation hook"""

        hook_script = f'''#!/bin/sh

# Enterprise Pre-Commit Security Validation Hook

# Repository: {repository.name}

# Security Classification: {repository.security_classification}

# Generated: {datetime.now().isoformat()}

set -e

echo "🛡️ Running Enterprise Security Validation..."

# Initialize security validation

SECURITY_EXIT_CODE=0
TEMP_DIR=$(mktemp -d)
SECURITY_REPORT="$TEMP_DIR/security_report.json"

# Function to log security events

log_security_event() {{
    echo "$(date '+%Y-%m-%d %H:%M:%S') [SECURITY] $1" >> .git/security.log
}}

# Function to send security alerts

send_security_alert() {{
    local severity="$1"
    local message="$2"
    local webhook_url="${{SECURITY_WEBHOOK_URL:-}}"

    if [ -n "$webhook_url" ]; then
        curl -X POST "$webhook_url" \\
            -H "Content-Type: application/json" \\
            -d "{{\\"severity\\": \\"$severity\\", \\"message\\": \\"$message\\", \\"repo\\": \\"{repository.name}\\"}}"
    fi

}}

# 1. Secret Detection Scan

echo "🔍 Scanning for secrets and sensitive data..."
if command -v truffleHog >/dev/null 2>&1; then
if ! truffleHog --json --entropy=False git://. > "$TEMP_DIR/secrets.json" 2>/dev/null; then
        echo "❌ Secret detection scan failed"
        SECURITY_EXIT_CODE=1
    else
        SECRET_COUNT=$(cat "$TEMP_DIR/secrets.json" | jq length 2>/dev/null || echo "0")
        if [ "$SECRET_COUNT" -gt 0 ]; then
echo "🚨 CRITICAL: $SECRET_COUNT secrets detected in commit"
log_security_event "CRITICAL: Secrets detected in commit"
send_security_alert "CRITICAL" "Secrets detected in repository {repository.name}"
SECURITY_EXIT_CODE=1
fi
fi
fi

# 2. Malware and Suspicious Content Scan

echo "🦠 Scanning for malware and suspicious content..."
SUSPICIOUS*PATTERNS=(
"eval\\\\s*\\\\("
"exec\\\\s*\\\\("
"system\\\\s*\\\\("
"shell_exec\\\\s*\\\\("
"\\\\$\\\\{{.*\\\\}\\\\}"
    "\\\\$\\\\(.*\\\\)"
"<script[^>]\_>.\*</script>"
)

for pattern in "${{SUSPICIOUS_PATTERNS[@]}}"; do
    if git diff --cached --name-only | xargs grep -l "$pattern" 2>/dev/null; then
echo "⚠️ Suspicious pattern detected: $pattern"
log_security_event "WARNING: Suspicious pattern detected: $pattern"
SECURITY_EXIT_CODE=1
fi
done

# 3. Dependency Vulnerability Scan

echo "📦 Scanning dependencies for vulnerabilities..."
if [ -f "package.json" ] && command -v npm >/dev/null 2>&1; then
if ! npm audit --audit-level=moderate --json > "$TEMP_DIR/npm_audit.json" 2>/dev/null; then
echo "⚠️ Dependency vulnerabilities detected"
log_security_event "WARNING: Dependency vulnerabilities detected"
fi
fi

if [ -f "requirements.txt" ] && command -v safety >/dev/null 2>&1; then
if ! safety check --json > "$TEMP_DIR/safety_report.json" 2>/dev/null; then
echo "⚠️ Python dependency vulnerabilities detected"
log_security_event "WARNING: Python dependency vulnerabilities detected"
fi
fi

# 4. Code Quality and Security Analysis

echo "⚡ Running code quality and security analysis..."
if command -v sonar-scanner >/dev/null 2>&1; then
sonar-scanner -Dsonar.analysis.mode=preview \\
-Dsonar.report.export.path="$TEMP_DIR/sonar_report.json" \\ > /dev/null 2>&1 || true
fi

# 5. License Compliance Check

echo "📄 Checking license compliance..."
if command -v licensecheck >/dev/null 2>&1; then
licensecheck --json > "$TEMP_DIR/license_report.json" 2>/dev/null || true
fi

# 6. File Permission and Path Validation

echo "🔐 Validating file permissions and paths..."
git diff --cached --name-only | while read file; do # Check for suspicious file paths
if echo "$file" | grep -E "(\\\\.\\\\.|\\\\.git/|/etc/|/root/|\\\\$)" >/dev/null; then
echo "🚨 CRITICAL: Suspicious file path detected: $file"
log_security_event "CRITICAL: Suspicious file path: $file"
SECURITY_EXIT_CODE=1
fi

    # Check for executable files in unexpected locations
    if [ -f "$file" ] && [ -x "$file" ]; then
        case "$file" in
            *.sh|*.bat|*.exe|*.bin) ;;
            *)
                echo "⚠️  Executable file in unexpected location: $file"
                log_security_event "WARNING: Executable file: $file"
                ;;
        esac
    fi

done

# 7. Generate Security Report

echo "📊 Generating security validation report..."
cat > "$SECURITY_REPORT" << EOF
{{
    "repository": "{repository.name}",
    "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
"commit_hash": "$(git rev-parse HEAD)",
"security_classification": "{repository.security_classification}",
"validation_results": {{
        "secret_scan": ${{SECRET_COUNT:-0}},
"malware_scan": "completed",
"dependency_scan": "completed",
"code_quality": "completed",
"license_compliance": "completed",
"file_validation": "completed"
}},
"exit_code": $SECURITY_EXIT_CODE
}}
EOF

# 8. Store security metrics

if [ -f "$SECURITY_REPORT" ]; then
cp "$SECURITY_REPORT" ".git/hooks/security_reports/$(date +%Y%m%d\_%H%M%S)\_pre_commit.json"
fi

# 9. Compliance validation for regulated environments

if [ "{repository.security_classification}" = "restricted" ] || [ "{repository.security_classification}" = "confidential" ]; then
echo "🏛️ Running compliance validation for restricted repository..."

    # Additional compliance checks for regulated environments
    if [ "$SECURITY_EXIT_CODE" -ne 0 ]; then
        echo "🚨 COMPLIANCE FAILURE: Security violations detected in regulated repository"
        log_security_event "COMPLIANCE FAILURE: Security violations in regulated repository"
        send_security_alert "CRITICAL" "Compliance failure in regulated repository {repository.name}"
    fi

fi

# Cleanup

rm -rf "$TEMP_DIR"

# Final security validation result

if [ $SECURITY_EXIT_CODE -eq 0 ]; then
echo "✅ Security validation passed"
log_security_event "SUCCESS: Pre-commit security validation passed"
else
echo "❌ Security validation failed - commit blocked"
log_security_event "FAILURE: Pre-commit security validation failed"
send_security_alert "HIGH" "Pre-commit security validation failed for {repository.name}"
fi

exit $SECURITY_EXIT_CODE
'''

        return hook_script

    def commit_security_analysis(self, repository: EnterpriseRepository, commit_hash: str) -> CommitValidationResult:
        """Perform comprehensive security analysis of a commit"""
        logger.info(f"Analyzing commit security for {commit_hash}")

        try:
            # Extract commit information
            commit_info = self._extract_commit_information(repository, commit_hash)

            # Perform security scans
            security_results = self._perform_comprehensive_security_scan(repository, commit_hash)

            # Validate compliance requirements
            compliance_results = self._validate_compliance_requirements(repository, commit_hash)

            # Analyze code quality and security patterns
            code_analysis = self._analyze_code_security_patterns(repository, commit_hash)

            # Check for threat indicators
            threat_analysis = self._analyze_threat_indicators(repository, commit_hash)

            # Calculate security score
            security_score = self._calculate_security_score(security_results, code_analysis, threat_analysis)

            # Calculate compliance score
            compliance_score = self._calculate_compliance_score(compliance_results)

            # Compile validation result
            validation_result = CommitValidationResult(
                commit_hash=commit_hash,
                validation_timestamp=datetime.now(),
                overall_status="PASS" if security_score >= 8.0 and compliance_score >= 8.0 else "FAIL",
                security_score=security_score,
                compliance_score=compliance_score,
                violations=security_results.get("violations", []),
                security_issues=security_results.get("security_issues", []),
                performance_metrics={
                    "scan_duration": security_results.get("scan_duration", 0),
                    "files_analyzed": security_results.get("files_analyzed", 0),
                    "lines_analyzed": security_results.get("lines_analyzed", 0)
                }
            )

            # Store validation result
            self._store_commit_validation_result(repository, validation_result)

            # Generate alerts if necessary
            if validation_result.overall_status == "FAIL":
                self._generate_security_alerts(repository, validation_result)

            logger.info(f"Security analysis completed with score: {security_score:.1f}/10")

            return validation_result

        except Exception as e:
            logger.error(f"Commit security analysis failed: {e}")
            return CommitValidationResult(
                commit_hash=commit_hash,
                validation_timestamp=datetime.now(),
                overall_status="ERROR",
                security_score=0.0,
                compliance_score=0.0,
                violations=[{"type": "analysis_error", "message": str(e)}],
                security_issues=[],
                performance_metrics={}
            )

    def workflow_orchestration_engine(self, repository: EnterpriseRepository, trigger_event: str) -> Dict[str, Any]:
        """Execute comprehensive workflow orchestration"""
        logger.info(f"Orchestrating workflow for {trigger_event} in {repository.name}")

        orchestration_result = {
            "repository_id": repository.repo_id,
            "trigger_event": trigger_event,
            "orchestration_start": datetime.now().isoformat(),
            "workflows_executed": [],
            "security_validations": [],
            "compliance_checks": [],
            "performance_metrics": {}
        }

        try:
            # Determine workflow stages based on trigger event
            workflow_stages = self._determine_workflow_stages(trigger_event)

            # Execute parallel workflows
            with ThreadPoolExecutor(max_workers=4) as executor:
                workflow_futures = []

                for stage in workflow_stages:
                    future = executor.submit(self._execute_workflow_stage, repository, stage)
                    workflow_futures.append((stage, future))

                # Collect workflow results
                for stage, future in workflow_futures:
                    try:
                        stage_result = future.result(timeout=300)  # 5 minute timeout
                        orchestration_result["workflows_executed"].append({
                            "stage": stage,
                            "result": stage_result,
                            "status": "SUCCESS"
                        })
                    except Exception as e:
                        logger.error(f"Workflow stage {stage} failed: {e}")
                        orchestration_result["workflows_executed"].append({
                            "stage": stage,
                            "error": str(e),
                            "status": "FAILED"
                        })

            # Perform post-workflow analysis
            post_analysis = self._perform_post_workflow_analysis(repository, orchestration_result)
            orchestration_result["post_analysis"] = post_analysis

            orchestration_result["orchestration_end"] = datetime.now().isoformat()

            # Calculate overall success rate
            successful_workflows = len([w for w in orchestration_result["workflows_executed"] if w["status"] == "SUCCESS"])
            total_workflows = len(orchestration_result["workflows_executed"])
            orchestration_result["success_rate"] = (successful_workflows / total_workflows * 100) if total_workflows > 0 else 0

            logger.info(f"Workflow orchestration completed with {orchestration_result['success_rate']:.1f}% success rate")

        except Exception as e:
            logger.error(f"Workflow orchestration failed: {e}")
            orchestration_result["error"] = str(e)

        return orchestration_result

    def _execute_workflow_stage(self, repository: EnterpriseRepository, stage: str) -> Dict[str, Any]:
        """Execute a specific workflow stage"""
        stage_result = {
            "stage": stage,
            "start_time": datetime.now().isoformat(),
            "actions_performed": [],
            "validation_results": [],
            "performance_metrics": {}
        }

        try:
            if stage == "security_validation":
                # Execute comprehensive security validation
                security_result = self._execute_security_validation_workflow(repository)
                stage_result["validation_results"].append(security_result)
                stage_result["actions_performed"].append("security_scan_completed")

            elif stage == "compliance_check":
                # Execute compliance validation workflow
                compliance_result = self._execute_compliance_validation_workflow(repository)
                stage_result["validation_results"].append(compliance_result)
                stage_result["actions_performed"].append("compliance_check_completed")

            elif stage == "code_quality_analysis":
                # Execute code quality analysis workflow
                quality_result = self._execute_code_quality_workflow(repository)
                stage_result["validation_results"].append(quality_result)
                stage_result["actions_performed"].append("code_quality_analysis_completed")

            elif stage == "dependency_validation":
                # Execute dependency security and license validation
                dependency_result = self._execute_dependency_validation_workflow(repository)
                stage_result["validation_results"].append(dependency_result)
                stage_result["actions_performed"].append("dependency_validation_completed")

            elif stage == "performance_testing":
                # Execute performance impact testing
                performance_result = self._execute_performance_testing_workflow(repository)
                stage_result["validation_results"].append(performance_result)
                stage_result["actions_performed"].append("performance_testing_completed")

            elif stage == "threat_intelligence":
                # Execute threat intelligence analysis
                threat_result = self._execute_threat_intelligence_workflow(repository)
                stage_result["validation_results"].append(threat_result)
                stage_result["actions_performed"].append("threat_intelligence_completed")

            stage_result["end_time"] = datetime.now().isoformat()
            stage_result["status"] = "SUCCESS"

        except Exception as e:
            stage_result["error"] = str(e)
            stage_result["status"] = "FAILED"

        return stage_result

    def automated_remediation_system(self, repository: EnterpriseRepository, violation: Dict[str, Any]) -> Dict[str, Any]:
        """Execute automated remediation for security and compliance violations"""
        logger.info(f"Starting automated remediation for {violation['type']}")

        remediation_result = {
            "violation_id": violation.get("id", "unknown"),
            "remediation_start": datetime.now().isoformat(),
            "remediation_type": violation["type"],
            "actions_taken": [],
            "success": False,
            "backup_created": False
        }

        try:
            # Create repository backup
            backup_result = self._create_repository_backup(repository)
            remediation_result["backup_created"] = backup_result["success"]

            # Execute remediation based on violation type
            if violation["type"] == "secret_exposure":
                remediation_result = self._remediate_secret_exposure(remediation_result, violation, repository)
            elif violation["type"] == "vulnerable_dependency":
                remediation_result = self._remediate_vulnerable_dependency(remediation_result, violation, repository)
            elif violation["type"] == "code_quality_violation":
                remediation_result = self._remediate_code_quality_violation(remediation_result, violation, repository)
            elif violation["type"] == "compliance_violation":
                remediation_result = self._remediate_compliance_violation(remediation_result, violation, repository)
            elif violation["type"] == "security_misconfiguration":
                remediation_result = self._remediate_security_misconfiguration(remediation_result, violation, repository)
            elif violation["type"] == "license_violation":
                remediation_result = self._remediate_license_violation(remediation_result, violation, repository)
            else:
                remediation_result = self._remediate_generic_violation(remediation_result, violation, repository)

            # Validate remediation success
            validation_result = self._validate_remediation_success(repository, violation)
            remediation_result["validation_result"] = validation_result
            remediation_result["success"] = validation_result["remediation_successful"]

            # Generate remediation report
            remediation_report = self._generate_remediation_report(remediation_result)
            remediation_result["report"] = remediation_report

            remediation_result["remediation_end"] = datetime.now().isoformat()

            logger.info(f"Automated remediation completed with success: {remediation_result['success']}")

        except Exception as e:
            logger.error(f"Automated remediation failed: {e}")
            remediation_result["error"] = str(e)

        return remediation_result

    def _remediate_secret_exposure(self, result: Dict[str, Any], violation: Dict[str, Any], repository: EnterpriseRepository) -> Dict[str, Any]:
        """Remediate secret exposure violations"""

        exposed_files = violation.get("affected_files", [])
        secret_patterns = violation.get("secret_patterns", [])

        for file_path in exposed_files:
            try:
                file_full_path = repository.path / file_path

                # Read file content
                with open(file_full_path, 'r', encoding='utf-8') as f:
                    content = f.read()

                # Remove or mask secrets
                cleaned_content = content
                for pattern in secret_patterns:
                    # Replace secret values with placeholders
                    cleaned_content = re.sub(
                        pattern["regex"],
                        f"{pattern['key']}=<REDACTED>",
                        cleaned_content
                    )

                # Write cleaned content back
                with open(file_full_path, 'w', encoding='utf-8') as f:
                    f.write(cleaned_content)

                result["actions_taken"].append(f"Removed secrets from {file_path}")

                # Add to .gitignore if it's a config file
                if file_path.endswith(('.env', '.config', '.secret')):
                    gitignore_path = repository.path / '.gitignore'
                    with open(gitignore_path, 'a') as f:
                        f.write(f'\n{file_path}\n')
                    result["actions_taken"].append(f"Added {file_path} to .gitignore")

            except Exception as e:
                result["actions_taken"].append(f"Failed to remediate secrets in {file_path}: {e}")

        # Generate security incident report
        incident_report = self._generate_security_incident_report("secret_exposure", violation, repository)
        result["incident_report"] = incident_report

        return result

    def continuous_security_monitoring(self, repository: EnterpriseRepository) -> Dict[str, Any]:
        """Implement continuous security monitoring for Git operations"""
        logger.info(f"Setting up continuous security monitoring for {repository.name}")

        monitoring_config = {
            "repository_id": repository.repo_id,
            "monitoring_start": datetime.now().isoformat(),
            "monitoring_components": {},
            "alerting_rules": [],
            "automation_triggers": []
        }

        try:
            # Real-time commit monitoring
            commit_monitoring = self._setup_commit_monitoring(repository)
            monitoring_config["monitoring_components"]["commit_monitoring"] = commit_monitoring

            # Branch protection monitoring
            branch_monitoring = self._setup_branch_protection_monitoring(repository)
            monitoring_config["monitoring_components"]["branch_monitoring"] = branch_monitoring

            # Access control monitoring
            access_monitoring = self._setup_access_control_monitoring(repository)
            monitoring_config["monitoring_components"]["access_monitoring"] = access_monitoring

            # Dependency security monitoring
            dependency_monitoring = self._setup_dependency_security_monitoring(repository)
            monitoring_config["monitoring_components"]["dependency_monitoring"] = dependency_monitoring

            # Behavioral anomaly detection
            anomaly_detection = self._setup_behavioral_anomaly_detection(repository)
            monitoring_config["monitoring_components"]["anomaly_detection"] = anomaly_detection

            # Compliance drift monitoring
            compliance_monitoring = self._setup_compliance_drift_monitoring(repository)
            monitoring_config["monitoring_components"]["compliance_monitoring"] = compliance_monitoring

            # Configure alerting rules
            monitoring_config["alerting_rules"] = self._configure_security_alerting_rules(repository)

            # Configure automation triggers
            monitoring_config["automation_triggers"] = self._configure_security_automation_triggers(repository)

            # Start monitoring services
            self._start_security_monitoring_services(monitoring_config)

            logger.info("Continuous security monitoring configured and activated")

        except Exception as e:
            logger.error(f"Continuous security monitoring setup failed: {e}")

        return monitoring_config

    def _setup_commit_monitoring(self, repository: EnterpriseRepository) -> Dict[str, Any]:
        """Setup real-time commit monitoring"""
        return {
            "component": "commit_monitoring",
            "monitoring_scope": [
                "commit_content", "commit_metadata", "file_changes",
                "author_identity", "commit_patterns", "timing_analysis"
            ],
            "detection_rules": [
                {
                    "rule_id": "COMMIT_001",
                    "name": "Large Commit Detection",
                    "condition": "files_changed > 50 OR lines_changed > 1000",
                    "severity": "MEDIUM",
                    "action": "require_additional_review"
                },
                {
                    "rule_id": "COMMIT_002",
                    "name": "Off-Hours Commit Detection",
                    "condition": "commit_time outside business_hours AND author_location != approved_locations",
                    "severity": "HIGH",
                    "action": "security_team_alert"
                },
                {
                    "rule_id": "COMMIT_003",
                    "name": "Binary File Commit Detection",
                    "condition": "binary_files_added > 0 AND file_size > 10MB",
                    "severity": "HIGH",
                    "action": "malware_scan_required"
                }
            ],
            "real_time_analysis": True,
            "historical_pattern_analysis": True,
            "anomaly_detection_enabled": True
        }

    def developer_productivity_analytics(self, repository: EnterpriseRepository, time_period_days: int = 30) -> Dict[str, Any]:
        """Analyze developer productivity impact of Git hooks and security measures"""
        logger.info(f"Analyzing developer productivity for {repository.name}")

        analytics_result = {
            "repository_id": repository.repo_id,
            "analysis_period": time_period_days,
            "analysis_date": datetime.now().isoformat(),
            "productivity_metrics": {},
            "workflow_efficiency": {},
            "security_impact": {},
            "recommendations": []
        }

        try:
            # Analyze commit patterns and velocity
            commit_analytics = self._analyze_commit_patterns(repository, time_period_days)
            analytics_result["productivity_metrics"]["commits"] = commit_analytics

            # Analyze development workflow efficiency
            workflow_analytics = self._analyze_workflow_efficiency(repository, time_period_days)
            analytics_result["workflow_efficiency"] = workflow_analytics

            # Analyze security tooling impact on productivity
            security_impact = self._analyze_security_impact_on_productivity(repository, time_period_days)
            analytics_result["security_impact"] = security_impact

            # Analyze developer satisfaction and friction points
            satisfaction_analytics = self._analyze_developer_satisfaction(repository)
            analytics_result["productivity_metrics"]["satisfaction"] = satisfaction_analytics

            # Analyze automation effectiveness
            automation_analytics = self._analyze_automation_effectiveness(repository, time_period_days)
            analytics_result["productivity_metrics"]["automation"] = automation_analytics

            # Generate productivity recommendations
            recommendations = self._generate_productivity_recommendations(analytics_result)
            analytics_result["recommendations"] = recommendations

            # Calculate overall productivity score
            productivity_score = self._calculate_overall_productivity_score(analytics_result)
            analytics_result["overall_productivity_score"] = productivity_score

            logger.info(f"Productivity analysis completed with score: {productivity_score:.1f}/10")

        except Exception as e:
            logger.error(f"Developer productivity analytics failed: {e}")
            analytics_result["error"] = str(e)

        return analytics_result

    def enterprise_security_dashboard(self, repositories: List[EnterpriseRepository] = None) -> str:
        """Generate comprehensive enterprise Git security dashboard"""
        logger.info("Generating enterprise Git security dashboard")

        if repositories is None:
            repositories = self._get_all_enterprise_repositories()

        # Collect comprehensive security metrics
        dashboard_data = self._collect_security_dashboard_metrics(repositories)

        # Generate HTML dashboard
        dashboard_html = f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Enterprise Git Security & Workflow Dashboard</title>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
            <style>
                :root {{
                    --primary-color: #1f2937;
                    --secondary-color: #059669;
                    --success-color: #10b981;
                    --warning-color: #f59e0b;
                    --danger-color: #ef4444;
                    --dark-bg: #111827;
                    --light-bg: #f9fafb;
                    --card-bg: #ffffff;
                    --text-primary: #111827;
                    --text-secondary: #6b7280;
                }}

                * {{
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }}

                body {{
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                    background: linear-gradient(135deg, var(--light-bg) 0%, #e5e7eb 100%);
                    color: var(--text-primary);
                    line-height: 1.6;
                }}

                .header {{
                    background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                    color: white;
                    padding: 2rem;
                    text-align: center;
                    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                }}

                .header h1 {{
                    font-size: 2.5rem;
                    font-weight: 700;
                    margin-bottom: 0.5rem;
                }}

                .header p {{
                    font-size: 1.1rem;
                    opacity: 0.9;
                }}

                .dashboard-container {{
                    max-width: 1400px;
                    margin: 0 auto;
                    padding: 2rem;
                }}

                .metrics-grid {{
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                    gap: 1.5rem;
                    margin-bottom: 2rem;
                }}

                .metric-card {{
                    background: var(--card-bg);
                    border-radius: 12px;
                    padding: 1.5rem;
                    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
                    border: 1px solid #e5e7eb;
                    transition: transform 0.2s ease, box-shadow 0.2s ease;
                }}

                .metric-card:hover {{
                    transform: translateY(-2px);
                    box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.15);
                }}

                .metric-header {{
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    margin-bottom: 1rem;
                }}

                .metric-title {{
                    font-size: 0.875rem;
                    font-weight: 600;
                    color: var(--text-secondary);
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                }}

                .metric-icon {{
                    width: 2rem;
                    height: 2rem;
                    border-radius: 6px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1rem;
                }}

                .metric-value {{
                    font-size: 2.5rem;
                    font-weight: 700;
                    margin-bottom: 0.5rem;
                }}

                .metric-description {{
                    font-size: 0.875rem;
                    color: var(--text-secondary);
                }}

                .trend-indicator {{
                    display: inline-flex;
                    align-items: center;
                    font-size: 0.75rem;
                    font-weight: 500;
                    padding: 0.25rem 0.5rem;
                    border-radius: 4px;
                    margin-top: 0.5rem;
                }}

                .trend-up {{
                    background: #dcfce7;
                    color: var(--success-color);
                }}

                .trend-down {{
                    background: #fee2e2;
                    color: var(--danger-color);
                }}

                .chart-container {{
                    background: var(--card-bg);
                    border-radius: 12px;
                    padding: 1.5rem;
                    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
                    border: 1px solid #e5e7eb;
                    margin-bottom: 2rem;
                }}

                .chart-title {{
                    font-size: 1.25rem;
                    font-weight: 600;
                    margin-bottom: 1rem;
                    color: var(--text-primary);
                }}

                .two-column-charts {{
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 2rem;
                }}

                .security-alerts {{
                    background: var(--card-bg);
                    border-radius: 12px;
                    padding: 1.5rem;
                    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
                    border: 1px solid #e5e7eb;
                }}

                .alert-item {{
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 1rem;
                    border-bottom: 1px solid #e5e7eb;
                    transition: background-color 0.2s ease;
                }}

                .alert-item:hover {{
                    background: #f9fafb;
                }}

                .alert-item:last-child {{
                    border-bottom: none;
                }}

                .alert-info {{
                    flex: 1;
                }}

                .alert-title {{
                    font-weight: 600;
                    color: var(--text-primary);
                }}

                .alert-details {{
                    font-size: 0.875rem;
                    color: var(--text-secondary);
                    margin-top: 0.25rem;
                }}

                .security-badge {{
                    display: inline-flex;
                    align-items: center;
                    padding: 0.25rem 0.75rem;
                    border-radius: 6px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                }}

                .security-critical {{
                    background: #fee2e2;
                    color: var(--danger-color);
                }}

                .security-high {{
                    background: #fef3c7;
                    color: #d97706;
                }}

                .security-medium {{
                    background: #ddd6fe;
                    color: #7c3aed;
                }}

                .security-low {{
                    background: #dcfce7;
                    color: var(--success-color);
                }}

                @media (max-width: 768px) {{
                    .two-column-charts {{
                        grid-template-columns: 1fr;
                    }}

                    .metrics-grid {{
                        grid-template-columns: 1fr;
                    }}

                    .header h1 {{
                        font-size: 2rem;
                    }}
                }}
            </style>
        </head>
        <body>
            <div class="header">
                <h1>🔐 Enterprise Git Security Dashboard</h1>
                <p>Comprehensive Repository Security Monitoring & Workflow Analytics</p>
                <p>Report Generated: {datetime.now().strftime('%B %d, %Y at %I:%M %p')}</p>
            </div>

            <div class="dashboard-container">
                <!-- Key Security Metrics -->
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Repositories Monitored</span>
                            <div class="metric-icon" style="background: #dbeafe; color: var(--primary-color);">🏢</div>
                        </div>
                        <div class="metric-value" style="color: var(--primary-color);">{dashboard_data['total_repositories']}</div>
                        <div class="metric-description">Enterprise repositories under security monitoring</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('new_repositories', 3)} this month</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Security Threats Blocked</span>
                            <div class="metric-icon" style="background: #fee2e2; color: var(--danger-color);">🛡️</div>
                        </div>
                        <div class="metric-value" style="color: var(--danger-color);">{dashboard_data['threats_blocked']}</div>
                        <div class="metric-description">Security threats prevented this month</div>
                        <div class="trend-indicator trend-up">↗ {dashboard_data.get('threat_prevention_rate', 95)}% prevention rate</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Compliance Score</span>
                            <div class="metric-icon" style="background: #dcfce7; color: var(--success-color);">✅</div>
                        </div>
                        <div class="metric-value" style="color: var(--success-color);">{dashboard_data['compliance_score']:.1f}%</div>
                        <div class="metric-description">Average compliance across all repositories</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('compliance_improvement', 4.2):.1f}% improvement</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Developer Productivity</span>
                            <div class="metric-icon" style="background: #e0e7ff; color: #6366f1;">🚀</div>
                        </div>
                        <div class="metric-value" style="color: #6366f1;">{dashboard_data['productivity_index']:.1f}</div>
                        <div class="metric-description">Developer productivity index (1-10 scale)</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('productivity_improvement', 12)}% this quarter</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Automated Remediations</span>
                            <div class="metric-icon" style="background: #fef3c7; color: var(--warning-color);">⚡</div>
                        </div>
                        <div class="metric-value" style="color: var(--warning-color);">{dashboard_data['automated_fixes']}</div>
                        <div class="metric-description">Security issues automatically resolved</div>
                        <div class="trend-indicator trend-up">↗ {dashboard_data.get('automation_rate', 78)}% automation rate</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Workflow Efficiency</span>
                            <div class="metric-icon" style="background: #f3e8ff; color: #7c3aed;">📊</div>
                        </div>
                        <div class="metric-value" style="color: #7c3aed;">{dashboard_data['workflow_efficiency']:.1f}%</div>
                        <div class="metric-description">Overall development workflow efficiency</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('efficiency_improvement', 8.7):.1f}% improvement</div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="two-column-charts">
                    <div class="chart-container">
                        <h3 class="chart-title">Security Threats Over Time</h3>
                        <canvas id="securityThreatsChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Repository Security Scores</h3>
                        <canvas id="securityScoresChart"></canvas>
                    </div>
                </div>

                <div class="two-column-charts">
                    <div class="chart-container">
                        <h3 class="chart-title">Workflow Performance Metrics</h3>
                        <canvas id="workflowMetricsChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Compliance Status by Framework</h3>
                        <canvas id="complianceChart"></canvas>
                    </div>
                </div>

                <!-- Active Security Alerts -->
                <div class="security-alerts">
                    <h3 class="chart-title">Active Security Alerts</h3>
                    {self._generate_security_alerts_html(dashboard_data['security_alerts'])}
                </div>
            </div>

            <script>
                // Security Threats Chart
                const threatsCtx = document.getElementById('securityThreatsChart').getContext('2d');
                const threatsChart = new Chart(threatsCtx, {{
                    type: 'line',
                    data: {{
                        labels: {dashboard_data['threat_labels']},
                        datasets: [{{
                            label: 'Critical Threats',
                            data: {dashboard_data['critical_threats']},
                            borderColor: '#ef4444',
                            backgroundColor: 'rgba(239, 68, 68, 0.1)',
                            tension: 0.4
                        }}, {{
                            label: 'High Threats',
                            data: {dashboard_data['high_threats']},
                            borderColor: '#f59e0b',
                            backgroundColor: 'rgba(245, 158, 11, 0.1)',
                            tension: 0.4
                        }}, {{
                            label: 'Blocked Threats',
                            data: {dashboard_data['blocked_threats']},
                            borderColor: '#10b981',
                            backgroundColor: 'rgba(16, 185, 129, 0.1)',
                            tension: 0.4
                        }}]
                    }},
                    options: {{
                        responsive: true,
                        plugins: {{
                            legend: {{
                                position: 'top'
                            }}
                        }},
                        scales: {{
                            y: {{
                                beginAtZero: true
                            }}
                        }}
                    }}
                }});

                // Security Scores Chart
                const scoresCtx = document.getElementById('securityScoresChart').getContext('2d');
                const scoresChart = new Chart(scoresCtx, {{
                    type: 'bar',
                    data: {{
                        labels: {dashboard_data['repo_names']},
                        datasets: [{{
                            label: 'Security Score',
                            data: {dashboard_data['security_scores']},
                            backgroundColor: [
                                '#10b981', '#22c55e', '#eab308', '#f59e0b', '#ef4444'
                            ]
                        }}]
                    }},
                    options: {{
                        responsive: true,
                        plugins: {{
                            legend: {{
                                display: false
                            }}
                        }},
                        scales: {{
                            y: {{
                                beginAtZero: true,
                                max: 10
                            }}
                        }}
                    }}
                }});

                // Workflow Metrics Chart
                const workflowCtx = document.getElementById('workflowMetricsChart').getContext('2d');
                const workflowChart = new Chart(workflowCtx, {{
                    type: 'radar',
                    data: {{
                        labels: ['Commit Speed', 'Review Efficiency', 'Test Coverage', 'Security Checks', 'Deployment Speed'],
                        datasets: [{{
                            label: 'Performance %',
                            data: {dashboard_data['workflow_performance']},
                            backgroundColor: 'rgba(59, 130, 246, 0.2)',
                            borderColor: '#3b82f6',
                            borderWidth: 2
                        }}]
                    }},
                    options: {{
                        responsive: true,
                        scales: {{
                            r: {{
                                beginAtZero: true,
                                max: 100
                            }}
                        }}
                    }}
                }});

                // Compliance Chart
                const complianceCtx = document.getElementById('complianceChart').getContext('2d');
                const complianceChart = new Chart(complianceCtx, {{
                    type: 'doughnut',
                    data: {{
                        labels: {dashboard_data['compliance_labels']},
                        datasets: [{{
                            data: {dashboard_data['compliance_data']},
                            backgroundColor: [
                                '#10b981', '#22c55e', '#eab308', '#f59e0b',
                                '#ef4444', '#8b5cf6', '#ec4899', '#06b6d4'
                            ]
                        }}]
                    }},
                    options: {{
                        responsive: true,
                        plugins: {{
                            legend: {{
                                position: 'right'
                            }}
                        }}
                    }}
                }});
            </script>
        </body>
        </html>
        """

        return dashboard_html

## When to Use Husky

### ✅ **Use Husky When**

- Working in team environments requiring consistent code quality standards
- Need to automate code formatting, linting, and testing before commits
- Want to prevent bad commits from entering the repository
- Building projects requiring pre-commit, pre-push, or other Git hook automation
- Integrating with tools like ESLint, Prettier, Jest, TypeScript compilation
- Setting up continuous integration workflows with local validation
- Managing multiple developers with different development environment setups
- Need to enforce conventional commit messages or changelog generation
- Want to run security scans or dependency audits on code changes

### ❌ **Avoid Husky When**

- Working on solo projects where automation overhead isn't justified
- Git repository doesn't support hooks or has restrictions on hook execution
- Team strongly prefers manual code review processes without automation
- Performance is critical and hook execution time is unacceptable
- Working with legacy systems where Git hook setup is complex or impossible
- Repository has existing hook management that conflicts with Husky

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | Husky Recommendation                                 | Configuration Priority            |
| ---------------------- | ---------------------------------------------------- | --------------------------------- |
| Team Development       | ✅ **Essential** - Enforces standards across team    | High - Pre-commit + pre-push      |
| Open Source Project    | ✅ **Strongly Recommended** - Maintains code quality | High - Full workflow automation   |
| Enterprise Application | ✅ **Essential** - Security and compliance           | High - Security + quality checks  |
| Personal Project       | 🔄 **Consider** - Useful for good habits             | Medium - Basic pre-commit         |
| Legacy Codebase        | 🔄 **Consider** - Gradual adoption                   | Low - Start with formatting only  |
| CI/CD Pipeline         | ✅ **Recommended** - Local validation before remote  | Medium - Mirror CI checks locally |

### Complexity Assessment

| Factor                | Low Complexity           | Medium Complexity           | High Complexity                |
| --------------------- | ------------------------ | --------------------------- | ------------------------------ |
| **Setup Time**        | 10 minutes (basic hooks) | 30 minutes (multiple tools) | 2+ hours (custom scripts)      |
| **Team Size**         | 1-3 developers           | 4-10 developers             | 10+ developers                 |
| **Tools Integration** | ESLint + Prettier        | + Jest + TypeScript         | + Security + Custom validation |
| **Hook Types**        | Pre-commit only          | Pre-commit + pre-push       | Multiple Git hooks             |

## Installation & Setup

### Package Manager Installation

```bash
# npm installation (recommended for most projects)
npm install husky --save-dev

# yarn installation
yarn add husky --dev

# pnpm installation
pnpm add husky --save-dev

# Initialize Husky in existing project
npx husky init

# Alternative initialization for specific package managers
yarn dlx husky init
pnpm dlx husky init
```

### Project Integration

```bash
# Initialize Husky (creates .husky directory and installs Git hooks)
npx husky init

# Add your first hook (pre-commit example)
echo "npm test" > .husky/pre-commit

# Make hook executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit

# Verify installation
ls -la .husky/
cat .husky/pre-commit
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "prepare": "husky",
    "lint": "eslint src/**/*.{js,ts,jsx,tsx}",
    "lint:fix": "eslint src/**/*.{js,ts,jsx,tsx} --fix",
    "format": "prettier --write src/**/*.{js,ts,jsx,tsx,css,md}",
    "format:check": "prettier --check src/**/*.{js,ts,jsx,tsx,css,md}",
    "test": "jest",
    "test:coverage": "jest --coverage",
    "type-check": "tsc --noEmit"
  },
  "devDependencies": {
    "husky": "^9.0.0",
    "lint-staged": "^15.0.0",
    "eslint": "^8.0.0",
    "prettier": "^3.0.0",
    "jest": "^29.0.0"
  }
}
```

## Configuration

### Basic Hook Configuration

```bash
# .husky/pre-commit - Basic pre-commit hook
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run lint
npm run format:check
npm run test
```

### Advanced Pre-commit Hook

```bash
# .husky/pre-commit - Advanced with error handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit checks..."

# Run linting
echo "📝 Checking code style..."
npm run lint || {
  echo "❌ Linting failed. Please fix the issues above."
  exit 1
}

# Run Prettier formatting check
echo "🎨 Checking code formatting..."
npm run format:check || {
  echo "❌ Code formatting issues found. Run 'npm run format' to fix."
  exit 1
}

# Type checking for TypeScript projects
if [ -f "tsconfig.json" ]; then
  echo "📘 Type checking..."
  npm run type-check || {
    echo "❌ TypeScript type checking failed."
    exit 1
  }
fi

# Run tests
echo "🧪 Running tests..."
npm run test || {
  echo "❌ Tests failed. Please fix failing tests."
  exit 1
}

echo "✅ All pre-commit checks passed!"
```

### Pre-push Hook Configuration

```bash
# .husky/pre-push - Comprehensive pre-push validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push checks..."

# Ensure all commits are properly formatted
echo "📋 Checking commit messages..."
npm run commitlint || {
  echo "❌ Commit message format is invalid."
  exit 1
}

# Run full test suite with coverage
echo "🧪 Running full test suite..."
npm run test:coverage || {
  echo "❌ Tests failed or coverage threshold not met."
  exit 1
}

# Security audit
echo "🔒 Running security audit..."
npm audit --audit-level moderate || {
  echo "⚠️  Security vulnerabilities found. Please review."
  # Don't exit on audit failures in development, but warn
}

# Build check
echo "🏗️ Checking build..."
npm run build || {
  echo "❌ Build failed."
  exit 1
}

echo "✅ All pre-push checks passed! Safe to push."
```

### Lint-staged Integration

```bash
# Install lint-staged for performance
npm install lint-staged --save-dev
```

```json
// package.json - lint-staged configuration
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{css,scss,less}": ["prettier --write"],
    "*.{json,md,yaml,yml}": ["prettier --write"],
    "*.{js,jsx,ts,tsx}": ["jest --bail --findRelatedTests --passWithNoTests"]
  }
}
```

```bash
# .husky/pre-commit - Using lint-staged
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx lint-staged
```

### Commit Message Hook

```bash
# .husky/commit-msg - Enforce conventional commits
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npx commitlint --edit "$1"
```

```javascript
// commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat', // New feature
        'fix', // Bug fix
        'docs', // Documentation changes
        'style', // Code style changes (formatting, etc.)
        'refactor', // Code refactoring
        'test', // Adding or updating tests
        'chore', // Build process or auxiliary tool changes
        'perf', // Performance improvements
        'ci', // CI/CD changes
        'revert', // Reverting changes
      ],
    ],
    'subject-case': [2, 'never', ['start-case', 'pascal-case', 'upper-case']],
    'subject-max-length': [2, 'always', 100],
    'body-max-line-length': [2, 'always', 150],
  },
};
```

## Core Features

### Git Hook Automation

- **Purpose**: Automatically executes scripts at specific Git lifecycle events
- **Usage**: Enforces code quality standards before commits, pushes, or merges
- **Example**:

```bash
# Create pre-commit hook
echo "npm run lint && npm run test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Create pre-push hook
echo "npm run build && npm run test:e2e" > .husky/pre-push
chmod +x .husky/pre-push
```

### Lint-staged Integration

- **Purpose**: Runs linting and formatting only on staged files for performance
- **Usage**: Speeds up pre-commit checks by processing only changed files
- **Example**:

```bash
# Install lint-staged
npm install lint-staged --save-dev

# Configure in package.json
{
  "lint-staged": {
    "*.{js,ts}": ["eslint --fix", "prettier --write"]
  }
}

# Update pre-commit hook
echo "npx lint-staged" > .husky/pre-commit
```

### Cross-platform Compatibility

- **Purpose**: Ensures hooks work across Windows, macOS, and Linux environments
- **Usage**: Provides consistent behavior regardless of development environment
- **Example**:

```bash
# .husky/pre-commit - Cross-platform script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Works on all platforms
npm run lint
npm run test
```

### Hook Bypassing and Debugging

- **Purpose**: Allows temporary bypassing of hooks for emergency commits or debugging
- **Usage**: Provides escape mechanisms while maintaining normal workflow enforcement
- **Example**:

```bash
# Bypass hooks for emergency commit
git commit --no-verify -m "hotfix: critical security patch"

# Skip specific hook types
HUSKY_SKIP_HOOKS=1 git commit -m "skip all hooks"

# Debug hook execution
HUSKY_DEBUG=1 git commit -m "debug hook execution"
```

## Common Commands

```bash
# Essential daily commands
npx husky init                        # Initialize Husky in project
npx husky add .husky/pre-commit "npm test"  # Add pre-commit hook
npx husky --help                      # Get command help

# Hook management
chmod +x .husky/pre-commit           # Make hook executable
rm .husky/pre-commit                 # Remove hook
ls -la .husky/                       # List all hooks

# Testing and debugging
git commit -m "test" --dry-run       # Test commit without executing
git commit --no-verify -m "bypass"  # Bypass hooks for one commit
HUSKY_DEBUG=1 git commit -m "debug"  # Debug hook execution

# Advanced operations
npx husky uninstall                  # Uninstall Husky hooks
git config core.hooksPath .husky    # Verify hooks path
git config --unset core.hooksPath   # Reset hooks path
```

## Workflow Integration

### Development Workflow

1. **Setup**: Install Husky and configure initial hooks for code quality
2. **Development**: Automatic validation runs on every commit and push
3. **Team Onboarding**: New developers automatically get hooks via npm install
4. **Quality Assurance**: Consistent standards enforced across all contributors
5. **CI/CD**: Local validation mirrors remote pipeline checks

### Team Setup Workflow

```bash
# Team lead setup
npm install husky lint-staged --save-dev
npx husky init

# Create comprehensive pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🔍 Running pre-commit validation..."

# Lint staged files
npx lint-staged

# Type check
if [ -f "tsconfig.json" ]; then
  npm run type-check
fi

echo "✅ Pre-commit validation passed!"
EOF

chmod +x .husky/pre-commit

# Create pre-push hook
cat > .husky/pre-push << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🚀 Running pre-push validation..."

# Full test suite
npm run test

# Build verification
npm run build

echo "✅ Pre-push validation passed!"
EOF

chmod +x .husky/pre-push

# Commit configuration
git add .
git commit -m "feat: add Husky Git hooks for code quality"
```

### New Developer Onboarding

```bash
# New developer workflow
git clone <repository>
cd <project>
npm install  # Automatically sets up Husky hooks

# Verify hooks are installed
ls -la .husky/
git config core.hooksPath  # Should show .husky

# Make first commit (hooks will run automatically)
echo "# Test" >> README.md
git add README.md
git commit -m "docs: test commit with hooks"
```

### CI/CD Integration

```yaml
# .github/workflows/validate.yml
name: Code Quality
on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'

      - run: npm ci

      # Run the same checks as local hooks
      - name: Lint code
        run: npm run lint

      - name: Check formatting
        run: npm run format:check

      - name: Type check
        run: npm run type-check

      - name: Run tests
        run: npm run test:coverage

      - name: Build project
        run: npm run build
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Keep hooks fast** - Use lint-staged to process only changed files
- **Make hooks informative** - Add clear echo statements showing progress
- **Handle errors gracefully** - Provide helpful error messages and exit codes
- **Use consistent formatting** - Follow team conventions for hook scripts
- **Document hook behavior** - Include README sections explaining what hooks do
- **Test hooks thoroughly** - Verify hook behavior across different scenarios

### ✅ **Performance Optimization**

- **Use lint-staged** for file-specific operations to reduce execution time
- **Cache dependencies** in CI/CD to speed up hook validation
- **Parallelize independent checks** where possible using concurrent execution
- **Skip heavy operations** in development hooks, save for pre-push or CI
- **Use incremental builds** and testing for faster feedback loops
- **Monitor hook execution time** and optimize slow operations

### ✅ **Team Collaboration**

- **Establish clear bypass policies** for emergency commits with --no-verify
- **Document hook requirements** in project README and contributing guidelines
- **Provide debugging instructions** for when hooks fail unexpectedly
- **Use conventional commit messages** with commitlint for consistency
- **Share hook configurations** via version control for team alignment
- **Handle cross-platform differences** in hook scripts and dependencies

### ❌ **Common Pitfalls to Avoid**

- **Don't make hooks too strict** - Balance quality with development velocity
- **Avoid platform-specific scripts** - Ensure hooks work on Windows, macOS, Linux
- **Don't skip hook testing** - Test hooks with various commit scenarios
- **Avoid blocking emergency commits** - Always provide bypass mechanisms
- **Don't ignore hook failures** - Address root causes rather than bypassing
- **Avoid over-engineering** - Start simple and add complexity as needed

## Advanced Hook Configurations

### Multi-stage Validation Hook

```bash
# .husky/pre-commit - Multi-stage with early exit
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "${YELLOW}🔍 Starting pre-commit validation...${NC}"

# Stage 1: Fast checks first
echo "${YELLOW}📝 Stage 1: Code style and formatting...${NC}"
npx lint-staged || {
  echo "${RED}❌ Code style checks failed${NC}"
  exit 1
}

# Stage 2: Type checking
if [ -f "tsconfig.json" ]; then
  echo "${YELLOW}📘 Stage 2: Type checking...${NC}"
  npm run type-check || {
    echo "${RED}❌ TypeScript type checking failed${NC}"
    exit 1
  }
fi

# Stage 3: Unit tests for changed files
echo "${YELLOW}🧪 Stage 3: Running related tests...${NC}"
npm run test:related || {
  echo "${RED}❌ Related tests failed${NC}"
  exit 1
}

# Stage 4: Security checks
echo "${YELLOW}🔒 Stage 4: Security scanning...${NC}"
npm audit --audit-level high || {
  echo "${YELLOW}⚠️  High-severity security issues found${NC}"
  echo "${YELLOW}Continue with caution or run 'npm audit fix'${NC}"
}

echo "${GREEN}✅ All pre-commit checks passed!${NC}"
```

### Conditional Hook Execution

```bash
# .husky/pre-commit - Conditional based on changed files
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Get list of changed files
CHANGED_FILES=$(git diff --cached --name-only)

# Check if any JS/TS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(js|jsx|ts|tsx)$'; then
  echo "📝 JavaScript/TypeScript files changed, running linting..."
  npm run lint
fi

# Check if any CSS files were changed
if echo "$CHANGED_FILES" | grep -qE '\.(css|scss|less)$'; then
  echo "🎨 Stylesheet files changed, running style linting..."
  npm run lint:css
fi

# Check if package.json or package-lock.json changed
if echo "$CHANGED_FILES" | grep -q "package"; then
  echo "📦 Package files changed, running security audit..."
  npm audit --audit-level moderate
fi

# Check if documentation files changed
if echo "$CHANGED_FILES" | grep -qE '\.(md|mdx)$'; then
  echo "📚 Documentation changed, running markdown linting..."
  npm run lint:markdown
fi

# Always run tests for safety
echo "🧪 Running tests..."
npm run test
```

### Environment-aware Hook

```bash
# .husky/pre-commit - Environment-aware execution
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if we're in CI environment
if [ "$CI" = "true" ]; then
  echo "🤖 Running in CI environment, skipping local-only checks..."
  npm run test
  exit 0
fi

# Check Node.js version
NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt "18" ]; then
  echo "⚠️  Node.js 18+ required for full validation"
  echo "📝 Running basic checks only..."
  npm run lint:basic
  exit 0
fi

# Full validation for appropriate environment
echo "🔍 Running full pre-commit validation..."
npx lint-staged
npm run type-check
npm run test
```

## Integration with Development Tools

### ESLint and Prettier Integration

```json
// package.json - Complete lint-staged configuration
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write", "git add"],
    "*.{css,scss,less}": ["stylelint --fix", "prettier --write", "git add"],
    "*.{json,md,yaml,yml}": ["prettier --write", "git add"]
  }
}
```

### Jest Testing Integration

```bash
# .husky/pre-commit - Jest with coverage thresholds
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

echo "🧪 Running tests with coverage..."

# Run tests for changed files with coverage
npm run test -- --coverage --changedSince=HEAD^ || {
  echo "❌ Tests failed or coverage below threshold"
  exit 1
}

# Check if coverage reports were generated
if [ -d "coverage" ]; then
  echo "📊 Coverage report generated in coverage/"
fi
```

### TypeScript Integration

```bash
# .husky/pre-commit - TypeScript with incremental checking
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Type check with incremental compilation
echo "📘 Incremental TypeScript checking..."
npx tsc --noEmit --incremental || {
  echo "❌ TypeScript compilation errors found"
  exit 1
}

# Check for TypeScript-specific linting
echo "📝 TypeScript-specific linting..."
npx eslint --ext .ts,.tsx src/ || {
  echo "❌ TypeScript linting failed"
  exit 1
}
```

### Docker Integration

```bash
# .husky/pre-commit - Docker environment validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if Docker is available and project uses Docker
if command -v docker >/dev/null 2>&1 && [ -f "Dockerfile" ]; then
  echo "🐳 Validating Docker configuration..."

  # Lint Dockerfile
  docker run --rm -i hadolint/hadolint < Dockerfile || {
    echo "⚠️  Dockerfile linting issues found"
  }

  # Test Docker build (quick check)
  docker build --target development . -t temp-build-test || {
    echo "❌ Docker build failed"
    exit 1
  }

  # Cleanup
  docker rmi temp-build-test >/dev/null 2>&1
fi
```

## Troubleshooting

### Common Issues

#### Hooks Not Executing

**Problem**: Git hooks are not running when expected
**Symptoms**: Commits succeed without running validation scripts
**Solution**:

```bash
# Check if Husky is properly installed
ls -la .husky/
cat .husky/pre-commit

# Verify Git hooks path
git config core.hooksPath

# Reinstall Husky if needed
rm -rf .husky
npx husky init
echo "npm test" > .husky/pre-commit
chmod +x .husky/pre-commit

# Check hook permissions (Unix/Linux/macOS)
chmod +x .husky/*
```

#### Permission Denied Errors

**Problem**: Hooks fail with permission denied errors
**Symptoms**: "Permission denied" error when Git tries to execute hooks
**Solution**:

```bash
# Make hooks executable (Unix/Linux/macOS)
chmod +x .husky/pre-commit
chmod +x .husky/pre-push

# For Windows (using Git Bash)
git update-index --chmod=+x .husky/pre-commit

# Verify permissions
ls -la .husky/
```

#### Hook Script Failures

**Problem**: Hook scripts fail with cryptic error messages
**Symptoms**: Hooks exit with non-zero status but unclear error information
**Solution**:

```bash
# Add debugging to hook script
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

set -e  # Exit on any error
set -x  # Print commands as they execute

echo "Starting pre-commit hook..."
npm run lint
echo "Lint completed successfully"

# Test hook manually
./.husky/pre-commit

# Check specific command failures
npm run lint  # Run individual commands to isolate issues
```

#### Performance Issues

**Problem**: Hooks take too long to execute, slowing down development
**Symptoms**: Long delays during commits, developer frustration
**Solution**:

```bash
# Use lint-staged for file-specific operations
npm install lint-staged --save-dev

# Optimize hook to run only necessary checks
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Time the hook execution
start_time=$(date +%s)

# Use lint-staged instead of full project linting
npx lint-staged

# Skip heavy operations in pre-commit, move to pre-push
# npm run test  # Move to pre-push hook

end_time=$(date +%s)
echo "Hook execution time: $((end_time - start_time)) seconds"
```

### Debug Mode

```bash
# Enable Husky debugging
HUSKY_DEBUG=1 git commit -m "debug commit"

# Check hook configuration
cat .husky/pre-commit
ls -la .husky/

# Test hook execution manually
./.husky/pre-commit

# Verify Git hooks path
git config --list | grep hooks
```

### Performance Optimization

```bash
# Measure hook performance
time ./.husky/pre-commit

# Use lint-staged for incremental checking
npx lint-staged --debug

# Profile specific commands
time npm run lint
time npm run test

# Optimize package.json scripts
{
  "scripts": {
    "lint:fast": "eslint --cache src/",
    "test:fast": "jest --onlyChanged"
  }
}
```

## Security Considerations

### Security Best Practices

- **Validate hook scripts** for malicious code before committing to repository
- **Use trusted sources** for hook script templates and avoid copying unknown scripts
- **Limit hook permissions** to only necessary operations and file access
- **Audit dependencies** used in hook scripts regularly for vulnerabilities
- **Avoid sensitive data** in hook scripts or environment variables
- **Use secure communication** when hooks interact with external services

### Sensitive Data Handling

```bash
# .husky/pre-commit - Secure environment handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check for sensitive data in commits
echo "🔒 Scanning for sensitive data..."

# Check for common secrets patterns
if git diff --cached | grep -E "(password|secret|key|token)" >/dev/null; then
  echo "⚠️  Potential sensitive data detected in commit"
  echo "Please review your changes before committing"
fi

# Use environment variables securely
if [ -n "$SECURITY_SCAN_ENABLED" ]; then
  npm run security:scan
fi
```

### Network Security

```bash
# .husky/pre-commit - Network-aware security
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Only run network-dependent checks when online
if ping -c 1 google.com >/dev/null 2>&1; then
  echo "🌐 Network available, running online security checks..."
  npm audit --audit-level moderate
else
  echo "🔌 No network connection, skipping online security checks"
fi
```

## AI Assistant Guidelines

When helping with Husky:

1. **Always suggest Husky 9.0+** for new projects with improved performance and simplicity
2. **Provide complete workflow examples** that integrate with common development tools
3. **Include lint-staged setup** for performance optimization in team environments
4. **Suggest cross-platform compatible** hook scripts that work on Windows, macOS, and Linux
5. **Provide debugging strategies** for common hook execution and permission issues
6. **Include emergency bypass procedures** for critical commits using --no-verify
7. **Reference team collaboration patterns** for establishing consistent development standards
8. **Provide performance optimization** techniques for large projects and teams

### Code Generation Rules

- Generate executable shell scripts with proper shebang and Husky initialization
- Include error handling and informative output messages in hook scripts
- Provide both basic and advanced hook configurations based on project complexity
- Include lint-staged configuration for performance optimization
- Follow cross-platform compatibility best practices in script generation
- Add debugging and troubleshooting guidance for common setup issues
- Include integration patterns with popular tools (ESLint, Prettier, Jest, TypeScript)
- Follow security best practices for hook script content and execution

## Installation & Setup

### Package Manager Installation

```bash
# npm/yarn installation
npm install -g [tool-name]
# or
yarn global add [tool-name]

# pip installation
pip install [tool-name]

# homebrew installation (macOS)
brew install [tool-name]

# Other platform-specific commands
[other installation methods]
```

### Project Integration

```bash
# Initialize in project
[tool] init

# Add to existing project
[project setup commands]
```

## Configuration

### Configuration File

```[config-format]
# [config-file-name] (e.g., .toolrc, tool.config.js, tool.yaml)
[configuration-example]
```

### Environment Variables

```bash
# Environment-specific settings
[TOOL_ENV_VAR]=[value]
[TOOL_CONFIG_PATH]=[path]
```

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
