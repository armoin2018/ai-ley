// security-compliance-foundation.bicep - Comprehensive Security and Compliance
targetScope = 'subscription'

@description('Environment type for security configuration')
@allowed(['production', 'staging', 'development', 'sandbox'])
param environment string = 'production'

@description('Compliance frameworks to implement')
param complianceFrameworks array = [
  'SOC2'
  'PCI-DSS'
  'HIPAA'
  'CIS'
  'NIST'
]

@description('Data classification level')
@allowed(['public', 'internal', 'confidential', 'restricted'])
param dataClassification string = 'confidential'

@description('Location for security resources')
param location string = deployment().location

// Security Resource Group
resource securityResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-security-${environment}'
  location: location
  tags: {
    Purpose: 'Security'
    Environment: environment
    ComplianceFrameworks: join(complianceFrameworks, ',')
    DataClassification: dataClassification
  }
}

// Key Vault with Advanced Security
module keyVault '../modules/key-vault-premium.bicep' = {
  name: 'enterprise-keyvault-${environment}'
  scope: securityResourceGroup
  params: {
    keyVaultName: 'kv-enterprise-${environment}-${uniqueString(subscription().subscriptionId)}'
    location: location
    sku: 'premium'
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enablePurgeProtection: true
    enableRbacAuthorization: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
    }
    diagnosticSettings: [
      {
        name: 'security-monitoring'
        logAnalyticsWorkspaceId: securityLogAnalytics.outputs.workspaceId
        logs: [
          {
            category: 'AuditEvent'
            enabled: true
            retentionPolicy: {
              enabled: true
              days: 365
            }
          }
        ]
        metrics: [
          {
            category: 'AllMetrics'
            enabled: true
            retentionPolicy: {
              enabled: true
              days: 90
            }
          }
        ]
      }
    ]
    tags: {
      Purpose: 'SecuritySecrets'
      ComplianceFramework: join(complianceFrameworks, ',')
      DataClassification: dataClassification
    }
  }
}

// Azure Sentinel (Security Information and Event Management)
module sentinelWorkspace '../modules/sentinel-workspace.bicep' = {
  name: 'sentinel-${environment}'
  scope: securityResourceGroup
  params: {
    workspaceName: 'law-sentinel-${environment}'
    location: location
    sku: 'PerGB2018'
    retentionInDays: environment == 'production' ? 730 : 90
    dailyQuotaGb: environment == 'production' ? 100 : 10
    sentinelSolutions: [
      'SecurityInsights'
      'AzureActivity'
      'SecurityEvents'
      'WindowsFirewall'
      'DNS'
      'AzureKeyVault'
      'AzureStorage'
      'AzureSQL'
    ]
    dataConnectors: [
      'AzureActiveDirectory'
      'AzureSecurityCenter'
      'MicrosoftCloudAppSecurity'
      'MicrosoftDefenderForIdentity'
      'Office365'
    ]
    alertRules: [
      {
        displayName: 'Suspicious Key Vault Access'
        description: 'Detects unusual access patterns to Key Vault'
        severity: 'High'
        enabled: true
        query: '''
          KeyVaultData
          | where TimeGenerated > ago(1h)
          | where ResultDescription contains "Forbidden"
          | summarize count() by CallerIpAddress, identity_claim_upn_s
          | where count_ > 5
        '''
        queryFrequency: 'PT1H'
        queryPeriod: 'PT1H'
        triggerOperator: 'GreaterThan'
        triggerThreshold: 0
      }
      {
        displayName: 'Privileged Role Assignment'
        description: 'Detects assignment of privileged roles'
        severity: 'Medium'
        enabled: true
        query: '''
          AuditLogs
          | where TimeGenerated > ago(1h)
          | where OperationName == "Add member to role"
          | where TargetResources has "Global Administrator" or TargetResources has "Privileged Role Administrator"
        '''
        queryFrequency: 'PT1H'
        queryPeriod: 'PT1H'
        triggerOperator: 'GreaterThan'
        triggerThreshold: 0
      }
    ]
    workbooks: [
      'Azure AD Audit logs'
      'Azure AD Sign-in logs'
      'Azure Activity'
      'Security Alerts'
      'Compliance'
    ]
    tags: {
      Purpose: 'SecurityMonitoring'
      SIEM: 'Sentinel'
      ComplianceFramework: join(complianceFrameworks, ',')
    }
  }
}

// Security Log Analytics Workspace
module securityLogAnalytics '../modules/log-analytics-workspace.bicep' = {
  name: 'security-logs-${environment}'
  scope: securityResourceGroup
  params: {
    workspaceName: 'law-security-${environment}'
    location: location
    sku: 'PerGB2018'
    retentionInDays: environment == 'production' ? 2555 : 365 // 7 years for production SOC2 compliance
    dailyQuotaGb: environment == 'production' ? 50 : 5
    solutions: [
      'Security'
      'SecurityInsights'
      'KeyVaultAnalytics'
      'AzureActivity'
      'NetworkMonitoring'
      'ServiceMap'
    ]
    tags: {
      Purpose: 'SecurityLogging'
      RetentionYears: environment == 'production' ? '7' : '1'
      ComplianceFramework: join(complianceFrameworks, ',')
    }
  }
}

// Microsoft Defender for Cloud Configuration
resource defenderPlan 'Microsoft.Security/pricings@2023-01-01' = [for service in [
  'VirtualMachines'
  'SqlServers'
  'AppServices'
  'StorageAccounts'
  'KeyVaults'
  'Arm'
  'Dns'
  'KubernetesService'
  'ContainerRegistry'
  'Containers'
]: {
  name: service
  properties: {
    pricingTier: environment == 'production' ? 'Standard' : 'Free'
    subPlan: service == 'VirtualMachines' ? 'P2' : null
  }
}]

// Security Contacts Configuration
resource securityContacts 'Microsoft.Security/securityContacts@2023-03-01' = {
  name: 'security-team'
  properties: {
    emails: 'security-team@company.com;incident-response@company.com'
    alertNotifications: {
      state: 'On'
      minimalSeverity: 'Medium'
    }
    notificationsByRole: {
      state: 'On'
      roles: [
        'Owner'
        'ServiceAdmin'
        'AccountAdmin'
      ]
    }
  }
}

// Auto Provisioning Settings
resource autoProvisioningSettings 'Microsoft.Security/autoProvisioningSettings@2017-08-01-preview' = {
  name: 'default'
  properties: {
    autoProvision: 'On'
  }
}

// Compliance Assessment for SOC2
resource soc2Assessment 'Microsoft.Security/assessmentMetadata@2021-06-01' = if (contains(complianceFrameworks, 'SOC2')) {
  name: 'soc2-compliance-assessment'
  properties: {
    displayName: 'SOC 2 Compliance Assessment'
    description: 'Comprehensive SOC 2 compliance assessment for trust service criteria'
    severity: 'High'
    userImpact: 'High'
    implementationEffort: 'High'
    threats: [
      'dataExfiltration'
      'dataSpillage'
      'maliciousInsider'
      'accountBreach'
    ]
    categories: [
      'Data'
      'IdentityAndAccess'
      'IoT'
      'Networking'
      'Compute'
    ]
    assessmentType: 'BuiltIn'
    policyDefinitionId: resourceId('Microsoft.Authorization/policyDefinitions', 'enterprise-soc2-baseline')
  }
}

// PCI-DSS Compliance Configuration
resource pciDssInitiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = if (contains(complianceFrameworks, 'PCI-DSS')) {
  name: 'enterprise-pci-dss-initiative'
  properties: {
    displayName: 'Enterprise PCI-DSS Compliance Initiative'
    description: 'Comprehensive PCI-DSS compliance controls for payment card data protection'
    policyType: 'Custom'
    metadata: {
      category: 'Compliance'
      version: '1.0.0'
      source: 'Enterprise Security Team'
      pciDssVersion: '4.0'
    }
    parameters: {
      effect: {
        type: 'String'
        defaultValue: 'AuditIfNotExists'
        allowedValues: [
          'AuditIfNotExists'
          'Disabled'
        ]
      }
    }
    policyDefinitions: [
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9' // Storage accounts should use customer-managed key for encryption
        parameters: {
          effect: {
            value: '[parameters(\'effect\')]'
          }
        }
        policyDefinitionReferenceId: 'pci-requirement-3-4'
        groupNames: [
          'PCI_DSS_3.4'
        ]
      }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d' // Key vaults should have purge protection enabled
        parameters: {
          effect: {
            value: '[parameters(\'effect\')]'
          }
        }
        policyDefinitionReferenceId: 'pci-requirement-3-6'
        groupNames: [
          'PCI_DSS_3.6'
        ]
      }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/55615ac9-af46-4a59-874e-391cc3dfb490' // Firewall should be enabled on Key Vault
        parameters: {
          effect: {
            value: '[parameters(\'effect\')]'
          }
        }
        policyDefinitionReferenceId: 'pci-requirement-1-3'
        groupNames: [
          'PCI_DSS_1.3'
        ]
      }
    ]
    policyDefinitionGroups: [
      {
        name: 'PCI_DSS_1.3'
        displayName: 'Requirement 1.3 - Prohibit direct public access between external networks and components'
        description: 'Install perimeter firewalls between all external networks and components that store cardholder data'
      }
      {
        name: 'PCI_DSS_3.4'
        displayName: 'Requirement 3.4 - Render Primary Account Numbers unreadable'
        description: 'Use strong cryptography to render cardholder data unreadable'
      }
      {
        name: 'PCI_DSS_3.6'
        displayName: 'Requirement 3.6 - Protect cryptographic keys'
        description: 'Fully document and implement key-management processes and procedures for cryptographic keys'
      }
    ]
  }
}

// HIPAA Compliance for Healthcare Data
resource hipaaSecurityRules 'Microsoft.Authorization/policyDefinition@2023-04-01' = if (contains(complianceFrameworks, 'HIPAA')) {
  name: 'enterprise-hipaa-security-rule'
  properties: {
    displayName: 'HIPAA Security Rule Compliance'
    description: 'Implement HIPAA Security Rule requirements for protected health information (PHI)'
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      category: 'Healthcare'
      version: '1.0.0'
      hipaaSection: '164.312'
      description: 'Administrative, physical, and technical safeguards for electronic PHI'
    }
    parameters: {
      requiredEncryption: {
        type: 'Boolean'
        defaultValue: true
        metadata: {
          displayName: 'Require Encryption'
          description: 'Require encryption for all PHI storage and transmission'
        }
      }
      auditRetentionDays: {
        type: 'Integer'
        defaultValue: 2555 // 7 years
        metadata: {
          displayName: 'Audit Log Retention (Days)'
          description: 'Minimum retention period for audit logs'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            in: [
              'Microsoft.Storage/storageAccounts'
              'Microsoft.Sql/servers'
              'Microsoft.DocumentDB/databaseAccounts'
            ]
          }
          {
            field: 'tags[\'DataClassification\']'
            equals: 'PHI'
          }
        ]
      }
      then: {
        effect: 'AuditIfNotExists'
        details: {
          type: 'Microsoft.Insights/diagnosticSettings'
          existenceCondition: {
            allOf: [
              {
                count: {
                  field: 'Microsoft.Insights/diagnosticSettings/logs[*]'
                  where: {
                    allOf: [
                      {
                        field: 'Microsoft.Insights/diagnosticSettings/logs[*].enabled'
                        equals: 'True'
                      }
                      {
                        field: 'Microsoft.Insights/diagnosticSettings/logs[*].retentionPolicy.days'
                        greaterOrEquals: '[parameters(\'auditRetentionDays\')]'
                      }
                    ]
                  }
                }
                greaterOrEquals: 1
              }
            ]
          }
        }
      }
    }
  }
}

// Advanced Threat Protection Configuration
resource advancedThreatProtection 'Microsoft.Security/advancedThreatProtectionSettings@2019-01-01' = {
  name: 'current'
  scope: keyVault
  properties: {
    isEnabled: true
  }
}

output keyVaultId string = keyVault.outputs.keyVaultId
output sentinelWorkspaceId string = sentinelWorkspace.outputs.workspaceId
output securityLogAnalyticsId string = securityLogAnalytics.outputs.workspaceId
output complianceInitiatives array = [
  soc2Assessment.id
  pciDssInitiative.id
  hipaaSecurityRules.id
]