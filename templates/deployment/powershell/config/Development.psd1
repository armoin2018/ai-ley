@{
    # Application Configuration
    Application = @{
        Name = "MyApp"
        DisplayName = "My Application"
        DefaultVersion = "1.0.0"
        InstallPath = "C:\Program Files\MyApp"
        DataPath = "C:\ProgramData\MyApp"
        LogPath = "C:\Logs\MyApp"
    }
    
    # Deployment Configuration
    Deployment = @{
        RequireAdministrator = $true
        RequiredDiskSpaceGB = 2
        DeploymentMethod = "FileSystem"  # FileSystem, Git, Artifact, Docker
        SourcePath = "\\deployment-server\releases"
        BackupBeforeDeploy = $true
        RollbackOnFailure = $true
    }
    
    # Database Configuration
    Database = @{
        Server = "localhost"
        Name = "MyAppDev"
        Port = 1433
        IntegratedSecurity = $true
        Username = ""
        PasswordKeyFile = ""
        RunMigrations = $true
        EnableBackup = $true
        MigrationPath = "Database\Migrations"
    }
    
    # IIS Configuration
    IIS = @{
        Enabled = $false
        SiteName = "MyApp-Dev"
        ApplicationPool = "MyApp-Dev-Pool"
        PhysicalPath = "C:\inetpub\wwwroot\MyApp-Dev"
        Port = 80
        Protocol = "http"
        ManagedRuntimeVersion = "v4.0"
        Enable32BitAppOnWin64 = $false
    }
    
    # Services Configuration
    Services = @{
        Names = @()  # No Windows services for development
        StartupType = "Automatic"
        Dependencies = @()
    }
    
    # Dependencies
    Dependencies = @{
        DatabaseServer = "localhost"
        DatabasePort = 1433
        WindowsFeatures = @()
        RequiredSoftware = @()
    }
    
    # Health Check Configuration
    HealthCheck = @{
        Endpoints = @()  # No health endpoints for development
        TimeoutSeconds = 30
        RetryCount = 3
        RetryIntervalSeconds = 5
    }
    
    # Security Configuration
    Security = @{
        FilePermissions = @{
            Paths = @(
                @{
                    Path = "C:\Program Files\MyApp"
                    Owner = "BUILTIN\Administrators"
                    Access = @(
                        @{
                            Account = "BUILTIN\Users"
                            Rights = "ReadAndExecute"
                            Type = "Allow"
                        }
                        @{
                            Account = "BUILTIN\Administrators"
                            Rights = "FullControl"
                            Type = "Allow"
                        }
                    )
                }
            )
        }
        RegistryKeys = @()
    }
    
    # Backup Configuration
    Backup = @{
        RetentionDays = 7
        ConfigurationPaths = @(
            "C:\Program Files\MyApp\config"
        )
        ExcludePatterns = @(
            "*.tmp"
            "*.log"
            "cache\*"
        )
    }
    
    # Validation Configuration
    Validation = @{
        CustomScript = ""
        PostDeploymentScript = ""
        RequiredFiles = @()
        RequiredRegistryKeys = @()
    }
    
    # Monitoring Configuration
    Monitoring = @{
        EventLog = @{
            LogName = "Application"
            Source = "MyApp-Dev"
        }
        PerformanceCounters = @()
        WindowsServices = @()
    }
    
    # Environment-Specific Settings
    Environment = @{
        Name = "Development"
        LogLevel = "Debug"
        DebugMode = $true
        Features = @{
            EnableSwagger = $true
            EnableDebugMode = $true
            EnableDetailedErrors = $true
        }
    }
}
