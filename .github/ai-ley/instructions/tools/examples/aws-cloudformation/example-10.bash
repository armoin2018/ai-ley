# Create comprehensive enterprise CloudFormation structure
mkdir -p aws-cloudformation-enterprise/{
  templates/{nested,modules,macros,custom-resources},
  parameters/{dev,staging,production},
  policies/{iam,scp,bucket},
  scripts/{deploy,validate,cleanup},
  tests/{unit,integration,security,compliance},
  docs/{architecture,runbooks,compliance},
  cicd/{codepipeline,github-actions,jenkins},
  monitoring/{cloudwatch,x-ray,config},
  security/{kms,secrets,certificates},
  backup/{cross-region,disaster-recovery},
  costs/{budgets,optimization,reports}
}

# Initialize CDK project for advanced constructs
cd aws-cloudformation-enterprise
cdk init app --language typescript
npm install @aws-cdk/aws-cloudformation @aws-cdk/aws-iam @aws-cdk/aws-s3

# Create enterprise template structure
cat > templates/enterprise-foundation.yaml << 'EOF'
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: 'Enterprise Foundation Stack with Compliance, Security, and Monitoring'

Metadata:
  AWS::CloudFormation::Interface:
    ParameterGroups:
      - Label:
          default: "Environment Configuration"
        Parameters:
          - Environment
          - ComplianceFramework
          - CostCenter
      - Label:
          default: "Security Configuration"
        Parameters:
          - EnableEncryption
          - KMSKeyId
          - SecurityContactEmail
      - Label:
          default: "Monitoring Configuration"
        Parameters:
          - EnableDetailedMonitoring
          - AlertingEmail
          - RetentionPeriod

Parameters:
  Environment:
    Type: String
    AllowedValues: [dev, staging, production]
    Default: dev
    Description: Deployment environment

  ComplianceFramework:
    Type: String
    AllowedValues: [SOC2, PCI-DSS, HIPAA, CIS, NIST]
    Default: SOC2
    Description: Compliance framework to implement

  CostCenter:
    Type: String
    Description: Cost center for resource tagging
    Default: "Engineering"

  EnableEncryption:
    Type: String
    AllowedValues: [true, false]
    Default: true
    Description: Enable encryption at rest and in transit

  KMSKeyId:
    Type: String
    Description: KMS Key ID for encryption (leave empty for AWS managed)
    Default: ""

  SecurityContactEmail:
    Type: String
    Description: Email for security notifications
    AllowedPattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

  EnableDetailedMonitoring:
    Type: String
    AllowedValues: [true, false]
    Default: true
    Description: Enable detailed CloudWatch monitoring

  AlertingEmail:
    Type: String
    Description: Email for operational alerts
    AllowedPattern: "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

  RetentionPeriod:
    Type: Number
    Default: 90
    MinValue: 30
    MaxValue: 2555
    Description: Log retention period in days

Conditions:
  IsProduction: !Equals [!Ref Environment, production]
  EnableEncryptionCondition: !Equals [!Ref EnableEncryption, true]
  UseCustomKMS: !Not [!Equals [!Ref KMSKeyId, ""]]
  EnableDetailedMonitoringCondition: !Equals [!Ref EnableDetailedMonitoring, true]

Resources:
  # Enterprise KMS Key for encryption
  EnterpriseKMSKey:
    Type: AWS::KMS::Key
    Condition: EnableEncryptionCondition
    Properties:
      Description: !Sub "Enterprise KMS Key for ${Environment} environment"
      KeyPolicy:
        Statement:
          - Sid: Enable IAM User Permissions
            Effect: Allow
            Principal:
              AWS: !Sub "arn:aws:iam::${AWS::AccountId}:root"
            Action: "kms:*"
            Resource: "*"
          - Sid: Allow CloudFormation Service
            Effect: Allow
            Principal:
              Service: cloudformation.amazonaws.com
            Action:
              - kms:Decrypt
              - kms:Encrypt
              - kms:ReEncrypt*
              - kms:GenerateDataKey*
              - kms:CreateGrant
              - kms:DescribeKey
            Resource: "*"
      KeyUsage: ENCRYPT_DECRYPT
      KeySpec: SYMMETRIC_DEFAULT
      MultiRegion: !If [IsProduction, true, false]
      Tags:
        - Key: Environment
          Value: !Ref Environment
        - Key: ComplianceFramework
          Value: !Ref ComplianceFramework
        - Key: CostCenter
          Value: !Ref CostCenter

  EnterpriseKMSKeyAlias:
    Type: AWS::KMS::Alias
    Condition: EnableEncryptionCondition
    Properties:
      AliasName: !Sub "alias/enterprise-${Environment}-key"
      TargetKeyId: !Ref EnterpriseKMSKey

Outputs:
  StackName:
    Description: Name of this CloudFormation stack
    Value: !Ref AWS::StackName
    Export:
      Name: !Sub "${AWS::StackName}-StackName"

  Environment:
    Description: Deployment environment
    Value: !Ref Environment
    Export:
      Name: !Sub "${AWS::StackName}-Environment"

  KMSKeyId:
    Condition: EnableEncryptionCondition
    Description: Enterprise KMS Key ID
    Value: !Ref EnterpriseKMSKey
    Export:
      Name: !Sub "${AWS::StackName}-KMSKeyId"

  KMSKeyArn:
    Condition: EnableEncryptionCondition
    Description: Enterprise KMS Key ARN
    Value: !GetAtt EnterpriseKMSKey.Arn
    Export:
      Name: !Sub "${AWS::StackName}-KMSKeyArn"
EOF

# Create parameter files for different environments
cat > parameters/dev/foundation-params.json << 'EOF'
[
  {
    "ParameterKey": "Environment",
    "ParameterValue": "dev"
  },
  {
    "ParameterKey": "ComplianceFramework",
    "ParameterValue": "CIS"
  },
  {
    "ParameterKey": "CostCenter",
    "ParameterValue": "Development"
  },
  {
    "ParameterKey": "EnableEncryption",
    "ParameterValue": "true"
  },
  {
    "ParameterKey": "SecurityContactEmail",
    "ParameterValue": "security-dev@enterprise.local"
  },
  {
    "ParameterKey": "EnableDetailedMonitoring",
    "ParameterValue": "false"
  },
  {
    "ParameterKey": "AlertingEmail",
    "ParameterValue": "alerts-dev@enterprise.local"
  },
  {
    "ParameterKey": "RetentionPeriod",
    "ParameterValue": "30"
  }
]
EOF

cat > parameters/production/foundation-params.json << 'EOF'
[
  {
    "ParameterKey": "Environment",
    "ParameterValue": "production"
  },
  {
    "ParameterKey": "ComplianceFramework",
    "ParameterValue": "SOC2"
  },
  {
    "ParameterKey": "CostCenter",
    "ParameterValue": "Operations"
  },
  {
    "ParameterKey": "EnableEncryption",
    "ParameterValue": "true"
  },
  {
    "ParameterKey": "SecurityContactEmail",
    "ParameterValue": "security@enterprise.local"
  },
  {
    "ParameterKey": "EnableDetailedMonitoring",
    "ParameterValue": "true"
  },
  {
    "ParameterKey": "AlertingEmail",
    "ParameterValue": "alerts@enterprise.local"
  },
  {
    "ParameterKey": "RetentionPeriod",
    "ParameterValue": "365"
  }
]
EOF

echo "Enterprise AWS CloudFormation structure created successfully"