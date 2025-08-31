
# pip Package Manager Instructions

## Tool Overview
- **Tool Name**: pip (Pip Installs Packages)
- **Version**: 21.0+ (Python 3.9+), 22.0+ (Python 3.10+), 23.0+ (Python 3.11+)
- **Category**: Package Management
- **Purpose**: Install and manage Python packages from PyPI and other repositories
- **Prerequisites**: Python 3.7+ (pip included), internet connection for package downloads

## Installation & Setup
### pip Installation
```bash
# pip comes with Python 3.4+, but to upgrade:
python -m pip install --upgrade pip

# Install pip on older Python versions
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

# Platform-specific installations
# macOS (with Homebrew Python)
brew install python          # Includes pip

# Ubuntu/Debian
sudo apt update
sudo apt install python3-pip

# CentOS/RHEL/Fedora
sudo yum install python3-pip
# or
sudo dnf install python3-pip

# Windows (Python from python.org includes pip)
# Verify installation
python -m pip --version
pip --version
```

### Virtual Environment Setup
```bash
# Create virtual environment
python -m venv myenv                    # Using venv (recommended)
python -m venv myenv --prompt="MyProject"  # Custom prompt

# Activate virtual environment
# On macOS/Linux:
source myenv/bin/activate

# On Windows:
myenv\Scripts\activate

# On Windows (PowerShell):
myenv\Scripts\Activate.ps1

# Deactivate virtual environment
deactivate

# Alternative: Using virtualenv
pip install virtualenv
virtualenv myenv
source myenv/bin/activate               # macOS/Linux
myenv\Scripts\activate                  # Windows
```

## Configuration

### pip Configuration File
```ini
# pip.conf (Linux/macOS: ~/.config/pip/pip.conf or ~/.pip/pip.conf)
# pip.ini (Windows: %APPDATA%\pip\pip.ini)

[global]
# Default index URL
index-url = https://pypi.org/simple/

# Additional index URLs
extra-index-url = https://pypi.anaconda.org/simple/
                  https://download.pytorch.org/whl/cpu

# Trusted hosts (for HTTP repositories)
trusted-host = pypi.org
               pypi.python.org
               files.pythonhosted.org

# Cache directory
cache-dir = ~/.cache/pip

# Timeout settings
timeout = 60
retries = 3

# Default options
no-cache-dir = false
disable-pip-version-check = false

# Proxy settings
proxy = http://user:password@proxy.server:port

[install]
# Default installation options
user = false
ignore-installed = false
no-deps = false
compile = true

[freeze]
# Freeze command options
all = false

[list]
# List command options
format = columns
```

### Environment Variables
```bash
# pip configuration via environment variables
export PIP_INDEX_URL=https://pypi.org/simple/
export PIP_EXTRA_INDEX_URL=https://pypi.anaconda.org/simple/
export PIP_CACHE_DIR=~/.cache/pip
export PIP_TIMEOUT=60
export PIP_RETRIES=3

# Proxy configuration
export PIP_PROXY=http://proxy.server:port
export HTTP_PROXY=http://proxy.server:port
export HTTPS_PROXY=http://proxy.server:port

# Authentication
export PIP_INDEX_URL=https://username:password@pypi.example.com/simple/

# Disable version check
export PIP_DISABLE_PIP_VERSION_CHECK=1
```

### requirements.txt Format
```txt
# requirements.txt - Basic dependencies
requests==2.31.0                   # Exact version
flask>=2.3.0,<3.0.0               # Version range
django~=4.2.0                      # Compatible release
numpy                              # Latest version
scipy>=1.10.0                      # Minimum version

# Development dependencies (requirements-dev.txt)
pytest>=7.4.0
black>=23.7.0
flake8>=6.0.0
mypy>=1.5.0

# Optional dependencies with extras
requests[security,socks]>=2.31.0

# Git repositories
git+https://github.com/user/repo.git
git+https://github.com/user/repo.git@v1.0.0
git+https://github.com/user/repo.git@branch-name

# Local packages
-e .                               # Editable install of current directory
-e ./local-package                 # Editable install of local package
file:///path/to/local/package      # Local file system

# Include other requirement files
-r requirements-base.txt
-r requirements-dev.txt

# Constraints (pip-tools format)
# constraints.txt
setuptools<60.0.0                  # Constrain transitive dependencies
```

### setup.py and pyproject.toml
```python
# setup.py (traditional approach)
from setuptools import setup, find_packages

setup(
    name="my-package",
    version="1.0.0",
    description="A sample Python package",
    author="Your Name",
    author_email="your.email@example.com",
    packages=find_packages(),
    install_requires=[
        "requests>=2.31.0",
        "click>=8.1.0",
    ],
    extras_require={
        "dev": [
            "pytest>=7.4.0",
            "black>=23.7.0",
            "mypy>=1.5.0",
        ],
        "docs": [
            "sphinx>=7.1.0",
            "sphinx-rtd-theme>=1.3.0",
        ],
    },
    python_requires=">=3.8",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
    ],
)
```

```toml
# pyproject.toml (modern approach)
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "my-package"
version = "1.0.0"
description = "A sample Python package"
authors = [{name = "Your Name", email = "your.email@example.com"}]
license = {text = "MIT"}
readme = "README.md"
requires-python = ">=3.8"
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
]

dependencies = [
    "requests>=2.31.0",
    "click>=8.1.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "black>=23.7.0",
    "mypy>=1.5.0",
]
docs = [
    "sphinx>=7.1.0",
    "sphinx-rtd-theme>=1.3.0",
]

[project.urls]
Homepage = "https://github.com/username/my-package"
Documentation = "https://my-package.readthedocs.io"
Repository = "https://github.com/username/my-package.git"
Issues = "https://github.com/username/my-package/issues"

[project.scripts]
my-cli = "my_package.cli:main"

[tool.setuptools.packages.find]
where = ["src"]
include = ["my_package*"]
```

## Core Features

### Package Installation
- **Purpose**: Install Python packages and their dependencies
- **Usage**: Add libraries and tools to your Python environment
- **Example**:
```bash
# Basic installation
pip install requests                    # Latest version
pip install requests==2.31.0           # Specific version
pip install "requests>=2.31.0,<3.0.0"  # Version range
pip install requests~=2.31.0           # Compatible release

# Install from requirements file
pip install -r requirements.txt
pip install -r requirements-dev.txt

# Install with extras
pip install requests[security,socks]
pip install "django[argon2,bcrypt]"

# Install from different sources
pip install requests                    # PyPI (default)
pip install --index-url https://pypi.anaconda.org/simple/ numpy
pip install --extra-index-url https://download.pytorch.org/whl/cpu torch

# Install from Git repositories
pip install git+https://github.com/user/repo.git
pip install git+https://github.com/user/repo.git@v1.0.0
pip install git+https://github.com/user/repo.git@branch-name
pip install git+ssh://git@github.com/user/repo.git

# Install from local sources
pip install .                          # Current directory
pip install -e .                       # Editable/development install
pip install ./path/to/package          # Local package
pip install file:///absolute/path/to/package

# Install from URLs
pip install https://files.pythonhosted.org/packages/.../package.whl
pip install https://github.com/user/repo/archive/main.zip

# System-level installations (use with caution)
pip install --user requests            # User-level install
sudo pip install requests              # System-wide (not recommended)

# Force reinstall
pip install --force-reinstall requests
pip install --upgrade --force-reinstall requests
```

### Package Management
- **Purpose**: Update, remove, and inspect installed packages
- **Usage**: Maintain and analyze your Python environment
- **Example**:
```bash
# List installed packages
pip list                               # All packages
pip list --outdated                    # Show outdated packages
pip list --uptodate                    # Show up-to-date packages
pip list --user                        # User-installed packages
pip list --format=freeze              # Requirements format

# Show package information
pip show requests                      # Package details
pip show -v requests                   # Verbose package info
pip show --files requests             # Show installed files

# Update packages
pip install --upgrade requests         # Upgrade specific package
pip install -U requests               # Short form
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U  # Upgrade all

# Remove packages
pip uninstall requests                 # Remove package
pip uninstall -r requirements.txt     # Remove packages from file
pip uninstall -y requests             # Auto-confirm removal

# Check dependencies
pip check                              # Check for dependency conflicts
pip show --dependencies requests       # Show package dependencies

# Generate requirements
pip freeze                             # All installed packages
pip freeze > requirements.txt         # Save to file
pip freeze --local                     # Only packages in virtual env
pip freeze | grep -v "^-e"            # Exclude editable packages
```

### Virtual Environment Integration
- **Purpose**: Manage isolated Python environments
- **Usage**: Avoid dependency conflicts between projects
- **Example**:
```bash
# Create and activate virtual environment
python -m venv myproject
source myproject/bin/activate          # macOS/Linux
myproject\Scripts\activate             # Windows

# Install packages in virtual environment
pip install django flask pytest

# Save environment state
pip freeze > requirements.txt

# Recreate environment
deactivate
rm -rf myproject
python -m venv myproject
source myproject/bin/activate
pip install -r requirements.txt

# Alternative: conda environments
conda create -n myproject python=3.11
conda activate myproject
pip install -r requirements.txt
```

## Common Commands
```bash
# Installation commands
pip install [package]              # Install package
pip install -r requirements.txt    # Install from requirements file
pip install -e .                   # Editable install (development)
pip install --upgrade [package]    # Upgrade package
pip install --user [package]       # Install for current user only

# Package information
pip list                           # List installed packages
pip list --outdated               # Show outdated packages
pip show [package]                 # Show package information
pip show --files [package]         # Show installed files
pip check                          # Check for dependency conflicts

# Package removal
pip uninstall [package]            # Uninstall package
pip uninstall -r requirements.txt  # Uninstall from requirements file
pip uninstall -y [package]         # Auto-confirm uninstall

# Requirements management
pip freeze                         # Show installed packages in requirements format
pip freeze > requirements.txt      # Save requirements to file
pip freeze --local                 # Only show packages in virtual environment

# Cache management
pip cache dir                      # Show cache directory
pip cache info                     # Show cache information
pip cache list                     # List cached packages
pip cache remove [package]         # Remove package from cache
pip cache purge                    # Clear entire cache

# Configuration
pip config list                    # Show configuration
pip config edit                    # Edit configuration file
pip config set global.index-url [url]  # Set configuration value
pip config unset global.index-url      # Remove configuration value

# Debugging and troubleshooting
pip install --verbose [package]    # Verbose output
pip install --dry-run [package]    # Show what would be installed
pip install --no-cache-dir [package]  # Disable cache
pip debug --verbose               # Show debug information
```

## Advanced Features

### pip-tools for Dependency Management
```bash
# Install pip-tools
pip install pip-tools

# Create requirements.in (high-level dependencies)
echo "django>=4.2.0" > requirements.in
echo "requests" >> requirements.in

# Generate locked requirements.txt
pip-compile requirements.in

# Update requirements
pip-compile --upgrade requirements.in

# Install from compiled requirements
pip-sync requirements.txt

# Development workflow with pip-tools
pip-compile requirements.in
pip-compile requirements-dev.in
pip-sync requirements.txt requirements-dev.txt
```

### Constraints Files
```bash
# constraints.txt - Constrain transitive dependencies
setuptools<60.0.0
urllib3<2.0.0

# Install with constraints
pip install -c constraints.txt requests
pip install -r requirements.txt -c constraints.txt
```

### Custom Index and Private Repositories
```bash
# Install from custom index
pip install --index-url https://pypi.example.com/simple/ mypackage

# Multiple indexes
pip install --extra-index-url https://pypi.example.com/simple/ mypackage

# Authentication with custom index
pip install --index-url https://username:password@pypi.example.com/simple/ mypackage

# Use personal access token
pip install --index-url https://token:${TOKEN}@pypi.example.com/simple/ mypackage

# Configuration for custom index
pip config set global.index-url https://pypi.example.com/simple/
pip config set global.trusted-host pypi.example.com
```

### Editable Installs for Development
```bash
# Install package in development mode
pip install -e .                   # Current directory
pip install -e ./path/to/package   # Specific path
pip install -e git+https://github.com/user/repo.git#egg=package  # Git repo

# Install with extras in development mode
pip install -e ".[dev,test]"

# Uninstall editable package
pip uninstall package-name         # Use package name, not path
```

## Common Patterns

### Project Setup Workflow
```bash
# Start new Python project
mkdir myproject && cd myproject
python -m venv venv
source venv/bin/activate            # macOS/Linux
# or venv\Scripts\activate          # Windows

# Install development tools
pip install --upgrade pip setuptools wheel
pip install pytest black flake8 mypy

# Create requirements files
echo "requests>=2.31.0" > requirements.in
echo "flask>=2.3.0" >> requirements.in
pip-compile requirements.in

echo "pytest>=7.4.0" > requirements-dev.in
echo "black>=23.7.0" >> requirements-dev.in
pip-compile requirements-dev.in

# Install dependencies
pip install -r requirements.txt -r requirements-dev.txt
```

### Dependency Management Strategy
```bash
# High-level dependencies (requirements.in)
django>=4.2.0
requests
celery[redis]

# Generate locked file
pip-compile requirements.in         # Creates requirements.txt with exact versions

# Regular updates
pip-compile --upgrade requirements.in

# Security updates only
pip-compile --upgrade-package django requirements.in
```

### Multi-Environment Setup
```bash
# Base requirements (requirements-base.in)
requests>=2.31.0
click>=8.1.0

# Production requirements (requirements-prod.in)
-r requirements-base.in
gunicorn>=21.0.0
psycopg2-binary>=2.9.0

# Development requirements (requirements-dev.in)
-r requirements-base.in
pytest>=7.4.0
black>=23.7.0
mypy>=1.5.0

# Generate all requirement files
pip-compile requirements-base.in
pip-compile requirements-prod.in
pip-compile requirements-dev.in

# Install for development
pip install -r requirements-dev.txt

# Install for production
pip install -r requirements-prod.txt
```

## Performance Optimization

### Installation Speed
```bash
# Use cache for faster installs
pip install --cache-dir ~/.cache/pip requests

# Install from local cache only
pip install --find-links ~/.cache/pip --no-index requests

# Parallel downloads (pip 20.3+)
pip install requests flask django    # Downloads in parallel

# Use pre-compiled wheels
pip install --only-binary=all numpy scipy pandas

# Disable unnecessary features
pip install --no-compile requests    # Skip bytecode compilation
pip install --no-deps requests       # Skip dependency resolution
```

### Cache Management
```bash
# Check cache usage
pip cache info

# Cache specific packages
pip download -d ~/.cache/pip requests flask

# Use local cache as index
pip install --find-links ~/.cache/pip --no-index requests

# Warm cache for requirements
pip download -r requirements.txt -d ~/.cache/pip
```

### Wheel Building
```bash
# Build wheels for dependencies
pip wheel -r requirements.txt -w ./wheels

# Install from pre-built wheels
pip install --find-links ./wheels -r requirements.txt

# Build wheel for current package
pip wheel .

# Build source distribution
python setup.py sdist
```

## Common Issues & Solutions

### Permission Errors
**Problem**: Permission denied when installing packages
**Solution**: Use virtual environments or user installs
```bash
# Use virtual environment (recommended)
python -m venv venv
source venv/bin/activate
pip install requests

# Use user install
pip install --user requests

# Fix ownership (macOS/Linux)
sudo chown -R $(whoami) ~/.local/lib/python3.x/site-packages/
```

### Dependency Conflicts
**Problem**: Conflicting package versions
**Solution**: Use constraints or virtual environments
```bash
# Check for conflicts
pip check

# Use constraints file
echo "urllib3<2.0.0" > constraints.txt
pip install -c constraints.txt requests

# Create clean environment
deactivate
rm -rf venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### SSL Certificate Issues
**Problem**: SSL certificate verification failed
**Solution**: Configure trusted hosts or update certificates
```bash
# Add trusted host
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org requests

# Update certificates (macOS)
/Applications/Python\ 3.x/Install\ Certificates.command

# Configure globally
pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"
```

### Network and Proxy Issues
**Problem**: Network connectivity problems
**Solution**: Configure proxy and timeout settings
```bash
# Configure proxy
pip install --proxy http://proxy.server:port requests
pip config set global.proxy http://proxy.server:port

# Increase timeout
pip install --timeout 60 requests
pip config set global.timeout 60

# Use alternative index
pip install --index-url https://pypi.doubanio.com/simple/ requests
```

## Integration with Development Tools

### CI/CD Integration
```yaml
# GitHub Actions example
name: Python CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.8', '3.9', '3.10', '3.11']

    steps:
    - uses: actions/checkout@v4

    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
        cache: 'pip'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
        pip install -r requirements-dev.txt

    - name: Run tests
      run: |
        pytest

    - name: Check security
      run: |
        pip-audit
```

### Docker Integration
```dockerfile
# Dockerfile with pip
FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
USER app

# Install package in development mode
RUN pip install --user -e .

EXPOSE 8000

CMD ["python", "-m", "myapp"]
```

### IDE Integration
```json
// VS Code settings.json
{
  "python.defaultInterpreterPath": "./venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.formatting.provider": "black"
}
```

## Useful Resources
- **Official Documentation**: https://pip.pypa.io/
- **PyPI (Python Package Index)**: https://pypi.org/
- **Python Packaging User Guide**: https://packaging.python.org/
- **pip-tools**: https://pip-tools.readthedocs.io/
- **Virtual Environments Guide**: https://docs.python.org/3/tutorial/venv.html
- **setuptools Documentation**: https://setuptools.pypa.io/

## Tool-Specific Guidelines

### Requirements File Best Practices
- Pin exact versions in production (requirements.txt)
- Use version ranges for dependencies (requirements.in)
- Separate development and production requirements
- Use constraints files for transitive dependencies
- Regular security audits with tools like pip-audit

### Virtual Environment Management
- Always use virtual environments for projects
- Name environments descriptively
- Keep requirements files updated
- Document Python version requirements
- Use tools like pyenv for Python version management

### Package Development
- Use editable installs during development (`pip install -e .`)
- Follow semantic versioning
- Include comprehensive metadata in setup.py/pyproject.toml
- Test package installation before publishing
- Use twine for secure package uploads

## Version Compatibility
- **Python**: 3.7+ (pip 21.0+), 3.8+ (pip 22.0+), 3.9+ (pip 23.0+)
- **pip**: 20.0+ (legacy), 21.0+ (current), 22.0+ (modern), 23.0+ (latest)
- **setuptools**: 45.0+ (legacy), 61.0+ (pyproject.toml support)
- **Platform Support**: Windows, macOS, Linux, BSD

## Troubleshooting

### Debug Mode
```bash
# Enable verbose output
pip install --verbose requests
pip -v install requests

# Debug specific issues
pip debug --verbose               # Show environment info
pip config debug                 # Show configuration sources

# Check pip installation
python -m pip --version
python -c "import pip; print(pip.__file__)"

# Verify package integrity
pip install --force-reinstall --no-deps requests
python -c "import requests; print(requests.__version__)"
```

### Common Error Messages
- **Error**: `No module named 'pip'`
  **Cause**: pip not installed or not in PATH
  **Solution**: Reinstall Python or use `python -m ensurepip`

- **Error**: `Could not find a version that satisfies the requirement`
  **Cause**: Package not found or version constraint too strict
  **Solution**: Check package name and available versions

- **Error**: `Permission denied`
  **Cause**: Insufficient permissions for installation
  **Solution**: Use virtual environment or --user flag
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
