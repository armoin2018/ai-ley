---
title: 'Microsoft Azure Enterprise Cloud Platform Instructions'
description: 'Comprehensive guide for Microsoft Azure development, deployment, and management including App Service, Functions, AKS, and enterprise integration'
category: 'Cloud Platforms'

tags:
  [
    'azure',
    'microsoft',
    'app-service',
    'azure-functions',
    'aks',
    'kubernetes',
    'devops',
    'enterprise',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/azure-pipelines.yml'
  - '**/azuredeploy.json'
  - '**/bicep/**'
  - '**/ARM/**'
  - '**/docker-compose.yml'
  - '**/.azure/**'
---

# Microsoft Azure Enterprise Cloud Platform Instructions

## Tool Overview

- **Tool Name**: Microsoft Azure
- **Version**: Azure CLI 2.52+ (Latest stable with Bicep support)
- **Category**: Cloud Platforms - Enterprise Integration
- **Purpose**: Comprehensive cloud computing platform for enterprise applications, hybrid cloud, and Microsoft ecosystem integration
- **Prerequisites**: Microsoft account, Azure subscription, Azure CLI installed, PowerShell/Bash for scripting

## When to Use Azure

### ✅ **Use Azure When**

- Building enterprise applications requiring Microsoft ecosystem integration
- Working with .NET, C#, and Microsoft development stack
- Need hybrid cloud capabilities with on-premises Active Directory
- Building applications requiring enterprise security and compliance
- Working with Office 365, Microsoft 365, and Dynamics integration
- Need advanced AI and machine learning services (Cognitive Services)
- Building Windows-based applications and legacy system modernization
- Working in enterprises with existing Microsoft licensing agreements

### ❌ **Avoid Azure When**

- Building simple static websites or basic web applications
- Working primarily with open-source technologies without Microsoft integration
- Team lacks experience with Microsoft technologies and Azure ecosystem
- Budget constraints for enterprise-level cloud services
- Building applications targeting primarily Linux/Unix environments
- Need simple deployment without complex enterprise requirements
- Working with applications not requiring Microsoft-specific features

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type               | Azure Recommendation                     | Configuration Priority         |
| -------------------------- | ---------------------------------------- | ------------------------------ |
| Enterprise .NET App        | ✅ **Essential** - Native integration    | High - App Service + SQL       |
| Microservices Architecture | ✅ **Essential** - AKS + Service Fabric  | High - Container orchestration |
| Hybrid Cloud Application   | ✅ **Essential** - Arc + hybrid services | High - Hybrid connectivity     |
| AI/ML Application          | ✅ **Recommended** - Cognitive Services  | Medium - AI platform setup     |
| Static Website             | 🔄 **Consider** - May be overkill        | Low - Static Web Apps          |
| Legacy Modernization       | ✅ **Essential** - Migration tools       | High - Assessment + migration  |

### Complexity Assessment

| Factor            | Low Complexity             | Medium Complexity      | High Complexity             |
| ----------------- | -------------------------- | ---------------------- | --------------------------- |
| **Setup Time**    | 2 hours (App Service)      | 1 day (AKS cluster)    | 2 weeks (enterprise setup)  |
| **Services Used** | App Service + SQL Database | Multiple PaaS services | Full enterprise integration |
| **Architecture**  | Single service             | Multi-tier application | Enterprise hybrid cloud     |
| **Integration**   | Basic Azure services       | Office 365 integration | Full Microsoft ecosystem    |

## Installation & Setup

### Azure CLI Installation

```bash
# macOS installation
brew install azure-cli

# Linux installation (Ubuntu/Debian)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Windows installation (PowerShell)
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Verify installation
az --version
az extension list-available

# Login to Azure
az login
az account list
az account set --subscription "your-subscription-id"
```

### PowerShell and Development Tools

```powershell
# Install Azure PowerShell
Install-Module -Name Az -Repository PSGallery -Force

# Install additional tools
winget install Microsoft.Bicep
npm install -g @azure/static-web-apps-cli
dotnet tool install --global Azure.Developer.CLI

# Verify installations
az --version
bicep --version
swa --version
azd version
```

### Project Setup and Configuration

```bash
# Create resource group
az group create --name myResourceGroup --location eastus

# Set default resource group and location
az configure --defaults group=myResourceGroup location=eastus

# Enable necessary providers
az provider register --namespace Microsoft.Web
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.Sql
az provider register --namespace Microsoft.Storage
az provider register --namespace Microsoft.KeyVault

# Create service principal for automation
az ad sp create-for-rbac --name "myAppServicePrincipal" --role contributor

# Verify setup
az account show
az group list
```

## Configuration

### Azure App Service Configuration

```json
// azuredeploy.json - ARM Template for App Service
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "appName": {
      "type": "string",
      "metadata": {
        "description": "Name of the web app"
      }
    },
    "sku": {
      "type": "string",
      "defaultValue": "S1",
      "allowedValues": ["F1", "B1", "S1", "P1V2", "P2V2", "P3V2"],
      "metadata": {
        "description": "App Service Plan SKU"
      }
    },
    "location": {
      "type": "string",
      "defaultValue": "[resourceGroup().location]",
      "metadata": {
        "description": "Location for all resources"
      }
    }
  },
  "variables": {
    "appServicePlanName": "[concat(parameters('appName'), '-plan')]",
    "appInsightsName": "[concat(parameters('appName'), '-insights')]"
  },
  "resources": [
    {
      "type": "Microsoft.Web/serverfarms",
      "apiVersion": "2021-02-01",
      "name": "[variables('appServicePlanName')]",
      "location": "[parameters('location')]",
      "sku": {
        "name": "[parameters('sku')]"
      },
      "properties": {
        "reserved": false
      }
    },
    {
      "type": "Microsoft.Web/sites",
      "apiVersion": "2021-02-01",
      "name": "[parameters('appName')]",
      "location": "[parameters('location')]",
      "dependsOn": ["[resourceId('Microsoft.Web/serverfarms', variables('appServicePlanName'))]"],
      "properties": {
        "serverFarmId": "[resourceId('Microsoft.Web/serverfarms', variables('appServicePlanName'))]",
        "httpsOnly": true,
        "siteConfig": {
          "minTlsVersion": "1.2",
          "ftpsState": "FtpsOnly",
          "appSettings": [
            {
              "name": "WEBSITE_NODE_DEFAULT_VERSION",
              "value": "18-lts"
            },
            {
              "name": "APPINSIGHTS_INSTRUMENTATIONKEY",
              "value": "[reference(resourceId('Microsoft.Insights/components', variables('appInsightsName'))).InstrumentationKey]"
            }
          ]
        }
      }
    },
    {
      "type": "Microsoft.Insights/components",
      "apiVersion": "2020-02-02",
      "name": "[variables('appInsightsName')]",
      "location": "[parameters('location')]",
      "kind": "web",
      "properties": {
        "Application_Type": "web",
        "Request_Source": "rest"
      }
    }
  ],
  "outputs": {
    "webAppUrl": {
      "type": "string",
      "value": "[concat('https://', reference(resourceId('Microsoft.Web/sites', parameters('appName'))).defaultHostName)]"
    }
  }
}
```

### Bicep Infrastructure Configuration

```bicep
// main.bicep - Modern Azure infrastructure
@description('Name of the application')
param appName string

@description('Location for all resources')
param location string = resourceGroup().location

@description('App Service Plan SKU')
@allowed(['B1', 'S1', 'P1V2', 'P2V2', 'P3V2'])
param sku string = 'S1'

@description('SQL Database administrator login')
param sqlAdministratorLogin string

@description('SQL Database administrator password')
@secure()
param sqlAdministratorPassword string

// Variables
var appServicePlanName = '${appName}-plan'
var webAppName = '${appName}-web'
var sqlServerName = '${appName}-sql-server'
var sqlDatabaseName = '${appName}-database'
var keyVaultName = '${appName}-kv'
var storageAccountName = '${replace(appName, '-', '')}storage'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  properties: {
    reserved: false
  }
}

// Web App
resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
      netFrameworkVersion: 'v6.0'
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultConnection'
          connectionString: 'Server=tcp:${sqlServer.properties.fullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${sqlAdministratorLogin};Password=${sqlAdministratorPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
          type: 'SQLAzure'
        }
      ]
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdministratorLogin
    administratorLoginPassword: sqlAdministratorPassword
    version: '12.0'
  }
}

// SQL Database
resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-11-01' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: {
    name: 'S0'
    tier: 'Standard'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 268435456000
  }
}

// Firewall rule to allow Azure services
resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-11-01' = {
  parent: sqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// Application Insights
resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${appName}-insights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: webApp.identity.principalId
        permissions: {
          secrets: ['get', 'list']
        }
      }
    ]
    enableRbacAuthorization: false
  }
}

// Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

// Outputs
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output sqlServerFqdn string = sqlServer.properties.fullyQualifiedDomainName
output keyVaultName string = keyVault.name
output storageAccountName string = storageAccount.name
```

### Azure DevOps Pipeline Configuration

```yaml
# azure-pipelines.yml - Complete CI/CD pipeline
trigger:
  branches:
    include:
      - main
      - develop
  paths:
    exclude:
      - README.md
      - docs/*

variables:
  azureSubscription: 'my-azure-subscription'
  resourceGroupName: 'my-app-rg'
  webAppName: 'my-web-app'
  vmImageName: 'ubuntu-latest'
  buildConfiguration: 'Release'

stages:
  - stage: Build
    displayName: 'Build and Test'
    jobs:
      - job: Build
        displayName: 'Build job'
        pool:
          vmImage: $(vmImageName)

        steps:
          - task: UseDotNet@2
            displayName: 'Use .NET 6 SDK'
            inputs:
              packageType: 'sdk'
              version: '6.x'

          - task: DotNetCoreCLI@2
            displayName: 'Restore packages'
            inputs:
              command: 'restore'
              projects: '**/*.csproj'

          - task: DotNetCoreCLI@2
            displayName: 'Build application'
            inputs:
              command: 'build'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-restore'

          - task: DotNetCoreCLI@2
            displayName: 'Run unit tests'
            inputs:
              command: 'test'
              projects: '**/*Tests/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-build --collect:"XPlat Code Coverage" --logger trx'
              publishTestResults: true

          - task: PublishCodeCoverageResults@1
            displayName: 'Publish code coverage'
            inputs:
              codeCoverageTool: 'Cobertura'
              summaryFileLocation: '$(Agent.TempDirectory)/**/coverage.cobertura.xml'

          - task: DotNetCoreCLI@2
            displayName: 'Publish application'
            inputs:
              command: 'publish'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory) --no-build'
              zipAfterPublish: true

          - task: PublishBuildArtifacts@1
            displayName: 'Publish artifacts'
            inputs:
              PathtoPublish: '$(Build.ArtifactStagingDirectory)'
              ArtifactName: 'drop'
              publishLocation: 'Container'

  - stage: Deploy_Staging
    displayName: 'Deploy to Staging'
    dependsOn: Build
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
    jobs:
      - deployment: Deploy
        displayName: 'Deploy to staging'
        pool:
          vmImage: $(vmImageName)
        environment: 'staging'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureWebApp@1
                  displayName: 'Deploy to Azure App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    appType: 'webApp'
                    appName: '$(webAppName)-staging'
                    package: '$(Pipeline.Workspace)/drop/*.zip'
                    deploymentMethod: 'auto'

  - stage: Deploy_Production
    displayName: 'Deploy to Production'
    dependsOn: Build
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: Deploy
        displayName: 'Deploy to production'
        pool:
          vmImage: $(vmImageName)
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy ARM template'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: $(azureSubscription)
                    subscriptionId: $(subscriptionId)
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: $(resourceGroupName)
                    location: 'East US'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/azuredeploy.json'
                    overrideParameters: '-appName $(webAppName) -sku P1V2'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy to Azure App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    appType: 'webApp'
                    appName: $(webAppName)
                    package: '$(Pipeline.Workspace)/drop/*.zip'
                    deploymentMethod: 'auto'

                - task: AzureAppServiceManage@0
                  displayName: 'Restart App Service'
                  inputs:
                    azureSubscription: $(azureSubscription)
                    Action: 'Restart Azure App Service'
                    WebAppName: $(webAppName)
```

### Azure Kubernetes Service (AKS) Configuration

```yaml
# aks-deployment.yaml - AKS application deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: default
  labels:
    app: my-app
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        version: v1
    spec:
      serviceAccountName: my-app-service-account
      containers:
        - name: my-app
          image: myregistry.azurecr.io/my-app:latest
          ports:
            - containerPort: 80
              name: http
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: 'Production'
            - name: ConnectionStrings__DefaultConnection
              valueFrom:
                secretKeyRef:
                  name: sql-connection
                  key: connectionString
          resources:
            requests:
              memory: '256Mi'
              cpu: '250m'
            limits:
              memory: '512Mi'
              cpu: '500m'
          livenessProbe:
            httpGet:
              path: /health
              port: 80
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /health/ready
              port: 80
            initialDelaySeconds: 5
            periodSeconds: 5
      imagePullSecrets:
        - name: acr-secret

---
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
  labels:
    app: my-app
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
      name: http

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/ssl-redirect: 'true'
    cert-manager.io/cluster-issuer: 'letsencrypt-prod'
spec:
  tls:
    - hosts:
        - myapp.example.com
      secretName: my-app-tls
  rules:
    - host: myapp.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: my-app-service
                port:
                  number: 80
```

## Core Features

### Azure App Service

- **Purpose**: Fully managed platform for building, deploying, and scaling web apps
- **Usage**: Host web applications, APIs, and mobile backends
- **Example**:

```csharp
// Program.cs - ASP.NET Core application
using Microsoft.ApplicationInsights;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Add Application Insights
builder.Services.AddApplicationInsightsTelemetry(
    builder.Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"]);

// Add Entity Framework
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Add health checks
builder.Services.AddHealthChecks()
    .AddDbContextCheck<ApplicationDbContext>();

var app = builder.Build();

// Configure pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
else
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

// Health check endpoints
app.MapHealthChecks("/health");
app.MapHealthChecks("/health/ready", new HealthCheckOptions
{
    Predicate = check => check.Tags.Contains("ready")
});

app.MapControllers();

app.Run();
```

```bash
# Deploy to App Service
az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name myUniqueAppName
az webapp deployment source config --name myUniqueAppName --resource-group myResourceGroup --repo-url https://github.com/user/repo --branch main
```

### Azure Functions (Serverless)

- **Purpose**: Event-driven serverless compute platform
- **Usage**: Process events, integrate systems, build APIs
- **Example**:

```csharp
// HttpTriggerFunction.cs
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;
using System.Net;
using System.Text.Json;

public class HttpTriggerFunction
{
    private readonly ILogger _logger;

    public HttpTriggerFunction(ILoggerFactory loggerFactory)
    {
        _logger = loggerFactory.CreateLogger<HttpTriggerFunction>();
    }

    [Function("ProcessOrder")]
    public async Task<HttpResponseData> ProcessOrder(
        [HttpTrigger(AuthorizationLevel.Function, "post")] HttpRequestData req)
    {
        _logger.LogInformation("Processing order request");

        try
        {
            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var order = JsonSerializer.Deserialize<Order>(requestBody);

            // Validate order
            if (order == null || string.IsNullOrEmpty(order.CustomerId))
            {
                var badResponse = req.CreateResponse(HttpStatusCode.BadRequest);
                await badResponse.WriteStringAsync("Invalid order data");
                return badResponse;
            }

            // Process order (business logic)
            var processedOrder = await ProcessOrderAsync(order);

            // Return success response
            var response = req.CreateResponse(HttpStatusCode.OK);
            response.Headers.Add("Content-Type", "application/json");
            await response.WriteStringAsync(JsonSerializer.Serialize(processedOrder));
            return response;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing order");
            var errorResponse = req.CreateResponse(HttpStatusCode.InternalServerError);
            await errorResponse.WriteStringAsync("Internal server error");
            return errorResponse;
        }
    }

    private async Task<ProcessedOrder> ProcessOrderAsync(Order order)
    {
        // Simulate order processing
        await Task.Delay(100);

        return new ProcessedOrder
        {
            OrderId = Guid.NewGuid().ToString(),
            CustomerId = order.CustomerId,
            Status = "Processed",
            ProcessedAt = DateTime.UtcNow
        };
    }
}

public class Order
{
    public string CustomerId { get; set; }
    public List<OrderItem> Items { get; set; }
    public decimal Total { get; set; }
}

public class OrderItem
{
    public string ProductId { get; set; }
    public int Quantity { get; set; }
    public decimal Price { get; set; }
}

public class ProcessedOrder
{
    public string OrderId { get; set; }
    public string CustomerId { get; set; }
    public string Status { get; set; }
    public DateTime ProcessedAt { get; set; }
}
```

```bash
# Deploy Azure Function
func azure functionapp publish myFunctionApp
```

### Azure Container Instances (ACI)

- **Purpose**: Run containers without managing servers
- **Usage**: Batch processing, microservices, CI/CD agents
- **Example**:

```yaml
# container-group.yaml
apiVersion: 2021-03-01
location: eastus
name: my-container-group
properties:
  containers:
    - name: my-app
      properties:
        image: myregistry.azurecr.io/my-app:latest
        resources:
          requests:
            cpu: 1
            memoryInGb: 1.5
        ports:
          - port: 80
            protocol: TCP
        environmentVariables:
          - name: ASPNETCORE_ENVIRONMENT
            value: Production
          - name: ConnectionString
            secureValue: 'Server=tcp:myserver.database.windows.net,1433;Database=mydb;'
  osType: Linux
  restartPolicy: Always
  ipAddress:
    type: Public
    ports:
      - protocol: TCP
        port: 80
    dnsNameLabel: my-unique-app
  imageRegistryCredentials:
    - server: myregistry.azurecr.io
      username: myregistry
      password: 'registry-password'
tags:
  environment: production
  team: development
```

```bash
# Deploy container group
az container create --resource-group myResourceGroup --file container-group.yaml
```

### Azure Service Bus

- **Purpose**: Enterprise messaging service for reliable communication
- **Usage**: Decouple applications, implement messaging patterns
- **Example**:

```csharp
// ServiceBusService.cs
using Azure.Messaging.ServiceBus;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Text.Json;

public class ServiceBusService
{
    private readonly ServiceBusClient _client;
    private readonly ILogger<ServiceBusService> _logger;
    private readonly string _queueName;

    public ServiceBusService(IConfiguration configuration, ILogger<ServiceBusService> logger)
    {
        var connectionString = configuration.GetConnectionString("ServiceBus");
        _client = new ServiceBusClient(connectionString);
        _queueName = configuration["ServiceBus:QueueName"];
        _logger = logger;
    }

    public async Task SendMessageAsync<T>(T message)
    {
        try
        {
            ServiceBusSender sender = _client.CreateSender(_queueName);

            var messageBody = JsonSerializer.Serialize(message);
            var serviceBusMessage = new ServiceBusMessage(messageBody)
            {
                ContentType = "application/json",
                MessageId = Guid.NewGuid().ToString(),
                TimeToLive = TimeSpan.FromMinutes(30)
            };

            await sender.SendMessageAsync(serviceBusMessage);
            _logger.LogInformation($"Sent message with ID: {serviceBusMessage.MessageId}");
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error sending message to Service Bus");
            throw;
        }
    }

    public async Task ProcessMessagesAsync(Func<string, Task> messageHandler)
    {
        ServiceBusProcessor processor = _client.CreateProcessor(_queueName, new ServiceBusProcessorOptions
        {
            MaxConcurrentCalls = 2,
            AutoCompleteMessages = false
        });

        processor.ProcessMessageAsync += async args =>
        {
            try
            {
                string body = args.Message.Body.ToString();
                _logger.LogInformation($"Processing message: {args.Message.MessageId}");

                await messageHandler(body);
                await args.CompleteMessageAsync(args.Message);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Error processing message: {args.Message.MessageId}");
                await args.AbandonMessageAsync(args.Message);
            }
        };

        processor.ProcessErrorAsync += args =>
        {
            _logger.LogError(args.Exception, "Error in Service Bus processor");
            return Task.CompletedTask;
        };

        await processor.StartProcessingAsync();
    }
}
```

## Common Commands

```bash
# Essential Azure CLI commands
az login                              # Login to Azure
az account list                       # List subscriptions
az account set --subscription "name"  # Set active subscription
az group list                         # List resource groups

# Resource management
az group create --name myRG --location eastus     # Create resource group
az resource list --resource-group myRG            # List resources in group
az group delete --name myRG --yes                 # Delete resource group

# App Service
az webapp list                        # List web apps
az webapp create --name myApp --resource-group myRG --plan myPlan
az webapp deploy --resource-group myRG --name myApp --src-path app.zip
az webapp log tail --name myApp --resource-group myRG

# Container Registry
az acr create --resource-group myRG --name myRegistry --sku Basic
az acr login --name myRegistry
az acr build --registry myRegistry --image myapp:v1 .
az acr repository list --name myRegistry

# AKS (Azure Kubernetes Service)
az aks create --resource-group myRG --name myAKSCluster --node-count 3
az aks get-credentials --resource-group myRG --name myAKSCluster
kubectl get nodes
kubectl apply -f k8s-manifests/

# Azure Functions
func init MyFunctionApp --dotnet
func new --name HttpTrigger --template "HTTP trigger"
func start                            # Run locally
func azure functionapp publish MyFunctionApp

# SQL Database
az sql server create --name myServer --resource-group myRG --admin-user myAdmin
az sql db create --resource-group myRG --server myServer --name myDatabase
az sql server firewall-rule create --resource-group myRG --server myServer

# Storage Account
az storage account create --name mystorageaccount --resource-group myRG
az storage container create --name mycontainer --account-name mystorageaccount
az storage blob upload --file myfile.txt --container-name mycontainer

# Key Vault
az keyvault create --name myKeyVault --resource-group myRG
az keyvault secret set --vault-name myKeyVault --name mysecret --value myvalue
az keyvault secret show --vault-name myKeyVault --name mysecret

# Monitoring and diagnostics
az monitor activity-log list --resource-group myRG
az monitor log-analytics workspace create --resource-group myRG --workspace-name myWorkspace
az monitor diagnostic-settings create --resource myResourceId --name myDiagnostic
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use Azure CLI and local emulators for development
2. **Source Control**: Integrate with Azure DevOps or GitHub
3. **CI/CD Pipeline**: Use Azure DevOps Pipelines for automated deployment
4. **Environment Management**: Separate development, staging, and production
5. **Monitoring**: Use Application Insights and Azure Monitor
6. **Security**: Implement Azure Active Directory and Key Vault

### Complete DevOps Pipeline

```yaml
# azure-devops-complete.yml
name: $(Date:yyyyMMdd)$(Rev:.r)

trigger:
  branches:
    include:
      - main
      - develop
      - feature/*

variables:
  - group: 'production-variables'
  - name: buildConfiguration
    value: 'Release'
  - name: azureSubscription
    value: 'my-service-connection'

stages:
  - stage: 'Build'
    displayName: 'Build Application'
    jobs:
      - job: 'BuildJob'
        displayName: 'Build and Test'
        pool:
          vmImage: 'ubuntu-latest'

        steps:
          # Setup
          - task: UseDotNet@2
            displayName: 'Use .NET 6 SDK'
            inputs:
              packageType: 'sdk'
              version: '6.x'

          # Restore and build
          - task: DotNetCoreCLI@2
            displayName: 'Restore NuGet packages'
            inputs:
              command: 'restore'
              projects: '**/*.csproj'

          - task: DotNetCoreCLI@2
            displayName: 'Build solution'
            inputs:
              command: 'build'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --no-restore'

          # Security scanning
          - task: CredScan@3
            displayName: 'Run Credential Scanner'

          - task: SonarCloudPrepare@1
            displayName: 'Prepare SonarCloud'
            inputs:
              SonarCloud: 'SonarCloud'
              organization: 'my-org'
              scannerMode: 'MSBuild'
              projectKey: 'my-project'

          # Tests
          - task: DotNetCoreCLI@2
            displayName: 'Run unit tests'
            inputs:
              command: 'test'
              projects: '**/*Tests.csproj'
              arguments: '--configuration $(buildConfiguration) --no-build --collect:"XPlat Code Coverage" --logger trx'
              publishTestResults: true

          - task: PublishCodeCoverageResults@1
            displayName: 'Publish code coverage'
            inputs:
              codeCoverageTool: 'Cobertura'
              summaryFileLocation: '$(Agent.TempDirectory)/**/coverage.cobertura.xml'

          # SonarCloud analysis
          - task: SonarCloudAnalyze@1
            displayName: 'Run SonarCloud analysis'

          - task: SonarCloudPublish@1
            displayName: 'Publish SonarCloud results'

          # Publish artifacts
          - task: DotNetCoreCLI@2
            displayName: 'Publish application'
            inputs:
              command: 'publish'
              projects: '**/*.csproj'
              arguments: '--configuration $(buildConfiguration) --output $(Build.ArtifactStagingDirectory) --no-build'
              zipAfterPublish: true

          - task: PublishBuildArtifacts@1
            displayName: 'Publish build artifacts'
            inputs:
              PathtoPublish: '$(Build.ArtifactStagingDirectory)'
              ArtifactName: 'drop'

  - stage: 'Deploy_Development'
    displayName: 'Deploy to Development'
    dependsOn: 'Build'
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/develop'))
    jobs:
      - deployment: 'DeployDev'
        displayName: 'Deploy to Development Environment'
        pool:
          vmImage: 'ubuntu-latest'
        environment: 'development'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy infrastructure'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: '$(azureSubscription)'
                    subscriptionId: '$(subscriptionId)'
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: '$(resourceGroupName)-dev'
                    location: '$(location)'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/infrastructure/main.bicep'
                    overrideParameters: '-environment dev -appName $(appName)'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy web application'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    appType: 'webApp'
                    appName: '$(appName)-dev'
                    package: '$(Pipeline.Workspace)/drop/*.zip'

  - stage: 'Deploy_Production'
    displayName: 'Deploy to Production'
    dependsOn: 'Build'
    condition: and(succeeded(), eq(variables['Build.SourceBranch'], 'refs/heads/main'))
    jobs:
      - deployment: 'DeployProd'
        displayName: 'Deploy to Production Environment'
        pool:
          vmImage: 'ubuntu-latest'
        environment: 'production'
        strategy:
          runOnce:
            deploy:
              steps:
                - task: AzureResourceManagerTemplateDeployment@3
                  displayName: 'Deploy infrastructure'
                  inputs:
                    deploymentScope: 'Resource Group'
                    azureResourceManagerConnection: '$(azureSubscription)'
                    subscriptionId: '$(subscriptionId)'
                    action: 'Create Or Update Resource Group'
                    resourceGroupName: '$(resourceGroupName)'
                    location: '$(location)'
                    templateLocation: 'Linked artifact'
                    csmFile: '$(Pipeline.Workspace)/drop/infrastructure/main.bicep'
                    overrideParameters: '-environment prod -appName $(appName)'
                    deploymentMode: 'Incremental'

                - task: AzureWebApp@1
                  displayName: 'Deploy web application'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    appType: 'webApp'
                    appName: '$(appName)'
                    package: '$(Pipeline.Workspace)/drop/*.zip'

                - task: AzureAppServiceManage@0
                  displayName: 'Restart App Service'
                  inputs:
                    azureSubscription: '$(azureSubscription)'
                    Action: 'Restart Azure App Service'
                    WebAppName: '$(appName)'
```

## Best Practices

### ✅ **Infrastructure Best Practices**

- **Use Infrastructure as Code** - Manage resources with ARM templates or Bicep
- **Implement resource tagging** - Tag all resources for cost management and organization
- **Use managed identities** - Authenticate services without storing credentials
- **Implement least privilege access** - Use Azure RBAC for fine-grained permissions
- **Use Azure Policy** - Enforce organizational standards and compliance
- **Monitor costs** - Set up cost alerts and budgets

### ✅ **Security Best Practices**

- **Enable Azure Security Center** - Monitor security posture and recommendations
- **Use Azure Key Vault** - Store secrets, keys, and certificates securely
- **Implement network security** - Use NSGs, firewalls, and private endpoints
- **Enable audit logging** - Track all operations with Azure Activity Log
- **Use Azure AD integration** - Centralize identity and access management
- **Regular security assessments** - Perform vulnerability scans and penetration testing

### ✅ **Performance Optimization**

- **Use Azure CDN** - Improve global performance with content delivery network
- **Implement caching** - Use Azure Cache for Redis for better performance
- **Optimize database performance** - Use SQL Database performance recommendations
- **Monitor application performance** - Use Application Insights for APM
- **Use auto-scaling** - Implement horizontal and vertical scaling
- **Optimize storage** - Choose appropriate storage tiers and access patterns

### ❌ **Common Pitfalls to Avoid**

- **Don't hardcode secrets** - Use Key Vault and managed identities
- **Avoid single region deployment** - Plan for disaster recovery across regions
- **Don't ignore cost optimization** - Regularly review and optimize resource usage
- **Avoid manual deployments** - Use automation and infrastructure as code
- **Don't skip monitoring** - Implement comprehensive logging and alerting
- **Avoid vendor lock-in** - Design with portability in mind

## Advanced Azure Usage

### Azure Arc for Hybrid Cloud

```yaml
# arc-configuration.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: azure-arc-config
  namespace: azure-arc
data:
  AZURE_TENANT_ID: 'your-tenant-id'
  AZURE_SUBSCRIPTION_ID: 'your-subscription-id'
  AZURE_RESOURCE_GROUP: 'arc-enabled-servers'
  AZURE_LOCATION: 'eastus'

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: arc-enabled-app
  namespace: azure-arc
spec:
  replicas: 2
  selector:
    matchLabels:
      app: arc-app
  template:
    metadata:
      labels:
        app: arc-app
    spec:
      containers:
        - name: app
          image: myapp:latest
          env:
            - name: AZURE_CLIENT_ID
              valueFrom:
                secretKeyRef:
                  name: azure-credentials
                  key: client-id
            - name: AZURE_CLIENT_SECRET
              valueFrom:
                secretKeyRef:
                  name: azure-credentials
                  key: client-secret
```

### Azure Logic Apps for Integration

```json
{
  "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "triggers": {
    "When_a_blob_is_added_or_modified": {
      "recurrence": {
        "frequency": "Minute",
        "interval": 5
      },
      "type": "ApiConnection",
      "inputs": {
        "host": {
          "connection": {
            "name": "@parameters('$connections')['azureblob']['connectionId']"
          }
        },
        "method": "get",
        "path": "/datasets/default/triggers/batch/onupdatedfile",
        "queries": {
          "folderId": "uploads",
          "maxFileCount": 10
        }
      }
    }
  },
  "actions": {
    "Process_File": {
      "type": "Http",
      "inputs": {
        "method": "POST",
        "uri": "https://myapp.azurewebsites.net/api/process",
        "headers": {
          "Content-Type": "application/json"
        },
        "body": {
          "fileName": "@triggerBody()?['Name']",
          "filePath": "@triggerBody()?['Path']",
          "fileSize": "@triggerBody()?['Size']"
        }
      },
      "runAfter": {}
    },
    "Send_Notification": {
      "type": "ApiConnection",
      "inputs": {
        "host": {
          "connection": {
            "name": "@parameters('$connections')['teams']['connectionId']"
          }
        },
        "method": "post",
        "path": "/flowbot/actions/notification/recipienttypes/channel",
        "body": {
          "messageBody": "File @{triggerBody()?['Name']} has been processed successfully.",
          "recipient": {
            "channelId": "your-channel-id"
          }
        }
      },
      "runAfter": {
        "Process_File": ["Succeeded"]
      }
    }
  }
}
```

## Integration with Other Tools

### GitHub Actions Integration

```yaml
# .github/workflows/azure-deploy.yml
name: Deploy to Azure

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: 6.0.x

      - name: Restore dependencies
        run: dotnet restore

      - name: Build
        run: dotnet build --no-restore

      - name: Test
        run: dotnet test --no-build --verbosity normal

      - name: Publish
        run: dotnet publish -c Release -o ./publish

      - name: Login to Azure
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Deploy to Azure Web App
        uses: azure/webapps-deploy@v2
        with:
          app-name: 'my-web-app'
          package: './publish'

      - name: Azure CLI script
        uses: azure/CLI@v1
        with:
          azcliversion: 2.30.0
          inlineScript: |
            az webapp restart --name my-web-app --resource-group my-resource-group
```

### Terraform Integration

```hcl
# main.tf - Azure infrastructure with Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "terraformstatestorage"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_name}-plan"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

# Web App
resource "azurerm_linux_web_app" "main" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_service_plan.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = true
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.main.connection_string
  }

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.main.name};Persist Security Info=False;User ID=${var.sql_admin_username};Password=${var.sql_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }

  identity {
    type = "SystemAssigned"
  }
}

# Application Insights
resource "azurerm_application_insights" "main" {
  name                = "${var.app_name}-insights"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"

  tags = {
    Environment = var.environment
  }
}

# Variables
variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

# Outputs
output "web_app_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "application_insights_key" {
  value = azurerm_application_insights.main.instrumentation_key
  sensitive = true
}
```

## Troubleshooting

### Common Issues

#### Authentication and Access Issues

**Problem**: Access denied or authentication failures
**Symptoms**: 401 Unauthorized, access denied errors
**Solution**:

```bash
# Check current login status
az account show
az account list

# Re-login if needed
az login --tenant your-tenant-id
az account set --subscription "your-subscription"

# Check permissions
az role assignment list --assignee your-user-id
az ad user show --id your-user-id
```

#### Deployment Failures

**Problem**: Application deployment fails
**Symptoms**: Deployment errors, service unavailable
**Solution**:

```bash
# Check deployment logs
az webapp log tail --name myapp --resource-group myrg

# Check app service logs
az webapp log download --name myapp --resource-group myrg

# Debug with Kudu console
az webapp browse --name myapp --resource-group myrg

# Check application settings
az webapp config appsettings list --name myapp --resource-group myrg
```

#### Resource Quota Issues

**Problem**: Resource creation fails due to quota limits
**Symptoms**: Quota exceeded errors
**Solution**:

```bash
# Check current usage
az vm list-usage --location eastus
az network list-usages --location eastus

# Request quota increase through Azure portal
# Monitor resource usage
az monitor activity-log list --resource-group myrg
```

### Debug Mode

```bash
# Enable debug mode
az config set core.output=yaml
az config set core.only_show_errors=false

# Verbose logging
az webapp log config --name myapp --resource-group myrg --web-server-logging filesystem
az webapp log tail --name myapp --resource-group myrg --provider application

# Performance monitoring
az monitor app-insights component show --app myapp --resource-group myrg
```

## Security Considerations

### Security Best Practices

- **Implement Azure Active Directory** - Use AAD for centralized identity management
- **Use managed identities** - Authenticate without storing credentials in code
- **Enable Microsoft Defender for Cloud** - Monitor security posture and threats
- **Implement network security** - Use NSGs, WAF, and private endpoints
- **Use Azure Key Vault** - Securely store secrets, keys, and certificates
- **Enable audit logging** - Track all operations and access patterns

### Secure Configuration Examples

```json
{
  "security": {
    "authentication": {
      "azureActiveDirectory": {
        "enabled": true,
        "tenantId": "your-tenant-id",
        "clientId": "your-client-id",
        "issuer": "https://sts.windows.net/your-tenant-id/"
      }
    },
    "authorization": {
      "defaultPolicy": "require-authenticated-user",
      "policies": [
        {
          "name": "admin-only",
          "requirements": ["role:admin"]
        }
      ]
    },
    "networking": {
      "allowedIpRanges": ["10.0.0.0/8", "172.16.0.0/12"],
      "enablePrivateEndpoints": true,
      "tlsVersion": "1.2"
    }
  }
}
```

## AI Assistant Guidelines

When helping with Azure:

1. **Always suggest managed services** when appropriate for reduced operational overhead
2. **Provide complete infrastructure configurations** with ARM templates or Bicep
3. **Include security best practices** with AAD, managed identities, and Key Vault
4. **Suggest appropriate service combinations** based on Microsoft ecosystem integration
5. **Provide debugging strategies** for common deployment and configuration issues
6. **Include monitoring and alerting** setup with Application Insights and Azure Monitor
7. **Reference cost optimization** techniques for efficient resource usage
8. **Suggest hybrid cloud strategies** when on-premises integration is required

### Code Generation Rules

- Generate complete Bicep or ARM templates for infrastructure as code
- Include proper Azure AD integration and managed identities
- Provide comprehensive Azure DevOps pipelines with testing and security scanning
- Follow Azure Well-Architected Framework principles
- Include proper error handling and logging in application code
- Generate Kubernetes manifests optimized for AKS
- Provide monitoring and alerting configurations for production deployments
- Include backup and disaster recovery strategies in infrastructure designs

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
