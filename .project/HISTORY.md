# Project History

This file tracks the version history and major changes to the ai-ley project to allow for resuming, replay, and rollback.

## Version 2025.08.29-00005 - Project Folder Reorganization

**Date**: August 29, 2025  
**Instructions Used**: N/A  
**Personas Used**: N/A

**Changes Made**:

- Relocated `project/` folder to `.project/` for better organization and to hide project management files
- Updated all file references throughout the codebase:
  - `.github/copilot-instructions.md`: Updated all `project/` references to `.project/`
  - `.github/prompts/build-plan.prompt.md`: Updated all `project/` references to `.project/`
  - `.ai-ley/claude-code/commands/build-plan.md`: Updated all `project/` references to `.project/`
  - `.ai-ley/copilot/prompts/build-plan.prompt.md`: Updated all `project/` references to `.project/`
  - Flow diagram files in `docs/prompts/`: Updated references to use `.project/` paths
  - `.ai-ley/copilot/chatmodes/meeting-to-code.chatmode.md`: Fixed persona reference path
- Added `.project` to `.gitignore` to exclude project management files from version control
- Maintained all file contents and structure within the relocated directory

**Files Moved**:

- `project/ASK.md` → `.project/ASK.md`
- `project/BLACKLIST.md` → `.project/BLACKLIST.md`
- `project/CHANGELOG.md` → `.project/CHANGELOG.md`
- `project/HISTORY.md` → `.project/HISTORY.md`
- `project/plan/` → `.project/plan/`
- `project/PLAN.md` → `.project/PLAN.md`
- `project/REQUIREMENTS.md` → `.project/REQUIREMENTS.md`
- `project/SUGGESTIONS.md` → `.project/SUGGESTIONS.md`
- `project/WHITELIST.md` → `.project/WHITELIST.md`

**Verification**:

- All functionality preserved with updated paths
- Project management files now properly hidden from main directory view
- Version control properly excludes project management files

---

## Version 2025.08.29-00004 - External Cache Visibility Enhancement

## 2025.08.29-00003

**Date:** 2025-08-29  
**Description:** Move common folder to .ai-ley/common and update all references  
**Instructions used:** `.github/copilot-instructions.md`  
**Personas used:** N/A

### Changes Made:

- Moved `common/` folder to `.ai-ley/common/` for better organization
- Updated `ai-ley.py` to reference `.ai-ley/common/` instead of `common/`:
  - Updated `self.common_dir` path initialization
  - Updated comment references from `common/prompts` to `.ai-ley/common/prompts`
  - Updated `update_paths` list from `common/` to `.ai-ley/common/`
- Updated `ai-ley.map.yaml` configuration file mappings:
  - Claude Code instructions: `common/instructions/` → `.ai-ley/common/instructions/`
  - Claude Code personas: `common/personas/` → `.ai-ley/common/personas/`
  - Claude Code prompts: `common/prompts/` → `.ai-ley/common/prompts/`
  - Copilot instructions: `common/instructions/` → `.ai-ley/common/instructions/`
  - Copilot personas: `common/personas/` → `.ai-ley/common/personas/`
  - Copilot prompts: `common/prompts/` → `.ai-ley/common/prompts/`
  - Prompts source priority: `common/prompts` → `.ai-ley/common/prompts`
- Updated `scripts/compare_and_clean.sh` to reference `.ai-ley/common/` paths
- Updated documentation files in `.github/prompts/`:
  - `update-personas.prompt.md`: Updated all `common/personas/` references to `.ai-ley/common/personas/`
  - `update-instructions.prompt.md`: Updated references to use `.ai-ley/common/` paths
  - `build-plan.prompt.md`: Updated context from `templates/` to `.ai-ley/`

### Technical Details:

- All common assets (instructions, personas, prompts) now organized under `.ai-ley/common/`
- Maintains complete functionality with cleaner organizational structure
- Common folder contents: instructions/, personas/, README.md, md5sums.txt, instructions-CHANGES.md
- No breaking changes to user-facing commands or functionality
- Follows consistent hidden directory pattern established with `.ai-ley/`

### Verification:

- ✅ `python ai-ley.py list --type ai-tools` - Works correctly
- ✅ `python ai-ley.py list --type projects` - Works correctly
- ✅ `python ai-ley.py provision --ai-tool claude-code` - Successfully provisions from new common paths
- ✅ Folder structure verified: `.ai-ley/common/` contains instructions/, personas/, etc.
- ✅ All AI tool configurations correctly reference `.ai-ley/common/` resources

## 2025.08.29-00002

**Date:** 2025-08-29  
**Description:** Rename templates folder to .ai-ley and reorganize structure  
**Instructions used:** `.github/copilot-instructions.md`  
**Personas used:** N/A

### Changes Made:

- Renamed `templates/` folder to `.ai-ley/` to follow hidden directory convention
- Created `.ai-ley/.external/` directory for git repository caching
- Updated all references in `ai-ley.py` to use `.ai-ley/` instead of `templates/`
- Updated `.gitignore` to reference `.ai-ley/.external` instead of `.external`
- Updated all file path references in `ai-ley.map.yaml` configuration:
  - Docusaurus project paths: `templates/projects/docusaurus/` → `.ai-ley/projects/docusaurus/`
  - MkDocs project paths: `templates/projects/mkdocs/` → `.ai-ley/projects/mkdocs/`
  - Minimal project paths: `templates/projects/minimal/` → `.ai-ley/projects/minimal/`
  - Claude Code templates: `templates/claude-code/` → `.ai-ley/claude-code/`
  - Copilot templates: `templates/copilot/` → `.ai-ley/copilot/`
- Updated external git repository cache paths in ai-ley.py from `.external` to `.ai-ley/.external`
- Updated update_files method to reference `.ai-ley/` in update paths

### Technical Details:

- All template files now organized under hidden `.ai-ley/` directory for cleaner project root
- External repository cache moved to `.ai-ley/.external/` for better organization
- Maintained all existing functionality and command-line interface
- No breaking changes to user-facing APIs or commands
- Follows Unix convention of using hidden directories for application data

### Verification:

- `python ai-ley.py list --type ai-tools` - ✓ Lists claude-code, copilot correctly
- `python ai-ley.py list --type projects` - ✓ Lists docusaurus, mkdocs, minimal correctly
- `python ai-ley.py provision --project-type minimal` - ✓ Successfully provisions from new paths
- Folder structure verified: `.ai-ley/` contains claude-code, copilot, projects, etc.
- Git cache directory created at `.ai-ley/.external/`

## 2025.01.27-00001

**Date:** 2025-01-27  
**Description:** Complete removal of map.yaml dependencies from ai-ley.py  
**Instructions used:** `.github/copilot-instructions.md`  
**Personas used:** N/A

### Changes Made:

- Removed all `load_config()` method calls and the method itself from `TemplateProvisioner` class
- Updated `list_available_ai_tools()` to use only `ai-ley.map.yaml` configuration
- Updated `list_available_project_types()` to use only `ai-ley.map.yaml` configuration
- Updated `clean_provisioned_files()` to use `ai-ley.map.yaml` format
- Removed legacy `_provision_ai_tool_legacy()` method entirely
- Fixed duplicate `provision_project_type()` method definition
- Fixed `substitute_variables()` method to properly handle variable replacement
- Removed legacy `map.yaml` file from filesystem
- All functionality now exclusively uses unified `ai-ley.map.yaml` configuration

### Technical Details:

- No more fallback logic to `map.yaml` - script will fail gracefully if `ai-ley.map.yaml` is missing
- Clean separation between AI tools (`ai_tools`), documentation projects (`doc_handler`), and git repositories (`git_repos`)
- Maintained backward compatibility for all user-facing commands and options
- All lint errors resolved except for one general Exception catch (design decision)

### Verification:

- `python ai-ley.py list --type ai-tools` - ✓ Lists claude-code, copilot
- `python ai-ley.py list --type projects` - ✓ Lists docusaurus, mkdocs, minimal
- No references to `map.yaml` remain in codebase except in documentation comments
- Script executes without errors and maintains all expected functionality
