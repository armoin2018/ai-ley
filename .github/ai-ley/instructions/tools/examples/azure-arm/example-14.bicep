// main.bicep
@description('Environment name')
@allowed(['dev', 'staging', 'prod'])
param environment string = 'dev'

@description('Location for all resources')
param location string = resourceGroup().location

@description('Virtual machine size')
@allowed(['Standard_B1s', 'Standard_B2s', 'Standard_D2s_v3'])
param vmSize string = 'Standard_B2s'

@secure()
@description('Admin password for virtual machine')
param adminPassword string

var namingPrefix = '${environment}-webapp'
var vnetName = '${namingPrefix}-vnet'
var subnetName = '${namingPrefix}-subnet'
var vmName = '${namingPrefix}-vm'

// Network Security Group
resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: '${namingPrefix}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHTTP'
        properties: {
          priority: 100
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '80'
        }
      }
      {
        name: 'AllowHTTPS'
        properties: {
          priority: 110
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '443'
        }
      }
    ]
  }
  tags: {
    Environment: environment
    Purpose: 'Network Security'
  }
}

// Virtual Network
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
  }
  tags: {
    Environment: environment
    Purpose: 'Network Infrastructure'
  }
}

// Output values
output vnetId string = virtualNetwork.id
output subnetId string = virtualNetwork.properties.subnets[0].id

// Deploy Bicep template
// az deployment group create --resource-group myRG --template-file main.bicep --parameters environment=dev adminPassword=SecurePass123!