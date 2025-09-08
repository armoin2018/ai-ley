# AI-LEY: AI Building Resource Toolkit

A comprehensive tool for managing AI instruction sets, personas, and prompts across multiple repositories and projects.

## Overview

AI-LEY enables developers and AI practitioners to:

- Manage distributed AI instruction repositories
- Synchronize shared AI content across projects
- Contribute improvements back to the community
- Port portable AI tools and configurations

## Prerequisites

- Python 3.6 or higher
- Git
- PyYAML package: `pip install pyyaml`

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/armoin2018/ai-ley.git
   cd ai-ley
   ```

2. Install dependencies:

   ```bash
   pip install pyyaml
   ```

3. Make the script executable:
   ```bash
   chmod +x ai-ley.py
   ```

## Configuration

AI-LEY uses a YAML configuration file (default: `ai-ley.map.yaml`) to define repositories and their properties.

### Configuration Structure

```yaml
git_repos:
  repo-name:
    url: 'https://github.com/user/repo.git'
    branch: main
    portable: true|false
    folders:
      - 'source-path:target-path'
```

### Example Configuration

```yaml
git_repos:
  ai-ley:
    url: 'https://github.com/armoin2018/ai-ley.git'
    branch: main
    portable: false

  awesome-copilot:
    url: 'https://github.com/github/awesome-copilot.git'
    branch: main
    portable: true
    folders:
      - 'chatmodes:.github/chatmodes/'
      - 'instructions:.github/instructions/'
```

## Usage

### Basic Commands

```bash
# Show help
./ai-ley.py --help

# List available repositories
./ai-ley.py --list

# Fetch a specific repository
./ai-ley.py --fetch <repo-name>

# Update local shared content from ai-ley repository
./ai-ley.py --update

# Contribute local changes back to ai-ley repository
./ai-ley.py --contribute

# Port content from a portable repository
./ai-ley.py --port <repo-name>

# Use custom configuration file
./ai-ley.py --config custom-config.yaml --list
```

### Detailed Command Descriptions

#### `--list`

Lists all repositories defined in the configuration file with their details:

- Repository name
- URL
- Branch
- Portable status
- Folder mappings (if applicable)

#### `--fetch <repo-name>`

Downloads or updates a specific repository to `.ai-ley/external/<repo-name>`:

- Clones the repository if it doesn't exist locally
- Pulls the latest changes if it already exists
- Skips inaccessible repositories with appropriate error handling

#### `--update`

Synchronizes local shared content from the main ai-ley repository:

- Automatically fetches ai-ley repository if not present
- Updates `.ai-ley/shared/instructions/`, `.ai-ley/shared/personas/`, and `.ai-ley/shared/prompts/`
- Uses MD5 hashing to only update changed files
- Preserves local modifications not conflicting with upstream

#### `--contribute`

Contributes local changes back to the ai-ley repository:

- Creates a timestamped branch (e.g., `contribution-20240129-143052`)
- Compares local `.ai-ley/shared/` content with repository content using MD5 hashes
- Commits and pushes only changed files
- Provides instructions for creating a pull request

#### `--port <repo-name>`

Copies content from portable repositories to your project:

- Only works with repositories marked as `portable: true`
- Copies folders according to `source:target` mappings
- Overwrites existing target content
- Useful for integrating AI tools and configurations

## Directory Structure

```
project-root/
├── ai-ley.py                    # Main script
├── ai-ley.map.yaml             # Configuration file
├── .ai-ley/
│   ├── external/               # Downloaded repositories
│   │   ├── ai-ley/            # Main AI-LEY repository
│   │   └── other-repos/       # Other fetched repositories
│   └── shared/                # Local shared content
│       ├── instructions/      # AI instruction sets
│       ├── personas/          # AI personas
│       └── prompts/           # AI prompts
└── .github/                   # GitHub-specific AI tools (from porting)
```

## Workflow Examples

### Setting Up a New Project

1. **Initialize with AI-LEY content:**

   ```bash
   ./ai-ley.py --update
   ```

2. **List available portable tools:**

   ```bash
   ./ai-ley.py --list
   ```

3. **Port GitHub Copilot configurations:**
   ```bash
   ./ai-ley.py --port awesome-copilot
   ```

### Contributing Improvements

1. **Edit local instruction sets:**

   ```bash
   # Edit files in .ai-ley/shared/instructions/
   # Edit files in .ai-ley/shared/personas/
   # Edit files in .ai-ley/shared/prompts/
   ```

2. **Contribute changes back:**

   ```bash
   ./ai-ley.py --contribute
   ```

3. **Create pull request via GitHub web interface**

### Staying Updated

1. **Fetch latest AI-LEY content:**

   ```bash
   ./ai-ley.py --update
   ```

2. **Update specific repositories:**
   ```bash
   ./ai-ley.py --fetch awesome-copilot
   ./ai-ley.py --port awesome-copilot
   ```

## Advanced Configuration

### Repository Properties

- **url**: Git repository URL (required)
- **branch**: Target branch (default: main)
- **portable**: Whether content can be ported to projects (default: false)
- **folders**: Array of `source:target` mappings for portable repos

### Folder Mapping Format

```yaml
folders:
  - 'src-folder:dest-folder' # Copy folder
  - 'file.txt:.config/file.txt' # Copy file
  - 'deep/path:shallow/' # Flatten structure
```

## Error Handling

- **Missing repositories**: Skipped with informational messages
- **Permission errors**: Gracefully handled, operations continue
- **Network issues**: Retries and fallbacks where appropriate
- **File conflicts**: Local content preserved, conflicts reported

## Troubleshooting

### Common Issues

1. **PyYAML not found**:

   ```bash
   pip install pyyaml
   ```

2. **Permission denied errors**:

   - Check repository access permissions
   - Verify SSH keys or authentication tokens
   - Use HTTPS URLs for public repositories

3. **Configuration errors**:
   - Validate YAML syntax
   - Check repository URLs and branch names
   - Ensure folder mappings use correct format

### Debug Mode

Add verbose output by modifying the script or check log files in `.ai-ley/logs/`

## Contributing to AI-LEY

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with various configurations
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

- GitHub Issues: https://github.com/armoin2018/ai-ley/issues
- Documentation: This file and inline help (`--help`)
- Community: Join discussions in GitHub Discussions
