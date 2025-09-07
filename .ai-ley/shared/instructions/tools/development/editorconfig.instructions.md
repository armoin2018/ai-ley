---
agentMode: general
applyTo:
  - '**/.editorconfig'
  - '**/editor.config'
  - '**/.*rc'
  - '**/package.json'
author: AI-LEY
category: Development Tools
description: Enterprise-grade EditorConfig platform with advanced code standards automation, policy enforcement engines, compliance validation frameworks, automated code quality gates, security-focused configuration management, enterprise development workflow integration, and comprehensive developer productivity optimization for complete enterprise development environment standardization.
extensions:
  - .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:47.924734'
last_updated: '2025-08-14'
summaryScore: 3.0
tags:
  - editorconfig
  - code-style
  - editor-consistency
  - team-development
  - cross-platform
  - ide-integration
  - formatting
  - enterprise-standards
  - policy-enforcement
  - compliance-validation
  - security-configuration
  - workflow-automation
  - productivity-optimization
title: EditorConfig Enterprise Code Standards & Developer Productivity Platform
version: '2.0'
---

# EditorConfig Enterprise Code Standards & Developer Productivity Platform

## Enterprise Platform Overview

- **Platform Name**: EditorConfig Enterprise Standards Engine
- **Version**: 2.0+ (Advanced enterprise specification with comprehensive automation)
- **Category**: Enterprise Development Standards & Policy Enforcement
- **Core Purpose**: Advanced enterprise code standards automation, policy enforcement, compliance validation, and comprehensive developer productivity optimization
- **Enterprise Capabilities**: Automated policy enforcement, compliance validation, security configuration, workflow integration, productivity analytics
- **Prerequisites**: Compatible enterprise development environment with advanced EditorConfig plugin support

# === Enterprise EditorConfig Standards Automation Framework ===

import logging
import json
import yaml
import os
import re
import subprocess
from datetime import datetime
from typing import Dict, List, Any, Optional, Union
from pathlib import Path
from dataclasses import dataclass, field
from enum import Enum

logger = logging.getLogger(**name**)

class ComplianceFramework(Enum):
"""Enterprise compliance frameworks for code standards"""
ISO_27001 = "ISO-27001"
SOC2_TYPE2 = "SOC2-Type2"
NIST_CYBERSECURITY = "NIST-Cybersecurity"
PCI_DSS = "PCI-DSS"
GDPR = "GDPR"
HIPAA = "HIPAA"
ENTERPRISE_SECURITY = "Enterprise-Security"
DEVELOPMENT_STANDARDS = "Development-Standards"

class PolicySeverity(Enum):
"""Policy violation severity levels"""
CRITICAL = "CRITICAL"
HIGH = "HIGH"
MEDIUM = "MEDIUM"
LOW = "LOW"
INFO = "INFO"

@dataclass
class EnterpriseProject:
"""Represents an enterprise development project"""
project_id: str
name: str
path: Path
languages: List[str]
frameworks: List[str]
compliance_requirements: List[ComplianceFramework]
security_level: str = "standard"
team_size: int = 5
project_type: str = "application"
industry: str = "technology"
data_classification: str = "internal"
regulatory_requirements: List[str] = field(default_factory=list)

@dataclass
class StandardsPolicy:
"""Enterprise code standards policy definition"""
policy_id: str
name: str
description: str
severity: PolicySeverity
category: str
compliance_frameworks: List[ComplianceFramework]
file_patterns: List[str]
rules: Dict[str, Any]
remediation_guidance: str
business_justification: str

class EnterpriseEditorConfigEngine:
"""Advanced enterprise EditorConfig standards and policy enforcement engine"""

    def __init__(self, config: Dict[str, Any] = None):
        self.config = config or self._load_default_enterprise_config()
        self.standards_database = self._initialize_standards_database()
        self.policy_engine = self._initialize_policy_engine()
        self.compliance_validator = self._initialize_compliance_validator()
        self.productivity_analytics = self._initialize_productivity_analytics()
        logger.info("Enterprise EditorConfig Engine initialized")

    def _load_default_enterprise_config(self) -> Dict[str, Any]:
        """Load comprehensive enterprise configuration"""
        return {
            "enterprise_settings": {
                "policy_enforcement": True,
                "compliance_validation": True,
                "security_scanning": True,
                "productivity_monitoring": True,
                "automated_remediation": True,
                "executive_reporting": True
            },
            "compliance_frameworks": {
                "iso_27001": True,
                "soc2_type2": True,
                "nist_cybersecurity": True,
                "pci_dss": False,
                "gdpr": True,
                "hipaa": False
            },
            "security_standards": {
                "code_scanning": True,
                "secret_detection": True,
                "vulnerability_assessment": True,
                "dependency_scanning": True,
                "license_compliance": True
            },
            "productivity_features": {
                "performance_analytics": True,
                "developer_insights": True,
                "automation_metrics": True,
                "workflow_optimization": True,
                "team_collaboration": True
            },
            "integration_platforms": {
                "ci_cd_systems": ["Jenkins", "GitLab-CI", "GitHub-Actions", "Azure-DevOps"],
                "ide_platforms": ["VS-Code", "IntelliJ", "Sublime", "Atom", "Vim", "Emacs"],
                "security_tools": ["SonarQube", "Veracode", "Snyk", "WhiteSource"],
                "monitoring_systems": ["DataDog", "New-Relic", "Splunk", "ELK-Stack"]
            }
        }

    def generate_enterprise_editorconfig(self, project: EnterpriseProject) -> str:
        """Generate comprehensive enterprise EditorConfig with advanced standards"""
        logger.info(f"Generating enterprise EditorConfig for {project.name}")

        try:
            # Analyze project requirements
            project_analysis = self._analyze_project_requirements(project)

            # Generate policy-compliant configuration
            base_config = self._generate_base_enterprise_config(project, project_analysis)

            # Add compliance-specific rules
            compliance_rules = self._generate_compliance_rules(project)

            # Add security-focused configuration
            security_config = self._generate_security_configuration(project)

            # Add productivity optimizations
            productivity_config = self._generate_productivity_configuration(project)

            # Combine all configurations
            enterprise_config = self._merge_configurations(
                base_config, compliance_rules, security_config, productivity_config
            )

            # Validate configuration
            validation_result = self._validate_enterprise_config(enterprise_config, project)

            if not validation_result["valid"]:
                logger.warning(f"Configuration validation issues: {validation_result['issues']}")

            # Generate final EditorConfig content
            editorconfig_content = self._render_editorconfig_content(enterprise_config, project)

            # Add enterprise metadata and documentation
            documented_config = self._add_enterprise_documentation(editorconfig_content, project)

            logger.info(f"Enterprise EditorConfig generated with {len(enterprise_config)} rules")

            return documented_config

        except Exception as e:
            logger.error(f"Enterprise EditorConfig generation failed: {e}")
            raise

    def _generate_base_enterprise_config(self, project: EnterpriseProject, analysis: Dict[str, Any]) -> Dict[str, Any]:
        """Generate base enterprise configuration with universal standards"""

        base_config = {
            "root": True,
            "global_rules": {
                "charset": "utf-8",
                "end_of_line": "lf",
                "insert_final_newline": True,
                "trim_trailing_whitespace": True,
                "max_line_length": 120  # Enterprise standard
            },
            "language_specific": {},
            "framework_specific": {},
            "security_rules": {},
            "compliance_rules": {}
        }

        # Language-specific configurations
        for language in project.languages:
            base_config["language_specific"][language] = self._get_language_standards(language, project)

        # Framework-specific configurations
        for framework in project.frameworks:
            base_config["framework_specific"][framework] = self._get_framework_standards(framework, project)

        # Enterprise-specific rules based on project type
        if project.project_type == "microservice":
            base_config["global_rules"]["max_line_length"] = 100  # Stricter for microservices
        elif project.project_type == "monolith":
            base_config["global_rules"]["max_line_length"] = 140  # More flexible for complex logic

        # Team size adjustments
        if project.team_size > 20:
            base_config["global_rules"]["indent_style"] = "space"
            base_config["global_rules"]["indent_size"] = 2  # Consistent for large teams

        return base_config

    def _generate_compliance_rules(self, project: EnterpriseProject) -> Dict[str, Any]:
        """Generate compliance-specific configuration rules"""
        compliance_config = {
            "audit_requirements": {},
            "documentation_standards": {},
            "review_requirements": {}
        }

        for framework in project.compliance_requirements:
            if framework == ComplianceFramework.ISO_27001:
                compliance_config["audit_requirements"]["file_tracking"] = True
                compliance_config["documentation_standards"]["header_required"] = True
                compliance_config["review_requirements"]["mandatory_review"] = True

            elif framework == ComplianceFramework.SOC2_TYPE2:
                compliance_config["audit_requirements"]["change_logging"] = True
                compliance_config["documentation_standards"]["change_justification"] = True
                compliance_config["review_requirements"]["security_review"] = True

            elif framework == ComplianceFramework.PCI_DSS:
                compliance_config["security_requirements"] = {
                    "sensitive_data_handling": True,
                    "secure_coding_standards": True,
                    "access_control": True
                }

            elif framework == ComplianceFramework.GDPR:
                compliance_config["privacy_requirements"] = {
                    "data_classification": True,
                    "consent_tracking": True,
                    "deletion_capability": True
                }

        return compliance_config

    def _generate_security_configuration(self, project: EnterpriseProject) -> Dict[str, Any]:
        """Generate security-focused configuration"""
        security_config = {
            "secret_detection": {
                "patterns_to_flag": [
                    r"password\s*=\s*[\"'][^\"']+[\"']",
                    r"api_key\s*=\s*[\"'][^\"']+[\"']",
                    r"secret\s*=\s*[\"'][^\"']+[\"']",
                    r"token\s*=\s*[\"'][^\"']+[\"']"
                ],
                "file_extensions": [".js", ".py", ".java", ".cs", ".php", ".rb"],
                "enforcement_level": "block_commit" if project.security_level == "high" else "warn"
            },
            "vulnerability_patterns": {
                "sql_injection_patterns": [
                    r"execute\s*\(\s*[\"'][^\"']*\$",
                    r"query\s*\(\s*[\"'][^\"']*\+",
                ],
                "xss_patterns": [
                    r"innerHTML\s*=\s*.*\+",
                    r"document\.write\s*\(",
                ],
                "file_permissions": {
                    "executable_extensions": [".sh", ".bat", ".exe"],
                    "restricted_directories": ["/etc", "/root", "/admin"]
                }
            },
            "secure_coding": {
                "require_input_validation": True,
                "require_output_encoding": True,
                "require_error_handling": True,
                "require_logging": True
            }
        }

        if project.data_classification in ["confidential", "restricted"]:
            security_config["enhanced_security"] = {
                "mandatory_encryption": True,
                "access_logging": True,
                "integrity_checks": True
            }

        return security_config

    def policy_enforcement_engine(self, project_path: Path, policies: List[StandardsPolicy]) -> Dict[str, Any]:
        """Execute comprehensive enterprise policy enforcement"""
        logger.info(f"Running policy enforcement on {project_path}")

        enforcement_results = {
            "project_path": str(project_path),
            "enforcement_start": datetime.now().isoformat(),
            "policies_evaluated": 0,
            "policies_passed": 0,
            "violations_found": 0,
            "critical_violations": 0,
            "policy_results": [],
            "remediation_recommendations": []
        }

        try:
            for policy in policies:
                policy_result = self._evaluate_policy(project_path, policy)
                enforcement_results["policy_results"].append(policy_result)
                enforcement_results["policies_evaluated"] += 1

                if policy_result["compliant"]:
                    enforcement_results["policies_passed"] += 1
                else:
                    enforcement_results["violations_found"] += len(policy_result["violations"])

                    if policy.severity == PolicySeverity.CRITICAL:
                        enforcement_results["critical_violations"] += 1

                    # Generate remediation recommendations
                    remediation = self._generate_policy_remediation(policy, policy_result)
                    enforcement_results["remediation_recommendations"].append(remediation)

            # Calculate overall compliance score
            if enforcement_results["policies_evaluated"] > 0:
                compliance_score = (enforcement_results["policies_passed"] / enforcement_results["policies_evaluated"]) * 100
                enforcement_results["overall_compliance_score"] = compliance_score

            # Generate executive summary
            enforcement_results["executive_summary"] = self._generate_enforcement_executive_summary(enforcement_results)

            enforcement_results["enforcement_end"] = datetime.now().isoformat()

            logger.info(f"Policy enforcement completed: {enforcement_results['overall_compliance_score']:.1f}% compliance")

        except Exception as e:
            logger.error(f"Policy enforcement failed: {e}")
            enforcement_results["error"] = str(e)

        return enforcement_results

    def _evaluate_policy(self, project_path: Path, policy: StandardsPolicy) -> Dict[str, Any]:
        """Evaluate a specific enterprise policy"""

        policy_result = {
            "policy_id": policy.policy_id,
            "policy_name": policy.name,
            "severity": policy.severity.value,
            "compliant": True,
            "violations": [],
            "files_checked": 0,
            "evidence": {}
        }

        try:
            # Find files matching policy patterns
            matching_files = self._find_policy_files(project_path, policy.file_patterns)
            policy_result["files_checked"] = len(matching_files)

            for file_path in matching_files:
                file_violations = self._check_file_compliance(file_path, policy)

                if file_violations:
                    policy_result["violations"].extend(file_violations)
                    policy_result["compliant"] = False

            # Collect evidence for compliance reporting
            policy_result["evidence"] = self._collect_policy_evidence(policy, matching_files)

        except Exception as e:
            logger.error(f"Policy evaluation failed for {policy.policy_id}: {e}")
            policy_result["error"] = str(e)

        return policy_result

    def automated_remediation_system(self, project_path: Path, violation: Dict[str, Any]) -> Dict[str, Any]:
        """Execute automated remediation for policy violations"""
        logger.info(f"Starting automated remediation for {violation['violation_type']}")

        remediation_result = {
            "violation_id": violation.get("violation_id", "unknown"),
            "remediation_start": datetime.now().isoformat(),
            "remediation_type": "",
            "actions_taken": [],
            "success": False,
            "backup_created": False
        }

        try:
            # Create backup before making changes
            backup_result = self._create_project_backup(project_path)
            remediation_result["backup_created"] = backup_result["success"]

            # Determine remediation strategy
            remediation_strategy = self._determine_remediation_strategy(violation)
            remediation_result["remediation_type"] = remediation_strategy["type"]

            # Execute remediation based on violation type
            if violation["violation_type"] == "indentation_inconsistency":
                remediation_result = self._remediate_indentation_issues(remediation_result, violation, project_path)
            elif violation["violation_type"] == "line_ending_inconsistency":
                remediation_result = self._remediate_line_ending_issues(remediation_result, violation, project_path)
            elif violation["violation_type"] == "character_encoding_issue":
                remediation_result = self._remediate_encoding_issues(remediation_result, violation, project_path)
            elif violation["violation_type"] == "trailing_whitespace":
                remediation_result = self._remediate_whitespace_issues(remediation_result, violation, project_path)
            elif violation["violation_type"] == "missing_final_newline":
                remediation_result = self._remediate_newline_issues(remediation_result, violation, project_path)
            elif violation["violation_type"] == "security_violation":
                remediation_result = self._remediate_security_issues(remediation_result, violation, project_path)
            else:
                remediation_result = self._remediate_generic_violation(remediation_result, violation, project_path)

            # Validate remediation success
            validation_result = self._validate_remediation(project_path, violation)
            remediation_result["validation_result"] = validation_result
            remediation_result["success"] = validation_result["remediation_successful"]

            remediation_result["remediation_end"] = datetime.now().isoformat()

            logger.info(f"Automated remediation completed with success: {remediation_result['success']}")

        except Exception as e:
            logger.error(f"Automated remediation failed: {e}")
            remediation_result["error"] = str(e)

        return remediation_result

    def _remediate_indentation_issues(self, result: Dict[str, Any], violation: Dict[str, Any], project_path: Path) -> Dict[str, Any]:
        """Remediate indentation inconsistencies"""

        target_indent_style = violation.get("expected_indent_style", "space")
        target_indent_size = violation.get("expected_indent_size", 2)

        files_to_fix = violation.get("affected_files", [])

        for file_path in files_to_fix:
            try:
                # Read file content
                with open(project_path / file_path, 'r', encoding='utf-8') as f:
                    content = f.read()

                # Convert indentation
                if target_indent_style == "space":
                    # Convert tabs to spaces
                    fixed_content = content.expandtabs(target_indent_size)
                else:
                    # Convert spaces to tabs
                    lines = content.splitlines(True)
                    fixed_lines = []

                    for line in lines:
                        leading_spaces = len(line) - len(line.lstrip(' '))
                        if leading_spaces > 0:
                            tab_count = leading_spaces // target_indent_size
                            remaining_spaces = leading_spaces % target_indent_size
                            fixed_line = '\t' * tab_count + ' ' * remaining_spaces + line.lstrip(' ')
                            fixed_lines.append(fixed_line)
                        else:
                            fixed_lines.append(line)

                    fixed_content = ''.join(fixed_lines)

                # Write fixed content
                with open(project_path / file_path, 'w', encoding='utf-8') as f:
                    f.write(fixed_content)

                result["actions_taken"].append(f"Fixed indentation in {file_path}")

            except Exception as e:
                result["actions_taken"].append(f"Failed to fix indentation in {file_path}: {e}")

        return result

    def developer_productivity_analytics(self, project_path: Path, time_period_days: int = 30) -> Dict[str, Any]:
        """Analyze developer productivity impact of EditorConfig standards"""
        logger.info(f"Analyzing developer productivity for {project_path}")

        analytics_result = {
            "analysis_period": time_period_days,
            "project_path": str(project_path),
            "analysis_date": datetime.now().isoformat(),
            "productivity_metrics": {},
            "compliance_trends": {},
            "developer_insights": {},
            "recommendations": []
        }

        try:
            # Analyze code consistency metrics
            consistency_metrics = self._analyze_code_consistency(project_path)
            analytics_result["productivity_metrics"]["consistency"] = consistency_metrics

            # Analyze development velocity impact
            velocity_metrics = self._analyze_development_velocity(project_path, time_period_days)
            analytics_result["productivity_metrics"]["velocity"] = velocity_metrics

            # Analyze code review efficiency
            review_metrics = self._analyze_code_review_efficiency(project_path, time_period_days)
            analytics_result["productivity_metrics"]["code_reviews"] = review_metrics

            # Analyze developer satisfaction metrics
            satisfaction_metrics = self._analyze_developer_satisfaction(project_path)
            analytics_result["productivity_metrics"]["satisfaction"] = satisfaction_metrics

            # Analyze compliance trends
            compliance_trends = self._analyze_compliance_trends(project_path, time_period_days)
            analytics_result["compliance_trends"] = compliance_trends

            # Generate developer insights
            developer_insights = self._generate_developer_insights(project_path, analytics_result["productivity_metrics"])
            analytics_result["developer_insights"] = developer_insights

            # Generate productivity recommendations
            recommendations = self._generate_productivity_recommendations(analytics_result)
            analytics_result["recommendations"] = recommendations

            # Calculate overall productivity score
            productivity_score = self._calculate_productivity_score(analytics_result["productivity_metrics"])
            analytics_result["overall_productivity_score"] = productivity_score

            logger.info(f"Productivity analysis completed with score: {productivity_score:.1f}%")

        except Exception as e:
            logger.error(f"Productivity analytics failed: {e}")
            analytics_result["error"] = str(e)

        return analytics_result

    def _analyze_code_consistency(self, project_path: Path) -> Dict[str, Any]:
        """Analyze code consistency metrics across the project"""

        consistency_metrics = {
            "indentation_consistency": 0,
            "line_ending_consistency": 0,
            "encoding_consistency": 0,
            "file_naming_consistency": 0,
            "overall_consistency": 0,
            "inconsistency_hotspots": []
        }

        # Analyze all relevant files
        code_files = self._find_code_files(project_path)

        if not code_files:
            return consistency_metrics

        # Check indentation consistency
        indent_styles = {}
        indent_sizes = {}

        for file_path in code_files:
            try:
                with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                    content = f.read()

                # Analyze indentation
                lines = content.splitlines()
                for line in lines:
                    if line.strip():  # Skip empty lines
                        leading = len(line) - len(line.lstrip())
                        if leading > 0:
                            if '\t' in line[:leading]:
                                indent_styles['tab'] = indent_styles.get('tab', 0) + 1
                            elif ' ' in line[:leading]:
                                indent_styles['space'] = indent_styles.get('space', 0) + 1
                                # Estimate indent size
                                size = self._estimate_indent_size(line)
                                if size:
                                    indent_sizes[size] = indent_sizes.get(size, 0) + 1

            except Exception:
                continue

        # Calculate consistency percentages
        total_indented_lines = sum(indent_styles.values())
        if total_indented_lines > 0:
            dominant_style = max(indent_styles.items(), key=lambda x: x[1])
            consistency_metrics["indentation_consistency"] = (dominant_style[1] / total_indented_lines) * 100

        # Check line ending consistency
        line_endings = {"lf": 0, "crlf": 0, "cr": 0}

        for file_path in code_files:
            try:
                with open(file_path, 'rb') as f:
                    content = f.read()

                if b'\r\n' in content:
                    line_endings["crlf"] += 1
                elif b'\n' in content:
                    line_endings["lf"] += 1
                elif b'\r' in content:
                    line_endings["cr"] += 1

            except Exception:
                continue

        total_files = len(code_files)
        if total_files > 0:
            dominant_ending = max(line_endings.items(), key=lambda x: x[1])
            consistency_metrics["line_ending_consistency"] = (dominant_ending[1] / total_files) * 100

        # Calculate overall consistency
        consistency_values = [
            consistency_metrics["indentation_consistency"],
            consistency_metrics["line_ending_consistency"]
        ]

        if consistency_values:
            consistency_metrics["overall_consistency"] = sum(consistency_values) / len(consistency_values)

        return consistency_metrics

    def continuous_standards_monitoring(self, project_path: Path) -> Dict[str, Any]:
        """Implement continuous monitoring of code standards compliance"""
        logger.info(f"Setting up continuous standards monitoring for {project_path}")

        monitoring_config = {
            "project_path": str(project_path),
            "monitoring_start": datetime.now().isoformat(),
            "monitoring_components": {},
            "alerting_rules": [],
            "automation_triggers": []
        }

        try:
            # Real-time file monitoring
            file_monitoring = self._setup_file_monitoring(project_path)
            monitoring_config["monitoring_components"]["file_monitoring"] = file_monitoring

            # Compliance drift detection
            drift_detection = self._setup_compliance_drift_detection(project_path)
            monitoring_config["monitoring_components"]["drift_detection"] = drift_detection

            # Developer workflow monitoring
            workflow_monitoring = self._setup_workflow_monitoring(project_path)
            monitoring_config["monitoring_components"]["workflow_monitoring"] = workflow_monitoring

            # Performance impact monitoring
            performance_monitoring = self._setup_performance_monitoring(project_path)
            monitoring_config["monitoring_components"]["performance_monitoring"] = performance_monitoring

            # Configure alerting rules
            monitoring_config["alerting_rules"] = self._configure_standards_alerting_rules()

            # Configure automation triggers
            monitoring_config["automation_triggers"] = self._configure_standards_automation_triggers()

            # Start monitoring services
            self._start_monitoring_services(monitoring_config)

            logger.info("Continuous standards monitoring configured and activated")

        except Exception as e:
            logger.error(f"Continuous monitoring setup failed: {e}")

        return monitoring_config

    def _setup_file_monitoring(self, project_path: Path) -> Dict[str, Any]:
        """Setup real-time file change monitoring"""
        return {
            "component": "file_monitoring",
            "watch_patterns": [
                "**/*.js", "**/*.ts", "**/*.jsx", "**/*.tsx",
                "**/*.py", "**/*.java", "**/*.cs", "**/*.php",
                "**/*.rb", "**/*.go", "**/*.rs", "**/*.cpp",
                "**/*.h", "**/*.hpp", "**/*.c", "**/*.cc"
            ],
            "monitoring_events": [
                "file_created", "file_modified", "file_deleted", "file_renamed"
            ],
            "validation_triggers": {
                "on_save": True,
                "on_commit": True,
                "on_push": True,
                "on_pull_request": True
            },
            "real_time_analysis": {
                "indentation_check": True,
                "line_ending_check": True,
                "encoding_check": True,
                "whitespace_check": True
            }
        }

    def enterprise_compliance_dashboard(self, projects: List[EnterpriseProject] = None) -> str:
        """Generate comprehensive enterprise standards compliance dashboard"""
        logger.info("Generating enterprise compliance dashboard")

        if projects is None:
            projects = self._get_all_enterprise_projects()

        # Collect comprehensive metrics
        dashboard_data = self._collect_compliance_dashboard_metrics(projects)

        # Generate HTML dashboard
        dashboard_html = f"""
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Enterprise Development Standards Compliance Dashboard</title>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns/dist/chartjs-adapter-date-fns.bundle.min.js"></script>
            <style>
                :root {{
                    --primary-color: #2563eb;
                    --secondary-color: #7c3aed;
                    --success-color: #059669;
                    --warning-color: #d97706;
                    --danger-color: #dc2626;
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

                .compliance-list {{
                    background: var(--card-bg);
                    border-radius: 12px;
                    padding: 1.5rem;
                    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
                    border: 1px solid #e5e7eb;
                }}

                .compliance-item {{
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    padding: 1rem;
                    border-bottom: 1px solid #e5e7eb;
                    transition: background-color 0.2s ease;
                }}

                .compliance-item:hover {{
                    background: #f9fafb;
                }}

                .compliance-item:last-child {{
                    border-bottom: none;
                }}

                .project-info {{
                    flex: 1;
                }}

                .project-name {{
                    font-weight: 600;
                    color: var(--text-primary);
                }}

                .project-details {{
                    font-size: 0.875rem;
                    color: var(--text-secondary);
                    margin-top: 0.25rem;
                }}

                .compliance-badge {{
                    display: inline-flex;
                    align-items: center;
                    padding: 0.25rem 0.75rem;
                    border-radius: 6px;
                    font-size: 0.75rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.05em;
                }}

                .compliance-excellent {{
                    background: #dcfce7;
                    color: var(--success-color);
                }}

                .compliance-good {{
                    background: #fef3c7;
                    color: #d97706;
                }}

                .compliance-poor {{
                    background: #fee2e2;
                    color: var(--danger-color);
                }}

                .standards-grid {{
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 1rem;
                    margin-top: 1rem;
                }}

                .standards-item {{
                    text-align: center;
                    padding: 1rem;
                    background: #f8fafc;
                    border-radius: 8px;
                }}

                .standards-score {{
                    font-size: 2rem;
                    font-weight: 700;
                    margin-bottom: 0.5rem;
                }}

                .standards-name {{
                    font-size: 0.875rem;
                    color: var(--text-secondary);
                    font-weight: 500;
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
                <h1>📊 Enterprise Development Standards Dashboard</h1>
                <p>Comprehensive Code Standards Compliance & Developer Productivity</p>
                <p>Report Generated: {datetime.now().strftime('%B %d, %Y at %I:%M %p')}</p>
            </div>

            <div class="dashboard-container">
                <!-- Key Metrics -->
                <div class="metrics-grid">
                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Total Projects</span>
                            <div class="metric-icon" style="background: #dbeafe; color: var(--primary-color);">📁</div>
                        </div>
                        <div class="metric-value" style="color: var(--primary-color);">{dashboard_data['total_projects']}</div>
                        <div class="metric-description">Projects under standards management</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('new_projects', 2)} this month</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Standards Compliance</span>
                            <div class="metric-icon" style="background: #dcfce7; color: var(--success-color);">✅</div>
                        </div>
                        <div class="metric-value" style="color: var(--success-color);">{dashboard_data['overall_compliance']:.1f}%</div>
                        <div class="metric-description">Average compliance across all projects</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('compliance_improvement', 3.2):.1f}% this quarter</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Policy Violations</span>
                            <div class="metric-icon" style="background: #fee2e2; color: var(--danger-color);">⚠️</div>
                        </div>
                        <div class="metric-value" style="color: var(--danger-color);">{dashboard_data['total_violations']}</div>
                        <div class="metric-description">Active violations requiring attention</div>
                        <div class="trend-indicator trend-down">↘ -{dashboard_data.get('violations_resolved', 12)} resolved this week</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Developer Productivity</span>
                            <div class="metric-icon" style="background: #e0e7ff; color: var(--secondary-color);">🚀</div>
                        </div>
                        <div class="metric-value" style="color: var(--secondary-color);">{dashboard_data['productivity_score']:.1f}%</div>
                        <div class="metric-description">Overall developer productivity index</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('productivity_improvement', 8.5):.1f}% improvement</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Automated Fixes</span>
                            <div class="metric-icon" style="background: #fef3c7; color: var(--warning-color);">🔧</div>
                        </div>
                        <div class="metric-value" style="color: var(--warning-color);">{dashboard_data['automated_fixes']}</div>
                        <div class="metric-description">Issues automatically remediated</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('automation_increase', 25)}% automation</div>
                    </div>

                    <div class="metric-card">
                        <div class="metric-header">
                            <span class="metric-title">Code Quality Score</span>
                            <div class="metric-icon" style="background: #f3e8ff; color: #7c3aed;">⭐</div>
                        </div>
                        <div class="metric-value" style="color: #7c3aed;">{dashboard_data['code_quality_score']:.1f}</div>
                        <div class="metric-description">Average code quality rating (1-10)</div>
                        <div class="trend-indicator trend-up">↗ +{dashboard_data.get('quality_improvement', 0.8):.1f} improvement</div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="two-column-charts">
                    <div class="chart-container">
                        <h3 class="chart-title">Compliance Trends Over Time</h3>
                        <canvas id="complianceTrendChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Standards Categories Performance</h3>
                        <canvas id="standardsPerformanceChart"></canvas>
                    </div>
                </div>

                <div class="two-column-charts">
                    <div class="chart-container">
                        <h3 class="chart-title">Violation Types Distribution</h3>
                        <canvas id="violationTypesChart"></canvas>
                    </div>

                    <div class="chart-container">
                        <h3 class="chart-title">Developer Productivity Metrics</h3>
                        <canvas id="productivityChart"></canvas>
                    </div>
                </div>

                <!-- Project Compliance List -->
                <div class="compliance-list">
                    <h3 class="chart-title">Project Compliance Status</h3>
                    {self._generate_project_compliance_list_html(dashboard_data['project_compliance'])}
                </div>

                <!-- Standards Performance -->
                <div class="chart-container">
                    <h3 class="chart-title">Standards Categories Performance</h3>
                    <div class="standards-grid">
                        {self._generate_standards_performance_html(dashboard_data['standards_categories'])}
                    </div>
                </div>
            </div>

            <script>
                // Compliance Trend Chart
                const trendCtx = document.getElementById('complianceTrendChart').getContext('2d');
                const trendChart = new Chart(trendCtx, {{
                    type: 'line',
                    data: {{
                        labels: {dashboard_data['trend_labels']},
                        datasets: [{{
                            label: 'Overall Compliance',
                            data: {dashboard_data['compliance_trend']},
                            borderColor: '#2563eb',
                            backgroundColor: 'rgba(37, 99, 235, 0.1)',
                            tension: 0.4
                        }}, {{
                            label: 'Critical Standards',
                            data: {dashboard_data['critical_standards_trend']},
                            borderColor: '#dc2626',
                            backgroundColor: 'rgba(220, 38, 38, 0.1)',
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
                                beginAtZero: true,
                                max: 100
                            }}
                        }}
                    }}
                }});

                // Standards Performance Chart
                const performanceCtx = document.getElementById('standardsPerformanceChart').getContext('2d');
                const performanceChart = new Chart(performanceCtx, {{
                    type: 'radar',
                    data: {{
                        labels: {dashboard_data['standards_labels']},
                        datasets: [{{
                            label: 'Performance %',
                            data: {dashboard_data['standards_performance']},
                            backgroundColor: 'rgba(37, 99, 235, 0.2)',
                            borderColor: '#2563eb',
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

                // Violation Types Chart
                const violationCtx = document.getElementById('violationTypesChart').getContext('2d');
                const violationChart = new Chart(violationCtx, {{
                    type: 'doughnut',
                    data: {{
                        labels: {dashboard_data['violation_labels']},
                        datasets: [{{
                            data: {dashboard_data['violation_data']},
                            backgroundColor: [
                                '#dc2626', '#d97706', '#eab308', '#059669',
                                '#0891b2', '#2563eb', '#7c3aed', '#be185d'
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

                // Productivity Chart
                const productivityCtx = document.getElementById('productivityChart').getContext('2d');
                const productivityChart = new Chart(productivityCtx, {{
                    type: 'bar',
                    data: {{
                        labels: ['Code Quality', 'Review Speed', 'Consistency', 'Automation', 'Satisfaction'],
                        datasets: [{{
                            label: 'Score %',
                            data: {dashboard_data['productivity_metrics']},
                            backgroundColor: [
                                '#059669', '#2563eb', '#7c3aed', '#d97706', '#dc2626'
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
                                max: 100
                            }}
                        }}
                    }}
                }});
            </script>
        </body>
        </html>
        """

        return dashboard_html

## When to Use EditorConfig

### ✅ **Use EditorConfig When**

- Working in team environments with developers using different editors and IDEs
- Need to enforce consistent indentation, line endings, and character encoding across projects
- Want to standardize basic formatting rules without forcing specific editor choices
- Working on cross-platform projects requiring consistent file formatting
- Contributing to open source projects with established style guidelines
- Need basic style enforcement that works independently of language-specific tools
- Want to establish baseline formatting before adding advanced linting tools
- Working with multiple programming languages in a single project

### ❌ **Avoid EditorConfig When**

- Working solo with a single editor and consistent personal preferences
- Need advanced linting and formatting beyond basic style rules
- Project already has comprehensive formatting tools that handle all style requirements
- Working with editors that don't support EditorConfig and can't install plugins
- Need dynamic formatting rules that change based on code context
- Team prefers language-specific formatters like Prettier, Black, or rustfmt exclusively

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type           | EditorConfig Recommendation                   | Configuration Priority         |
| ---------------------- | --------------------------------------------- | ------------------------------ |
| Multi-Language Project | ✅ **Essential** - Cross-language consistency | High - Complete style coverage |
| Team Development       | ✅ **Essential** - Editor-agnostic standards  | High - Comprehensive rules     |
| Open Source Project    | ✅ **Essential** - Contributor consistency    | High - Clear guidelines        |
| Enterprise Application | ✅ **Recommended** - Professional standards   | Medium - Core style rules      |
| Personal Project       | 🔄 **Consider** - Good practice habits        | Low - Basic formatting         |
| Legacy Codebase        | ✅ **Recommended** - Gradual standardization  | Medium - Incremental adoption  |

### Team Diversity Assessment

| Factor                | Low Diversity      | Medium Diversity | High Diversity        |
| --------------------- | ------------------ | ---------------- | --------------------- |
| **Editor Variety**    | 1-2 editors        | 3-4 editors      | 5+ different editors  |
| **Platform Mix**      | Single OS          | 2 platforms      | Cross-platform team   |
| **Experience Levels** | Similar experience | Mixed experience | Wide range            |
| **Setup Complexity**  | 5 minutes          | 15 minutes       | 30+ minutes (plugins) |

## Installation & Setup

### EditorConfig File Creation

```bash
# Create .editorconfig in project root
touch .editorconfig

# Alternative: create in subdirectories for specific rules
mkdir -p src/frontend
touch src/frontend/.editorconfig

# Verify file placement
find . -name ".editorconfig" -type f
```

### Editor Plugin Installation

#### Visual Studio Code

```bash
# Install EditorConfig extension
code --install-extension EditorConfig.EditorConfig

# Verify installation
code --list-extensions | grep EditorConfig
```

#### JetBrains IDEs (IntelliJ, WebStorm, PyCharm)

```text
Built-in support (no plugin required)
File → Settings → Editor → Code Style → EditorConfig
Enable "Enable EditorConfig support"
```

#### Vim/Neovim

```bash
# Install via vim-plug
# Add to .vimrc or init.vim:
Plug 'editorconfig/editorconfig-vim'

# Install via Vundle
Plugin 'editorconfig/editorconfig-vim'

# Manual installation
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/bundle/editorconfig-vim
```

#### Sublime Text

```bash
# Install Package Control, then:
# Package Control: Install Package
# Search for "EditorConfig"
```

#### Atom

```bash
# Install EditorConfig package
apm install editorconfig
```

## Configuration

### Basic .editorconfig Configuration

```ini
# .editorconfig - Root configuration file

# Indicate this is the root EditorConfig file
root = true

# All files
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Override for specific file types
[*.{js,jsx,ts,tsx}]
indent_size = 2

[*.{py,pyi}]
indent_size = 4

[*.{java,kotlin,scala}]
indent_size = 4

[*.{go}]
indent_style = tab
indent_size = 4

[*.{yaml,yml}]
indent_size = 2

[*.{md,markdown}]
trim_trailing_whitespace = false

[*.{bat,cmd}]
end_of_line = crlf

[Makefile]
indent_style = tab
```

### Advanced Multi-Language Configuration

```ini
# .editorconfig - Comprehensive multi-language setup

root = true

# Default settings for all files
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# Web Development
[*.{html,htm,xhtml}]
indent_size = 2

[*.{css,scss,sass,less,styl}]
indent_size = 2

[*.{js,jsx,mjs,cjs}]
indent_size = 2

[*.{ts,tsx}]
indent_size = 2

[*.{vue,svelte}]
indent_size = 2

# Backend Languages
[*.{py,pyi,pyw}]
indent_size = 4
max_line_length = 88

[*.{java,kt,kts}]
indent_size = 4

[*.{cs,vb}]
indent_size = 4

[*.{php,phtml}]
indent_size = 4

[*.{rb,rake,gemspec}]
indent_size = 2

[*.go]
indent_style = tab
indent_size = 4

[*.rs]
indent_size = 4

[*.{c,cpp,cc,cxx,h,hpp}]
indent_size = 4

# Data and Configuration
[*.{json,jsonc}]
indent_size = 2

[*.{yaml,yml}]
indent_size = 2

[*.{xml,xsd,xsl,xslt}]
indent_size = 2

[*.{toml,ini,cfg}]
indent_size = 4

# Documentation
[*.{md,markdown,mdown,mkd}]
trim_trailing_whitespace = false
indent_size = 2

[*.{rst,txt}]
indent_size = 4

# Database
[*.sql]
indent_size = 2

# Shell scripts
[*.{sh,bash,zsh,fish}]
indent_size = 2

[*.{ps1,psm1,psd1}]
indent_size = 4

# Windows specific
[*.{bat,cmd}]
end_of_line = crlf
indent_size = 4

# Build files
[{Makefile,makefile,GNUmakefile}]
indent_style = tab
indent_size = 4

[*.{gradle,groovy}]
indent_size = 4

[{CMakeLists.txt,*.cmake}]
indent_size = 2

# Docker
[{Dockerfile,*.dockerfile}]
indent_size = 2

# Version control
[.gitignore]
indent_size = 2

[.gitattributes]
indent_size = 2
```

### Project-Specific Configuration Examples

#### React/TypeScript Project

```ini
# .editorconfig for React/TypeScript project

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# JavaScript/TypeScript files
[*.{js,jsx,ts,tsx}]
indent_style = space
indent_size = 2

# JSON files
[*.{json,jsonc}]
indent_style = space
indent_size = 2

# CSS/SCSS files
[*.{css,scss,sass}]
indent_style = space
indent_size = 2

# HTML files
[*.{html,htm}]
indent_style = space
indent_size = 2

# Configuration files
[*.{yml,yaml}]
indent_style = space
indent_size = 2

# Markdown (preserve trailing spaces for line breaks)
[*.md]
trim_trailing_whitespace = false
indent_style = space
indent_size = 2

# Package files
[package.json]
indent_style = space
indent_size = 2
```

#### Python Project

```ini
# .editorconfig for Python project

root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# Python files (PEP 8 compliance)
[*.{py,pyi,pyw}]
indent_style = space
indent_size = 4
max_line_length = 88

# Python configuration
[*.{cfg,ini}]
indent_style = space
indent_size = 4

# Requirements files
[requirements*.txt]
indent_style = space
indent_size = 2

# YAML files (Docker, CI/CD)
[*.{yml,yaml}]
indent_style = space
indent_size = 2

# TOML files (pyproject.toml)
[*.toml]
indent_style = space
indent_size = 4

# Dockerfile
[Dockerfile*]
indent_style = space
indent_size = 2

# Markdown
[*.md]
trim_trailing_whitespace = false
indent_style = space
indent_size = 2
```

## Core Features

### Character Encoding Standardization

- **Purpose**: Ensures consistent character encoding across all files in the project
- **Usage**: Prevents encoding-related issues in multi-developer environments
- **Example**:

```ini
[*]
charset = utf-8  # Forces UTF-8 encoding for all files

[*.{bat,cmd}]
charset = utf-8-bom  # Windows batch files with BOM
```

### Line Ending Normalization

- **Purpose**: Standardizes line endings across different operating systems
- **Usage**: Prevents Git conflicts and ensures consistent file format
- **Example**:

```ini
[*]
end_of_line = lf  # Unix-style line endings (recommended)

[*.{bat,cmd}]
end_of_line = crlf  # Windows scripts require CRLF

[*.ps1]
end_of_line = crlf  # PowerShell scripts
```

### Indentation Consistency

- **Purpose**: Enforces consistent indentation style and size across editors
- **Usage**: Eliminates mixed tabs/spaces and inconsistent indentation
- **Example**:

```ini
# Standard 2-space indentation
[*.{js,ts,css,html}]
indent_style = space
indent_size = 2

# 4-space indentation for backend languages
[*.{py,java,cs}]
indent_style = space
indent_size = 4

# Tab indentation for specific languages
[*.go]
indent_style = tab
indent_size = 4
```

### Whitespace Management

- **Purpose**: Controls trailing whitespace and final newlines
- **Usage**: Maintains clean file formatting and prevents unnecessary diffs
- **Example**:

```ini
[*]
trim_trailing_whitespace = true
insert_final_newline = true

# Exception for Markdown (preserves intentional trailing spaces)
[*.md]
trim_trailing_whitespace = false
```

## Common Commands

```bash
# Essential file operations
touch .editorconfig                   # Create EditorConfig file
cp .editorconfig backup/.editorconfig # Backup configuration
find . -name ".editorconfig"          # Find all EditorConfig files

# Validation and testing
editorconfig-checker .                # Check files against EditorConfig
editorconfig-tools check .            # Validate EditorConfig syntax
editorconfig-tools format .           # Auto-format files

# Integration commands
git add .editorconfig                 # Add to version control
git commit -m "Add EditorConfig"      # Commit configuration
echo ".editorconfig" >> .gitignore    # Exclude from tracking (not recommended)

# Editor integration verification
code .editorconfig                    # Edit in VS Code
vim .editorconfig                     # Edit in Vim
```

## Workflow Integration

### Development Workflow

1. **Setup**: Create `.editorconfig` file in project root with team-agreed standards
2. **Editor Configuration**: Install EditorConfig plugins in all team editors
3. **Development**: Automatic formatting applied as developers work
4. **Quality Assurance**: Consistent style maintained across all contributions
5. **CI/CD**: Optional validation checks to ensure compliance

### Team Onboarding Workflow

```bash
# New team member setup
git clone project-repository
cd project-repository

# Verify EditorConfig presence
ls -la .editorconfig

# Install editor plugin (VS Code example)
code --install-extension EditorConfig.EditorConfig

# Verify plugin is working
echo "Testing EditorConfig..." > test.js
# Open test.js in editor - should apply configured formatting

# Clean up test
rm test.js
```

### Git Hooks Integration

```bash
# .husky/pre-commit - Validate EditorConfig compliance
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check EditorConfig compliance
if command -v editorconfig-checker >/dev/null 2>&1; then
    echo "🔍 Checking EditorConfig compliance..."
    editorconfig-checker

    if [ $? -ne 0 ]; then
        echo "❌ EditorConfig violations found. Please fix formatting issues."
        exit 1
    fi
    echo "✅ EditorConfig compliance verified"
fi
```

### CI/CD Integration

```yaml
# .github/workflows/editorconfig.yml
name: EditorConfig Validation
on: [push, pull_request]

jobs:
  editorconfig:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install EditorConfig Checker
        run: |
          wget https://github.com/editorconfig-checker/editorconfig-checker/releases/latest/download/ec-linux-amd64.tar.gz
          tar -xzf ec-linux-amd64.tar.gz
          sudo mv bin/ec-linux-amd64 /usr/local/bin/editorconfig-checker

      - name: Check EditorConfig
        run: |
          editorconfig-checker

      - name: Report Results
        if: failure()
        run: |
          echo "EditorConfig violations detected. Please ensure your editor has EditorConfig support enabled."
          echo "See https://editorconfig.org/ for setup instructions."
```

## Best Practices

### ✅ **Configuration Best Practices**

- **Place root file strategically** - Put main `.editorconfig` at project root with `root = true`
- **Use specific patterns** - Target specific file types rather than overly broad patterns
- **Document team standards** - Include comments explaining non-obvious choices
- **Test across editors** - Verify configuration works with all team members' editors
- **Keep it simple** - Focus on essential formatting rules, avoid over-configuration
- **Version control inclusion** - Always commit `.editorconfig` to repository

### ✅ **Pattern Matching Best Practices**

- **Be specific with extensions** - Use `*.{js,jsx,ts,tsx}` instead of `*` when possible
- **Consider file naming conventions** - Account for common file naming patterns
- **Handle special cases** - Explicitly configure exceptions like Makefiles or batch files
- **Use hierarchical configs** - Place specific `.editorconfig` files in subdirectories when needed
- **Test pattern matching** - Verify patterns match intended files correctly
- **Document complex patterns** - Add comments for non-obvious pattern choices

### ✅ **Team Collaboration**

- **Establish before coding** - Set up EditorConfig early in project lifecycle
- **Communicate requirements** - Ensure all team members understand and install plugins
- **Provide setup documentation** - Include editor-specific setup instructions in README
- **Regular compliance checks** - Use automated tools to verify ongoing compliance
- **Handle legacy code gradually** - Apply standards incrementally to existing codebases
- **Consider language conventions** - Align with established conventions for each language

### ❌ **Common Pitfalls to Avoid**

- **Don't over-specify** - Avoid configuring every possible option when defaults work
- **Avoid conflicting tools** - Ensure EditorConfig doesn't conflict with Prettier or similar tools
- **Don't ignore editor differences** - Test configuration across different editors used by team
- **Avoid platform assumptions** - Consider cross-platform development requirements
- **Don't skip plugin installation** - Verify all team members have proper editor support
- **Avoid inconsistent hierarchies** - Maintain clear and logical configuration hierarchy

## Advanced EditorConfig Usage

### Hierarchical Configuration

```ini
# Root .editorconfig
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

# General defaults
[*.{js,ts,css,html}]
indent_style = space
indent_size = 2
```

```ini
# src/legacy/.editorconfig - Override for legacy code
[*]
# Inherit from parent, but don't enforce trailing whitespace removal
trim_trailing_whitespace = false

[*.js]
# Legacy JavaScript uses 4-space indentation
indent_size = 4
```

### Complex Pattern Matching

```ini
# Advanced pattern examples

# Multiple extensions with braces
[*.{js,jsx,ts,tsx,vue,svelte}]
indent_size = 2

# Glob patterns for specific directories
[src/**/*.{py,pyi}]
indent_size = 4

# Negation patterns (files to exclude)
[{package-lock.json,yarn.lock}]
# No formatting rules for lock files

# Specific filenames
[{Dockerfile,docker-compose.yml,docker-compose.yaml}]
indent_size = 2

# Complex directory patterns
[{test,tests,spec,specs}/**/*.{js,ts}]
# Test files might have different rules

# File path patterns
[scripts/*.{sh,bash}]
indent_size = 2
end_of_line = lf

# Configuration file patterns
[{.*rc,*.config.{js,ts,json}}]
indent_size = 2
```

### Language-Specific Advanced Rules

```ini
# Language-specific advanced configurations

# Python with PEP 8 compliance
[*.{py,pyi,pyw}]
indent_style = space
indent_size = 4
max_line_length = 88
trim_trailing_whitespace = true

# Go with standard formatting
[*.go]
indent_style = tab
indent_size = 4
max_line_length = 120

# Rust formatting
[*.rs]
indent_style = space
indent_size = 4
max_line_length = 100

# Java/Kotlin enterprise standards
[*.{java,kt,kts}]
indent_style = space
indent_size = 4
max_line_length = 120

# C/C++ with specific style
[*.{c,cpp,cc,cxx,h,hpp}]
indent_style = space
indent_size = 4
max_line_length = 100

# Ruby conventions
[*.{rb,rake,gemspec}]
indent_style = space
indent_size = 2
max_line_length = 120

# PHP standards
[*.{php,phtml}]
indent_style = space
indent_size = 4
max_line_length = 120
```

## Integration with Other Tools

### Prettier Integration

```json
// .prettierrc.json - Coordinated with EditorConfig
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "useTabs": false,
  "trailingComma": "es5",
  "endOfLine": "lf"
}
```

```ini
# .editorconfig - Compatible with Prettier
[*.{js,jsx,ts,tsx,json,css,scss,md}]
indent_style = space
indent_size = 2
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false  # Prettier handles this
```

### ESLint Integration

```json
// .eslintrc.json - Uses EditorConfig for base formatting
{
  "extends": ["eslint:recommended", "@typescript-eslint/recommended"],
  "rules": {
    "indent": ["error", 2], // Matches EditorConfig
    "linebreak-style": ["error", "unix"], // Matches end_of_line = lf
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
```

### VS Code Settings Integration

```json
// .vscode/settings.json - Respects EditorConfig
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "files.eol": "
",
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "editor.detectIndentation": false,  // Use EditorConfig instead
  "editor.insertSpaces": true,
  "editor.tabSize": 2
}
```

### Git Configuration Integration

```ini
# .gitattributes - Coordinates with EditorConfig
* text=auto eol=lf

# Binary files
*.png binary
*.jpg binary
*.pdf binary

# Text files with specific handling
*.md text eol=lf
*.sh text eol=lf
*.bat text eol=crlf
*.ps1 text eol=crlf

# Generated files
package-lock.json linguist-generated=true
yarn.lock linguist-generated=true
```

## Troubleshooting

### Common Issues

#### EditorConfig Not Working

**Problem**: Editor not applying EditorConfig rules
**Symptoms**: Indentation and formatting not changing according to configuration
**Solution**:

```bash
# Check if .editorconfig file exists and is properly placed
ls -la .editorconfig

# Verify file content and syntax
cat .editorconfig

# Check editor plugin installation
# VS Code:
code --list-extensions | grep EditorConfig

# Restart editor after plugin installation
# Close and reopen all files to apply new rules
```

#### Conflicting Formatting Tools

**Problem**: EditorConfig conflicts with Prettier, ESLint, or other formatters
**Symptoms**: Inconsistent formatting or constant format changes
**Solution**:

```bash
# Check tool configurations for compatibility
cat .prettierrc.json
cat .editorconfig

# Align configurations
# Example: Make sure indent_size matches Prettier tabWidth
# Example: Ensure end_of_line matches Prettier endOfLine

# Use .editorconfig-ignore for problematic files
echo "generated/**" >> .editorconfig-ignore
```

#### Platform-Specific Issues

**Problem**: Different behavior on Windows, macOS, and Linux
**Symptoms**: Line ending conflicts or encoding issues
**Solution**:

```ini
# .editorconfig - Cross-platform compatibility
[*]
charset = utf-8
end_of_line = lf  # Use LF for most files

# Exception for Windows-specific files
[*.{bat,cmd,ps1}]
end_of_line = crlf

# Git configuration to handle line endings
# git config core.autocrlf input  # On macOS/Linux
# git config core.autocrlf true   # On Windows
```

#### Pattern Matching Issues

**Problem**: Rules not applying to expected files
**Symptoms**: Some files not following EditorConfig rules
**Solution**:

```bash
# Test pattern matching
# Create test files and check if rules apply

# Debug pattern syntax
# Use specific patterns instead of complex globs
[*.js]        # Instead of [**/*.js]
[src/*.py]    # Instead of [src/**/*.py]

# Check for typos in file extensions
[*.{js,jsx,ts,tsx}]  # Correct
[*.{js,jsx,ts,tsx]   # Missing closing brace - incorrect
```

### Debug Mode

```bash
# Validate EditorConfig file syntax
editorconfig-checker --version
editorconfig-checker .editorconfig

# Test specific files
editorconfig-checker src/component.js

# Verbose output
editorconfig-checker --verbose .

# Check what rules apply to specific files
editorconfig-tools query src/component.js
```

### Performance Optimization

```ini
# Optimize large projects
[*]
# Use minimal essential rules
charset = utf-8
end_of_line = lf
insert_final_newline = true

# Avoid overly complex patterns
[*.js]  # Better than [**/*.{js,jsx,ts,tsx,vue,svelte}]

# Use directory-specific configs for performance
# Place .editorconfig in subdirectories instead of complex root patterns
```

## Security Considerations

### Security Best Practices

- **Validate configuration sources** - Only use trusted `.editorconfig` files from known sources
- **Review inherited configurations** - Check parent directory configurations in complex projects
- **Limit file access scope** - Use specific patterns to avoid affecting system files
- **Protect against malicious patterns** - Avoid patterns that could match sensitive files
- **Version control security** - Ensure `.editorconfig` is properly tracked and reviewed
- **Plugin security** - Keep editor plugins updated to latest secure versions

### File Access Control

```ini
# Safe pattern examples
[src/**/*.{js,ts}]  # Limited to src directory
[*.{js,ts,css}]     # Specific file types only

# Avoid overly broad patterns
# [**/*]            # Too broad - could affect system files
# [.*]              # Could affect hidden system files

# Safe project-specific patterns
[{src,test,docs}/**/*]  # Explicit directory list
[!node_modules/**]      # Exclude dependencies
```

### Configuration Validation

```bash
# Validate EditorConfig files before committing
editorconfig-checker .editorconfig

# Automated validation in CI
npm install --save-dev editorconfig-checker
echo "editorconfig-checker" >> package.json scripts.lint

# Pre-commit hook validation
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Validate EditorConfig
if command -v editorconfig-checker >/dev/null 2>&1; then
    editorconfig-checker
fi
EOF
```

## AI Assistant Guidelines

When helping with EditorConfig:

1. **Always suggest placing `.editorconfig` at project root** with `root = true` directive
2. **Provide language-specific configurations** that follow established conventions for each language
3. **Include cross-platform considerations** for line endings and character encoding
4. **Suggest integration patterns** with popular formatting tools like Prettier and ESLint
5. **Provide debugging strategies** for editor plugin issues and pattern matching problems
6. **Include team onboarding guidance** for ensuring all developers have proper setup
7. **Reference security considerations** for file patterns and configuration validation
8. **Suggest automation opportunities** with Git hooks and CI/CD integration

### Code Generation Rules

- Generate `.editorconfig` files with clear section organization and comments
- Include appropriate patterns for the specific technology stack and project structure
- Provide cross-platform compatible settings with proper line ending configuration
- Follow established language conventions for indentation and formatting
- Include validation mechanisms and testing approaches for generated configurations
- Generate editor-specific setup instructions and troubleshooting guides
- Provide integration examples with popular development tools and workflows
- Include security considerations and best practices in generated configurations

## Installation & Setup

### EditorConfig File Creation

```bash
# Create .editorconfig in project root
touch .editorconfig

# Alternative: create in subdirectories for specific rules
mkdir -p src/frontend
touch src/frontend/.editorconfig

# Verify file placement
find . -name ".editorconfig" -type f
```

### Editor Plugin Installation

#### Visual Studio Code

```bash
# Install EditorConfig extension
code --install-extension EditorConfig.EditorConfig

# Verify installation
code --list-extensions | grep EditorConfig
```

#### JetBrains IDEs (IntelliJ, WebStorm, PyCharm)

```text
Built-in support (no plugin required)
File → Settings → Editor → Code Style → EditorConfig
Enable "Enable EditorConfig support"
```

#### Vim/Neovim

```bash
# Install via vim-plug
# Add to .vimrc or init.vim:
Plug 'editorconfig/editorconfig-vim'

# Install via Vundle
Plugin 'editorconfig/editorconfig-vim'

# Manual installation
git clone https://github.com/editorconfig/editorconfig-vim.git ~/.vim/bundle/editorconfig-vim
```

#### Sublime Text

```bash
# Install Package Control, then:
# Package Control: Install Package
# Search for "EditorConfig"
```

#### Atom

```bash
# Install EditorConfig package
apm install editorconfig
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
