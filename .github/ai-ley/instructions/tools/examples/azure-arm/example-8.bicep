// azure-devops-integration.bicep - Enterprise CI/CD Pipeline
targetScope = 'subscription'

@description('Azure DevOps organization name')
param azureDevOpsOrganization string

@description('Azure DevOps project name')
param azureDevOpsProject string

@description('Repository name for infrastructure code')
param repositoryName string = 'enterprise-infrastructure'

@description('Environment for pipeline configuration')
param environment string = 'production'

@description('Service connection name')
param serviceConnectionName string = 'azure-enterprise-connection'

// Resource group for DevOps resources
resource devopsResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'rg-devops-${environment}'
  location: deployment().location
  tags: {
    Purpose: 'DevOps'
    Environment: environment
    ManagedBy: 'InfrastructureTeam'
  }
}

// Container Registry for build artifacts
module containerRegistry '../modules/container-registry.bicep' = {
  name: 'devops-container-registry'
  scope: devopsResourceGroup
  params: {
    registryName: 'acrdevops${uniqueString(subscription().subscriptionId)}'
    location: deployment().location
    sku: 'Premium'
    adminUserEnabled: false
    publicNetworkAccess: 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      quarantinePolicy: {
        status: 'enabled'
      }
      trustPolicy: {
        status: 'enabled'
        type: 'Notary'
      }
      retentionPolicy: {
        status: 'enabled'
        days: 30
      }
    }
    diagnosticSettings: [
      {
        name: 'registry-monitoring'
        logAnalyticsWorkspaceId: devopsLogAnalytics.outputs.workspaceId
        logs: [
          {
            category: 'ContainerRegistryRepositoryEvents'
            enabled: true
          }
          {
            category: 'ContainerRegistryLoginEvents'
            enabled: true
          }
        ]
        metrics: [
          {
            category: 'AllMetrics'
            enabled: true
          }
        ]
      }
    ]
    tags: {
      Purpose: 'BuildArtifacts'
      Environment: environment
    }
  }
}

// Log Analytics for DevOps monitoring
module devopsLogAnalytics '../modules/log-analytics-workspace.bicep' = {
  name: 'devops-monitoring'
  scope: devopsResourceGroup
  params: {
    workspaceName: 'law-devops-${environment}'
    location: deployment().location
    sku: 'PerGB2018'
    retentionInDays: 90
    dailyQuotaGb: 10
    solutions: [
      'ContainerInsights'
      'AzureActivity'
      'SecurityInsights'
    ]
    tags: {
      Purpose: 'DevOpsMonitoring'
      Environment: environment
    }
  }
}

// Key Vault for DevOps secrets
module devopsKeyVault '../modules/key-vault.bicep' = {
  name: 'devops-secrets'
  scope: devopsResourceGroup
  params: {
    keyVaultName: 'kv-devops-${uniqueString(subscription().subscriptionId)}'
    location: deployment().location
    sku: 'standard'
    enableSoftDelete: true
    softDeleteRetentionInDays: 30
    enablePurgeProtection: false
    enableRbacAuthorization: true
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
    secrets: [
      {
        name: 'azure-devops-pat'
        value: 'placeholder-token'
        contentType: 'Azure DevOps Personal Access Token'
      }
      {
        name: 'container-registry-password'
        value: 'placeholder-password'
        contentType: 'Container Registry Admin Password'
      }
    ]
    tags: {
      Purpose: 'DevOpsSecrets'
      Environment: environment
    }
  }
}

output containerRegistryId string = containerRegistry.outputs.registryId
output containerRegistryLoginServer string = containerRegistry.outputs.loginServer
output devopsKeyVaultId string = devopsKeyVault.outputs.keyVaultId
output devopsLogAnalyticsId string = devopsLogAnalytics.outputs.workspaceId