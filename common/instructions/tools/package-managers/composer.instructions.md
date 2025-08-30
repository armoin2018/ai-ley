
# Composer PHP Package Manager Instructions

## Tool Overview
- **Tool Name**: Composer
- **Version**: 2.5+ (stable), 2.6+ (latest with enhanced performance)
- **Category**: Package Manager
- **Purpose**: Dependency manager for PHP applications and libraries
- **Prerequisites**: PHP 7.2.5+ (8.0+ recommended), command line access

## Installation & Setup
### Installation Methods
```bash
# Download and install globally (recommended)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Verify installation
composer --version

# macOS installation via Homebrew
brew install composer

# Windows installation via Chocolatey
choco install composer

# Ubuntu/Debian installation
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Docker installation
docker run --rm -v $(pwd):/app composer:latest install

# Update Composer itself
composer self-update
composer self-update --stable    # Update to latest stable
composer self-update --preview   # Update to development version
```

### Project Initialization
```bash
# Create new project with composer.json
composer init

# Interactive project creation
composer init --name="vendor/package" --description="Project description"

# Create project from package template
composer create-project laravel/laravel my-project
composer create-project symfony/skeleton my-app
composer create-project drupal/recommended-project my-site

# Initialize in existing project
touch composer.json
```

## Configuration

### composer.json (Basic Project)
```json
{
    "name": "vendor/package-name",
    "description": "A sample PHP project with Composer",
    "type": "project",
    "license": "MIT",
    "authors": [
        {
            "name": "Your Name",
            "email": "your.email@example.com",
            "homepage": "https://example.com",
            "role": "Developer"
        }
    ],
    "minimum-stability": "stable",
    "prefer-stable": true,
    "require": {
        "php": ">=8.0",
        "monolog/monolog": "^3.0",
        "guzzlehttp/guzzle": "^7.0",
        "symfony/console": "^6.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "squizlabs/php_codesniffer": "^3.7",
        "phpstan/phpstan": "^1.10"
    },
    "autoload": {
        "psr-4": {
            "App\\": "src/",
            "Vendor\\Package\\": "lib/"
        },
        "files": ["src/helpers.php"]
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\": "tests/"
        }
    },
    "scripts": {
        "test": "phpunit",
        "cs-check": "phpcs --standard=PSR12 src/",
        "cs-fix": "phpcbf --standard=PSR12 src/",
        "analyze": "phpstan analyse src/",
        "post-install-cmd": [
            "@php artisan clear-compiled",
            "@php artisan optimize"
        ]
    },
    "config": {
        "optimize-autoloader": true,
        "sort-packages": true,
        "allow-plugins": {
            "dealerdirect/phpcodesniffer-composer-installer": true
        }
    }
}
```

### Advanced Configuration
```json
{
    "name": "enterprise/application",
    "description": "Enterprise PHP application with advanced Composer configuration",
    "type": "project",
    "license": "proprietary",
    "authors": [
        {
            "name": "Development Team",
            "email": "dev-team@company.com"
        }
    ],
    "minimum-stability": "stable",
    "prefer-stable": true,
    "require": {
        "php": ">=8.1",
        "ext-json": "*",
        "ext-pdo": "*",
        "ext-mbstring": "*",
        "doctrine/orm": "^2.15",
        "symfony/framework-bundle": "^6.3",
        "twig/twig": "^3.6"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.2",
        "psalm/plugin-symfony": "^5.0",
        "symfony/var-dumper": "^6.3"
    },
    "autoload": {
        "psr-4": {
            "App\\": "src/",
            "Domain\\": "src/Domain/",
            "Infrastructure\\": "src/Infrastructure/"
        },
        "classmap": ["database/seeders"],
        "files": [
            "src/helpers.php",
            "config/constants.php"
        ]
    },
    "autoload-dev": {
        "psr-4": {
            "Tests\\": "tests/",
            "Fixtures\\": "tests/fixtures/"
        }
    },
    "repositories": [
        {
            "type": "composer",
            "url": "https://repo.packagist.com/company/"
        },
        {
            "type": "vcs",
            "url": "https://github.com/company/private-package"
        },
        {
            "type": "path",
            "url": "../local-packages/*"
        }
    ],
    "scripts": {
        "pre-install-cmd": [
            "echo 'Starting installation...'"
        ],
        "post-install-cmd": [
            "@php bin/console cache:clear",
            "@php bin/console doctrine:schema:update --force"
        ],
        "pre-update-cmd": [
            "echo 'Starting update...'"
        ],
        "post-update-cmd": [
            "@post-install-cmd"
        ],
        "test": [
            "@test-unit",
            "@test-integration"
        ],
        "test-unit": "phpunit --testsuite=unit",
        "test-integration": "phpunit --testsuite=integration",
        "cs-check": "phpcs --standard=PSR12 src/ tests/",
        "cs-fix": "phpcbf --standard=PSR12 src/ tests/",
        "analyze": [
            "phpstan analyse",
            "psalm"
        ],
        "deploy": [
            "@test",
            "@cs-check",
            "@analyze"
        ]
    },
    "scripts-descriptions": {
        "test": "Run all tests",
        "cs-check": "Check coding standards",
        "analyze": "Run static analysis"
    },
    "config": {
        "optimize-autoloader": true,
        "sort-packages": true,
        "platform": {
            "php": "8.1.0"
        },
        "allow-plugins": {
            "symfony/flex": true,
            "dealerdirect/phpcodesniffer-composer-installer": true
        },
        "process-timeout": 600,
        "cache-dir": "/tmp/composer-cache"
    },
    "extra": {
        "symfony": {
            "allow-contrib": false,
            "require": "6.3.*"
        },
        "laravel": {
            "dont-discover": []
        }
    },
    "funding": [
        {
            "type": "github",
            "url": "https://github.com/sponsors/maintainer"
        }
    ]
}
```

### Global Configuration
```bash
# Global composer configuration
composer config --global repositories.packagist composer https://packagist.org
composer config --global github-oauth.github.com YOUR_GITHUB_TOKEN

# Configure authentication
composer config --global http-basic.repo.packagist.com username password
composer config --global gitlab-token.gitlab.com YOUR_GITLAB_TOKEN

# Performance optimization
composer config --global cache-ttl 86400
composer config --global process-timeout 600
composer config --global optimize-autoloader true

# Platform configuration
composer config --global platform.php 8.1.0
```

### composer.lock File
```bash
# The composer.lock file ensures reproducible builds
# Always commit composer.lock to version control
# Contains exact versions of all dependencies

# Update lock file without changing dependencies
composer update --lock

# Validate lock file
composer validate --strict
```

## Core Features

### Package Installation
- **Purpose**: Install project dependencies from Packagist or custom repositories
- **Usage**: Manage both production and development dependencies
- **Example**:
```bash
# Install all dependencies
composer install

# Install only production dependencies
composer install --no-dev

# Install with optimizations
composer install --optimize-autoloader --no-dev

# Add new dependency
composer require monolog/monolog
composer require guzzlehttp/guzzle "^7.0"
composer require --dev phpunit/phpunit

# Add with specific constraints
composer require "doctrine/orm:^2.15"
composer require "symfony/*:^6.0"

# Install from specific repository
composer require vendor/package --repository=https://custom-repo.com

# Install global packages
composer global require laravel/installer
composer global require phpunit/phpunit
```

### Package Updates
- **Purpose**: Update dependencies to newer versions within constraints
- **Usage**: Keep packages up-to-date while maintaining compatibility
- **Example**:
```bash
# Update all packages
composer update

# Update specific package
composer update monolog/monolog
composer update vendor/package

# Update with development dependencies
composer update --with-dependencies

# Update without development dependencies
composer update --no-dev

# Update to latest versions (ignore constraints)
composer update --with-all-dependencies

# Show what would be updated
composer outdated
composer outdated --direct
composer outdated --minor-only

# Interactive update
composer update --interactive

# Update lock file only
composer update --lock
```

### Autoloading
- **Purpose**: Automatically load PHP classes without manual include/require
- **Usage**: PSR-4 compliant autoloading for modern PHP applications
- **Example**:
```bash
# Generate autoloader
composer dump-autoload

# Optimize autoloader for production
composer dump-autoload --optimize

# Include autoloader in PHP files
<?php
require_once 'vendor/autoload.php';

use App\Models\User;
use Monolog\Logger;
use Guzzle\Http\Client;

$user = new User();
$logger = new Logger('app');
$client = new Client();
```

## Common Commands
```bash
# Package management
composer install                    # Install dependencies
composer update                     # Update dependencies
composer require vendor/package     # Add dependency
composer remove vendor/package      # Remove dependency
composer search keyword             # Search packages

# Project management
composer init                       # Initialize project
composer create-project template    # Create from template
composer validate                   # Validate composer.json
composer diagnose                   # Diagnose issues

# Autoloader management
composer dump-autoload              # Regenerate autoloader
composer dump-autoload --optimize   # Optimize for production
composer dump-autoload --classmap-authoritative  # Use classmap only

# Information and analysis
composer show                       # List installed packages
composer show vendor/package        # Show package details
composer depends vendor/package     # Show dependents
composer why vendor/package         # Alias for depends
composer why-not vendor/package     # Show conflicts

# Script execution
composer run-script script-name     # Run defined script
composer test                       # Run test script
composer cs-fix                     # Run code style fixer

# Global operations
composer global require package     # Install globally
composer global update              # Update global packages
composer global show               # Show global packages

# Cache management
composer clear-cache                # Clear all caches
composer clearcache                 # Alias for clear-cache

# Security and maintenance
composer audit                      # Check for vulnerabilities
composer outdated                   # Show outdated packages
composer licenses                   # Show package licenses
```

## Advanced Features

### Private Repositories
```json
{
    "repositories": [
        {
            "type": "composer",
            "url": "https://private-repo.company.com"
        },
        {
            "type": "vcs",
            "url": "git@github.com:company/private-package.git"
        },
        {
            "type": "artifact",
            "url": "path/to/directory/with/zips/"
        },
        {
            "type": "path",
            "url": "../my-local-package"
        }
    ]
}

# Authentication for private repositories
composer config repositories.private-repo composer https://repo.company.com
composer config http-basic.repo.company.com username password
```

### Custom Scripts and Hooks
```json
{
    "scripts": {
        "pre-install-cmd": [
            "echo 'About to install dependencies'"
        ],
        "post-install-cmd": [
            "@php bin/console cache:clear",
            "npm install",
            "npm run build"
        ],
        "pre-update-cmd": [
            "echo 'About to update dependencies'"
        ],
        "post-update-cmd": [
            "@post-install-cmd"
        ],
        "pre-package-install": [
            "echo 'Installing package...'"
        ],
        "post-package-install": [
            "echo 'Package installed successfully'"
        ],
        "test": [
            "@test-unit",
            "@test-integration",
            "@cs-check"
        ],
        "test-unit": "phpunit --testsuite=unit",
        "test-integration": "phpunit --testsuite=integration",
        "cs-check": "phpcs --standard=PSR12 src/",
        "cs-fix": "phpcbf --standard=PSR12 src/",
        "build": [
            "@cs-fix",
            "@test",
            "echo 'Build completed successfully'"
        ]
    }
}

# Run scripts
composer run-script test
composer test                        # If script named 'test'
composer run-script build --verbose  # With verbose output
```

### Version Constraints
```json
{
    "require": {
        "exact-version": "1.2.3",
        "range": ">=1.0,<2.0",
        "wildcard": "1.2.*",
        "tilde": "~1.2.3",      // >=1.2.3,<1.3.0
        "caret": "^1.2.3",      // >=1.2.3,<2.0.0
        "dev-version": "dev-master",
        "alias": "1.2.3 as 2.0.0",
        "stability": "1.2.3@stable"
    }
}
```

### Platform Requirements
```json
{
    "require": {
        "php": ">=8.1",
        "ext-json": "*",
        "ext-pdo": "*",
        "ext-mbstring": "*",
        "ext-gd": "*",
        "lib-openssl": ">=1.1.0"
    },
    "config": {
        "platform": {
            "php": "8.1.15",
            "ext-mongodb": "1.15.0"
        },
        "platform-check": true
    }
}
```

## Package Development

### Creating a Package
```bash
# Initialize package structure
mkdir my-package && cd my-package
composer init

# Package composer.json
{
    "name": "vendor/my-package",
    "description": "A useful PHP package",
    "type": "library",
    "license": "MIT",
    "authors": [
        {
            "name": "Your Name",
            "email": "your.email@example.com"
        }
    ],
    "minimum-stability": "stable",
    "require": {
        "php": ">=8.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0"
    },
    "autoload": {
        "psr-4": {
            "Vendor\\MyPackage\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Vendor\\MyPackage\\Tests\\": "tests/"
        }
    }
}

# Package structure
src/
├── MyClass.php
├── Services/
│   └── MyService.php
└── Contracts/
    └── MyInterface.php
tests/
├── Unit/
│   └── MyClassTest.php
└── Integration/
    └── MyServiceTest.php
```

### Local Development
```bash
# Link local package for development
composer config repositories.local-package path ../my-package
composer require vendor/my-package:dev-master

# Use symlinks for faster development
composer config repositories.local-package '{"type": "path", "url": "../my-package", "options": {"symlink": true}}'

# Remove local repository configuration
composer config --unset repositories.local-package
```

### Publishing Packages
```bash
# Submit to Packagist
1. Push code to GitHub/GitLab
2. Go to https://packagist.org
3. Click "Submit"
4. Enter repository URL
5. Add webhooks for auto-updates

# Validate before publishing
composer validate --strict
composer check-platform-reqs

# Tag releases
git tag -a v1.0.0 -m "Version 1.0.0"
git push origin v1.0.0
```

## Performance Optimization

### Production Optimization
```bash
# Install with optimizations
composer install --no-dev --optimize-autoloader --classmap-authoritative

# Alternative optimization flags
composer install --no-dev --optimize-autoloader --apcu-autoloader

# Update with optimization
composer update --optimize-autoloader --classmap-authoritative

# Generate optimized autoloader
composer dump-autoload --optimize --classmap-authoritative
composer dump-autoload --apcu
```

### Cache Management
```bash
# Configure cache directory
composer config cache-dir /tmp/composer-cache

# Clear cache
composer clear-cache

# Cache repository metadata
composer config cache-ttl 86400

# Disable cache temporarily
composer install --no-cache
```

### Parallel Downloads
```bash
# Enable parallel downloads (Composer 2.0+)
composer config --global process-timeout 600
composer global require hirak/prestissimo  # For Composer 1.x

# Multiple concurrent downloads
composer install --prefer-dist --no-progress
```

## Common Patterns

### Framework Integration
```bash
# Laravel project
composer create-project laravel/laravel my-app
cd my-app
composer require laravel/sanctum
composer require --dev laravel/telescope

# Symfony project
composer create-project symfony/skeleton my-app
cd my-app
composer require webapp
composer require --dev symfony/profiler-pack

# WordPress with Composer
composer create-project roots/bedrock my-site
cd my-site
composer require wpackagist-plugin/advanced-custom-fields
```

### Testing Setup
```json
{
    "require-dev": {
        "phpunit/phpunit": "^10.0",
        "mockery/mockery": "^1.5",
        "fakerphp/faker": "^1.21",
        "squizlabs/php_codesniffer": "^3.7",
        "phpstan/phpstan": "^1.10",
        "psalm/plugin-laravel": "^2.8"
    },
    "scripts": {
        "test": "phpunit",
        "test-coverage": "phpunit --coverage-html coverage",
        "cs-check": "phpcs --standard=PSR12 src/ tests/",
        "cs-fix": "phpcbf --standard=PSR12 src/ tests/",
        "analyze": [
            "phpstan analyse --level=8 src/",
            "psalm --show-info=true"
        ],
        "quality": [
            "@cs-check",
            "@analyze",
            "@test"
        ]
    }
}
```

### Monorepo Configuration
```json
{
    "name": "company/monorepo",
    "type": "project",
    "repositories": [
        {
            "type": "path",
            "url": "packages/*"
        }
    ],
    "require": {
        "company/package-a": "dev-master",
        "company/package-b": "dev-master",
        "company/shared": "dev-master"
    },
    "minimum-stability": "dev",
    "prefer-stable": true,
    "config": {
        "optimize-autoloader": true
    }
}
```

## Environment-Specific Configuration

### Development Environment
```json
{
    "config": {
        "optimize-autoloader": false,
        "classmap-authoritative": false,
        "apcu-autoloader": false
    },
    "scripts": {
        "post-install-cmd": [
            "@php bin/console cache:clear --env=dev"
        ]
    }
}
```

### Production Environment
```bash
# Production installation
composer install --no-dev --optimize-autoloader --classmap-authoritative

# Production configuration
{
    "config": {
        "optimize-autoloader": true,
        "classmap-authoritative": true,
        "apcu-autoloader": true,
        "process-timeout": 300
    }
}
```

### Docker Integration
```dockerfile
# Dockerfile for PHP with Composer
FROM php:8.1-fpm

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Set working directory
WORKDIR /var/www

# Copy composer files
COPY composer.json composer.lock ./

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copy application code
COPY . .

# Generate autoloader
RUN composer dump-autoload --optimize --classmap-authoritative
```

## Common Issues & Solutions

### Memory Issues
**Problem**: Composer runs out of memory during installation
**Solution**: Increase PHP memory limit and use optimization flags
```bash
# Increase memory limit temporarily
php -d memory_limit=-1 $(which composer) install

# Set memory limit globally
echo 'memory_limit = 2G' >> /etc/php/8.1/cli/php.ini

# Use optimizations to reduce memory usage
composer install --prefer-dist --no-dev --optimize-autoloader
```

### Network Issues
**Problem**: Slow downloads or connection timeouts
**Solution**: Configure network settings and use alternative methods
```bash
# Increase timeout
composer config process-timeout 600

# Use prefer-dist to download archives instead of cloning
composer install --prefer-dist

# Use different repository mirrors
composer config repositories.packagist composer https://mirrors.cloud.tencent.com/composer/

# Configure proxy
composer config http-proxy http://proxy.company.com:8080
```

### Authentication Issues
**Problem**: Access denied to private repositories
**Solution**: Configure proper authentication
```bash
# GitHub token
composer config github-oauth.github.com YOUR_TOKEN

# HTTP basic auth
composer config http-basic.repo.example.com username password

# SSH key for Git repositories
ssh-add ~/.ssh/id_rsa
```

### Version Conflicts
**Problem**: Dependency version conflicts
**Solution**: Analyze and resolve conflicts
```bash
# Diagnose conflicts
composer why-not vendor/package 2.0

# Show dependency tree
composer depends vendor/package

# Try different versions
composer require vendor/package:^1.0 --with-dependencies

# Force update with conflicts
composer update --with-dependencies --ignore-platform-reqs
```

## Integration with Development Tools

### IDE Integration
```json
// VS Code settings.json
{
    "php.validate.executablePath": "/usr/bin/php",
    "composer.executablePath": "/usr/local/bin/composer",
    "php.suggest.basic": false,
    "composer.enabled": true
}

// PhpStorm configuration
// File > Settings > Languages & Frameworks > PHP > Composer
// Path to composer.json: /path/to/project/composer.json
// Composer executable: /usr/local/bin/composer
```

### CI/CD Integration
```yaml
# GitHub Actions
name: CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        php-version: [8.1, 8.2, 8.3]

    steps:
    - uses: actions/checkout@v4

    - name: Setup PHP
      uses: shivammathur/setup-php@v2
      with:
        php-version: ${{ matrix.php-version }}
        extensions: mbstring, xml, bcmath
        coverage: xdebug

    - name: Validate composer.json
      run: composer validate --strict

    - name: Cache Composer packages
      uses: actions/cache@v3
      with:
        path: vendor
        key: ${{ runner.os }}-php-${{ hashFiles('**/composer.lock') }}
        restore-keys: |
          ${{ runner.os }}-php-

    - name: Install dependencies
      run: composer install --prefer-dist --no-progress

    - name: Run tests
      run: composer test

    - name: Run code analysis
      run: composer analyze
```

### Static Analysis Integration
```bash
# Install analysis tools
composer require --dev phpstan/phpstan
composer require --dev vimeo/psalm

# Configure phpstan.neon
parameters:
    level: 8
    paths:
        - src
    excludePaths:
        - src/legacy

# Configure psalm.xml
<?xml version="1.0"?>
<psalm totallyTyped="false">
    <projectFiles>
        <directory name="src" />
        <ignoreFiles>
            <directory name="vendor" />
        </ignoreFiles>
    </projectFiles>
</psalm>

# Add to composer scripts
"scripts": {
    "analyze": [
        "phpstan analyse",
        "psalm --show-info=true"
    ]
}
```

## Useful Resources
- **Official Documentation**: https://getcomposer.org/doc/
- **Packagist Repository**: https://packagist.org/
- **Version Constraints**: https://getcomposer.org/doc/articles/versions.md
- **Schema Reference**: https://getcomposer.org/doc/04-schema.md
- **Best Practices**: https://getcomposer.org/doc/articles/best-practices.md
- **Troubleshooting**: https://getcomposer.org/doc/articles/troubleshooting.md

## Tool-Specific Guidelines

### Dependency Management
- Always commit composer.lock to ensure reproducible builds
- Use semantic versioning constraints (^1.2.3) for stable dependencies
- Pin exact versions for critical security-sensitive packages
- Separate production and development dependencies clearly
- Use composer outdated regularly to check for updates

### Performance Best Practices
- Use --optimize-autoloader in production
- Enable APCu autoloader for better performance
- Use --classmap-authoritative for fastest autoloading
- Clear cache before deployment
- Use composer install --no-dev in production

### Security Considerations
- Run composer audit regularly to check for vulnerabilities
- Use private repositories for proprietary code
- Never commit authentication credentials
- Validate packages before adding dependencies
- Keep Composer itself updated

## Version Compatibility
- **PHP**: 7.2.5+ (minimum), 8.0+ (recommended)
- **Composer**: 2.5+ (stable), 2.6+ (latest)
- **Git**: 2.0+ for VCS repositories
- **Memory**: 2GB+ recommended for large projects

## Troubleshooting

### Debug Mode
```bash
# Enable debug output
composer install -vvv

# Debug specific issues
composer diagnose
composer why vendor/package
composer why-not vendor/package 2.0

# Check platform requirements
composer check-platform-reqs

# Validate configuration
composer validate --strict
```

### Common Error Messages
- **Error**: `Your requirements could not be resolved to an installable set of packages`
  **Cause**: Version conflicts between dependencies
  **Solution**: Use `composer why-not` to identify conflicts, update constraints

- **Error**: `Failed to download from dist: guzzlehttp/guzzle`
  **Cause**: Network connectivity or authentication issues
  **Solution**: Configure authentication, use --prefer-source, check network settings

- **Error**: `Class 'App\Example' not found`
  **Cause**: Autoloader not updated after adding classes
  **Solution**: Run `composer dump-autoload` to regenerate autoloader
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

```

```
