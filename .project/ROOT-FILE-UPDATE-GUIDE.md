# File Update Feature - Quick Reference

## Overview

The `--update` command now automatically updates root-level `ai-ley.*` files and shared instruction markdown files from the ai-ley repository.

## Files Managed

### ✅ Root-Level Auto-Updated Files:

- **ai-ley.readme** - Documentation and getting started guide
- **ai-ley.map.yaml** - Repository configuration and mappings

### ✅ Shared Instruction Auto-Updated Files:

- **global-instructions.md** - Core AI system instructions (.ai-ley/shared/)
- **persona-conflict-flow.md** - Persona conflict resolution workflow (.ai-ley/shared/)

### ⚠️ Manual Update Required:

- **ai-ley.py** - The script itself (cannot auto-update while running)

## How It Works

When you run `./ai-ley.py --update`, the script now:

1. Fetches the ai-ley repository
2. Updates shared/builder/docs directories
3. **NEW:** Updates root `ai-ley.*` files
4. **NEW:** Updates shared `*.md` instruction files
5. Fetches all external repositories
6. Ports content from portable repositories

## Update Process

### For ai-ley.readme, ai-ley.map.yaml, and shared .md files:

```
✅ Automatic Update
├─ Compares MD5 hashes
├─ Copies if different
└─ Shows status: ✅ Updated or ✓ Up to date
```

Files updated automatically:

- `ai-ley.readme` (root level)
- `ai-ley.map.yaml` (root level)
- `.ai-ley/shared/global-instructions.md` (shared instructions)
- `.ai-ley/shared/persona-conflict-flow.md` (shared instructions)

### For ai-ley.py:

```
⚠️ Manual Update Required
├─ Detects new version
├─ Shows notification with instructions
└─ User copies file manually
```

## Example Output

```bash
$ ./ai-ley.py --update

Fetching latest changes from ai-ley repository...
Successfully fetched: ai-ley

Updated 3 files in instructions
No updates needed for personas
Updated 1 files in prompts
Updated 5 files in builder
No updates needed for docs

Updating root-level ai-ley.* files...
✅ Updated: ai-ley.readme
✓ ai-ley.map.yaml is up to date
⚠️  ai-ley.py: New version available
    To update, run: cp .ai-ley/external/ai-ley/ai-ley.py ./ai-ley.py
    Or manually backup and replace the file.

Updated 1 root-level file(s)

Updating shared markdown files (.ai-ley/shared/*.md)...
✅ Updated: global-instructions.md
✓ persona-conflict-flow.md is up to date

Updated 1 shared markdown file(s)
```

## Updating ai-ley.py Manually

### Option 1: Simple Copy

```bash
cp .ai-ley/external/ai-ley/ai-ley.py ./ai-ley.py
```

### Option 2: With Backup

```bash
cp ai-ley.py ai-ley.py.backup
cp .ai-ley/external/ai-ley/ai-ley.py ./ai-ley.py
```

### Option 3: Review Changes First

```bash
# View differences
diff ai-ley.py .ai-ley/external/ai-ley/ai-ley.py

# Or use a visual diff tool
code --diff ai-ley.py .ai-ley/external/ai-ley/ai-ley.py
```

## Safety Features

### Why ai-ley.py Isn't Auto-Updated:

1. **Prevents Script Corruption** - Overwriting a running Python script can crash it
2. **User Control** - Review changes before updating
3. **Customization Safety** - Preserve any local modifications

### Hash-Based Updates:

- Only updates files that have actually changed
- Avoids unnecessary file operations
- Preserves file timestamps when possible

### Error Handling:

- Gracefully handles missing source files
- Reports update failures with clear messages
- Continues processing other files on error

## Integration Details

### New Methods Added:

#### `update_root_ailey_files()`

```python
def update_root_ailey_files(self) -> None:
    """Update root-level ai-ley.* files from ai-ley repository."""
    # Called automatically during update_shared_content()
    # Processes: ai-ley.py, ai-ley.readme, ai-ley.map.yaml
    # Uses MD5 hash comparison
    # Special handling for ai-ley.py (notify only)
```

#### `update_shared_md_files()`

```python
def update_shared_md_files(self) -> None:
    """Update global and flow instruction markdown files in .ai-ley/shared/."""
    # Called automatically during update_shared_content()
    # Processes: global-instructions.md, persona-conflict-flow.md
    # Uses MD5 hash comparison
    # Critical for AI behavior consistency
```

### Called From:

```python
def update_shared_content(self) -> None:
    # ... updates shared/builder/docs ...

    # Update root-level ai-ley.* files
    self.update_root_ailey_files()  # <-- NEW in v1.2.0

    # Update shared markdown files
    self.update_shared_md_files()  # <-- NEW in v1.3.0
```

## Troubleshooting

### "Source file not found" Error:

```bash
# Ensure ai-ley repo is cloned
./ai-ley.py --fetch ai-ley

# Check if file exists in repo
ls -la .ai-ley/external/ai-ley/ai-ley.*
```

### Updates Not Detected:

```bash
# Force re-fetch of ai-ley repo
rm -rf .ai-ley/external/ai-ley
./ai-ley.py --update
```

### Permission Issues:

```bash
# Check file permissions
ls -l ai-ley.*

# Fix if needed
chmod 644 ai-ley.readme ai-ley.map.yaml
chmod 755 ai-ley.py
```

## Best Practices

### Regular Updates:

```bash
# Weekly or before major work
./ai-ley.py --update

# Check for ai-ley.py updates
grep "⚠️  ai-ley.py" <(./ai-ley.py --update)
```

### Before Contributing:

```bash
# Ensure you have latest version
./ai-ley.py --update

# Update ai-ley.py if notified
# Then contribute
./ai-ley.py --contribute
```

### After Cloning Project:

```bash
# First-time setup
./ai-ley.py --init

# Then update everything
./ai-ley.py --update
```

## Why Shared Markdown Files Matter

### global-instructions.md

- **Purpose**: Defines core AI system behavior across all projects
- **Impact**: Changes affect how AI agents interpret and execute tasks
- **Importance**: Keeping this updated ensures consistent AI behavior
- **Location**: `.ai-ley/shared/global-instructions.md`

### persona-conflict-flow.md

- **Purpose**: Defines how multiple AI personas resolve conflicts
- **Impact**: Improves multi-agent collaboration and decision making
- **Importance**: Critical for projects using multiple AI personalities
- **Location**: `.ai-ley/shared/persona-conflict-flow.md`

## Version History

- **v1.3.0** (Oct 4, 2025) - Added shared markdown file updates
- **v1.2.0** (Oct 3-4, 2025) - Added root file updates
- **v1.1.0** (Oct 3, 2025) - Added fetch-before-update behavior
- **v1.0.0** - Initial release

---

**Quick Command Reference:**

```bash
# Update everything (including root files)
./ai-ley.py --update

# Manually update ai-ley.py after notification
cp .ai-ley/external/ai-ley/ai-ley.py ./ai-ley.py

# View what changed in ai-ley.py
diff ai-ley.py .ai-ley/external/ai-ley/ai-ley.py
```
