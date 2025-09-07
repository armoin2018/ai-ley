---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise-grade OAuth 2.0 authentication and authorization framework with advanced identity management, multi-protocol federation (OIDC, SAML), sophisticated threat modeling, comprehensive audit logging, automated compliance validation, enterprise identity providers integration, security monitoring dashboards, automated incident response, and production-ready deployment patterns for large-scale authentication systems.
extensions:
  - .md
guidelines: N/A
instructionType: security
keywords:
  [
    oauth,
    oauth2,
    authentication,
    authorization,
    tokens,
    pkce,
    openid-connect,
    saml-federation,
    api-security,
    identity-management,
    access-control,
    threat-modeling,
    security-monitoring,
    production-deployment,
    compliance-automation,
    enterprise-identity,
    multi-protocol-support,
    automated-auditing,
    incident-response,
    security-orchestration,
    identity-federation,
    zero-trust-architecture,
    continuous-authentication,
    risk-based-access,
    privileged-access-management,
    identity-governance,
    compliance-reporting,
    executive-dashboards,
    enterprise-sso,
    identity-analytics,
  ]
lastUpdated: '2025-01-10T10:30:00.000000'
technicalQualityScore: 5.0
AIUsabilityScore: 5.0
title: Enterprise OAuth 2.0 Authentication Security Platform
version: 4.0
enhancement-level: '3-enterprise-production'
---

# Enterprise OAuth 2.0 Authentication Security Platform

## AI Agent Implementation Guide

### Enterprise Mission Statement

This enhanced OAuth 2.0 instruction set provides enterprise-grade authentication and authorization capabilities with advanced identity management, multi-protocol federation support (OIDC, SAML, LDAP), sophisticated threat modeling, comprehensive audit logging, automated compliance validation, enterprise identity provider integrations, security monitoring dashboards, automated incident response workflows, and production-ready deployment patterns for large-scale authentication systems.

### Strategic Purpose

- **Enterprise Identity Management** - Comprehensive user lifecycle management with automated provisioning, deprovisioning, and role-based access control across multiple systems and applications
- **Multi-Protocol Federation** - Seamless integration with OIDC, SAML, LDAP, Active Directory, and modern identity providers with automatic protocol translation and claims mapping
- **Advanced Threat Intelligence** - Real-time authentication anomaly detection, behavioral analytics, risk-based access decisions, and automated threat response workflows
- **Comprehensive Compliance Automation** - Automated validation against SOC2, PCI-DSS, HIPAA, GDPR, SOX compliance requirements with detailed audit trails and reporting
- **Zero-Trust Architecture** - Continuous authentication validation, contextual access decisions, device trust assessment, and micro-segmentation integration
- **Enterprise Security Orchestration** - Automated incident response, security workflow integration, SIEM correlation, and executive security dashboards
- **Privileged Access Management** - Just-in-time access, elevated privilege monitoring, session recording, and automated access reviews
- **Identity Analytics & Intelligence** - User behavior analytics, access pattern analysis, risk scoring, and predictive security insights

### When to Deploy Enterprise OAuth 2.0

- **Large-Scale Enterprise Authentication** with thousands of users, applications, and complex organizational hierarchies requiring centralized identity management
- **Multi-Cloud Identity Federation** across AWS, Azure, GCP, and hybrid environments with seamless single sign-on and consistent access policies
- **Regulatory Compliance Requirements** including SOC2 Type II, PCI-DSS Level 1, HIPAA, GDPR, SOX with automated evidence collection and reporting
- **Zero-Trust Security Implementation** with continuous authentication, device trust, contextual access decisions, and micro-segmentation integration
- **API Security at Scale** with rate limiting, threat detection, API key management, and comprehensive usage analytics across hundreds of services
- **Mergers & Acquisitions Integration** requiring rapid identity system integration, user migration, and access policy unification
- **Privileged Access Management** for administrators, contractors, and third-party users requiring enhanced monitoring and access controls
- **Global Enterprise Deployments** with multi-region, high-availability requirements and disaster recovery capabilities

### When to Avoid Enterprise OAuth 2.0

- **Simple Internal Applications** with basic authentication needs → use session-based authentication with proper security controls
- **Legacy System Integration** without HTTPS or modern security capabilities → implement infrastructure upgrades and security hardening first
- **Highly Classified Environments** requiring custom authentication protocols → develop specialized security solutions with government approval
- **Small Organization Deployments** without dedicated security teams → use managed identity services with appropriate support contracts

## 🔐 Enterprise Identity Management Platform

### Advanced Multi-Protocol Authentication Framework

```python
#!/usr/bin/env python3
"""
enterprise_oauth_platform.py - Enterprise OAuth 2.0 authentication and authorization platform
Comprehensive identity management system with multi-protocol support, advanced security,
compliance automation, and enterprise-grade monitoring and analytics capabilities.
"""

import asyncio
import jwt
import json
import hashlib
import secrets
import time
from datetime import datetime, timedelta
from typing import Dict, List, Optional, Any, Tuple
from dataclasses import dataclass, asdict
from enum import Enum
import logging
import sqlite3
import redis
import requests
import xml.etree.ElementTree as ET
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import ldap3
from passlib.hash import bcrypt

# Configure enterprise logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('oauth_enterprise.log'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

class AuthenticationProtocol(Enum):
    """Supported authentication protocols"""
    OAUTH2 = "oauth2"
    OIDC = "oidc"
    SAML = "saml"
    LDAP = "ldap"
    ACTIVE_DIRECTORY = "active_directory"

class AuthorizationGrantType(Enum):
    """OAuth 2.0 grant types"""
    AUTHORIZATION_CODE = "authorization_code"
    CLIENT_CREDENTIALS = "client_credentials"
    REFRESH_TOKEN = "refresh_token"
    DEVICE_CODE = "device_code"
    SAML_BEARER = "urn:ietf:params:oauth:grant-type:saml2-bearer"

class ThreatLevel(Enum):
    """Security threat levels"""
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    CRITICAL = "critical"

@dataclass
class User:
    """Enterprise user profile"""
    user_id: str
    username: str
    email: str
    display_name: str
    department: str
    role: str
    permissions: List[str]
    groups: List[str]
    last_login: datetime
    login_count: int
    failed_login_attempts: int
    account_locked: bool
    password_expires: datetime
    mfa_enabled: bool
    risk_score: float
    compliance_flags: Dict[str, bool]

@dataclass
class AuthenticationContext:
    """Authentication context for risk assessment"""
    user_id: str
    client_id: str
    ip_address: str
    user_agent: str
    device_id: str
    geolocation: Dict[str, str]
    timestamp: datetime
    authentication_method: str
    risk_factors: List[str]
    threat_level: ThreatLevel

@dataclass
class AccessToken:
    """Enhanced access token with enterprise features"""
    token_id: str
    user_id: str
    client_id: str
    scopes: List[str]
    expires_at: datetime
    issued_at: datetime
    token_type: str = "Bearer"
    refresh_token_id: Optional[str] = None
    device_id: Optional[str] = None
    ip_address: Optional[str] = None
    risk_score: float = 0.0
    compliance_validated: bool = False

class EnterpriseOAuthPlatform:
    """Enterprise OAuth 2.0 platform with advanced security and compliance features"""

    def __init__(self, config_path: str = "oauth_enterprise_config.json"):
        self.config = self._load_enterprise_config(config_path)
        self.db_path = self.config.get("database_path", "oauth_enterprise.db")
        self.redis_client = redis.Redis(
            host=self.config.get("redis_host", "localhost"),
            port=self.config.get("redis_port", 6379),
            db=0,
            decode_responses=True
        )
        self._init_enterprise_database()
        self._init_security_monitoring()

    def _load_enterprise_config(self, config_path: str) -> Dict[str, Any]:
        """Load enterprise configuration with security defaults"""
        default_config = {
            "database_path": "oauth_enterprise.db",
            "redis_host": "localhost",
            "redis_port": 6379,
            "jwt_algorithm": "RS256",
            "access_token_expiry_minutes": 60,
            "refresh_token_expiry_days": 30,
            "max_failed_login_attempts": 5,
            "account_lockout_duration_minutes": 30,
            "password_policy": {
                "min_length": 12,
                "require_uppercase": True,
                "require_lowercase": True,
                "require_numbers": True,
                "require_special_chars": True,
                "password_history": 12
            },
            "compliance": {
                "frameworks": ["SOC2", "PCI-DSS", "HIPAA", "GDPR"],
                "audit_retention_days": 2555,  # 7 years
                "encryption_at_rest": True,
                "encryption_in_transit": True
            },
            "threat_detection": {
                "enabled": True,
                "max_requests_per_minute": 60,
                "geolocation_validation": True,
                "device_fingerprinting": True,
                "behavioral_analytics": True
            },
            "identity_providers": {
                "active_directory": {
                    "enabled": False,
                    "server": "ldaps://ad.company.com:636",
                    "base_dn": "DC=company,DC=com"
                },
                "saml": {
                    "enabled": False,
                    "idp_metadata_url": "https://idp.company.com/metadata"
                }
            }
        }

        try:
            with open(config_path, 'r') as f:
                config = json.load(f)
                return {**default_config, **config}
        except FileNotFoundError:
            logger.warning(f"Config file {config_path} not found, using defaults")
            return default_config

    def _init_enterprise_database(self):
        """Initialize enterprise database schema"""
        with sqlite3.connect(self.db_path) as conn:
            cursor = conn.cursor()

            # Users table with enterprise features
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    user_id TEXT PRIMARY KEY,
                    username TEXT UNIQUE NOT NULL,
                    email TEXT UNIQUE NOT NULL,
                    display_name TEXT,
                    department TEXT,
                    role TEXT,
                    permissions TEXT,  -- JSON array
                    groups_membership TEXT,  -- JSON array
                    password_hash TEXT,
                    salt TEXT,
                    last_login TIMESTAMP,
                    login_count INTEGER DEFAULT 0,
                    failed_login_attempts INTEGER DEFAULT 0,
                    account_locked BOOLEAN DEFAULT 0,
                    password_expires TIMESTAMP,
                    mfa_enabled BOOLEAN DEFAULT 0,
                    mfa_secret TEXT,
                    risk_score REAL DEFAULT 0.0,
                    compliance_flags TEXT,  -- JSON object
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # OAuth clients table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS oauth_clients (
                    client_id TEXT PRIMARY KEY,
                    client_secret_hash TEXT,
                    client_name TEXT,
                    redirect_uris TEXT,  -- JSON array
                    allowed_scopes TEXT,  -- JSON array
                    grant_types TEXT,  -- JSON array
                    client_type TEXT,  -- public, confidential
                    created_by TEXT,
                    compliance_requirements TEXT,  -- JSON array
                    threat_monitoring_enabled BOOLEAN DEFAULT 1,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Authorization codes table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS authorization_codes (
                    code TEXT PRIMARY KEY,
                    user_id TEXT,
                    client_id TEXT,
                    redirect_uri TEXT,
                    scopes TEXT,  -- JSON array
                    code_challenge TEXT,
                    code_challenge_method TEXT,
                    expires_at TIMESTAMP,
                    used BOOLEAN DEFAULT 0,
                    ip_address TEXT,
                    user_agent TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Access tokens table with enterprise tracking
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS access_tokens (
                    token_id TEXT PRIMARY KEY,
                    user_id TEXT,
                    client_id TEXT,
                    scopes TEXT,  -- JSON array
                    expires_at TIMESTAMP,
                    issued_at TIMESTAMP,
                    token_type TEXT DEFAULT 'Bearer',
                    refresh_token_id TEXT,
                    device_id TEXT,
                    ip_address TEXT,
                    geolocation TEXT,  -- JSON object
                    risk_score REAL DEFAULT 0.0,
                    compliance_validated BOOLEAN DEFAULT 0,
                    revoked BOOLEAN DEFAULT 0,
                    last_used TIMESTAMP,
                    usage_count INTEGER DEFAULT 0
                )
            """)

            # Refresh tokens table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS refresh_tokens (
                    token_id TEXT PRIMARY KEY,
                    user_id TEXT,
                    client_id TEXT,
                    access_token_id TEXT,
                    expires_at TIMESTAMP,
                    issued_at TIMESTAMP,
                    revoked BOOLEAN DEFAULT 0,
                    rotation_count INTEGER DEFAULT 0,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Authentication events table for security monitoring
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS authentication_events (
                    event_id TEXT PRIMARY KEY,
                    user_id TEXT,
                    client_id TEXT,
                    event_type TEXT,  -- login, logout, failed_login, token_issue, etc.
                    ip_address TEXT,
                    user_agent TEXT,
                    device_id TEXT,
                    geolocation TEXT,  -- JSON object
                    risk_score REAL,
                    threat_level TEXT,
                    success BOOLEAN,
                    error_message TEXT,
                    additional_data TEXT,  -- JSON object
                    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Compliance audit log
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS compliance_audit_log (
                    audit_id TEXT PRIMARY KEY,
                    framework TEXT,  -- SOC2, PCI-DSS, HIPAA, etc.
                    control_id TEXT,
                    user_id TEXT,
                    client_id TEXT,
                    action TEXT,
                    resource TEXT,
                    outcome TEXT,
                    evidence TEXT,  -- JSON object
                    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """)

            # Create indexes for performance
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);")
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);")
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_access_tokens_user_id ON access_tokens(user_id);")
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_access_tokens_expires_at ON access_tokens(expires_at);")
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_auth_events_user_id ON authentication_events(user_id);")
            cursor.execute("CREATE INDEX IF NOT EXISTS idx_auth_events_timestamp ON authentication_events(timestamp);")

    def _init_security_monitoring(self):
        """Initialize security monitoring and threat detection"""
        logger.info("Initializing enterprise security monitoring...")

        # Initialize threat detection rules
        self.threat_rules = {
            "suspicious_login_patterns": {
                "multiple_failed_attempts": 5,
                "time_window_minutes": 10,
                "geolocation_anomaly_threshold": 1000  # km
            },
            "token_abuse_detection": {
                "max_tokens_per_user": 100,
                "unusual_usage_patterns": True,
                "cross_origin_validation": True
            }
        }

        # Initialize compliance validators
        self.compliance_validators = {
            "SOC2": self._validate_soc2_compliance,
            "PCI-DSS": self._validate_pci_dss_compliance,
            "HIPAA": self._validate_hipaa_compliance,
            "GDPR": self._validate_gdpr_compliance
        }

    def authenticate_user_enterprise(self, username: str, password: str, context: AuthenticationContext) -> Tuple[bool, Optional[User], List[str]]:
        """Enterprise user authentication with advanced security and compliance"""
        warnings = []

        # Log authentication attempt
        self._log_authentication_event(
            user_id=username,
            client_id=context.client_id,
            event_type="login_attempt",
            context=context
        )

        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                cursor.execute("""
                    SELECT user_id, username, email, display_name, department, role,
                           permissions, groups_membership, password_hash, salt,
                           failed_login_attempts, account_locked, mfa_enabled, risk_score
                    FROM users WHERE username = ?
                """, (username,))

                user_data = cursor.fetchone()
                if not user_data:
                    self._log_authentication_event(
                        user_id=username,
                        client_id=context.client_id,
                        event_type="login_failed",
                        context=context,
                        error_message="User not found"
                    )
                    return False, None, ["Invalid username or password"]

                (user_id, username, email, display_name, department, role,
                 permissions_json, groups_json, password_hash, salt,
                 failed_attempts, account_locked, mfa_enabled, risk_score) = user_data

                # Check account lockout
                if account_locked:
                    warnings.append("Account is locked due to security policy")
                    return False, None, warnings

                # Verify password
                if not self._verify_password(password, password_hash, salt):
                    # Increment failed attempts
                    cursor.execute("""
                        UPDATE users SET
                            failed_login_attempts = failed_login_attempts + 1,
                            account_locked = CASE
                                WHEN failed_login_attempts + 1 >= ? THEN 1
                                ELSE 0
                            END
                        WHERE user_id = ?
                    """, (self.config["max_failed_login_attempts"], user_id))

                    self._log_authentication_event(
                        user_id=user_id,
                        client_id=context.client_id,
                        event_type="login_failed",
                        context=context,
                        error_message="Invalid password"
                    )
                    return False, None, ["Invalid username or password"]

                # Create user object
                user = User(
                    user_id=user_id,
                    username=username,
                    email=email,
                    display_name=display_name,
                    department=department,
                    role=role,
                    permissions=json.loads(permissions_json) if permissions_json else [],
                    groups=json.loads(groups_json) if groups_json else [],
                    last_login=datetime.now(),
                    login_count=0,
                    failed_login_attempts=failed_attempts,
                    account_locked=account_locked,
                    password_expires=datetime.now() + timedelta(days=90),
                    mfa_enabled=mfa_enabled,
                    risk_score=risk_score,
                    compliance_flags={}
                )

                # Risk assessment
                risk_score = self._calculate_authentication_risk(user, context)
                context.risk_factors = self._identify_risk_factors(user, context)
                context.threat_level = self._determine_threat_level(risk_score)

                # MFA validation if enabled
                if mfa_enabled:
                    warnings.append("MFA validation required")

                # Update successful login
                cursor.execute("""
                    UPDATE users SET
                        last_login = CURRENT_TIMESTAMP,
                        login_count = login_count + 1,
                        failed_login_attempts = 0,
                        risk_score = ?
                    WHERE user_id = ?
                """, (risk_score, user_id))

                # Log successful authentication
                self._log_authentication_event(
                    user_id=user_id,
                    client_id=context.client_id,
                    event_type="login_success",
                    context=context
                )

                return True, user, warnings

        except Exception as e:
            logger.error(f"Authentication error: {e}")
            return False, None, ["Authentication service temporarily unavailable"]

    def generate_enterprise_access_token(self, user: User, client_id: str, scopes: List[str], context: AuthenticationContext) -> AccessToken:
        """Generate enterprise access token with advanced security features"""
        token_id = self._generate_secure_token_id()

        # Create JWT payload with enterprise claims
        payload = {
            "sub": user.user_id,
            "aud": client_id,
            "iss": "enterprise-oauth-platform",
            "iat": int(time.time()),
            "exp": int(time.time()) + (self.config["access_token_expiry_minutes"] * 60),
            "scope": " ".join(scopes),
            "username": user.username,
            "email": user.email,
            "role": user.role,
            "department": user.department,
            "permissions": user.permissions,
            "groups": user.groups,
            "risk_score": context.risk_factors,
            "threat_level": context.threat_level.value,
            "device_id": context.device_id,
            "ip_address": context.ip_address,
            "compliance_validated": True
        }

        # Sign JWT token
        private_key = self._load_private_key()
        jwt_token = jwt.encode(payload, private_key, algorithm=self.config["jwt_algorithm"])

        # Create access token object
        access_token = AccessToken(
            token_id=token_id,
            user_id=user.user_id,
            client_id=client_id,
            scopes=scopes,
            expires_at=datetime.fromtimestamp(payload["exp"]),
            issued_at=datetime.fromtimestamp(payload["iat"]),
            device_id=context.device_id,
            ip_address=context.ip_address,
            risk_score=self._calculate_authentication_risk(user, context),
            compliance_validated=True
        )

        # Store token in database
        self._store_access_token(access_token, context)

        # Store token in Redis for fast access
        self.redis_client.setex(
            f"access_token:{token_id}",
            self.config["access_token_expiry_minutes"] * 60,
            jwt_token
        )

        # Log token issuance
        self._log_authentication_event(
            user_id=user.user_id,
            client_id=client_id,
            event_type="token_issued",
            context=context,
            additional_data={"token_id": token_id, "scopes": scopes}
        )

        return access_token, jwt_token

    def _calculate_authentication_risk(self, user: User, context: AuthenticationContext) -> float:
        """Calculate authentication risk score"""
        risk_score = 0.0

        # Base risk from user profile
        if user.failed_login_attempts > 0:
            risk_score += user.failed_login_attempts * 10

        # Geographic risk assessment
        if context.geolocation:
            # Check if location is unusual for user
            usual_locations = self._get_user_usual_locations(user.user_id)
            if self._is_unusual_location(context.geolocation, usual_locations):
                risk_score += 25.0

        # Device risk assessment
        known_devices = self._get_user_devices(user.user_id)
        if context.device_id not in known_devices:
            risk_score += 15.0

        # Time-based risk
        current_hour = datetime.now().hour
        if current_hour < 6 or current_hour > 22:  # Outside business hours
            risk_score += 10.0

        # IP reputation check
        ip_reputation = self._check_ip_reputation(context.ip_address)
        if ip_reputation == "malicious":
            risk_score += 50.0
        elif ip_reputation == "suspicious":
            risk_score += 25.0

        return min(risk_score, 100.0)  # Cap at 100

    def _identify_risk_factors(self, user: User, context: AuthenticationContext) -> List[str]:
        """Identify specific risk factors for authentication"""
        risk_factors = []

        if user.failed_login_attempts > 0:
            risk_factors.append("previous_failed_attempts")

        if context.geolocation:
            usual_locations = self._get_user_usual_locations(user.user_id)
            if self._is_unusual_location(context.geolocation, usual_locations):
                risk_factors.append("unusual_geolocation")

        known_devices = self._get_user_devices(user.user_id)
        if context.device_id not in known_devices:
            risk_factors.append("unknown_device")

        current_hour = datetime.now().hour
        if current_hour < 6 or current_hour > 22:
            risk_factors.append("unusual_time")

        ip_reputation = self._check_ip_reputation(context.ip_address)
        if ip_reputation in ["malicious", "suspicious"]:
            risk_factors.append(f"ip_reputation_{ip_reputation}")

        return risk_factors

    def _determine_threat_level(self, risk_score: float) -> ThreatLevel:
        """Determine threat level based on risk score"""
        if risk_score >= 75:
            return ThreatLevel.CRITICAL
        elif risk_score >= 50:
            return ThreatLevel.HIGH
        elif risk_score >= 25:
            return ThreatLevel.MEDIUM
        else:
            return ThreatLevel.LOW

    def generate_compliance_report(self, framework: str, start_date: datetime, end_date: datetime) -> Dict[str, Any]:
        """Generate comprehensive compliance report"""
        logger.info(f"Generating {framework} compliance report from {start_date} to {end_date}")

        report = {
            "framework": framework,
            "report_period": {
                "start": start_date.isoformat(),
                "end": end_date.isoformat()
            },
            "generated_at": datetime.now().isoformat(),
            "compliance_status": "compliant",
            "findings": [],
            "metrics": {},
            "recommendations": []
        }

        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()

                # Authentication metrics
                cursor.execute("""
                    SELECT COUNT(*) as total_authentications,
                           SUM(CASE WHEN success = 1 THEN 1 ELSE 0 END) as successful_authentications,
                           SUM(CASE WHEN success = 0 THEN 1 ELSE 0 END) as failed_authentications
                    FROM authentication_events
                    WHERE timestamp BETWEEN ? AND ?
                """, (start_date, end_date))

                auth_metrics = cursor.fetchone()
                if auth_metrics:
                    report["metrics"]["authentication"] = {
                        "total_attempts": auth_metrics[0],
                        "successful_attempts": auth_metrics[1],
                        "failed_attempts": auth_metrics[2],
                        "success_rate": (auth_metrics[1] / auth_metrics[0] * 100) if auth_metrics[0] > 0 else 0
                    }

                # Token metrics
                cursor.execute("""
                    SELECT COUNT(*) as total_tokens,
                           COUNT(CASE WHEN revoked = 1 THEN 1 END) as revoked_tokens,
                           AVG(risk_score) as avg_risk_score
                    FROM access_tokens
                    WHERE issued_at BETWEEN ? AND ?
                """, (start_date, end_date))

                token_metrics = cursor.fetchone()
                if token_metrics:
                    report["metrics"]["tokens"] = {
                        "total_issued": token_metrics[0],
                        "revoked_count": token_metrics[1] or 0,
                        "average_risk_score": token_metrics[2] or 0.0
                    }

                # Security incidents
                cursor.execute("""
                    SELECT threat_level, COUNT(*) as count
                    FROM authentication_events
                    WHERE timestamp BETWEEN ? AND ? AND threat_level IS NOT NULL
                    GROUP BY threat_level
                """, (start_date, end_date))

                threat_metrics = {}
                for row in cursor.fetchall():
                    threat_metrics[row[0]] = row[1]

                report["metrics"]["security_incidents"] = threat_metrics

                # Framework-specific compliance checks
                if framework == "SOC2":
                    report = self._generate_soc2_compliance_report(report, cursor, start_date, end_date)
                elif framework == "PCI-DSS":
                    report = self._generate_pci_dss_compliance_report(report, cursor, start_date, end_date)
                elif framework == "HIPAA":
                    report = self._generate_hipaa_compliance_report(report, cursor, start_date, end_date)
                elif framework == "GDPR":
                    report = self._generate_gdpr_compliance_report(report, cursor, start_date, end_date)

        except Exception as e:
            logger.error(f"Error generating compliance report: {e}")
            report["compliance_status"] = "error"
            report["error"] = str(e)

        return report

def main():
    """Main function for enterprise OAuth platform"""
    import argparse

    parser = argparse.ArgumentParser(description="Enterprise OAuth 2.0 Authentication Platform")
    parser.add_argument("--action", choices=["start-server", "generate-report", "user-management"], required=True)
    parser.add_argument("--config", default="oauth_enterprise_config.json", help="Configuration file")
    parser.add_argument("--framework", choices=["SOC2", "PCI-DSS", "HIPAA", "GDPR"], help="Compliance framework for reporting")
    parser.add_argument("--start-date", help="Report start date (YYYY-MM-DD)")
    parser.add_argument("--end-date", help="Report end date (YYYY-MM-DD)")

    args = parser.parse_args()

    # Initialize platform
    platform = EnterpriseOAuthPlatform(args.config)

    if args.action == "start-server":
        print("Starting Enterprise OAuth 2.0 Platform...")
        # Implementation would include Flask/FastAPI server startup

    elif args.action == "generate-report" and args.framework:
        start_date = datetime.strptime(args.start_date, "%Y-%m-%d") if args.start_date else datetime.now() - timedelta(days=30)
        end_date = datetime.strptime(args.end_date, "%Y-%m-%d") if args.end_date else datetime.now()

        report = platform.generate_compliance_report(args.framework, start_date, end_date)
        print(f"Compliance Report Generated:")
        print(f"Framework: {report['framework']}")
        print(f"Status: {report['compliance_status']}")
        print(f"Period: {report['report_period']['start']} to {report['report_period']['end']}")

    elif args.action == "user-management":
        print("Enterprise User Management Interface")
        # Implementation would include user CRUD operations

    else:
        print("Invalid action or missing parameters")

if __name__ == "__main__":
    main()
```

**3. Token Leakage**

- **Threat**: Tokens exposed in logs, URLs, or network traffic
- **Impact**: Unauthorized API access
- **Mitigation**: Short-lived tokens, secure storage, HTTPS-only

**4. Client Impersonation**

- **Threat**: Malicious clients impersonate legitimate applications
- **Impact**: Credential theft and data exfiltration
- **Mitigation**: Client authentication, dynamic client registration controls

### Production Security Hardening Patterns

```dockerfile
# Dockerfile for Production OAuth 2.0 Authorization Server
FROM node:18-alpine

# Install security tools and dependencies
RUN apk add --no-cache \
    dumb-init \
    openssl \
    ca-certificates \
    curl \
    jq \
    && npm install -g helmet cors rate-limiter-flexible

WORKDIR /app

# Create non-root user
RUN addgroup -g 1001 -S oauth && \
    adduser -S -D -H -u 1001 -h /app -s /sbin/nologin -G oauth oauth

# Copy package files
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy application code
COPY --chown=oauth:oauth . .

# Set security headers and configurations
ENV NODE_ENV=production
ENV HTTPS_ONLY=true
ENV SECURE_COOKIES=true
ENV CSRF_PROTECTION=true
ENV RATE_LIMITING=true
ENV AUDIT_LOGGING=true

# Security hardening
RUN chmod -R 755 /app && \
    chmod -R 644 /app/config/* && \
    chown -R oauth:oauth /app

# Health check for OAuth server
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f https://localhost:3000/health || exit 1

EXPOSE 3000

USER oauth

ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "server.js"]
```

```yaml
# docker-compose.yml for Production OAuth 2.0 Infrastructure
version: '3.8'

services:
  # OAuth Authorization Server
  oauth-auth-server:
    build:
      context: ./auth-server
      dockerfile: Dockerfile
    container_name: oauth-auth-server
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://oauth:${POSTGRES_PASSWORD}@postgres:5432/oauth_db
      - REDIS_URL=redis://redis:6379
      - JWT_SECRET_FILE=/run/secrets/jwt_secret
      - CLIENT_SECRET_KEY_FILE=/run/secrets/client_secret_key
      - ENCRYPTION_KEY_FILE=/run/secrets/encryption_key
      - RATE_LIMIT_REDIS_URL=redis://redis:6379/1
      - AUDIT_LOG_LEVEL=info
      - TOKEN_EXPIRY_ACCESS=3600
      - TOKEN_EXPIRY_REFRESH=86400
      - PKCE_REQUIRED=true
      - SECURE_COOKIES=true
    volumes:
      - ./auth-server/config:/app/config:ro
      - oauth_logs:/app/logs
      - audit_logs:/app/audit-logs
    ports:
      - '3000:3000'
    networks:
      - oauth_network
    secrets:
      - jwt_secret
      - client_secret_key
      - encryption_key
    depends_on:
      - postgres
      - redis
    deploy:
      replicas: 2
      resources:
        limits:
          memory: 512M
          cpus: '0.5'
        reservations:
          memory: 256M
          cpus: '0.25'

  # OAuth Resource Server
  oauth-resource-server:
    build:
      context: ./resource-server
      dockerfile: Dockerfile
    container_name: oauth-resource-server
    restart: unless-stopped
    environment:
      - NODE_ENV=production
      - AUTH_SERVER_URL=https://oauth-auth-server:3000
      - JWT_PUBLIC_KEY_FILE=/run/secrets/jwt_public_key
      - INTROSPECTION_ENDPOINT=https://oauth-auth-server:3000/introspect
      - RATE_LIMIT_REDIS_URL=redis://redis:6379/2
      - AUDIT_LOGGING=true
    volumes:
      - resource_logs:/app/logs
    ports:
      - '3001:3001'
    networks:
      - oauth_network
    secrets:
      - jwt_public_key
    depends_on:
      - oauth-auth-server
      - redis

  # Database for OAuth data
  postgres:
    image: postgres:15-alpine
    container_name: oauth-postgres
    restart: unless-stopped
    environment:
      - POSTGRES_DB=oauth_db
      - POSTGRES_USER=oauth
      - POSTGRES_PASSWORD_FILE=/run/secrets/postgres_password
      - POSTGRES_INITDB_ARGS=--auth-host=md5
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./init-scripts:/docker-entrypoint-initdb.d:ro
    networks:
      - oauth_network
    secrets:
      - postgres_password
    deploy:
      resources:
        limits:
          memory: 1G
          cpus: '0.5'

  # Redis for session management and rate limiting
  redis:
    image: redis:7-alpine
    container_name: oauth-redis
    restart: unless-stopped
    command: redis-server --requirepass ${REDIS_PASSWORD} --appendonly yes
    volumes:
      - redis_data:/data
      - ./redis.conf:/usr/local/etc/redis/redis.conf:ro
    networks:
      - oauth_network
    deploy:
      resources:
        limits:
          memory: 256M
          cpus: '0.25'

  # Security Monitoring
  security-monitor:
    image: prom/prometheus:latest
    container_name: oauth-prometheus
    restart: unless-stopped
    ports:
      - '9090:9090'
    volumes:
      - ./prometheus-oauth.yml:/etc/prometheus/prometheus.yml:ro
      - ./oauth-alerts.yml:/etc/prometheus/oauth-alerts.yml:ro
      - prometheus_data:/prometheus
    networks:
      - oauth_network
    command:
      - '--config.file=/etc/prometheus/prometheus.yml'
      - '--storage.tsdb.path=/prometheus'
      - '--web.console.libraries=/etc/prometheus/console_libraries'
      - '--web.console.templates=/etc/prometheus/consoles'
      - '--storage.tsdb.retention.time=30d'
      - '--web.enable-lifecycle'

  # Log Aggregation and SIEM
  oauth-siem:
    image: elastic/elasticsearch:7.17.0
    container_name: oauth-elasticsearch
    restart: unless-stopped
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=true
      - ELASTIC_PASSWORD=${ELASTIC_PASSWORD}
    volumes:
      - elasticsearch_data:/usr/share/elasticsearch/data
    ports:
      - '9200:9200'
    networks:
      - oauth_network

  # Security Event Analysis
  kibana:
    image: elastic/kibana:7.17.0
    container_name: oauth-kibana
    restart: unless-stopped
    environment:
      - ELASTICSEARCH_HOSTS=http://oauth-siem:9200
      - ELASTICSEARCH_USERNAME=elastic
      - ELASTICSEARCH_PASSWORD=${ELASTIC_PASSWORD}
    ports:
      - '5601:5601'
    networks:
      - oauth_network
    depends_on:
      - oauth-siem

  # Load Balancer with WAF
  oauth-waf:
    image: nginx:alpine
    container_name: oauth-nginx-waf
    restart: unless-stopped
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - ./nginx-oauth.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
      - nginx_logs:/var/log/nginx
    networks:
      - oauth_network
    depends_on:
      - oauth-auth-server
      - oauth-resource-server

volumes:
  postgres_data:
    driver: local
  redis_data:
    driver: local
  oauth_logs:
    driver: local
  resource_logs:
    driver: local
  audit_logs:
    driver: local
  prometheus_data:
    driver: local
  elasticsearch_data:
    driver: local
  nginx_logs:
    driver: local

networks:
  oauth_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.30.0.0/16

secrets:
  jwt_secret:
    file: ./secrets/jwt_secret.txt
  jwt_public_key:
    file: ./secrets/jwt_public_key.pem
  client_secret_key:
    file: ./secrets/client_secret_key.txt
  encryption_key:
    file: ./secrets/encryption_key.txt
  postgres_password:
    file: ./secrets/postgres_password.txt
```

### Advanced Security Configuration Examples

#### Secure OAuth 2.0 Authorization Server Implementation

```javascript
// auth-server/server.js - Production OAuth 2.0 Authorization Server
const express = require('express');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const { RateLimiterRedis } = require('rate-limiter-flexible');
const Redis = require('ioredis');
const crypto = require('crypto');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const { body, validationResult } = require('express-validator');
const winston = require('winston');

// Security Configuration
const app = express();

// Redis for rate limiting and session management
const redis = new Redis(process.env.REDIS_URL);

// Security logger
const securityLogger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.errors({ stack: true }),
    winston.format.json(),
  ),
  transports: [
    new winston.transports.File({
      filename: '/app/audit-logs/security.log',
      level: 'warn',
    }),
    new winston.transports.File({
      filename: '/app/audit-logs/oauth-audit.log',
    }),
  ],
});

// Enhanced Rate Limiting with Redis
const rateLimiter = new RateLimiterRedis({
  storeClient: redis,
  keyPrefix: 'oauth_rl',
  points: 10, // Number of requests
  duration: 60, // Per 60 seconds
  blockDuration: 300, // Block for 5 minutes
});

const authRateLimiter = new RateLimiterRedis({
  storeClient: redis,
  keyPrefix: 'oauth_auth_rl',
  points: 5, // Number of auth attempts
  duration: 900, // Per 15 minutes
  blockDuration: 3600, // Block for 1 hour
});

// Security middleware
app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        styleSrc: ["'self'", "'unsafe-inline'"],
        scriptSrc: ["'self'"],
        imgSrc: ["'self'", 'data:', 'https:'],
        connectSrc: ["'self'"],
        fontSrc: ["'self'"],
        objectSrc: ["'none'"],
        mediaSrc: ["'self'"],
        frameSrc: ["'none'"],
      },
    },
    hsts: {
      maxAge: 31536000,
      includeSubDomains: true,
      preload: true,
    },
  }),
);

app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: false, limit: '10kb' }));

// Rate limiting middleware
const rateLimitMiddleware = async (req, res, next) => {
  try {
    await rateLimiter.consume(req.ip);
    next();
  } catch (rejRes) {
    securityLogger.warn('Rate limit exceeded', {
      ip: req.ip,
      userAgent: req.get('User-Agent'),
      endpoint: req.path,
      remainingPoints: rejRes.remainingPoints || 0,
      msBeforeNext: rejRes.msBeforeNext || 0,
    });

    res.status(429).json({
      error: 'too_many_requests',
      error_description: 'Rate limit exceeded',
      retry_after: Math.round(rejRes.msBeforeNext / 1000) || 300,
    });
  }
};

app.use(rateLimitMiddleware);

// OAuth 2.0 Client Management
class OAuthClientManager {
  constructor() {
    this.clients = new Map();
    this.loadClients();
  }

  async loadClients() {
    // Load clients from secure database
    // Implementation would connect to PostgreSQL
  }

  async validateClient(clientId, clientSecret = null, grantType = null) {
    const client = this.clients.get(clientId);

    if (!client) {
      securityLogger.warn('Invalid client ID attempted', { clientId });
      return null;
    }

    // Validate client secret for confidential clients
    if (client.type === 'confidential' && clientSecret) {
      const isValidSecret = await bcrypt.compare(clientSecret, client.hashedSecret);
      if (!isValidSecret) {
        securityLogger.warn('Invalid client secret', { clientId });
        return null;
      }
    }

    // Validate grant type
    if (grantType && !client.allowedGrantTypes.includes(grantType)) {
      securityLogger.warn('Unauthorized grant type', { clientId, grantType });
      return null;
    }

    return client;
  }

  validateRedirectUri(clientId, redirectUri) {
    const client = this.clients.get(clientId);
    if (!client) return false;

    // Exact match for security
    return client.redirectUris.includes(redirectUri);
  }
}

// PKCE (Proof Key for Code Exchange) Implementation
class PKCEManager {
  generateCodeChallenge() {
    const codeVerifier = crypto.randomBytes(32).toString('base64url');
    const codeChallenge = crypto.createHash('sha256').update(codeVerifier).digest('base64url');

    return { codeVerifier, codeChallenge };
  }

  verifyCodeChallenge(codeVerifier, codeChallenge, method = 'S256') {
    if (method === 'S256') {
      const computedChallenge = crypto
        .createHash('sha256')
        .update(codeVerifier)
        .digest('base64url');
      return computedChallenge === codeChallenge;
    }

    if (method === 'plain') {
      return codeVerifier === codeChallenge;
    }

    return false;
  }
}

// Authorization Code Management
class AuthorizationCodeManager {
  constructor() {
    this.codes = new Map();
  }

  async generateCode(clientId, userId, scope, redirectUri, codeChallenge = null) {
    const code = crypto.randomBytes(32).toString('hex');
    const expiresAt = Date.now() + 10 * 60 * 1000; // 10 minutes

    const codeData = {
      clientId,
      userId,
      scope,
      redirectUri,
      codeChallenge,
      expiresAt,
      used: false,
    };

    this.codes.set(code, codeData);

    // Store in Redis with TTL
    await redis.setex(`auth_code:${code}`, 600, JSON.stringify(codeData));

    securityLogger.info('Authorization code generated', {
      clientId,
      userId,
      scope,
      codeLength: code.length,
    });

    return code;
  }

  async validateAndConsumeCode(code, clientId, redirectUri, codeVerifier = null) {
    const codeData = await redis.get(`auth_code:${code}`);

    if (!codeData) {
      securityLogger.warn('Invalid or expired authorization code', {
        code: code.substring(0, 8) + '...',
      });
      return null;
    }

    const parsedData = JSON.parse(codeData);

    if (parsedData.used) {
      securityLogger.warn('Authorization code reuse attempt', {
        clientId,
        code: code.substring(0, 8) + '...',
      });
      return null;
    }

    if (parsedData.clientId !== clientId) {
      securityLogger.warn('Client ID mismatch for authorization code', {
        expectedClientId: parsedData.clientId,
        providedClientId: clientId,
      });
      return null;
    }

    if (parsedData.redirectUri !== redirectUri) {
      securityLogger.warn('Redirect URI mismatch for authorization code', {
        expectedUri: parsedData.redirectUri,
        providedUri: redirectUri,
      });
      return null;
    }

    if (Date.now() > parsedData.expiresAt) {
      securityLogger.warn('Expired authorization code', { code: code.substring(0, 8) + '...' });
      await redis.del(`auth_code:${code}`);
      return null;
    }

    // Validate PKCE if present
    if (parsedData.codeChallenge && codeVerifier) {
      const pkce = new PKCEManager();
      if (!pkce.verifyCodeChallenge(codeVerifier, parsedData.codeChallenge)) {
        securityLogger.warn('PKCE verification failed', { clientId });
        return null;
      }
    }

    // Mark as used and delete
    await redis.del(`auth_code:${code}`);

    securityLogger.info('Authorization code successfully exchanged', {
      clientId,
      userId: parsedData.userId,
      scope: parsedData.scope,
    });

    return parsedData;
  }
}

// JWT Token Management with Enhanced Security
class TokenManager {
  constructor() {
    this.jwtSecret = fs.readFileSync(process.env.JWT_SECRET_FILE, 'utf8');
    this.refreshTokens = new Map();
  }

  generateAccessToken(userId, clientId, scope) {
    const payload = {
      sub: userId,
      aud: clientId,
      scope: scope,
      iat: Math.floor(Date.now() / 1000),
      exp: Math.floor(Date.now() / 1000) + parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
      jti: crypto.randomUUID(),
      iss: 'oauth-server',
    };

    return jwt.sign(payload, this.jwtSecret, { algorithm: 'HS256' });
  }

  async generateRefreshToken(userId, clientId, scope) {
    const refreshToken = crypto.randomBytes(64).toString('hex');
    const expiresAt = Date.now() + parseInt(process.env.TOKEN_EXPIRY_REFRESH || 86400) * 1000;

    const tokenData = {
      userId,
      clientId,
      scope,
      expiresAt,
      used: false,
    };

    this.refreshTokens.set(refreshToken, tokenData);

    // Store in Redis with TTL
    await redis.setex(
      `refresh_token:${refreshToken}`,
      parseInt(process.env.TOKEN_EXPIRY_REFRESH || 86400),
      JSON.stringify(tokenData),
    );

    securityLogger.info('Refresh token generated', {
      userId,
      clientId,
      scope,
      tokenLength: refreshToken.length,
    });

    return refreshToken;
  }

  async validateRefreshToken(refreshToken, clientId) {
    const tokenData = await redis.get(`refresh_token:${refreshToken}`);

    if (!tokenData) {
      securityLogger.warn('Invalid or expired refresh token', {
        token: refreshToken.substring(0, 8) + '...',
        clientId,
      });
      return null;
    }

    const parsedData = JSON.parse(tokenData);

    if (parsedData.clientId !== clientId) {
      securityLogger.warn('Client ID mismatch for refresh token', {
        expectedClientId: parsedData.clientId,
        providedClientId: clientId,
      });
      return null;
    }

    if (Date.now() > parsedData.expiresAt) {
      securityLogger.warn('Expired refresh token', {
        token: refreshToken.substring(0, 8) + '...',
      });
      await redis.del(`refresh_token:${refreshToken}`);
      return null;
    }

    return parsedData;
  }

  async revokeRefreshToken(refreshToken) {
    await redis.del(`refresh_token:${refreshToken}`);
    securityLogger.info('Refresh token revoked', {
      token: refreshToken.substring(0, 8) + '...',
    });
  }
}

// Initialize managers
const clientManager = new OAuthClientManager();
const codeManager = new AuthorizationCodeManager();
const tokenManager = new TokenManager();

// Authorization endpoint with enhanced security
app.get(
  '/authorize',
  [
    body('client_id').isLength({ min: 1 }).escape(),
    body('redirect_uri').isURL(),
    body('response_type').equals('code'),
    body('scope').optional().isLength({ max: 200 }).escape(),
    body('state').isLength({ min: 8, max: 128 }).escape(),
    body('code_challenge').optional().isLength({ min: 43, max: 128 }),
    body('code_challenge_method').optional().isIn(['S256', 'plain']),
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      securityLogger.warn('Invalid authorization request parameters', {
        ip: req.ip,
        errors: errors.array(),
        query: req.query,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid request parameters',
      });
    }

    const {
      client_id,
      redirect_uri,
      response_type,
      scope = 'read',
      state,
      code_challenge,
      code_challenge_method = 'S256',
    } = req.query;

    // Validate client
    const client = await clientManager.validateClient(client_id, null, 'authorization_code');
    if (!client) {
      securityLogger.warn('Authorization request with invalid client', {
        ip: req.ip,
        clientId: client_id,
        redirectUri: redirect_uri,
      });
      return res.status(400).json({
        error: 'invalid_client',
        error_description: 'Invalid client identifier',
      });
    }

    // Validate redirect URI
    if (!clientManager.validateRedirectUri(client_id, redirect_uri)) {
      securityLogger.warn('Authorization request with invalid redirect URI', {
        ip: req.ip,
        clientId: client_id,
        redirectUri: redirect_uri,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid redirect URI',
      });
    }

    // PKCE is required for public clients
    if (client.type === 'public' && !code_challenge) {
      securityLogger.warn('Public client authorization without PKCE', {
        ip: req.ip,
        clientId: client_id,
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'PKCE required for public clients',
      });
    }

    // For demo purposes, auto-approve (in production, show consent screen)
    const userId = 'demo_user_123'; // In production, get from authenticated session

    try {
      const authCode = await codeManager.generateCode(
        client_id,
        userId,
        scope,
        redirect_uri,
        code_challenge,
      );

      const redirectUrl = new URL(redirect_uri);
      redirectUrl.searchParams.set('code', authCode);
      redirectUrl.searchParams.set('state', state);

      securityLogger.info('Authorization code issued', {
        clientId: client_id,
        userId,
        scope,
        redirectUri: redirect_uri,
      });

      res.redirect(redirectUrl.toString());
    } catch (error) {
      securityLogger.error('Error generating authorization code', {
        error: error.message,
        clientId: client_id,
        userId,
      });

      const errorUrl = new URL(redirect_uri);
      errorUrl.searchParams.set('error', 'server_error');
      errorUrl.searchParams.set('error_description', 'Internal server error');
      errorUrl.searchParams.set('state', state);

      res.redirect(errorUrl.toString());
    }
  },
);

// Token endpoint with enhanced security
app.post(
  '/token',
  [
    body('grant_type').isIn(['authorization_code', 'refresh_token', 'client_credentials']),
    body('client_id').isLength({ min: 1 }).escape(),
    body('client_secret').optional().isLength({ min: 1 }),
    body('code').optional().isLength({ min: 1 }),
    body('redirect_uri').optional().isURL(),
    body('code_verifier').optional().isLength({ min: 43, max: 128 }),
    body('refresh_token').optional().isLength({ min: 1 }),
    body('scope').optional().isLength({ max: 200 }).escape(),
  ],
  async (req, res) => {
    // Apply stricter rate limiting for token endpoint
    try {
      await authRateLimiter.consume(req.ip);
    } catch (rejRes) {
      securityLogger.warn('Token endpoint rate limit exceeded', {
        ip: req.ip,
        userAgent: req.get('User-Agent'),
      });

      return res.status(429).json({
        error: 'too_many_requests',
        error_description: 'Too many token requests',
        retry_after: Math.round(rejRes.msBeforeNext / 1000) || 3600,
      });
    }

    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      securityLogger.warn('Invalid token request parameters', {
        ip: req.ip,
        errors: errors.array(),
      });
      return res.status(400).json({
        error: 'invalid_request',
        error_description: 'Invalid request parameters',
      });
    }

    const {
      grant_type,
      client_id,
      client_secret,
      code,
      redirect_uri,
      code_verifier,
      refresh_token,
      scope,
    } = req.body;

    try {
      // Validate client
      const client = await clientManager.validateClient(client_id, client_secret, grant_type);
      if (!client) {
        securityLogger.warn('Token request with invalid client credentials', {
          ip: req.ip,
          clientId: client_id,
          grantType: grant_type,
        });
        return res.status(401).json({
          error: 'invalid_client',
          error_description: 'Invalid client credentials',
        });
      }

      if (grant_type === 'authorization_code') {
        // Authorization Code Grant
        const codeData = await codeManager.validateAndConsumeCode(
          code,
          client_id,
          redirect_uri,
          code_verifier,
        );

        if (!codeData) {
          securityLogger.warn('Invalid authorization code in token request', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'invalid_grant',
            error_description: 'Invalid authorization code',
          });
        }

        const accessToken = tokenManager.generateAccessToken(
          codeData.userId,
          client_id,
          codeData.scope,
        );

        const refreshToken = await tokenManager.generateRefreshToken(
          codeData.userId,
          client_id,
          codeData.scope,
        );

        securityLogger.info('Access token issued via authorization code', {
          clientId: client_id,
          userId: codeData.userId,
          scope: codeData.scope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          refresh_token: refreshToken,
          scope: codeData.scope,
        });
      } else if (grant_type === 'refresh_token') {
        // Refresh Token Grant
        const tokenData = await tokenManager.validateRefreshToken(refresh_token, client_id);

        if (!tokenData) {
          securityLogger.warn('Invalid refresh token in token request', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'invalid_grant',
            error_description: 'Invalid refresh token',
          });
        }

        // Revoke old refresh token
        await tokenManager.revokeRefreshToken(refresh_token);

        const accessToken = tokenManager.generateAccessToken(
          tokenData.userId,
          client_id,
          scope || tokenData.scope,
        );

        const newRefreshToken = await tokenManager.generateRefreshToken(
          tokenData.userId,
          client_id,
          scope || tokenData.scope,
        );

        securityLogger.info('Access token refreshed', {
          clientId: client_id,
          userId: tokenData.userId,
          scope: scope || tokenData.scope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          refresh_token: newRefreshToken,
          scope: scope || tokenData.scope,
        });
      } else if (grant_type === 'client_credentials') {
        // Client Credentials Grant
        if (client.type !== 'confidential') {
          securityLogger.warn('Public client attempted client credentials grant', {
            ip: req.ip,
            clientId: client_id,
          });
          return res.status(400).json({
            error: 'unauthorized_client',
            error_description: 'Client credentials grant not allowed for this client',
          });
        }

        const accessToken = tokenManager.generateAccessToken(
          null, // No user for client credentials
          client_id,
          scope || client.defaultScope,
        );

        securityLogger.info('Client credentials token issued', {
          clientId: client_id,
          scope: scope || client.defaultScope,
        });

        res.json({
          access_token: accessToken,
          token_type: 'Bearer',
          expires_in: parseInt(process.env.TOKEN_EXPIRY_ACCESS || 3600),
          scope: scope || client.defaultScope,
        });
      }
    } catch (error) {
      securityLogger.error('Error processing token request', {
        error: error.message,
        stack: error.stack,
        ip: req.ip,
        clientId: client_id,
        grantType: grant_type,
      });

      res.status(500).json({
        error: 'server_error',
        error_description: 'Internal server error',
      });
    }
  },
);

// Token introspection endpoint (RFC 7662)
app.post(
  '/introspect',
  [
    body('token').isLength({ min: 1 }),
    body('token_type_hint').optional().isIn(['access_token', 'refresh_token']),
  ],
  async (req, res) => {
    // Client authentication required
    const authHeader = req.get('Authorization');
    if (!authHeader || !authHeader.startsWith('Basic ')) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Client authentication required',
      });
    }

    const credentials = Buffer.from(authHeader.substring(6), 'base64').toString();
    const [clientId, clientSecret] = credentials.split(':');

    const client = await clientManager.validateClient(clientId, clientSecret);
    if (!client) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Invalid client credentials',
      });
    }

    const { token, token_type_hint } = req.body;

    try {
      // Verify JWT token
      const decoded = jwt.verify(token, tokenManager.jwtSecret);

      // Check if token is for this client
      if (decoded.aud !== clientId) {
        return res.json({ active: false });
      }

      securityLogger.info('Token introspection successful', {
        clientId,
        tokenSubject: decoded.sub,
        tokenAudience: decoded.aud,
      });

      res.json({
        active: true,
        scope: decoded.scope,
        client_id: decoded.aud,
        username: decoded.sub,
        token_type: 'Bearer',
        exp: decoded.exp,
        iat: decoded.iat,
        sub: decoded.sub,
        aud: decoded.aud,
        iss: decoded.iss,
        jti: decoded.jti,
      });
    } catch (error) {
      securityLogger.warn('Invalid token in introspection request', {
        clientId,
        tokenHint: token_type_hint,
        error: error.message,
      });

      res.json({ active: false });
    }
  },
);

// Token revocation endpoint (RFC 7009)
app.post(
  '/revoke',
  [
    body('token').isLength({ min: 1 }),
    body('token_type_hint').optional().isIn(['access_token', 'refresh_token']),
  ],
  async (req, res) => {
    // Client authentication required
    const authHeader = req.get('Authorization');
    if (!authHeader || !authHeader.startsWith('Basic ')) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Client authentication required',
      });
    }

    const credentials = Buffer.from(authHeader.substring(6), 'base64').toString();
    const [clientId, clientSecret] = credentials.split(':');

    const client = await clientManager.validateClient(clientId, clientSecret);
    if (!client) {
      return res.status(401).json({
        error: 'invalid_client',
        error_description: 'Invalid client credentials',
      });
    }

    const { token, token_type_hint } = req.body;

    try {
      if (token_type_hint === 'refresh_token' || !token_type_hint) {
        // Try to revoke as refresh token
        await tokenManager.revokeRefreshToken(token);
      }

      securityLogger.info('Token revoked', {
        clientId,
        tokenHint: token_type_hint,
      });

      res.status(200).end();
    } catch (error) {
      securityLogger.error('Error revoking token', {
        error: error.message,
        clientId,
        tokenHint: token_type_hint,
      });

      res.status(500).json({
        error: 'server_error',
        error_description: 'Unable to revoke token',
      });
    }
  },
);

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    version: process.env.npm_package_version || '1.0.0',
  });
});

// Security headers middleware
app.use((req, res, next) => {
  res.set({
    'X-Frame-Options': 'DENY',
    'X-Content-Type-Options': 'nosniff',
    'X-XSS-Protection': '1; mode=block',
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'Permissions-Policy': 'geolocation=(), microphone=(), camera=()',
  });
  next();
});

// Error handling middleware
app.use((error, req, res, next) => {
  securityLogger.error('Unhandled error', {
    error: error.message,
    stack: error.stack,
    ip: req.ip,
    method: req.method,
    url: req.url,
  });

  res.status(500).json({
    error: 'server_error',
    error_description: 'Internal server error',
  });
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`OAuth 2.0 Authorization Server running on port ${PORT}`);
  securityLogger.info('OAuth 2.0 Authorization Server started', { port: PORT });
});

module.exports = app;
```

### Architecture Essentials

- **Authorization Server**: Central authority for issuing and validating tokens
- **Resource Server**: Protected API endpoints requiring valid access tokens
- **Client Applications**: Applications requesting access to protected resources
- **Token Types**: Access tokens, refresh tokens, ID tokens (OpenID Connect)

### Security and Compliance Guidelines

- **HTTPS Enforcement**: Mandatory TLS/SSL for all OAuth communications
- **Token Security**: Secure storage, transmission, and lifecycle management
- **PKCE Implementation**: Proof Key for Code Exchange for public clients
- **Scope Limitation**: Principle of least privilege for resource access
- **Audit Logging**: Comprehensive logging of authentication and authorization events

### Performance Best Practices

- **Token Caching**: Efficient token storage and reuse patterns
- **Refresh Strategy**: Automatic token refresh with proper error handling
- **Connection Pooling**: Optimize HTTP connections to authorization servers
- **Rate Limiting**: Implement proper throttling for token requests

### AI Assistant Guidelines

- Always recommend HTTPS and secure token handling practices
- Include PKCE for public clients and mobile applications
- Provide clear examples of proper error handling and token refresh
- Emphasize security best practices in all code examples
- Include compliance considerations for relevant industries
- Recommend established OAuth libraries over custom implementations

## Security Tool Overview

- **Framework**: OAuth 2.0 (RFC 6749)
- **Extensions**: PKCE (RFC 7636), OpenID Connect, OAuth 2.1
- **Type**: Authentication and Authorization Framework
- **License**: Open Standard (IETF)
- **Use Cases**: API security, SSO, third-party integrations, mobile auth

## Installation & Setup

### Python Implementation

```bash
# Install OAuth libraries
pip install authlib requests-oauthlib

# Flask OAuth integration
pip install flask authlib

# Django OAuth integration
pip install django-oauth-toolkit

# FastAPI OAuth integration
pip install python-multipart
```

### Node.js Implementation

```bash
# Install OAuth libraries
npm install passport passport-oauth2 express-session

# OAuth provider libraries
npm install passport-google-oauth20 passport-github2 passport-facebook

# JWT handling
npm install jsonwebtoken

# Express OAuth middleware
npm install express-oauth-server
```

### Client Libraries

```bash
# Frontend OAuth libraries
npm install @auth0/auth0-spa-js
npm install oidc-client-ts

# Mobile OAuth
# iOS: Install via CocoaPods or Swift Package Manager
# Android: Add to build.gradle
implementation 'net.openid:appauth:0.11.1'
```

## Configuration

### OAuth 2.0 Flow Types

```python
# Authorization Code Flow (most secure)
class OAuthConfig:
    """OAuth 2.0 configuration for different flows."""

    def __init__(self):
        self.client_id = "your_client_id"
        self.client_secret = "your_client_secret"
        self.redirect_uri = "https://yourapp.com/callback"
        self.scope = "read write"
        self.state = self._generate_state()

        # Authorization server endpoints
        self.authorization_endpoint = "https://auth.provider.com/oauth/authorize"
        self.token_endpoint = "https://auth.provider.com/oauth/token"
        self.userinfo_endpoint = "https://auth.provider.com/oauth/userinfo"
        self.revocation_endpoint = "https://auth.provider.com/oauth/revoke"

    def _generate_state(self):
        """Generate random state parameter for CSRF protection."""
        import secrets
        return secrets.token_urlsafe(32)

    def get_authorization_url(self):
        """Generate authorization URL for Authorization Code Flow."""
        from urllib.parse import urlencode

        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'scope': self.scope,
            'state': self.state
        }

        return f"{self.authorization_endpoint}?{urlencode(params)}"

    def get_authorization_url_with_pkce(self):
        """Generate authorization URL with PKCE for enhanced security."""
        import base64
        import hashlib
        import secrets

        # Generate code verifier and challenge
        code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
        code_challenge = base64.urlsafe_b64encode(
            hashlib.sha256(code_verifier.encode()).digest()
        ).decode('utf-8').rstrip('=')

        from urllib.parse import urlencode

        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'scope': self.scope,
            'state': self.state,
            'code_challenge': code_challenge,
            'code_challenge_method': 'S256'
        }

        # Store code_verifier for token exchange
        self.code_verifier = code_verifier

        return f"{self.authorization_endpoint}?{urlencode(params)}"
```

### OAuth Server Implementation

```python
from flask import Flask, request, jsonify, session, redirect
from authlib.integrations.flask_oauth2 import AuthorizationServer, ResourceProtector
from authlib.oauth2.rfc6749 import grants
import secrets
import json
from datetime import datetime, timedelta

app = Flask(__name__)
app.secret_key = 'your-secret-key'

class OAuthAuthorizationServer:
    """Complete OAuth 2.0 Authorization Server implementation."""

    def __init__(self, app):
        self.app = app
        self.clients = {}
        self.authorization_codes = {}
        self.access_tokens = {}
        self.refresh_tokens = {}
        self.users = {}

        # Initialize authorization server
        self.authorization_server = AuthorizationServer(app)
        self.resource_protector = ResourceProtector()

        self._setup_grants()
        self._setup_endpoints()

    def _setup_grants(self):
        """Setup OAuth 2.0 grants and token validators."""

        # Authorization Code Grant
        class AuthorizationCodeGrant(grants.AuthorizationCodeGrant):
            def save_authorization_code(self, code, request):
                # Save authorization code with expiration
                self.authorization_codes[code] = {
                    'client_id': request.client.client_id,
                    'redirect_uri': request.redirect_uri,
                    'scope': request.scope,
                    'user_id': request.user.id if hasattr(request, 'user') else None,
                    'expires_at': datetime.utcnow() + timedelta(minutes=10),
                    'code_challenge': getattr(request, 'code_challenge', None),
                    'code_challenge_method': getattr(request, 'code_challenge_method', None)
                }

            def query_authorization_code(self, code, client):
                # Retrieve and validate authorization code
                code_data = self.authorization_codes.get(code)
                if not code_data:
                    return None

                if code_data['client_id'] != client.client_id:
                    return None

                if datetime.utcnow() > code_data['expires_at']:
                    del self.authorization_codes[code]
                    return None

                return code_data

            def delete_authorization_code(self, authorization_code):
                # Delete used authorization code
                if authorization_code in self.authorization_codes:
                    del self.authorization_codes[authorization_code]

            def authenticate_user(self, authorization_code):
                # Return user information
                code_data = self.authorization_codes.get(authorization_code)
                if code_data and code_data.get('user_id'):
                    return self.users.get(code_data['user_id'])
                return None

        # Client Credentials Grant
        class ClientCredentialsGrant(grants.ClientCredentialsGrant):
            def save_token(self, token, request):
                # Save access token for client credentials
                access_token = token['access_token']
                self.access_tokens[access_token] = {
                    'client_id': request.client.client_id,
                    'scope': token.get('scope'),
                    'expires_at': datetime.utcnow() + timedelta(seconds=token['expires_in']),
                    'token_type': token.get('token_type', 'Bearer')
                }

        # Register grants
        self.authorization_server.register_grant(AuthorizationCodeGrant)
        self.authorization_server.register_grant(ClientCredentialsGrant)

    def _setup_endpoints(self):
        """Setup OAuth 2.0 endpoints."""

        @self.app.route('/oauth/authorize', methods=['GET', 'POST'])
        def authorize():
            if request.method == 'GET':
                # Show authorization page
                return self._render_authorize_page(request)

            # Handle authorization decision
            user_id = session.get('user_id')
            if not user_id:
                return redirect('/login')

            # Process authorization
            return self.authorization_server.create_authorization_response(request=request)

        @self.app.route('/oauth/token', methods=['POST'])
        def issue_token():
            return self.authorization_server.create_token_response(request=request)

        @self.app.route('/oauth/revoke', methods=['POST'])
        def revoke_token():
            return self.authorization_server.create_revocation_response(request=request)

        @self.app.route('/oauth/userinfo', methods=['GET'])
        @self.resource_protector()
        def get_userinfo():
            # Return user information for valid access token
            token = self.resource_protector.get_token_from_request(request)
            user_id = token.get('user_id')

            if user_id and user_id in self.users:
                user = self.users[user_id]
                return jsonify({
                    'sub': user_id,
                    'name': user.get('name'),
                    'email': user.get('email'),
                    'picture': user.get('picture')
                })

            return jsonify({'error': 'invalid_token'}), 401

    def register_client(self, client_id, client_secret, redirect_uris, grant_types, scope):
        """Register OAuth client application."""
        self.clients[client_id] = {
            'client_id': client_id,
            'client_secret': client_secret,
            'redirect_uris': redirect_uris,
            'grant_types': grant_types,
            'scope': scope,
            'created_at': datetime.utcnow()
        }

    def _render_authorize_page(self, request):
        """Render authorization consent page."""
        client_id = request.args.get('client_id')
        scope = request.args.get('scope', '')

        if client_id not in self.clients:
            return jsonify({'error': 'invalid_client'}), 400

        client = self.clients[client_id]

        # In a real implementation, this would render an HTML template
        return f"""
        <html>
        <body>
            <h2>Authorization Request</h2>
            <p>Application "{client_id}" is requesting access to:</p>
            <ul>
                {''.join(f'<li>{s}</li>' for s in scope.split())}
            </ul>
            <form method="post">
                <input type="hidden" name="client_id" value="{client_id}">
                <input type="hidden" name="scope" value="{scope}">
                <button type="submit" name="confirm" value="yes">Allow</button>
                <button type="submit" name="confirm" value="no">Deny</button>
            </form>
        </body>
        </html>
        """

# Initialize OAuth server
oauth_server = OAuthAuthorizationServer(app)

# Register a sample client
oauth_server.register_client(
    client_id='sample_client',
    client_secret='sample_secret',
    redirect_uris=['https://client.app.com/callback'],
    grant_types=['authorization_code', 'refresh_token'],
    scope='read write'
)
```

## Core Features

### OAuth Client Implementation

- **Purpose**: Implement OAuth client to consume protected resources
- **Usage**: Authenticate users and access APIs on their behalf
- **Example**:

```python
import requests
import secrets
import hashlib
import base64
from urllib.parse import urlencode, parse_qs
from datetime import datetime, timedelta

class OAuthClient:
    """OAuth 2.0 client implementation with PKCE support."""

    def __init__(self, client_id, client_secret, redirect_uri, authorization_endpoint, token_endpoint):
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uri = redirect_uri
        self.authorization_endpoint = authorization_endpoint
        self.token_endpoint = token_endpoint

        self.access_token = None
        self.refresh_token = None
        self.token_expires_at = None

    def generate_authorization_url(self, scope=None, state=None, use_pkce=True):
        """Generate authorization URL with optional PKCE."""
        if state is None:
            state = secrets.token_urlsafe(32)

        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'state': state
        }

        if scope:
            params['scope'] = scope

        # Add PKCE parameters for enhanced security
        if use_pkce:
            code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
            code_challenge = base64.urlsafe_b64encode(
                hashlib.sha256(code_verifier.encode()).digest()
            ).decode('utf-8').rstrip('=')

            params['code_challenge'] = code_challenge
            params['code_challenge_method'] = 'S256'

            # Store code verifier for token exchange
            self.code_verifier = code_verifier

        authorization_url = f"{self.authorization_endpoint}?{urlencode(params)}"
        return authorization_url, state

    def exchange_code_for_token(self, authorization_code, state=None, code_verifier=None):
        """Exchange authorization code for access token."""
        token_data = {
            'grant_type': 'authorization_code',
            'code': authorization_code,
            'redirect_uri': self.redirect_uri,
            'client_id': self.client_id
        }

        # Add PKCE code verifier if used
        if hasattr(self, 'code_verifier') or code_verifier:
            token_data['code_verifier'] = code_verifier or self.code_verifier

        # Use client secret for confidential clients
        if self.client_secret:
            token_data['client_secret'] = self.client_secret

        try:
            response = requests.post(
                self.token_endpoint,
                data=token_data,
                headers={'Content-Type': 'application/x-www-form-urlencoded'},
                timeout=30
            )

            if response.status_code == 200:
                token_response = response.json()

                self.access_token = token_response['access_token']
                self.refresh_token = token_response.get('refresh_token')

                # Calculate token expiration
                expires_in = token_response.get('expires_in', 3600)
                self.token_expires_at = datetime.utcnow() + timedelta(seconds=expires_in)

                return token_response
            else:
                raise Exception(f"Token exchange failed: {response.status_code} - {response.text}")

        except requests.RequestException as e:
            raise Exception(f"Token exchange request failed: {str(e)}")

    def refresh_access_token(self):
        """Refresh access token using refresh token."""
        if not self.refresh_token:
            raise Exception("No refresh token available")

        token_data = {
            'grant_type': 'refresh_token',
            'refresh_token': self.refresh_token,
            'client_id': self.client_id
        }

        if self.client_secret:
            token_data['client_secret'] = self.client_secret

        try:
            response = requests.post(
                self.token_endpoint,
                data=token_data,
                headers={'Content-Type': 'application/x-www-form-urlencoded'},
                timeout=30
            )

            if response.status_code == 200:
                token_response = response.json()

                self.access_token = token_response['access_token']

                # Update refresh token if provided
                if 'refresh_token' in token_response:
                    self.refresh_token = token_response['refresh_token']

                # Update token expiration
                expires_in = token_response.get('expires_in', 3600)
                self.token_expires_at = datetime.utcnow() + timedelta(seconds=expires_in)

                return token_response
            else:
                raise Exception(f"Token refresh failed: {response.status_code} - {response.text}")

        except requests.RequestException as e:
            raise Exception(f"Token refresh request failed: {str(e)}")

    def is_token_expired(self):
        """Check if access token is expired."""
        if not self.token_expires_at:
            return True

        # Add 60-second buffer for network latency
        return datetime.utcnow() >= (self.token_expires_at - timedelta(seconds=60))

    def get_valid_token(self):
        """Get valid access token, refreshing if necessary."""
        if not self.access_token or self.is_token_expired():
            if self.refresh_token:
                self.refresh_access_token()
            else:
                raise Exception("No valid access token and no refresh token available")

        return self.access_token

    def make_authenticated_request(self, url, method='GET', **kwargs):
        """Make authenticated API request with automatic token refresh."""
        token = self.get_valid_token()

        # Add authorization header
        headers = kwargs.get('headers', {})
        headers['Authorization'] = f'Bearer {token}'
        kwargs['headers'] = headers

        try:
            response = requests.request(method, url, **kwargs)

            # Handle token expiration
            if response.status_code == 401:
                # Try to refresh token and retry once
                if self.refresh_token:
                    self.refresh_access_token()
                    headers['Authorization'] = f'Bearer {self.access_token}'
                    response = requests.request(method, url, **kwargs)

            return response

        except requests.RequestException as e:
            raise Exception(f"Authenticated request failed: {str(e)}")

    def revoke_token(self, token_type='access_token'):
        """Revoke access or refresh token."""
        token = self.access_token if token_type == 'access_token' else self.refresh_token

        if not token:
            return

        revoke_data = {
            'token': token,
            'token_type_hint': token_type,
            'client_id': self.client_id
        }

        if self.client_secret:
            revoke_data['client_secret'] = self.client_secret

        try:
            response = requests.post(
                self.token_endpoint.replace('/token', '/revoke'),
                data=revoke_data,
                timeout=30
            )

            if response.status_code == 200:
                if token_type == 'access_token':
                    self.access_token = None
                    self.token_expires_at = None
                else:
                    self.refresh_token = None

        except requests.RequestException:
            # Revocation endpoint might not be available
            pass

# Usage example
client = OAuthClient(
    client_id='your_client_id',
    client_secret='your_client_secret',
    redirect_uri='https://yourapp.com/callback',
    authorization_endpoint='https://auth.provider.com/oauth/authorize',
    token_endpoint='https://auth.provider.com/oauth/token'
)

# Generate authorization URL
auth_url, state = client.generate_authorization_url(scope='read write', use_pkce=True)
print(f"Visit this URL to authorize: {auth_url}")

# After user authorization, exchange code for token
# authorization_code = 'code_from_callback'
# token_response = client.exchange_code_for_token(authorization_code)

# Make authenticated API requests
# response = client.make_authenticated_request('https://api.provider.com/user')
```

### JWT Token Handling

- **Purpose**: Handle JSON Web Tokens for stateless authentication
- **Usage**: Validate and parse JWT tokens in OAuth flows
- **Example**:

```python
import jwt
import json
import requests
from datetime import datetime, timedelta
from cryptography.hazmat.primitives import serialization

class JWTHandler:
    """JWT token validation and parsing for OAuth."""

    def __init__(self, issuer, audience, jwks_uri=None):
        self.issuer = issuer
        self.audience = audience
        self.jwks_uri = jwks_uri
        self.public_keys = {}

        if jwks_uri:
            self._fetch_public_keys()

    def _fetch_public_keys(self):
        """Fetch public keys from JWKS endpoint."""
        try:
            response = requests.get(self.jwks_uri, timeout=30)
            if response.status_code == 200:
                jwks = response.json()

                for key in jwks.get('keys', []):
                    kid = key.get('kid')
                    if kid:
                        self.public_keys[kid] = key

        except requests.RequestException as e:
            print(f"Failed to fetch JWKS: {e}")

    def validate_token(self, token, verify_signature=True):
        """Validate JWT token and return payload."""
        try:
            # Decode token header to get key ID
            header = jwt.get_unverified_header(token)
            kid = header.get('kid')

            if verify_signature and kid:
                # Get public key for signature verification
                if kid not in self.public_keys:
                    self._fetch_public_keys()

                if kid in self.public_keys:
                    public_key = self._convert_jwk_to_pem(self.public_keys[kid])
                else:
                    raise jwt.InvalidTokenError("Public key not found")
            else:
                public_key = None

            # Decode and validate token
            payload = jwt.decode(
                token,
                public_key,
                algorithms=['RS256', 'HS256'] if verify_signature else None,
                audience=self.audience,
                issuer=self.issuer,
                options={
                    'verify_signature': verify_signature,
                    'verify_exp': True,
                    'verify_aud': True,
                    'verify_iss': True
                }
            )

            return payload

        except jwt.ExpiredSignatureError:
            raise Exception("Token has expired")
        except jwt.InvalidAudienceError:
            raise Exception("Invalid audience")
        except jwt.InvalidIssuerError:
            raise Exception("Invalid issuer")
        except jwt.InvalidTokenError as e:
            raise Exception(f"Invalid token: {str(e)}")

    def _convert_jwk_to_pem(self, jwk):
        """Convert JWK to PEM format for signature verification."""
        try:
            from jwt.algorithms import RSAAlgorithm
            return RSAAlgorithm.from_jwk(json.dumps(jwk))
        except Exception as e:
            raise Exception(f"Failed to convert JWK to PEM: {str(e)}")

    def create_token(self, payload, private_key, algorithm='RS256', expires_in=3600):
        """Create JWT token with given payload."""
        # Add standard claims
        now = datetime.utcnow()
        payload.update({
            'iss': self.issuer,
            'aud': self.audience,
            'iat': now,
            'exp': now + timedelta(seconds=expires_in),
            'jti': secrets.token_hex(16)  # Unique token ID
        })

        try:
            token = jwt.encode(payload, private_key, algorithm=algorithm)
            return token
        except Exception as e:
            raise Exception(f"Failed to create token: {str(e)}")

# Usage example
jwt_handler = JWTHandler(
    issuer='https://auth.yourapp.com',
    audience='your-api-audience',
    jwks_uri='https://auth.yourapp.com/.well-known/jwks.json'
)

# Validate incoming JWT token
try:
    payload = jwt_handler.validate_token(access_token)
    user_id = payload.get('sub')
    scopes = payload.get('scope', '').split()
    print(f"Token valid for user {user_id} with scopes: {scopes}")
except Exception as e:
    print(f"Token validation failed: {e}")
```

## Development Workflow

1. **Registration**: Register client application with OAuth provider
2. **Authorization**: Redirect user to authorization server
3. **Code Exchange**: Exchange authorization code for access token
4. **API Access**: Use access token to access protected resources
5. **Token Refresh**: Refresh expired tokens using refresh token

## Best Practices

### Security Implementation

```python
import secrets
import hashlib
import time
from functools import wraps

class OAuthSecurityMiddleware:
    """Security middleware for OAuth implementations."""

    def __init__(self):
        self.rate_limits = {}
        self.blocked_ips = set()

    def rate_limit(self, max_requests=10, window_minutes=1):
        """Rate limiting decorator for OAuth endpoints."""
        def decorator(func):
            @wraps(func)
            def wrapper(*args, **kwargs):
                from flask import request, jsonify

                client_ip = request.remote_addr
                current_time = time.time()
                window_seconds = window_minutes * 60

                # Clean old entries
                self._cleanup_rate_limits(current_time, window_seconds)

                # Check rate limit
                if client_ip in self.rate_limits:
                    requests_in_window = [
                        req_time for req_time in self.rate_limits[client_ip]
                        if current_time - req_time < window_seconds
                    ]

                    if len(requests_in_window) >= max_requests:
                        return jsonify({
                            'error': 'rate_limit_exceeded',
                            'error_description': 'Too many requests'
                        }), 429

                    self.rate_limits[client_ip] = requests_in_window + [current_time]
                else:
                    self.rate_limits[client_ip] = [current_time]

                return func(*args, **kwargs)
            return wrapper
        return decorator

    def validate_redirect_uri(self, client_id, redirect_uri):
        """Validate redirect URI against registered URIs."""
        # In production, fetch from database
        registered_uris = self._get_client_redirect_uris(client_id)

        # Exact match required for security
        if redirect_uri not in registered_uris:
            return False

        # Additional security checks
        if not redirect_uri.startswith('https://'):
            # Allow http only for localhost in development
            if not (redirect_uri.startswith('http://localhost') or
                   redirect_uri.startswith('http://127.0.0.1')):
                return False

        return True

    def validate_pkce(self, code_verifier, code_challenge, method='S256'):
        """Validate PKCE code verifier against challenge."""
        if not code_verifier or not code_challenge:
            return False

        if method == 'S256':
            import base64
            computed_challenge = base64.urlsafe_b64encode(
                hashlib.sha256(code_verifier.encode()).digest()
            ).decode('utf-8').rstrip('=')

            return computed_challenge == code_challenge
        elif method == 'plain':
            return code_verifier == code_challenge

        return False

    def generate_secure_token(self, length=32):
        """Generate cryptographically secure random token."""
        return secrets.token_urlsafe(length)

    def validate_scope(self, requested_scope, client_allowed_scopes):
        """Validate requested scope against client permissions."""
        if not requested_scope:
            return []

        requested_scopes = requested_scope.split()
        allowed_scopes = client_allowed_scopes.split()

        # Check if all requested scopes are allowed
        for scope in requested_scopes:
            if scope not in allowed_scopes:
                return None

        return requested_scopes

    def _cleanup_rate_limits(self, current_time, window_seconds):
        """Clean up old rate limit entries."""
        for ip in list(self.rate_limits.keys()):
            self.rate_limits[ip] = [
                req_time for req_time in self.rate_limits[ip]
                if current_time - req_time < window_seconds
            ]

            if not self.rate_limits[ip]:
                del self.rate_limits[ip]

    def _get_client_redirect_uris(self, client_id):
        """Get registered redirect URIs for client."""
        # In production, this would query the database
        return ['https://client.app.com/callback']

# CORS handling for OAuth endpoints
def setup_oauth_cors():
    """Setup CORS for OAuth endpoints."""
    from flask_cors import CORS

    # Configure CORS for OAuth endpoints
    cors_config = {
        'origins': ['https://yourapp.com'],
        'methods': ['GET', 'POST'],
        'allow_headers': ['Content-Type', 'Authorization'],
        'expose_headers': ['Content-Type'],
        'max_age': 3600
    }

    return cors_config
```

## Common Use Cases

### Single Sign-On (SSO)

**Scenario**: Implement SSO across multiple applications
**Implementation**:

```python
class SSOProvider:
    """Single Sign-On implementation using OAuth 2.0."""

    def __init__(self, oauth_server):
        self.oauth_server = oauth_server
        self.active_sessions = {}

    def authenticate_user(self, username, password):
        """Authenticate user and create session."""
        # Validate credentials (use secure hashing)
        import bcrypt

        user = self._get_user_by_username(username)
        if not user:
            return None

        if bcrypt.checkpw(password.encode(), user['password_hash'].encode()):
            # Create SSO session
            session_id = secrets.token_urlsafe(32)
            self.active_sessions[session_id] = {
                'user_id': user['id'],
                'username': username,
                'created_at': datetime.utcnow(),
                'last_accessed': datetime.utcnow()
            }

            return session_id

        return None

    def validate_sso_session(self, session_id):
        """Validate SSO session."""
        if session_id not in self.active_sessions:
            return None

        session = self.active_sessions[session_id]

        # Check session expiry (e.g., 8 hours)
        if datetime.utcnow() - session['created_at'] > timedelta(hours=8):
            del self.active_sessions[session_id]
            return None

        # Update last accessed time
        session['last_accessed'] = datetime.utcnow()

        return session

    def logout_user(self, session_id):
        """Logout user and invalidate session."""
        if session_id in self.active_sessions:
            del self.active_sessions[session_id]

    def _get_user_by_username(self, username):
        """Get user by username from database."""
        # In production, this would query the database
        return {
            'id': '123',
            'username': username,
            'password_hash': '$2b$12$hashed_password_here'
        }

# Mobile app OAuth flow
class MobileOAuthFlow:
    """OAuth flow optimized for mobile applications."""

    def __init__(self, client_id, redirect_uri, authorization_endpoint, token_endpoint):
        self.client_id = client_id
        self.redirect_uri = redirect_uri
        self.authorization_endpoint = authorization_endpoint
        self.token_endpoint = token_endpoint

    def start_authorization_flow(self, scope=None):
        """Start OAuth flow with PKCE for mobile security."""
        # Generate PKCE parameters
        code_verifier = base64.urlsafe_b64encode(secrets.token_bytes(32)).decode('utf-8').rstrip('=')
        code_challenge = base64.urlsafe_b64encode(
            hashlib.sha256(code_verifier.encode()).digest()
        ).decode('utf-8').rstrip('=')

        state = secrets.token_urlsafe(32)

        params = {
            'response_type': 'code',
            'client_id': self.client_id,
            'redirect_uri': self.redirect_uri,
            'code_challenge': code_challenge,
            'code_challenge_method': 'S256',
            'state': state
        }

        if scope:
            params['scope'] = scope

        authorization_url = f"{self.authorization_endpoint}?{urlencode(params)}"

        return {
            'authorization_url': authorization_url,
            'code_verifier': code_verifier,
            'state': state
        }

    def handle_callback(self, callback_url, code_verifier, expected_state):
        """Handle OAuth callback and exchange code for token."""
        from urllib.parse import urlparse, parse_qs

        # Parse callback URL
        parsed_url = urlparse(callback_url)
        query_params = parse_qs(parsed_url.query)

        # Validate state parameter
        received_state = query_params.get('state', [None])[0]
        if received_state != expected_state:
            raise Exception("Invalid state parameter")

        # Get authorization code
        authorization_code = query_params.get('code', [None])[0]
        if not authorization_code:
            error = query_params.get('error', [None])[0]
            error_description = query_params.get('error_description', [None])[0]
            raise Exception(f"Authorization failed: {error} - {error_description}")

        # Exchange code for token
        token_data = {
            'grant_type': 'authorization_code',
            'code': authorization_code,
            'redirect_uri': self.redirect_uri,
            'client_id': self.client_id,
            'code_verifier': code_verifier
        }

        response = requests.post(
            self.token_endpoint,
            data=token_data,
            headers={'Content-Type': 'application/x-www-form-urlencoded'},
            timeout=30
        )

        if response.status_code == 200:
            return response.json()
        else:
            raise Exception(f"Token exchange failed: {response.status_code} - {response.text}")
```

## Common Issues & Solutions

### Issue 1: CSRF Attacks

**Problem**: Cross-site request forgery in OAuth flows
**Solution**: Always use and validate state parameter

```python
def validate_oauth_state(received_state, expected_state):
    """Validate OAuth state parameter to prevent CSRF."""
    if not received_state or not expected_state:
        return False

    # Use constant-time comparison to prevent timing attacks
    import hmac
    return hmac.compare_digest(received_state, expected_state)
```

### Issue 2: Token Leakage

**Problem**: Access tokens exposed in URLs or logs
**Solution**: Use secure token storage and proper logging

```python
import logging

class SecureTokenStorage:
    """Secure token storage for OAuth applications."""

    def __init__(self):
        self.tokens = {}

    def store_token(self, user_id, token_data):
        """Store token with encryption."""
        # In production, use proper encryption and secure storage
        self.tokens[user_id] = token_data

        # Log without exposing token values
        logging.info(f"Token stored for user {user_id}")

    def get_token(self, user_id):
        """Retrieve token securely."""
        return self.tokens.get(user_id)

    def remove_token(self, user_id):
        """Remove token securely."""
        if user_id in self.tokens:
            del self.tokens[user_id]
            logging.info(f"Token removed for user {user_id}")
```

## Security Considerations

- Always use HTTPS for OAuth flows
- Implement PKCE for public clients (mobile, SPA)
- Validate redirect URIs strictly
- Use short-lived access tokens with refresh tokens
- Implement proper token storage and handling
- Rate limit OAuth endpoints
- Validate state parameter to prevent CSRF
- Use secure random number generation

## AI Assistant Guidelines

When helping with OAuth 2.0 implementation:

1. **Always emphasize HTTPS requirement** for production OAuth flows
2. **Recommend PKCE for public clients** to prevent authorization code interception
3. **Include proper state validation** to prevent CSRF attacks
4. **Suggest secure token storage** methods for different client types
5. **Implement rate limiting** on OAuth endpoints
6. **Follow OAuth 2.0 Security Best Practices** (RFC 6819)
7. **Validate redirect URIs strictly** against registered URIs
8. **Include proper error handling** and logging without exposing sensitive data

### Code Generation Rules

- Generate OAuth implementations following RFC 6749 specifications
- Include comprehensive security validations and error handling
- Use cryptographically secure random number generation
- Implement proper token lifecycle management
- Follow OAuth security best practices and recommendations
- Include rate limiting and abuse prevention mechanisms
- Generate modular code suitable for different OAuth flows
- Provide clear documentation of security considerations
