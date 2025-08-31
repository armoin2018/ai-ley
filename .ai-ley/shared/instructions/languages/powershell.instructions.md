`
---
applyTo: "**/*.ps1, **/*.psm1, **/*.psd1, powershell"
---

# PowerShell Programming Instructions

## Overview
- **Domain**: System Administration, Automation, and Cross-Platform Scripting
- **Purpose**: Build efficient, maintainable automation scripts and administrative tools using PowerShell
- **Applicable To**: Windows/Linux/macOS automation, cloud administration, DevOps pipelines, and enterprise management
- **Integration Level**: System administration, CI/CD pipelines, and infrastructure automation

## Core Principles

### Fundamental Concepts
1. **Object-Oriented Pipelines**: PowerShell works with .NET objects, not just text
2. **Verb-Noun Syntax**: Consistent command structure following approved verb-noun pairs
3. **Pipeline-Centric**: Design scripts to work efficiently with PowerShell pipelines
4. **Cross-Platform Compatibility**: Modern PowerShell Core runs on Windows, Linux, and macOS

### Key Benefits
- Rich object model with .NET integration
- Extensive cmdlet library for system administration
- Strong support for remote management and automation
- Excellent help system and discoverability
- Integration with cloud platforms (Azure, AWS)

### Common Misconceptions
- **Myth**: PowerShell is only for Windows administration
  **Reality**: PowerShell Core is cross-platform and excellent for cloud/DevOps automation
- **Myth**: PowerShell is slow compared to other scripting languages
  **Reality**: PowerShell's object model provides efficiency gains for many administrative tasks

## Implementation Framework

### Getting Started
#### Prerequisites
- PowerShell 7+ (PowerShell Core recommended for cross-platform compatibility)
- Basic understanding of .NET objects and concepts
- Administrative privileges for system-level scripts

#### Initial Setup
```powershell
# Check PowerShell version
$PSVersionTable

# Set execution policy (Windows)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install PowerShellGet and update modules
Install-Module -Name PowerShellGet -Force
Update-Module -Name PowerShellGet

# Install common modules
Install-Module -Name Az -Scope CurrentUser  # Azure
Install-Module -Name AWS.Tools.Installer -Scope CurrentUser  # AWS
Install-Module -Name Pester -Scope CurrentUser  # Testing
```

### Core Methodologies
#### Function-Based Development
- **Purpose**: Create reusable, modular code with proper error handling
- **When to Use**: All PowerShell scripts beyond simple one-liners
- **Implementation Steps**:
  1. Design functions with single responsibilities
  2. Use approved verbs and proper parameter design
  3. Implement comprehensive error handling
  4. Add help documentation and examples
- **Success Metrics**: Reusable functions with clear interfaces and documentation

#### Pipeline Optimization
- **Purpose**: Leverage PowerShell's object pipeline for efficient data processing
- **When to Use**: Data processing, filtering, and transformation tasks
- **Implementation Steps**:
  1. Design functions to accept pipeline input
  2. Use Where-Object and ForEach-Object efficiently
  3. Implement proper pipeline terminating vs non-terminating errors
  4. Optimize memory usage with streaming operations
- **Success Metrics**: Efficient pipeline processing with minimal memory footprint

### Process Integration
#### Module Development
```powershell
# Create module structure
New-ModuleManifest -Path .\MyModule.psd1 -RootModule .\MyModule.psm1 -Author "Your Name" -Description "Description"

# Module file structure
MyModule/
├── MyModule.psd1          # Module manifest
├── MyModule.psm1          # Main module file
├── Public/                # Public functions
│   ├── Get-Something.ps1
│   └── Set-Something.ps1
├── Private/               # Private helper functions
│   └── Helper.ps1
├── Tests/                 # Pester tests
│   └── MyModule.Tests.ps1
└── docs/                  # Documentation
    └── README.md
```

#### CI/CD Integration
```yaml
# Azure DevOps pipeline example
trigger:
- main

pool:
  vmImage: 'windows-latest'

steps:
- task: PowerShell@2
  displayName: 'Install Pester'
  inputs:
    targetType: 'inline'
    script: |
      Install-Module -Name Pester -Force -SkipPublisherCheck
      Import-Module Pester

- task: PowerShell@2
  displayName: 'Run Pester Tests'
  inputs:
    targetType: 'inline'
    script: |
      Invoke-Pester -Path './Tests' -OutputFile 'TestResults.xml' -OutputFormat NUnitXml
      
- task: PublishTestResults@2
  inputs:
    testResultsFormat: 'NUnit'
    testResultsFiles: 'TestResults.xml'
```

## Best Practices

### Modern PowerShell Function Design
```powershell
#Requires -Version 7.0

function Get-SystemInfo {
    <#
    .SYNOPSIS
        Retrieves comprehensive system information from local or remote computers.
    
    .DESCRIPTION
        This function gathers detailed system information including hardware,
        operating system, and performance metrics. Supports both local and
        remote computer queries with proper error handling.
    
    .PARAMETER ComputerName
        Specifies the computer names to query. Defaults to localhost.
        Accepts pipeline input and supports wildcards.
    
    .PARAMETER Credential
        Specifies credentials for remote computer access.
    
    .PARAMETER IncludePerformance
        Include performance counter data in the output.
    
    .EXAMPLE
        Get-SystemInfo
        
        Gets system information for the local computer.
    
    .EXAMPLE
        Get-SystemInfo -ComputerName 'Server01', 'Server02' -IncludePerformance
        
        Gets system information including performance data for multiple servers.
    
    .EXAMPLE
        'Server01', 'Server02' | Get-SystemInfo -Credential $cred
        
        Uses pipeline input to query multiple servers with alternate credentials.
    
    .OUTPUTS
        System.Management.Automation.PSCustomObject
        Returns custom objects with system information properties.
    
    .NOTES
        Requires PowerShell 7.0 or later for cross-platform compatibility.
        Remote computers must have PowerShell remoting enabled.
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $env:COMPUTERNAME,
        
        [Parameter()]
        [System.Management.Automation.PSCredential]$Credential,
        
        [Parameter()]
        [switch]$IncludePerformance
    )
    
    begin {
        Write-Verbose "Starting system information collection"
        
        # Define common parameters for remote commands
        $commonParams = @{}
        if ($Credential) {
            $commonParams['Credential'] = $Credential
        }
        
        # Performance counters to collect
        $performanceCounters = @(
            '\Processor(_Total)\% Processor Time',
            '\Memory\Available MBytes',
            '\PhysicalDisk(_Total)\% Disk Time'
        )
    }
    
    process {
        foreach ($computer in $ComputerName) {
            Write-Verbose "Processing computer: $computer"
            
            try {
                # Test connectivity first
                if ($computer -ne $env:COMPUTERNAME) {
                    $testResult = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction Stop
                    if (-not $testResult) {
                        throw "Computer $computer is not reachable"
                    }
                }
                
                # Collect basic system information
                $systemInfo = if ($computer -eq $env:COMPUTERNAME) {
                    # Local computer - use direct CIM access
                    @{
                        OperatingSystem = Get-CimInstance -ClassName Win32_OperatingSystem
                        ComputerSystem = Get-CimInstance -ClassName Win32_ComputerSystem
                        Processor = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1
                        Memory = Get-CimInstance -ClassName Win32_PhysicalMemory | 
                                 Measure-Object -Property Capacity -Sum
                    }
                } else {
                    # Remote computer - use CIM sessions for better performance
                    $cimSession = New-CimSession -ComputerName $computer @commonParams -ErrorAction Stop
                    try {
                        @{
                            OperatingSystem = Get-CimInstance -CimSession $cimSession -ClassName Win32_OperatingSystem
                            ComputerSystem = Get-CimInstance -CimSession $cimSession -ClassName Win32_ComputerSystem
                            Processor = Get-CimInstance -CimSession $cimSession -ClassName Win32_Processor | 
                                       Select-Object -First 1
                            Memory = Get-CimInstance -CimSession $cimSession -ClassName Win32_PhysicalMemory | 
                                    Measure-Object -Property Capacity -Sum
                        }
                    }
                    finally {
                        Remove-CimSession -CimSession $cimSession -ErrorAction SilentlyContinue
                    }
                }
                
                # Collect performance data if requested
                $performanceData = if ($IncludePerformance) {
                    try {
                        if ($computer -eq $env:COMPUTERNAME) {
                            Get-Counter -Counter $performanceCounters -SampleInterval 1 -MaxSamples 1
                        } else {
                            Get-Counter -Counter $performanceCounters -ComputerName $computer -SampleInterval 1 -MaxSamples 1
                        }
                    }
                    catch {
                        Write-Warning "Could not collect performance data from $computer : $($_.Exception.Message)"
                        $null
                    }
                } else {
                    $null
                }
                
                # Create output object
                $output = [PSCustomObject]@{
                    ComputerName = $computer
                    OperatingSystem = $systemInfo.OperatingSystem.Caption
                    OSVersion = $systemInfo.OperatingSystem.Version
                    ServicePack = $systemInfo.OperatingSystem.ServicePackMajorVersion
                    Architecture = $systemInfo.OperatingSystem.OSArchitecture
                    Manufacturer = $systemInfo.ComputerSystem.Manufacturer
                    Model = $systemInfo.ComputerSystem.Model
                    ProcessorName = $systemInfo.Processor.Name
                    ProcessorCores = $systemInfo.Processor.NumberOfCores
                    ProcessorLogicalCores = $systemInfo.Processor.NumberOfLogicalProcessors
                    TotalMemoryGB = [math]::Round($systemInfo.Memory.Sum / 1GB, 2)
                    Domain = $systemInfo.ComputerSystem.Domain
                    LastBootTime = $systemInfo.OperatingSystem.LastBootUpTime
                    Uptime = (Get-Date) - $systemInfo.OperatingSystem.LastBootUpTime
                    CollectionTime = Get-Date
                }
                
                # Add performance data if available
                if ($performanceData) {
                    $cpuUsage = ($performanceData.CounterSamples | Where-Object {$_.Path -like "*Processor*"}).CookedValue
                    $availableMemoryMB = ($performanceData.CounterSamples | Where-Object {$_.Path -like "*Available MBytes*"}).CookedValue
                    $diskUsage = ($performanceData.CounterSamples | Where-Object {$_.Path -like "*Disk Time*"}).CookedValue
                    
                    $output | Add-Member -NotePropertyName 'CPUUsagePercent' -NotePropertyValue ([math]::Round($cpuUsage, 2))
                    $output | Add-Member -NotePropertyName 'AvailableMemoryMB' -NotePropertyValue $availableMemoryMB
                    $output | Add-Member -NotePropertyName 'DiskUsagePercent' -NotePropertyValue ([math]::Round($diskUsage, 2))
                }
                
                # Output the result
                Write-Output $output
            }
            catch {
                $errorRecord = [System.Management.Automation.ErrorRecord]::new(
                    $_.Exception,
                    "SystemInfoCollectionError",
                    [System.Management.Automation.ErrorCategory]::OperationStopped,
                    $computer
                )
                $PSCmdlet.WriteError($errorRecord)
            }
        }
    }
    
    end {
        Write-Verbose "System information collection completed"
    }
}
```

### Advanced Pipeline and Error Handling
```powershell
function Backup-UserData {
    <#
    .SYNOPSIS
        Creates backups of user data with validation and progress tracking.
    
    .DESCRIPTION
        Performs incremental or full backups of user data directories with
        comprehensive error handling, progress reporting, and validation.
    #>
    
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateScript({
            if (Test-Path $_ -PathType Container) { $true }
            else { throw "Path '$_' does not exist or is not a directory" }
        })]
        [string[]]$SourcePath,
        
        [Parameter(Mandatory)]
        [string]$DestinationPath,
        
        [Parameter()]
        [ValidateSet('Full', 'Incremental')]
        [string]$BackupType = 'Incremental',
        
        [Parameter()]
        [switch]$Verify,
        
        [Parameter()]
        [int]$RetryCount = 3
    )
    
    begin {
        # Ensure destination exists
        if (-not (Test-Path $DestinationPath)) {
            try {
                New-Item -Path $DestinationPath -ItemType Directory -Force | Out-Null
                Write-Verbose "Created destination directory: $DestinationPath"
            }
            catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
        }
        
        # Initialize progress tracking
        $totalSources = 0
        $processedSources = 0
        $backupResults = [System.Collections.ArrayList]::new()
    }
    
    process {
        foreach ($source in $SourcePath) {
            $totalSources++
            
            $activity = "Backing up user data"
            $status = "Processing: $source"
            $percentComplete = if ($totalSources -gt 1) { 
                ($processedSources / $totalSources) * 100 
            } else { 
                0 
            }
            
            Write-Progress -Activity $activity -Status $status -PercentComplete $percentComplete
            
            if ($PSCmdlet.ShouldProcess($source, "Backup to $DestinationPath")) {
                $backupResult = @{
                    SourcePath = $source
                    DestinationPath = $DestinationPath
                    BackupType = $BackupType
                    StartTime = Get-Date
                    Success = $false
                    FilesCopied = 0
                    TotalSize = 0
                    Error = $null
                }
                
                try {
                    # Calculate source size for progress
                    Write-Verbose "Calculating source size for $source"
                    $sourceSize = Get-ChildItem -Path $source -Recurse -File | 
                                  Measure-Object -Property Length -Sum
                    $backupResult.TotalSize = $sourceSize.Sum
                    
                    # Determine backup strategy
                    $destinationFolder = Join-Path $DestinationPath (Split-Path $source -Leaf)
                    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
                    
                    if ($BackupType -eq 'Full') {
                        $backupFolder = Join-Path $DestinationPath "Full_$timestamp"
                    } else {
                        $lastBackup = Get-ChildItem $DestinationPath -Directory | 
                                     Where-Object { $_.Name -match "^(Full_|Incremental_)" } |
                                     Sort-Object LastWriteTime -Descending |
                                     Select-Object -First 1
                        
                        $backupFolder = Join-Path $DestinationPath "Incremental_$timestamp"
                        $referenceDate = if ($lastBackup) { $lastBackup.LastWriteTime } else { [DateTime]::MinValue }
                    }
                    
                    # Perform backup with retry logic
                    $attempt = 0
                    do {
                        $attempt++
                        try {
                            if ($BackupType -eq 'Full') {
                                $result = Copy-ItemWithProgress -Source $source -Destination $backupFolder -Recurse
                            } else {
                                $result = Copy-ItemWithProgress -Source $source -Destination $backupFolder -Recurse -NewerThan $referenceDate
                            }
                            
                            $backupResult.FilesCopied = $result.FilesCopied
                            $backupResult.Success = $true
                            break
                        }
                        catch {
                            if ($attempt -eq $RetryCount) {
                                throw
                            }
                            Write-Warning "Backup attempt $attempt failed for $source. Retrying... Error: $($_.Exception.Message)"
                            Start-Sleep -Seconds (2 * $attempt)
                        }
                    } while ($attempt -lt $RetryCount)
                    
                    # Verify backup if requested
                    if ($Verify -and $backupResult.Success) {
                        Write-Verbose "Verifying backup for $source"
                        $verificationResult = Test-BackupIntegrity -SourcePath $source -BackupPath $backupFolder
                        if (-not $verificationResult.IsValid) {
                            throw "Backup verification failed: $($verificationResult.Error)"
                        }
                    }
                    
                    $backupResult.EndTime = Get-Date
                    $backupResult.Duration = $backupResult.EndTime - $backupResult.StartTime
                    
                    Write-Information "Successfully backed up $source to $backupFolder" -InformationAction Continue
                }
                catch {
                    $backupResult.Success = $false
                    $backupResult.Error = $_.Exception.Message
                    $backupResult.EndTime = Get-Date
                    
                    $errorRecord = [System.Management.Automation.ErrorRecord]::new(
                        $_.Exception,
                        "BackupOperationFailed",
                        [System.Management.Automation.ErrorCategory]::OperationStopped,
                        $source
                    )
                    $PSCmdlet.WriteError($errorRecord)
                }
                
                [void]$backupResults.Add([PSCustomObject]$backupResult)
                $processedSources++
            }
        }
    }
    
    end {
        Write-Progress -Activity "Backing up user data" -Completed
        
        # Output summary
        $successfulBackups = $backupResults | Where-Object Success
        $failedBackups = $backupResults | Where-Object { -not $_.Success }
        
        $summary = [PSCustomObject]@{
            TotalSources = $totalSources
            SuccessfulBackups = $successfulBackups.Count
            FailedBackups = $failedBackups.Count
            TotalFilesCopied = ($successfulBackups | Measure-Object -Property FilesCopied -Sum).Sum
            TotalSizeCopied = ($successfulBackups | Measure-Object -Property TotalSize -Sum).Sum
            BackupResults = $backupResults
        }
        
        Write-Output $summary
    }
}

function Copy-ItemWithProgress {
    param(
        [string]$Source,
        [string]$Destination,
        [switch]$Recurse,
        [DateTime]$NewerThan = [DateTime]::MinValue
    )
    
    $files = if ($Recurse) {
        Get-ChildItem -Path $Source -Recurse -File | Where-Object { $_.LastWriteTime -gt $NewerThan }
    } else {
        Get-ChildItem -Path $Source -File | Where-Object { $_.LastWriteTime -gt $NewerThan }
    }
    
    $filesCopied = 0
    $totalFiles = $files.Count
    
    foreach ($file in $files) {
        $relativePath = $file.FullName.Substring($Source.Length + 1)
        $destinationFile = Join-Path $Destination $relativePath
        $destinationDir = Split-Path $destinationFile -Parent
        
        if (-not (Test-Path $destinationDir)) {
            New-Item -Path $destinationDir -ItemType Directory -Force | Out-Null
        }
        
        Copy-Item -Path $file.FullName -Destination $destinationFile -Force
        $filesCopied++
        
        if ($totalFiles -gt 100 -and ($filesCopied % 10 -eq 0)) {
            $percentComplete = ($filesCopied / $totalFiles) * 100
            Write-Progress -Activity "Copying files" -Status "Copied $filesCopied of $totalFiles files" -PercentComplete $percentComplete
        }
    }
    
    return @{ FilesCopied = $filesCopied }
}

function Test-BackupIntegrity {
    param(
        [string]$SourcePath,
        [string]$BackupPath
    )
    
    try {
        # Simple file count and size verification
        $sourceFiles = Get-ChildItem -Path $SourcePath -Recurse -File
        $backupFiles = Get-ChildItem -Path $BackupPath -Recurse -File
        
        $sourceCount = $sourceFiles.Count
        $backupCount = $backupFiles.Count
        
        $sourceSize = ($sourceFiles | Measure-Object -Property Length -Sum).Sum
        $backupSize = ($backupFiles | Measure-Object -Property Length -Sum).Sum
        
        $isValid = ($sourceCount -eq $backupCount) -and ($sourceSize -eq $backupSize)
        
        return @{
            IsValid = $isValid
            SourceFileCount = $sourceCount
            BackupFileCount = $backupCount
            SourceSize = $sourceSize
            BackupSize = $backupSize
            Error = if (-not $isValid) { "File count or size mismatch" } else { $null }
        }
    }
    catch {
        return @{
            IsValid = $false
            Error = $_.Exception.Message
        }
    }
}
```

## Common Patterns and Examples

### Pattern 1: Configuration Management
**Scenario**: Manage system configurations across multiple servers
**Implementation**:
```powershell
# Configuration management with DSC-like approach
function Set-ServerConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]$ComputerName,
        
        [Parameter(Mandatory)]
        [hashtable]$Configuration
    )
    
    process {
        foreach ($computer in $ComputerName) {
            Invoke-Command -ComputerName $computer -ScriptBlock {
                param($Config)
                
                # Apply IIS configuration
                if ($Config.IIS) {
                    if ($Config.IIS.Enabled) {
                        Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole -All
                        
                        # Configure application pools
                        foreach ($pool in $Config.IIS.ApplicationPools) {
                            Import-Module WebAdministration -Force
                            if (-not (Get-IISAppPool -Name $pool.Name -ErrorAction SilentlyContinue)) {
                                New-WebAppPool -Name $pool.Name
                            }
                            Set-ItemProperty -Path "IIS:\AppPools\$($pool.Name)" -Name processModel.identityType -Value $pool.Identity
                        }
                    }
                }
                
                # Apply Windows services configuration
                if ($Config.Services) {
                    foreach ($service in $Config.Services) {
                        $svc = Get-Service -Name $service.Name -ErrorAction SilentlyContinue
                        if ($svc) {
                            if ($service.State -eq 'Running' -and $svc.Status -ne 'Running') {
                                Start-Service -Name $service.Name
                            }
                            elseif ($service.State -eq 'Stopped' -and $svc.Status -ne 'Stopped') {
                                Stop-Service -Name $service.Name
                            }
                            
                            if ($service.StartupType -and $svc.StartType -ne $service.StartupType) {
                                Set-Service -Name $service.Name -StartupType $service.StartupType
                            }
                        }
                    }
                }
                
                # Apply registry settings
                if ($Config.Registry) {
                    foreach ($regSetting in $Config.Registry) {
                        if (-not (Test-Path $regSetting.Path)) {
                            New-Item -Path $regSetting.Path -Force | Out-Null
                        }
                        Set-ItemProperty -Path $regSetting.Path -Name $regSetting.Name -Value $regSetting.Value
                    }
                }
                
            } -ArgumentList $Configuration
        }
    }
}

# Usage example
$serverConfig = @{
    IIS = @{
        Enabled = $true
        ApplicationPools = @(
            @{ Name = 'MyApp'; Identity = 'ApplicationPoolIdentity' }
        )
    }
    Services = @(
        @{ Name = 'W3SVC'; State = 'Running'; StartupType = 'Automatic' }
        @{ Name = 'WAS'; State = 'Running'; StartupType = 'Automatic' }
    )
    Registry = @(
        @{ 
            Path = 'HKLM:\SOFTWARE\MyCompany'
            Name = 'Environment'
            Value = 'Production'
        }
    )
}

'Server01', 'Server02' | Set-ServerConfiguration -Configuration $serverConfig
```
**Expected Outcomes**: Consistent server configurations with automated compliance checking

### Pattern 2: Azure Resource Management
**Scenario**: Manage Azure resources with PowerShell automation
**Implementation**:
```powershell
function New-AzureWebAppStack {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$ResourceGroupName,
        
        [Parameter(Mandatory)]
        [string]$AppName,
        
        [Parameter(Mandatory)]
        [string]$Location,
        
        [Parameter()]
        [string]$AppServicePlanTier = 'B1',
        
        [Parameter()]
        [hashtable]$AppSettings = @{},
        
        [Parameter()]
        [hashtable]$ConnectionStrings = @{}
    )
    
    try {
        # Ensure we're connected to Azure
        $context = Get-AzContext
        if (-not $context) {
            throw "Not connected to Azure. Please run Connect-AzAccount first."
        }
        
        Write-Information "Creating Azure Web App stack for: $AppName" -InformationAction Continue
        
        # Create resource group if it doesn't exist
        $resourceGroup = Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue
        if (-not $resourceGroup) {
            Write-Verbose "Creating resource group: $ResourceGroupName"
            $resourceGroup = New-AzResourceGroup -Name $ResourceGroupName -Location $Location
        }
        
        # Create App Service Plan
        $appServicePlanName = "$AppName-plan"
        $appServicePlan = Get-AzAppServicePlan -ResourceGroupName $ResourceGroupName -Name $appServicePlanName -ErrorAction SilentlyContinue
        if (-not $appServicePlan) {
            Write-Verbose "Creating App Service Plan: $appServicePlanName"
            $appServicePlan = New-AzAppServicePlan `
                -ResourceGroupName $ResourceGroupName `
                -Name $appServicePlanName `
                -Location $Location `
                -Tier $AppServicePlanTier
        }
        
        # Create Web App
        $webApp = Get-AzWebApp -ResourceGroupName $ResourceGroupName -Name $AppName -ErrorAction SilentlyContinue
        if (-not $webApp) {
            Write-Verbose "Creating Web App: $AppName"
            $webApp = New-AzWebApp `
                -ResourceGroupName $ResourceGroupName `
                -Name $AppName `
                -Location $Location `
                -AppServicePlan $appServicePlanName
        }
        
        # Configure application settings
        if ($AppSettings.Count -gt 0) {
            Write-Verbose "Configuring application settings"
            Set-AzWebApp -ResourceGroupName $ResourceGroupName -Name $AppName -AppSettings $AppSettings
        }
        
        # Configure connection strings
        if ($ConnectionStrings.Count -gt 0) {
            Write-Verbose "Configuring connection strings"
            $connectionStringSettings = @{}
            foreach ($cs in $ConnectionStrings.GetEnumerator()) {
                $connectionStringSettings[$cs.Key] = @{
                    Value = $cs.Value
                    Type = 'SQLServer'  # Default type, could be parameterized
                }
            }
            Set-AzWebApp -ResourceGroupName $ResourceGroupName -Name $AppName -ConnectionStrings $connectionStringSettings
        }
        
        # Enable HTTPS only
        Set-AzWebApp -ResourceGroupName $ResourceGroupName -Name $AppName -HttpsOnly $true
        
        # Return web app information
        $result = [PSCustomObject]@{
            ResourceGroupName = $ResourceGroupName
            AppName = $AppName
            AppServicePlan = $appServicePlanName
            DefaultHostName = $webApp.DefaultHostName
            State = $webApp.State
            Location = $Location
            CreatedTime = Get-Date
        }
        
        Write-Output $result
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

# Usage example
$appSettings = @{
    'ASPNETCORE_ENVIRONMENT' = 'Production'
    'ApplicationInsights:InstrumentationKey' = '12345678-1234-1234-1234-123456789012'
}

$connectionStrings = @{
    'DefaultConnection' = 'Server=myserver.database.windows.net;Database=mydb;User Id=myuser;Password=mypass;'
}

New-AzureWebAppStack -ResourceGroupName 'MyApp-RG' -AppName 'mywebapp' -Location 'East US' -AppSettings $appSettings -ConnectionStrings $connectionStrings
```
**Expected Outcomes**: Automated Azure infrastructure provisioning with proper configuration

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Using Write-Host for Output
- **Description**: Using Write-Host instead of Write-Output or Write-Information
- **Why It's Problematic**: Breaks pipeline functionality and cannot be captured
- **Better Approach**: Use Write-Output for data, Write-Information for user messages

#### Anti-Pattern 2: Ignoring Error Handling
- **Description**: Not implementing proper error handling and terminating vs non-terminating errors
- **Why It's Problematic**: Scripts fail unpredictably and provide poor user experience
- **Better Approach**: Use try-catch blocks and proper ErrorAction parameters

## Tools and Resources

### Essential Modules and Tools
```powershell
# Essential modules for modern PowerShell development
$essentialModules = @(
    'Az',                    # Azure PowerShell
    'AWS.Tools.Common',      # AWS PowerShell
    'Pester',               # Testing framework
    'PSScriptAnalyzer',     # Code analysis
    'platyPS',              # Help documentation
    'PowerShellGet',        # Module management
    'PSReadLine'            # Enhanced command line editing
)

foreach ($module in $essentialModules) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Install-Module -Name $module -Scope CurrentUser -Force
    }
}
```

### Code Analysis and Testing
```powershell
# Run PSScriptAnalyzer on scripts
Invoke-ScriptAnalyzer -Path .\MyScript.ps1 -Severity Warning,Error

# Pester test example
Describe "Get-SystemInfo Tests" {
    Context "When run against localhost" {
        It "Should return system information object" {
            $result = Get-SystemInfo
            $result | Should -Not -BeNullOrEmpty
            $result.ComputerName | Should -Be $env:COMPUTERNAME
        }
        
        It "Should include required properties" {
            $result = Get-SystemInfo
            $result.PSObject.Properties.Name | Should -Contain 'OperatingSystem'
            $result.PSObject.Properties.Name | Should -Contain 'TotalMemoryGB'
        }
    }
}
```

### Learning Resources
- **PowerShell Documentation**: https://docs.microsoft.com/en-us/powershell/
- **PowerShell Gallery**: https://www.powershellgallery.com/
- **PowerShell Best Practices**: https://github.com/PoshCode/PowerShellPracticeAndStyle
- **Pester Testing**: https://pester.dev/

## Quality and Compliance

### Quality Standards
- All functions include comprehensive help documentation
- Scripts pass PSScriptAnalyzer analysis with no errors or warnings
- Proper error handling implemented throughout
- Pipeline support for functions that process multiple objects
- Consistent verb-noun naming following PowerShell conventions

### Security Standards
- Credential handling through secure methods (never plaintext)
- Input validation for all parameters
- Execution policy considerations documented
- Script signing for production environments
- Principle of least privilege for administrative scripts

### Performance Standards
- Efficient use of PowerShell pipelines
- Memory-conscious processing for large datasets
- Proper use of PowerShell remoting for scale
- Background jobs for long-running operations

## AI Assistant Guidelines

When helping with PowerShell Development:

1. **Function Design First**: Always design proper functions with parameters, help, and pipeline support
2. **Error Handling Priority**: Implement comprehensive error handling with proper exception types
3. **Modern PowerShell**: Use PowerShell 7+ features and cross-platform compatibility
4. **Pipeline Focus**: Design scripts to work efficiently with PowerShell object pipelines
5. **Documentation Strategy**: Include comprehensive help documentation with examples
6. **Testing Approach**: Include Pester tests for all functions
7. **Security Considerations**: Handle credentials and sensitive data properly
8. **Performance Optimization**: Use efficient PowerShell patterns and avoid common pitfalls

### Decision Making Framework
When helping teams choose PowerShell approaches:

1. **Requirements Analysis**: Understand automation needs and target platforms
2. **Architecture Design**: Plan for modularity, reusability, and maintenance
3. **Security Assessment**: Implement appropriate security measures and access controls
4. **Performance Planning**: Design for efficiency and scalability
5. **Integration Strategy**: Plan for CI/CD and enterprise integration

### Code Generation Rules
- Generate functions following PowerShell best practices and conventions
- Include comprehensive parameter validation and help documentation
- Use proper error handling with try-catch blocks and error records
- Implement pipeline support where appropriate
- Generate corresponding Pester tests for all functions
- Follow approved verb-noun naming conventions
- Include verbose and debug output for troubleshooting
- Provide clear examples and usage documentation

### Quality Enforcement
- ✅ Enforce approved verb-noun function naming conventions
- ✅ Require comprehensive help documentation for all functions
- ✅ Block Write-Host usage in favor of proper output streams
- ✅ Enforce proper error handling and exception management
- ✅ Require parameter validation and type constraints
- ✅ Enforce pipeline support for multi-object functions
- ✅ Require PSScriptAnalyzer compliance
- ✅ Promote secure credential handling practices