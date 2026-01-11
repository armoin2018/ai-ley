class EnterpriseAWSPlatform:
    """Production-ready AWS platform management with enterprise features"""

    def __init__(self, config: EnterpriseAWSConfig):
        self.config = config
        self.logger = structlog.get_logger("enterprise.aws")
        self.sessions: Dict[str, boto3.Session] = {}
        self.clients: Dict[str, Dict[str, Any]] = {}

        # Enterprise components
        self.infrastructure_templates = {}
        self.security_policies = {}
        self.monitoring_dashboards = {}
        self.cost_optimization_rules = {}

        # Validate configuration
        config_errors = self.config.validate_configuration()
        if config_errors:
            raise ValueError(f"Configuration errors: {'; '.join(config_errors)}")

    async def __aenter__(self):
        """Async context manager entry"""
        await self.initialize()
        return self

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        """Async context manager exit"""
        await self.cleanup()

    async def initialize(self) -> None:
        """Initialize enterprise AWS platform"""
        try:
            # Initialize AWS sessions for all accounts
            await self._initialize_aws_sessions()

            # Setup cross-account roles and permissions
            await self._setup_cross_account_access()

            # Initialize enterprise security
            await self._setup_enterprise_security()

            # Setup monitoring and alerting
            await self._setup_enterprise_monitoring()

            # Configure cost management
            await self._setup_cost_management()

            # Setup compliance and governance
            await self._setup_compliance_governance()

            self.logger.info(
                "Enterprise AWS platform initialized",
                organization=self.config.organization_name,
                environment=self.config.environment.value,
                accounts=len(self.config.accounts),
                regions=len([self.config.primary_region] + self.config.secondary_regions)
            )

        except Exception as e:
            self.logger.error(f"Failed to initialize AWS platform: {e}")
            raise

    async def cleanup(self) -> None:
        """Clean up resources"""
        try:
            # Close all sessions
            self.sessions.clear()
            self.clients.clear()

            self.logger.info("AWS platform cleaned up successfully")

        except Exception as e:
            self.logger.error(f"Error during cleanup: {e}")

    async def _initialize_aws_sessions(self) -> None:
        """Initialize AWS sessions for all accounts and regions"""
        try:
            for account_name, account_id in self.config.accounts.items():
                session_key = f"{account_name}_{self.config.primary_region.value}"

                # Create session with assume role for cross-account access
                if account_name != "master":
                    role_arn = f"arn:aws:iam::{account_id}:role/EnterpriseOrganizationRole"
                    sts_client = boto3.client('sts')

                    assumed_role = sts_client.assume_role(
                        RoleArn=role_arn,
                        RoleSessionName=f"EnterpriseSession-{account_name}"
                    )

                    credentials = assumed_role['Credentials']
                    session = boto3.Session(
                        aws_access_key_id=credentials['AccessKeyId'],
                        aws_secret_access_key=credentials['SecretAccessKey'],
                        aws_session_token=credentials['SessionToken'],
                        region_name=self.config.primary_region.value
                    )
                else:
                    session = boto3.Session(region_name=self.config.primary_region.value)

                self.sessions[session_key] = session

                # Initialize clients for common services
                self.clients[session_key] = {
                    'ec2': session.client('ec2'),
                    'iam': session.client('iam'),
                    's3': session.client('s3'),
                    'rds': session.client('rds'),
                    'lambda': session.client('lambda'),
                    'cloudformation': session.client('cloudformation'),
                    'cloudwatch': session.client('cloudwatch'),
                    'logs': session.client('logs'),
                    'sts': session.client('sts'),
                    'organizations': session.client('organizations'),
                    'guardduty': session.client('guardduty'),
                    'securityhub': session.client('securityhub'),
                    'config': session.client('config')
                }

            self.logger.info(f"Initialized AWS sessions for {len(self.sessions)} account-region combinations")

        except Exception as e:
            self.logger.error(f"Failed to initialize AWS sessions: {e}")
            raise

    async def _setup_cross_account_access(self) -> None:
        """Setup cross-account access roles and policies"""
        try:
            master_session_key = f"master_{self.config.primary_region.value}"
            if master_session_key not in self.clients:
                return

            organizations_client = self.clients[master_session_key]['organizations']

            # Create enterprise organization role policy
            enterprise_role_policy = {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Effect": "Allow",
                        "Principal": {
                            "AWS": f"arn:aws:iam::{self.config.master_account_id}:root"
                        },
                        "Action": "sts:AssumeRole",
                        "Condition": {
                            "StringEquals": {
                                "aws:PrincipalTag/Department": "Engineering"
                            }
                        }
                    }
                ]
            }

            # Enterprise management policies
            enterprise_policies = [
                {
                    "name": "EnterpriseCloudFormationAccess",
                    "policy": {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Action": [
                                    "cloudformation:*",
                                    "iam:CreateRole",
                                    "iam:DeleteRole",
                                    "iam:PutRolePolicy",
                                    "iam:DeleteRolePolicy",
                                    "iam:PassRole"
                                ],
                                "Resource": "*"
                            }
                        ]
                    }
                },
                {
                    "name": "EnterpriseMonitoringAccess",
                    "policy": {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Action": [
                                    "cloudwatch:*",
                                    "logs:*",
                                    "xray:*",
                                    "application-insights:*"
                                ],
                                "Resource": "*"
                            }
                        ]
                    }
                },
                {
                    "name": "EnterpriseSecurityAccess",
                    "policy": {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Action": [
                                    "guardduty:*",
                                    "securityhub:*",
                                    "config:*",
                                    "inspector:*",
                                    "macie:*"
                                ],
                                "Resource": "*"
                            }
                        ]
                    }
                }
            ]

            self.security_policies = {
                "cross_account_role": enterprise_role_policy,
                "management_policies": enterprise_policies
            }

            self.logger.info("Cross-account access configuration prepared")

        except Exception as e:
            self.logger.error(f"Failed to setup cross-account access: {e}")
            raise