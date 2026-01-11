// bicep-registry-modules.bicep - Enterprise Bicep Module Registry
targetScope = 'subscription'

@description('Container registry for Bicep modules')
param moduleRegistryName string = 'acrenterprisemodules'

@description('Resource group for module registry')
param moduleRegistryRG string = 'rg-bicep-modules'

@description('Location for resources')
param location string = deployment().location

// Resource group for module registry
resource moduleRegistryResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: moduleRegistryRG
  location: location
  tags: {
    Purpose: 'BicepModules'
    Environment: 'Shared'
    ManagedBy: 'InfrastructureTeam'
  }
}

// Container Registry for Bicep modules
module moduleRegistry '../modules/container-registry.bicep' = {
  name: 'bicep-module-registry'
  scope: moduleRegistryResourceGroup
  params: {
    registryName: moduleRegistryName
    location: location
    sku: 'Premium'
    adminUserEnabled: false
    anonymousPullEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    publicNetworkAccess: 'Enabled'
    zoneRedundancy: 'Enabled'
    retentionDays: 30
    trustPolicy: {
      status: 'enabled'
      type: 'Notary'
    }
    quarantinePolicy: {
      status: 'enabled'
    }
    tags: {
      Purpose: 'BicepModuleRegistry'
      Environment: 'Shared'
    }
  }
}

// Template Specs for reusable templates
resource networkingTemplateSpec 'Microsoft.Resources/templateSpecs@2022-02-01' = {
  name: 'enterprise-networking-template'
  location: location
  properties: {
    displayName: 'Enterprise Networking Template Spec'
    description: 'Standardized networking components for enterprise workloads'
    metadata: {
      version: '1.0.0'
      author: 'Enterprise Architecture Team'
      category: 'Networking'
    }
  }
  tags: {
    Purpose: 'TemplateSpec'
    Category: 'Networking'
    Version: '1.0.0'
  }
}

resource networkingTemplateSpecVersion 'Microsoft.Resources/templateSpecs/versions@2022-02-01' = {
  parent: networkingTemplateSpec
  name: '1.0.0'
  location: location
  properties: {
    description: 'Initial version of enterprise networking template'
    metadata: {
      changelog: 'Initial release with VNet, subnets, NSGs, and security configurations'
    }
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      metadata: {
        description: 'Enterprise networking foundation with security controls'
      }
      parameters: {
        vnetName: {
          type: 'string'
          metadata: {
            description: 'Name of the virtual network'
          }
        }
        addressPrefix: {
          type: 'string'
          defaultValue: '10.0.0.0/16'
          metadata: {
            description: 'Address prefix for the VNet'
          }
        }
        subnets: {
          type: 'array'
          defaultValue: [
            {
              name: 'web-tier'
              addressPrefix: '10.0.1.0/24'
              securityRules: [
                {
                  name: 'AllowHTTPS'
                  properties: {
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '443'
                    sourceAddressPrefix: 'Internet'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                  }
                }
              ]
            }
            {
              name: 'app-tier'
              addressPrefix: '10.0.2.0/24'
              securityRules: [
                {
                  name: 'AllowWebTier'
                  properties: {
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '8080'
                    sourceAddressPrefix: '10.0.1.0/24'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                  }
                }
              ]
            }
            {
              name: 'data-tier'
              addressPrefix: '10.0.3.0/24'
              securityRules: [
                {
                  name: 'AllowAppTier'
                  properties: {
                    protocol: 'Tcp'
                    sourcePortRange: '*'
                    destinationPortRange: '1433'
                    sourceAddressPrefix: '10.0.2.0/24'
                    destinationAddressPrefix: '*'
                    access: 'Allow'
                    priority: 100
                    direction: 'Inbound'
                  }
                }
              ]
            }
          ]
          metadata: {
            description: 'Array of subnet configurations'
          }
        }
      }
      resources: [
        {
          type: 'Microsoft.Network/networkSecurityGroups'
          apiVersion: '2023-05-01'
          name: '[concat(\'nsg-\', parameters(\'subnets\')[copyIndex()].name)]'
          location: '[resourceGroup().location]'
          copy: {
            name: 'nsgLoop'
            count: '[length(parameters(\'subnets\'))]'
          }
          properties: {
            securityRules: '[parameters(\'subnets\')[copyIndex()].securityRules]'
          }
          tags: {
            Tier: '[parameters(\'subnets\')[copyIndex()].name]'
          }
        }
        {
          type: 'Microsoft.Network/virtualNetworks'
          apiVersion: '2023-05-01'
          name: '[parameters(\'vnetName\')]'
          location: '[resourceGroup().location]'
          dependsOn: [
            'nsgLoop'
          ]
          properties: {
            addressSpace: {
              addressPrefixes: [
                '[parameters(\'addressPrefix\')]'
              ]
            }
            subnets: '[map(parameters(\'subnets\'), lambda(\'subnet\', createObject(\'name\', subnet.name, \'properties\', createObject(\'addressPrefix\', subnet.addressPrefix, \'networkSecurityGroup\', createObject(\'id\', resourceId(\'Microsoft.Network/networkSecurityGroups\', concat(\'nsg-\', subnet.name)))))))]'
          }
        }
      ]
      outputs: {
        vnetId: {
          type: 'string'
          value: '[resourceId(\'Microsoft.Network/virtualNetworks\', parameters(\'vnetName\'))]'
        }
        subnetIds: {
          type: 'array'
          value: '[map(parameters(\'subnets\'), lambda(\'subnet\', resourceId(\'Microsoft.Network/virtualNetworks/subnets\', parameters(\'vnetName\'), subnet.name)))]'
        }
      }
    }
  }
}

output moduleRegistryId string = moduleRegistry.outputs.registryId
output moduleRegistryLoginServer string = moduleRegistry.outputs.loginServer
output networkingTemplateSpecId string = networkingTemplateSpec.id