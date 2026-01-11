// management-group-structure.bicep - Enterprise Management Group Hierarchy
targetScope = 'tenant'

@description('Organization name for naming conventions')
param organizationName string = 'Enterprise'

@description('Root management group configuration')
param rootManagementGroup object = {
  id: 'enterprise-root'
  displayName: 'Enterprise Root Management Group'
  description: 'Root management group for enterprise governance'
}

@description('Management group hierarchy configuration')
param managementGroupHierarchy array = [
  {
    id: 'enterprise-platform'
    displayName: 'Platform Management Group'
    description: 'Platform services and shared infrastructure'
    parentId: 'enterprise-root'
    subscriptions: []
  }
  {
    id: 'enterprise-landing-zones'
    displayName: 'Landing Zones Management Group'
    description: 'Application landing zones'
    parentId: 'enterprise-root'
    subscriptions: []
  }
  {
    id: 'enterprise-production'
    displayName: 'Production Landing Zones'
    description: 'Production application workloads'
    parentId: 'enterprise-landing-zones'
    subscriptions: ['subscription-prod-001', 'subscription-prod-002']
  }
  {
    id: 'enterprise-non-production'
    displayName: 'Non-Production Landing Zones'
    description: 'Development and testing workloads'
    parentId: 'enterprise-landing-zones'
    subscriptions: ['subscription-dev-001', 'subscription-test-001']
  }
  {
    id: 'enterprise-sandbox'
    displayName: 'Sandbox Management Group'
    description: 'Sandbox environments for experimentation'
    parentId: 'enterprise-root'
    subscriptions: ['subscription-sandbox-001']
  }
  {
    id: 'enterprise-decommissioned'
    displayName: 'Decommissioned Management Group'
    description: 'Decommissioned subscriptions with restricted access'
    parentId: 'enterprise-root'
    subscriptions: []
  }
]

// Create root management group
resource rootMg 'Microsoft.Management/managementGroups@2023-04-01' = {
  name: rootManagementGroup.id
  properties: {
    displayName: rootManagementGroup.displayName
    details: {
      parent: {
        id: '/providers/Microsoft.Management/managementGroups/${tenant().tenantId}'
      }
    }
  }
}

// Create management group hierarchy
resource managementGroups 'Microsoft.Management/managementGroups@2023-04-01' = [for mg in managementGroupHierarchy: {
  name: mg.id
  dependsOn: [rootMg]
  properties: {
    displayName: mg.displayName
    details: {
      parent: {
        id: '/providers/Microsoft.Management/managementGroups/${mg.parentId}'
      }
    }
  }
}]

// Enterprise Policy Definitions
resource enterpriseSecurityPolicy 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'enterprise-security-baseline'
  properties: {
    displayName: 'Enterprise Security Baseline'
    description: 'Comprehensive security baseline for enterprise workloads'
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Security'
      version: '1.0.0'
      source: 'Enterprise IT'
    }
    parameters: {
      effect: {
        type: 'String'
        allowedValues: ['Audit', 'Deny', 'DeployIfNotExists', 'AuditIfNotExists']
        defaultValue: 'Audit'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
      }
      requiredTags: {
        type: 'Array'
        defaultValue: [
          'Environment'
          'Owner'
          'Project'
          'CostCenter'
          'DataClassification'
          'BusinessUnit'
        ]
        metadata: {
          displayName: 'Required Tags'
          description: 'List of required tags for all resources'
        }
      }
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            notIn: [
              'Microsoft.Resources/resourceGroups'
              'Microsoft.Resources/subscriptions'
            ]
          }
          {
            anyOf: [
              for tag in parameters('requiredTags'): {
                field: 'tags[\'${tag}\']'
                exists: 'false'
              }
            ]
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          type: 'Microsoft.Resources/tags'
          roleDefinitionIds: [
            '/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c' // Contributor
          ]
          deployment: {
            properties: {
              mode: 'incremental'
              template: {
                '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
                contentVersion: '1.0.0.0'
                parameters: {
                  resourceName: {
                    type: 'string'
                  }
                  resourceType: {
                    type: 'string'
                  }
                  requiredTags: {
                    type: 'array'
                  }
                }
                resources: [
                  {
                    type: 'Microsoft.Resources/tags'
                    name: 'default'
                    apiVersion: '2021-04-01'
                    properties: {
                      tags: {
                        Environment: '[if(empty(reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Environment), \'NotSpecified\', reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Environment)]'
                        Owner: '[if(empty(reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Owner), \'NotSpecified\', reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Owner)]'
                        Project: '[if(empty(reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Project), \'NotSpecified\', reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.Project)]'
                        CostCenter: '[if(empty(reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.CostCenter), \'NotSpecified\', reference(resourceId(parameters(\'resourceType\'), parameters(\'resourceName\')), \'2021-04-01\', \'Full\').tags.CostCenter)]'
                      }
                    }
                  }
                ]
              }
              parameters: {
                resourceName: {
                  value: '[field(\'name\')]'
                }
                resourceType: {
                  value: '[field(\'type\')]'
                }
                requiredTags: {
                  value: '[parameters(\'requiredTags\')]'
                }
              }
            }
          }
        }
      }
    }
  }
}

// Enterprise Blueprint Definition
resource enterpriseBlueprint 'Microsoft.Blueprint/blueprints@2018-11-01-preview' = {
  name: 'enterprise-landing-zone-blueprint'
  properties: {
    displayName: 'Enterprise Landing Zone Blueprint'
    description: 'Comprehensive landing zone blueprint for enterprise workloads'
    targetScope: 'subscription'
    parameters: {
      environment: {
        type: 'string'
        allowedValues: [
          'production'
          'development'
          'testing'
          'staging'
        ]
        metadata: {
          displayName: 'Environment'
          description: 'The environment for this landing zone'
        }
      }
      workloadName: {
        type: 'string'
        maxLength: 10
        metadata: {
          displayName: 'Workload Name'
          description: 'Short name for the workload'
        }
      }
      deploymentRegion: {
        type: 'string'
        allowedValues: [
          'eastus2'
          'westus2'
          'centralus'
          'eastus'
          'westeurope'
          'northeurope'
        ]
        metadata: {
          displayName: 'Deployment Region'
          description: 'Primary Azure region for deployment'
        }
      }
    }
    resourceGroups: {
      networkingRG: {
        displayName: 'Networking Resource Group'
        description: 'Resource group for networking components'
        location: '[parameters(\'deploymentRegion\')]'
        tags: {
          Purpose: 'Networking'
          Environment: '[parameters(\'environment\')]'
        }
      }
      securityRG: {
        displayName: 'Security Resource Group'
        description: 'Resource group for security components'
        location: '[parameters(\'deploymentRegion\')]'
        tags: {
          Purpose: 'Security'
          Environment: '[parameters(\'environment\')]'
        }
      }
      monitoringRG: {
        displayName: 'Monitoring Resource Group'
        description: 'Resource group for monitoring components'
        location: '[parameters(\'deploymentRegion\')]'
        tags: {
          Purpose: 'Monitoring'
          Environment: '[parameters(\'environment\')]'
        }
      }
      workloadRG: {
        displayName: 'Workload Resource Group'
        description: 'Resource group for workload components'
        location: '[parameters(\'deploymentRegion\')]'
        tags: {
          Purpose: 'Workload'
          Environment: '[parameters(\'environment\')]'
          WorkloadName: '[parameters(\'workloadName\')]'
        }
      }
    }
  }
}

// Blueprint Artifacts
resource networkingArtifact 'Microsoft.Blueprint/blueprints/artifacts@2018-11-01-preview' = {
  parent: enterpriseBlueprint
  name: 'networking-foundation'
  kind: 'template'
  properties: {
    displayName: 'Networking Foundation'
    description: 'Deploy enterprise networking foundation'
    resourceGroup: 'networkingRG'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        vnetAddressPrefix: {
          type: 'string'
          defaultValue: '10.0.0.0/16'
        }
      }
      resources: [
        {
          type: 'Microsoft.Network/virtualNetworks'
          apiVersion: '2023-05-01'
          name: '[concat(\'vnet-\', parameters(\'workloadName\'), \'-\', parameters(\'environment\'))]'
          location: '[parameters(\'deploymentRegion\')]'
          properties: {
            addressSpace: {
              addressPrefixes: [
                '[parameters(\'vnetAddressPrefix\')]'
              ]
            }
            subnets: [
              {
                name: 'subnet-web'
                properties: {
                  addressPrefix: '10.0.1.0/24'
                  networkSecurityGroup: {
                    id: '[resourceId(\'Microsoft.Network/networkSecurityGroups\', concat(\'nsg-web-\', parameters(\'workloadName\'), \'-\', parameters(\'environment\')))]'
                  }
                }
              }
              {
                name: 'subnet-app'
                properties: {
                  addressPrefix: '10.0.2.0/24'
                  networkSecurityGroup: {
                    id: '[resourceId(\'Microsoft.Network/networkSecurityGroups\', concat(\'nsg-app-\', parameters(\'workloadName\'), \'-\', parameters(\'environment\')))]'
                  }
                }
              }
              {
                name: 'subnet-data'
                properties: {
                  addressPrefix: '10.0.3.0/24'
                  networkSecurityGroup: {
                    id: '[resourceId(\'Microsoft.Network/networkSecurityGroups\', concat(\'nsg-data-\', parameters(\'workloadName\'), \'-\', parameters(\'environment\')))]'
                  }
                }
              }
            ]
          }
        }
      ]
    }
  }
}

output managementGroupIds array = [for mg in managementGroupHierarchy: {
  id: mg.id
  displayName: mg.displayName
}]

output blueprintDefinitionId string = enterpriseBlueprint.id
output policyDefinitionId string = enterpriseSecurityPolicy.id