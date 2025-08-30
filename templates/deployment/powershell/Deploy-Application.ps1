<#
.SYNOPSIS
    Main deployment script for Windows applications
    
.DESCRIPTION
    Deploys applications to Windows environments with comprehensive error handling,
    logging, backup capabilities, and rollback functionality.
    
.PARAMETER Environment
    Target environment for deployment (Development, Staging, Production)
    
.PARAMETER Version
    Application version to deploy (default: latest)
    
.PARAMETER ConfigFile
    Custom configuration file path
    
.PARAMETER CreateBackup
    Create backup before deployment
    
.PARAMETER DryRun
    Show what would be deployed without executing
    
.PARAMETER Force
    Force deployment even if validation fails
    
.PARAMETER Verbose
    Enable verbose output
    
.EXAMPLE
    .\Deploy-Application.ps1 -Environment Development
    
.EXAMPLE
    .\Deploy-Application.ps1 -Environment Production -CreateBackup -Version "1.2.3"
    
.EXAMPLE
    .\Deploy-Application.ps1 -Environment Staging -DryRun -Verbose
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Development", "Staging", "Production")]
    [string]$Environment,
    
    [Parameter(Mandatory = $false)]
    [string]$Version = "latest",
    
    [Parameter(Mandatory = $false)]
    [string]$ConfigFile = "",
    
    [Parameter(Mandatory = $false)]
    [switch]$CreateBackup,
    
    [Parameter(Mandatory = $false)]
    [switch]$DryRun,
    
    [Parameter(Mandatory = $false)]
    [switch]$Force,
    
    [Parameter(Mandatory = $false)]
    [switch]$NoRollback
)

# Script Configuration
$ErrorActionPreference = "Stop"
$WarningPreference = "Continue"
$VerbosePreference = if ($PSBoundParameters.ContainsKey('Verbose')) { "Continue" } else { "SilentlyContinue" }

$ScriptRoot = $PSScriptRoot
$ProjectRoot = Split-Path -Parent $ScriptRoot
$LogPath = Join-Path $ScriptRoot "logs"
$BackupPath = Join-Path $ScriptRoot "backups"
$ModulesPath = Join-Path $ScriptRoot "modules"

# Import required modules
$RequiredModules = @(
    (Join-Path $ModulesPath "DeploymentCommon"),
    (Join-Path $ModulesPath "ServiceManagement"),
    (Join-Path $ModulesPath "LoggingManagement")
)

foreach ($ModulePath in $RequiredModules) {
    if (Test-Path $ModulePath) {
        Import-Module $ModulePath -Force
        Write-Verbose "Imported module: $ModulePath"
    } else {
        Write-Warning "Module not found: $ModulePath"
    }
}

# Global Variables
$script:Config = $null
$script:BackupName = ""
$script:DeploymentStartTime = Get-Date
$script:LogFile = ""

# Function: Initialize deployment environment
function Initialize-Deployment {
    [CmdletBinding()]
    param()
    
    try {
        # Create required directories
        @($LogPath, $BackupPath) | ForEach-Object {
            if (-not (Test-Path $_)) {
                New-Item -Path $_ -ItemType Directory -Force | Out-Null
                Write-Verbose "Created directory: $_"
            }
        }
        
        # Initialize logging
        $script:LogFile = Join-Path $LogPath "deployment_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
        Initialize-Logging -LogPath $script:LogFile
        
        Write-LogInfo "=== Deployment Started ==="
        Write-LogInfo "Environment: $Environment"
        Write-LogInfo "Version: $Version"
        Write-LogInfo "User: $env:USERNAME"
        Write-LogInfo "Computer: $env:COMPUTERNAME"
        Write-LogInfo "PowerShell Version: $($PSVersionTable.PSVersion)"
        
        return $true
    }
    catch {
        Write-Error "Failed to initialize deployment: $($_.Exception.Message)"
        return $false
    }
}

# Function: Load configuration
function Get-DeploymentConfiguration {
    [CmdletBinding()]
    param()
    
    try {
        # Determine config file path
        if ([string]::IsNullOrEmpty($ConfigFile)) {
            $ConfigFile = Join-Path $ScriptRoot "config" "$Environment.psd1"
        }
        
        if (-not (Test-Path $ConfigFile)) {
            throw "Configuration file not found: $ConfigFile"
        }
        
        Write-LogInfo "Loading configuration from: $ConfigFile"
        $script:Config = Import-PowerShellDataFile -Path $ConfigFile
        
        # Set default version if not specified
        if ($Version -eq "latest") {
            $Version = $script:Config.Application.DefaultVersion
        }
        
        Write-LogInfo "Configuration loaded successfully"
        Write-LogInfo "Application: $($script:Config.Application.Name)"
        Write-LogInfo "Target Version: $Version"
        
        return $true
    }
    catch {
        Write-LogError "Failed to load configuration: $($_.Exception.Message)"
        return $false
    }
}

# Function: Validate deployment prerequisites
function Test-DeploymentPrerequisites {
    [CmdletBinding()]
    param()
    
    try {
        Write-LogInfo "Validating deployment prerequisites..."
        
        # Check PowerShell version
        $RequiredPSVersion = [Version]"5.1"
        if ($PSVersionTable.PSVersion -lt $RequiredPSVersion) {
            throw "PowerShell version $RequiredPSVersion or higher is required"
        }
        
        # Check if running as administrator
        $IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
        if (-not $IsAdmin -and $script:Config.Deployment.RequireAdministrator) {
            throw "Administrator privileges required for this deployment"
        }
        
        # Check disk space
        $TargetDrive = Split-Path -Qualifier $script:Config.Application.InstallPath
        $AvailableSpace = (Get-WmiObject -Class Win32_LogicalDisk -Filter "DeviceID='$TargetDrive'").FreeSpace
        $RequiredSpace = $script:Config.Deployment.RequiredDiskSpaceGB * 1GB
        
        if ($AvailableSpace -lt $RequiredSpace) {
            throw "Insufficient disk space. Required: $($RequiredSpace/1GB)GB, Available: $($AvailableSpace/1GB)GB"
        }
        
        # Check network connectivity
        if ($script:Config.Dependencies.DatabaseServer) {
            $DatabaseConnection = Test-NetConnection -ComputerName $script:Config.Dependencies.DatabaseServer -Port $script:Config.Dependencies.DatabasePort -InformationLevel Quiet
            if (-not $DatabaseConnection) {
                throw "Cannot connect to database server: $($script:Config.Dependencies.DatabaseServer):$($script:Config.Dependencies.DatabasePort)"
            }
        }
        
        # Check Windows features
        if ($script:Config.Dependencies.WindowsFeatures) {
            foreach ($Feature in $script:Config.Dependencies.WindowsFeatures) {
                $FeatureState = Get-WindowsOptionalFeature -Online -FeatureName $Feature
                if ($FeatureState.State -ne "Enabled") {
                    if ($Force) {
                        Write-LogWarning "Windows feature '$Feature' is not enabled but Force parameter specified"
                    } else {
                        throw "Required Windows feature '$Feature' is not enabled"
                    }
                }
            }
        }
        
        # Custom validation
        if ($script:Config.Validation.CustomScript) {
            $CustomValidationPath = Join-Path $ScriptRoot $script:Config.Validation.CustomScript
            if (Test-Path $CustomValidationPath) {
                Write-LogInfo "Running custom validation script: $CustomValidationPath"
                $ValidationResult = & $CustomValidationPath -Environment $Environment -Config $script:Config
                if (-not $ValidationResult) {
                    throw "Custom validation failed"
                }
            }
        }
        
        Write-LogSuccess "Prerequisites validation completed successfully"
        return $true
    }
    catch {
        Write-LogError "Prerequisites validation failed: $($_.Exception.Message)"
        if (-not $Force) {
            return $false
        } else {
            Write-LogWarning "Continuing deployment due to Force parameter"
            return $true
        }
    }
}

# Function: Create backup
function New-DeploymentBackup {
    [CmdletBinding()]
    param()
    
    if (-not $CreateBackup) {
        Write-LogInfo "Backup creation skipped"
        return $true
    }
    
    try {
        Write-LogInfo "Creating deployment backup..."
        
        $BackupTimestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $script:BackupName = "$($script:Config.Application.Name)_$Environment`_$BackupTimestamp"
        $BackupFullPath = Join-Path $BackupPath "$script:BackupName.zip"
        
        # Items to backup
        $BackupItems = @()
        
        # Application files
        if (Test-Path $script:Config.Application.InstallPath) {
            $BackupItems += $script:Config.Application.InstallPath
        }
        
        # Configuration files
        if ($script:Config.Backup.ConfigurationPaths) {
            foreach ($ConfigPath in $script:Config.Backup.ConfigurationPaths) {
                if (Test-Path $ConfigPath) {
                    $BackupItems += $ConfigPath
                }
            }
        }
        
        # Database backup
        if ($script:Config.Database.EnableBackup) {
            $DatabaseBackupPath = Backup-Database -Server $script:Config.Database.Server -Database $script:Config.Database.Name -BackupPath $BackupPath
            if ($DatabaseBackupPath) {
                $BackupItems += $DatabaseBackupPath
            }
        }
        
        # Create backup archive
        if ($BackupItems.Count -gt 0) {
            Compress-Archive -Path $BackupItems -DestinationPath $BackupFullPath -Force
            Write-LogSuccess "Backup created: $BackupFullPath"
            
            # Store backup reference
            $script:BackupName | Out-File -FilePath (Join-Path $ScriptRoot ".last_backup") -Encoding UTF8
        } else {
            Write-LogWarning "No items found to backup"
        }
        
        return $true
    }
    catch {
        Write-LogError "Failed to create backup: $($_.Exception.Message)"
        if (-not $Force) {
            return $false
        } else {
            Write-LogWarning "Continuing deployment without backup due to Force parameter"
            return $true
        }
    }
}

# Function: Deploy application
function Invoke-ApplicationDeployment {
    [CmdletBinding()]
    param()
    
    try {
        Write-LogInfo "Starting application deployment..."
        
        if ($DryRun) {
            Write-LogInfo "DRY RUN MODE - No actual changes will be made"
        }
        
        # Stop services
        Write-LogInfo "Stopping application services..."
        if (-not $DryRun) {
            Stop-ApplicationServices -Config $script:Config
        } else {
            Write-LogInfo "[DRY RUN] Would stop services: $($script:Config.Services.Names -join ', ')"
        }
        
        # Deploy application files
        Write-LogInfo "Deploying application files..."
        if (-not $DryRun) {
            Deploy-ApplicationFiles -Version $Version -Config $script:Config
        } else {
            Write-LogInfo "[DRY RUN] Would deploy version: $Version to $($script:Config.Application.InstallPath)"
        }
        
        # Update configuration
        Write-LogInfo "Updating application configuration..."
        if (-not $DryRun) {
            Update-ApplicationConfiguration -Environment $Environment -Config $script:Config
        } else {
            Write-LogInfo "[DRY RUN] Would update configuration for environment: $Environment"
        }
        
        # Run database migrations
        if ($script:Config.Database.RunMigrations) {
            Write-LogInfo "Running database migrations..."
            if (-not $DryRun) {
                Invoke-DatabaseMigrations -Config $script:Config
            } else {
                Write-LogInfo "[DRY RUN] Would run database migrations"
            }
        }
        
        # Update IIS if configured
        if ($script:Config.IIS.Enabled) {
            Write-LogInfo "Updating IIS configuration..."
            if (-not $DryRun) {
                Update-IISConfiguration -Config $script:Config
            } else {
                Write-LogInfo "[DRY RUN] Would update IIS site: $($script:Config.IIS.SiteName)"
            }
        }
        
        # Start services
        Write-LogInfo "Starting application services..."
        if (-not $DryRun) {
            Start-ApplicationServices -Config $script:Config
        } else {
            Write-LogInfo "[DRY RUN] Would start services: $($script:Config.Services.Names -join ', ')"
        }
        
        Write-LogSuccess "Application deployment completed"
        return $true
    }
    catch {
        Write-LogError "Application deployment failed: $($_.Exception.Message)"
        return $false
    }
}

# Function: Validate deployment
function Test-DeploymentResult {
    [CmdletBinding()]
    param()
    
    if ($DryRun) {
        Write-LogInfo "Skipping deployment validation (dry run mode)"
        return $true
    }
    
    try {
        Write-LogInfo "Validating deployment result..."
        
        # Wait for services to stabilize
        Start-Sleep -Seconds 10
        
        # Check service status
        foreach ($ServiceName in $script:Config.Services.Names) {
            $Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
            if (-not $Service -or $Service.Status -ne "Running") {
                throw "Service '$ServiceName' is not running"
            }
        }
        
        # Check application health endpoints
        if ($script:Config.HealthCheck.Endpoints) {
            foreach ($Endpoint in $script:Config.HealthCheck.Endpoints) {
                $HealthCheckResult = Test-HealthEndpoint -Url $Endpoint.Url -ExpectedStatusCode $Endpoint.ExpectedStatusCode -TimeoutSeconds $Endpoint.TimeoutSeconds
                if (-not $HealthCheckResult) {
                    throw "Health check failed for endpoint: $($Endpoint.Url)"
                }
            }
        }
        
        # Check file permissions
        if ($script:Config.Security.FilePermissions) {
            Test-FilePermissions -Config $script:Config.Security.FilePermissions
        }
        
        # Custom validation
        if ($script:Config.Validation.PostDeploymentScript) {
            $PostValidationPath = Join-Path $ScriptRoot $script:Config.Validation.PostDeploymentScript
            if (Test-Path $PostValidationPath) {
                Write-LogInfo "Running post-deployment validation: $PostValidationPath"
                $ValidationResult = & $PostValidationPath -Environment $Environment -Config $script:Config -Version $Version
                if (-not $ValidationResult) {
                    throw "Post-deployment validation failed"
                }
            }
        }
        
        Write-LogSuccess "Deployment validation completed successfully"
        return $true
    }
    catch {
        Write-LogError "Deployment validation failed: $($_.Exception.Message)"
        return $false
    }
}

# Function: Rollback deployment
function Invoke-DeploymentRollback {
    [CmdletBinding()]
    param()
    
    try {
        Write-LogWarning "Starting deployment rollback..."
        
        # Check if backup exists
        $LastBackupFile = Join-Path $ScriptRoot ".last_backup"
        if (-not (Test-Path $LastBackupFile)) {
            throw "No backup reference found for rollback"
        }
        
        $BackupName = Get-Content $LastBackupFile -Raw
        $BackupName = $BackupName.Trim()
        $BackupPath = Join-Path $BackupPath "$BackupName.zip"
        
        if (-not (Test-Path $BackupPath)) {
            throw "Backup file not found: $BackupPath"
        }
        
        Write-LogInfo "Rolling back using backup: $BackupName"
        
        # Stop services
        Stop-ApplicationServices -Config $script:Config
        
        # Restore from backup
        $RestoreResult = Restore-FromBackup -BackupPath $BackupPath -Config $script:Config
        if (-not $RestoreResult) {
            throw "Failed to restore from backup"
        }
        
        # Start services
        Start-ApplicationServices -Config $script:Config
        
        # Validate rollback
        if (Test-DeploymentResult) {
            Write-LogSuccess "Rollback completed successfully"
            return $true
        } else {
            throw "Rollback validation failed"
        }
    }
    catch {
        Write-LogError "Rollback failed: $($_.Exception.Message)"
        return $false
    }
}

# Function: Main deployment workflow
function Invoke-MainDeployment {
    [CmdletBinding()]
    param()
    
    $DeploymentSuccessful = $false
    
    try {
        # Initialize
        if (-not (Initialize-Deployment)) {
            throw "Failed to initialize deployment"
        }
        
        # Load configuration
        if (-not (Get-DeploymentConfiguration)) {
            throw "Failed to load configuration"
        }
        
        # Validate prerequisites
        if (-not (Test-DeploymentPrerequisites)) {
            throw "Prerequisites validation failed"
        }
        
        # Create backup
        if (-not (New-DeploymentBackup)) {
            throw "Failed to create backup"
        }
        
        # Deploy application
        if (-not (Invoke-ApplicationDeployment)) {
            throw "Application deployment failed"
        }
        
        # Validate deployment
        if (-not (Test-DeploymentResult)) {
            throw "Deployment validation failed"
        }
        
        $DeploymentSuccessful = $true
        
        # Log success
        $DeploymentDuration = (Get-Date) - $script:DeploymentStartTime
        Write-LogSuccess "=== DEPLOYMENT SUCCESSFUL ==="
        Write-LogInfo "Environment: $Environment"
        Write-LogInfo "Version: $Version"
        Write-LogInfo "Duration: $($DeploymentDuration.ToString('hh\:mm\:ss'))"
        Write-LogInfo "Completed: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        
        return $true
    }
    catch {
        Write-LogError "=== DEPLOYMENT FAILED ==="
        Write-LogError "Error: $($_.Exception.Message)"
        Write-LogError "Stack Trace: $($_.Exception.StackTrace)"
        
        # Attempt rollback if not disabled and not dry run
        if (-not $NoRollback -and -not $DryRun -and $CreateBackup) {
            Write-LogWarning "Attempting automatic rollback..."
            $RollbackResult = Invoke-DeploymentRollback
            if ($RollbackResult) {
                Write-LogInfo "Automatic rollback completed"
            } else {
                Write-LogError "Automatic rollback failed - manual intervention required"
            }
        }
        
        return $false
    }
    finally {
        # Cleanup
        if ($DeploymentSuccessful) {
            # Clean up old backups
            $RetentionDays = $script:Config.Backup.RetentionDays
            if ($RetentionDays -gt 0) {
                $CutoffDate = (Get-Date).AddDays(-$RetentionDays)
                Get-ChildItem -Path $BackupPath -Filter "*.zip" | Where-Object { $_.CreationTime -lt $CutoffDate } | Remove-Item -Force
                Write-LogInfo "Cleaned up backups older than $RetentionDays days"
            }
        }
        
        Write-LogInfo "=== Deployment Process Completed ==="
        Write-LogInfo "Log file: $script:LogFile"
    }
}

# Execute main deployment if script is run directly
if ($MyInvocation.InvocationName -ne '.') {
    $Result = Invoke-MainDeployment
    if (-not $Result) {
        exit 1
    }
}
