# ai-ley.py Changelog

## Updates - October 3, 2025

### Enhanced Git Fetch Behavior

#### Changes Made:

1. **`--update` flag improvements:**

   - Now **always fetches** the ai-ley repository before checking for changes
   - Fetches **all external repositories** configured in `ai-ley.map.yaml`
   - Automatically updates content from all **portable repositories**
   - Provides clear visual feedback with progress indicators

2. **`--contribute` flag improvements:**

   - Now **always fetches** the ai-ley repository first before contributing
   - Ensures local repository is up-to-date to avoid merge conflicts
   - Reduces risk of overwriting recent changes

3. **New methods added:**
   - `fetch_all_external_repos()` - Fetches all configured external repositories
   - `update_all_portable_repos()` - Updates content from all portable repos automatically

---

## Behavior Changes

### Before:

```bash
# Update only checked if repo existed locally
./ai-ley.py --update

# Contribute only checked if repo existed locally
./ai-ley.py --contribute
```

### After:

```bash
# Update now:
# 1. Fetches ai-ley repo (git pull if exists, git clone if not)
# 2. Updates shared/builder/docs from ai-ley
# 3. Fetches ALL external repos from config
# 4. Ports content from all portable repos
./ai-ley.py --update

# Contribute now:
# 1. Fetches ai-ley repo first (ensures latest changes)
# 2. Creates contribution branch
# 3. Stages and commits changes
# 4. Pushes to origin
./ai-ley.py --contribute
```

---

## Technical Details

### Modified Functions:

#### 1. `update_shared_content()`

**Before:**

```python
# Only fetched if repo didn't exist
if not (self.external_dir / "ai-ley").exists():
    print("AI-LEY repository not found locally. Fetching...")
    if not self.fetch_repo("ai-ley"):
        return
```

**After:**

```python
# Always fetches to get latest changes
print("Fetching latest changes from ai-ley repository...")
if not self.fetch_repo("ai-ley"):
    print("Failed to fetch ai-ley repository.")
    return
```

#### 2. `contribute_changes()`

**Before:**

```python
# Only fetched if repo didn't exist
if not (self.external_dir / "ai-ley").exists():
    print("AI-LEY repository not found locally. Fetching...")
    if not self.fetch_repo("ai-ley"):
        return
```

**After:**

```python
# Always fetches before contributing
print("Fetching latest changes from ai-ley repository before contributing...")
if not self.fetch_repo("ai-ley"):
    print("Failed to fetch ai-ley repository.")
    return
```

#### 3. New: `fetch_all_external_repos()`

```python
def fetch_all_external_repos(self) -> None:
    """Fetch all external repositories from configuration."""
    # Reads git_repos from config
    # Fetches each repo (except ai-ley which is handled separately)
    # Provides success/failure counts
```

#### 4. New: `update_all_portable_repos()`

```python
def update_all_portable_repos(self) -> None:
    """Update content from all portable repositories."""
    # Finds all repos marked as portable=True
    # Automatically ports their content using folder mappings
```

---

## Example Output

### Running `--update`:

```bash
$ ./ai-ley.py --update

Fetching latest changes from ai-ley repository...
Updating existing repository: ai-ley
Successfully fetched: ai-ley

Updated: instructions/tools/seo/seo-report.instructions.md
Updated 3 files in instructions
No updates needed for personas
Updated 1 files in prompts
Updated 5 files in builder
No updates needed for docs

======================================================================
Updating external repositories...
======================================================================

Fetching all external repositories...

📥 Fetching example-repo-1...
Cloning repository: example-repo-1
Successfully fetched: example-repo-1

📥 Fetching example-repo-2...
Updating existing repository: example-repo-2
Successfully fetched: example-repo-2

✅ Successfully fetched: 2 repositories

Updating content from portable repositories...

📦 Porting content from example-repo-1...
Ported directory: src/templates -> .ai-ley/shared/templates/example

======================================================================
✅ Update complete!
======================================================================
```

---

## Benefits

### 1. **Prevents Stale Data**

- Always gets latest changes before updating local content
- Reduces version conflicts and inconsistencies

### 2. **Comprehensive Updates**

- Single `--update` command now handles all configured repos
- No need to manually fetch each external repo

### 3. **Safer Contributions**

- Fetching before contributing prevents overwriting recent changes
- Reduces merge conflicts and failed pull requests

### 4. **Better User Experience**

- Clear progress indicators with emoji icons
- Success/failure summaries
- Organized output with visual separators

---

## Migration Guide

### For Existing Users:

No migration needed! The changes are **fully backward compatible**.

**What to expect:**

- `--update` will take longer (fetches all repos)
- `--contribute` will always fetch first (adds ~2-5 seconds)
- More output/feedback during operations

**If you want old behavior:**

- Use `--fetch ai-ley` for just ai-ley updates
- Use `--port REPO_NAME` for individual repo porting

---

## Configuration Requirements

### ai-ley.map.yaml Format:

```yaml
git_repos:
  ai-ley:
    url: https://github.com/yourusername/ai-ley.git
    branch: main
    portable: false

  external-repo-1:
    url: https://github.com/yourusername/external-repo.git
    branch: main
    portable: true
    folders:
      - 'src/templates:.ai-ley/shared/templates/external'
      - 'docs/guides:.ai-ley/docs/external-guides'

  external-repo-2:
    url: https://github.com/example/another-repo.git
    branch: develop
    portable: false
```

**Key Points:**

- `portable: true` - Repo will be automatically ported during `--update`
- `folders` - List of `source:target` mappings for portable repos
- All repos (except ai-ley) will be fetched during `--update`

---

## Testing

### Test Cases Validated:

1. ✅ Update with existing ai-ley repo (git pull)
2. ✅ Update without ai-ley repo (git clone)
3. ✅ Update with multiple external repos
4. ✅ Update with portable repos (auto-port)
5. ✅ Contribute with existing ai-ley repo (fetch first)
6. ✅ Contribute without ai-ley repo (clone first)
7. ✅ Error handling for inaccessible repos
8. ✅ Skip patterns maintained (node_modules, .git, etc.)

---

## Future Enhancements

Potential improvements for future versions:

- [ ] Add `--update-only-ailey` flag for faster ai-ley-only updates
- [ ] Add `--skip-external` flag to skip external repo fetching
- [ ] Parallel fetching of multiple repos (threading/multiprocessing)
- [ ] Progress bars for large repo clones
- [ ] Configurable fetch timeout limits
- [ ] Selective repo updates (`--update-repos repo1,repo2`)
- [ ] Dry-run mode to preview changes before updating

---

## Questions or Issues?

If you encounter any problems with the new fetch behavior:

1. Check `.ai-ley/external/` directory for repo clones
2. Verify `ai-ley.map.yaml` configuration format
3. Test individual repo fetch: `./ai-ley.py --fetch REPO_NAME`
4. Check git credentials and network connectivity

---

**Version:** 1.1.0  
**Date:** October 3, 2025  
**Compatibility:** Fully backward compatible with existing installations
