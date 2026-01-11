// templates/bicep/main/enterprise-foundation.bicep
@description('Enterprise prefix for resource naming')
param enterprisePrefix string = 'enterprise'

@description('Deployment environment')
@allowed(['dev', 'staging', 'production'])
param environment string = 'dev'

@description('Compliance framework to implement')
@allowed(['SOC2', 'PCI-DSS', 'HIPAA', 'CIS', 'NIST'])
param complianceFramework string = 'SOC2'

@description('Primary Azure region')
param primaryRegion string = resourceGroup().location

@description('Enable advanced security features')
param enableAdvancedSecurity bool = true

// Shared variables
var namingConvention = {
  resourceGroup: '${enterprisePrefix}-${environment}-rg'
  keyVault: '${enterprisePrefix}-${environment}-kv-${uniqueString(resourceGroup().id)}'
  managedIdentity: '${enterprisePrefix}-${environment}-mi'
  logAnalytics: '${enterprisePrefix}-${environment}-law-${uniqueString(resourceGroup().id)}'
}

var complianceConfiguration = {
  SOC2: {
    auditRetentionDays: 2555
    encryptionRequired: true
    backupRequired: true
    monitoringLevel: 'comprehensive'
  }
  'PCI-DSS': {
    auditRetentionDays: 365
    encryptionRequired: true
    networkSegmentation: true
    monitoringLevel: 'detailed'
  }
  HIPAA: {
    auditRetentionDays: 2190
    encryptionRequired: true
    accessLogging: true
    monitoringLevel: 'comprehensive'
  }
}

var currentCompliance = complianceConfiguration[complianceFramework]

// Enterprise foundation modules
module managedIdentity 'modules/identity.bicep' = {
  name: 'managedIdentityDeployment'
  params: {
    name: namingConvention.managedIdentity
    location: primaryRegion
    tags: {
      Environment: environment
      ComplianceFramework: complianceFramework
      ManagedBy: 'Bicep'
    }
  }
}

module keyVault 'modules/security/keyvault.bicep' = if (enableAdvancedSecurity) {
  name: 'keyVaultDeployment'
  params: {
    name: namingConvention.keyVault
    location: primaryRegion
    sku: environment == 'production' ? 'premium' : 'standard'
    enablePurgeProtection: environment == 'production'
    softDeleteRetentionInDays: currentCompliance.auditRetentionDays
    managedIdentityPrincipalId: managedIdentity.outputs.principalId
  }
  dependsOn: [
    managedIdentity
  ]
}

module logAnalytics 'modules/monitoring/log-analytics.bicep' = {
  name: 'logAnalyticsDeployment'
  params: {
    name: namingConvention.logAnalytics
    location: primaryRegion
    retentionInDays: currentCompliance.auditRetentionDays
    enableSentinel: environment == 'production'
  }
}

// Outputs
output managedIdentityId string = managedIdentity.outputs.id
output managedIdentityPrincipalId string = managedIdentity.outputs.principalId
output keyVaultUri string = enableAdvancedSecurity ? keyVault.outputs.vaultUri : ''
output logAnalyticsWorkspaceId string = logAnalytics.outputs.workspaceId