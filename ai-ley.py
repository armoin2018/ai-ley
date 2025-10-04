#!/usr/bin/env python3
"""
AI-LEY: AI Building Resource Toolkit
A tool for managing AI instruction sets, personas, prompts, builder tools, and documentation.
"""

import argparse
import hashlib
import os
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple

import yaml


class AILeyManager:
    """Main class for managing AI-LEY repositories and content."""
    
    def __init__(self, config_path: str = "ai-ley.map.yaml"):
        self.config_path = config_path
        self.config = self._load_config()
        self.base_dir = Path.cwd()
        self.external_dir = self.base_dir / ".ai-ley" / "external"
        self.shared_dir = self.base_dir / ".ai-ley" / "shared"
        self.builder_dir = self.base_dir / ".ai-ley" / "builder"
        self.docs_dir = self.base_dir / ".ai-ley" / "docs"
        
        # Ensure directories exist
        self.external_dir.mkdir(parents=True, exist_ok=True)
        self.shared_dir.mkdir(parents=True, exist_ok=True)
        self.builder_dir.mkdir(parents=True, exist_ok=True)
        self.docs_dir.mkdir(parents=True, exist_ok=True)
    
    def _load_config(self) -> Dict:
        """Load configuration from YAML file."""
        try:
            with open(self.config_path, 'r') as f:
                return yaml.safe_load(f)
        except FileNotFoundError:
            print(f"Error: Configuration file '{self.config_path}' not found.")
            sys.exit(1)
        except yaml.YAMLError as e:
            print(f"Error parsing YAML configuration: {e}")
            sys.exit(1)
    
    def list_repos(self) -> None:
        """List all available repositories."""
        git_repos = self.config.get('git_repos', {})
        if not git_repos:
            print("No repositories configured.")
            return
        
        print("Available repositories:")
        for repo_name, repo_config in git_repos.items():
            url = repo_config.get('url', 'N/A')
            branch = repo_config.get('branch', 'main')
            portable = repo_config.get('portable', False)
            print(f"  {repo_name}")
            print(f"    URL: {url}")
            print(f"    Branch: {branch}")
            print(f"    Portable: {portable}")
            if 'folders' in repo_config:
                print(f"    Folders: {repo_config['folders']}")
            print()
    
    def fetch_repo(self, repo_name: str) -> bool:
        """Fetch a specific repository."""
        git_repos = self.config.get('git_repos', {})
        
        if repo_name not in git_repos:
            print(f"Error: Repository '{repo_name}' not found in configuration.")
            return False
        
        repo_config = git_repos[repo_name]
        url = repo_config.get('url')
        branch = repo_config.get('branch', 'main')
        
        if not url:
            print(f"Error: No URL specified for repository '{repo_name}'.")
            return False
        
        repo_path = self.external_dir / repo_name
        
        try:
            if repo_path.exists():
                print(f"Updating existing repository: {repo_name}")
                subprocess.run(['git', 'pull'], cwd=repo_path, check=True, 
                             capture_output=True, text=True)
            else:
                print(f"Cloning repository: {repo_name}")
                subprocess.run(['git', 'clone', '-b', branch, url, str(repo_path)], 
                             check=True, capture_output=True, text=True)
            
            print(f"Successfully fetched: {repo_name}")
            return True
            
        except subprocess.CalledProcessError as e:
            print(f"Error fetching repository '{repo_name}': {e}")
            if "Permission denied" in str(e) or "not found" in str(e.stderr if e.stderr else ""):
                print(f"Skipping inaccessible repository: {repo_name}")
            return False
        except Exception as e:
            print(f"Unexpected error fetching '{repo_name}': {e}")
            return False
    
    def _calculate_md5_hash(self, file_path: Path) -> str:
        """Calculate MD5 hash of a file."""
        hash_md5 = hashlib.md5()
        try:
            with open(file_path, "rb") as f:
                for chunk in iter(lambda: f.read(4096), b""):
                    hash_md5.update(chunk)
            return hash_md5.hexdigest()
        except Exception:
            return ""
    
    def _should_skip_file(self, file_path: Path, dir_name: str) -> bool:
        """Check if a file should be skipped during updates/contributions."""
        file_name = file_path.name
        relative_path = str(file_path)
        
        # Skip common build artifacts and temporary files
        skip_patterns = [
            'node_modules/',
            '.next/',
            'dist/',
            'build/',
            '.git/',
            '__pycache__/',
            '.DS_Store',
            '*.tmp',
            '*.log',
            'package-lock.json',  # Let users manage their own lock files
            'yarn.lock',
        ]
        
        # Additional patterns specific to builder directory
        if dir_name == "builder":
            skip_patterns.extend([
                '.env.local',
                '.env.production',
                'public/exports/',  # User-generated exports
            ])
        
        for pattern in skip_patterns:
            if pattern.endswith('/') and f"{pattern}" in relative_path:
                return True
            elif not pattern.endswith('/') and (
                file_name == pattern or 
                (pattern.startswith('*.') and file_name.endswith(pattern[1:]))
            ):
                return True
        
        return False
    
    def _get_folder_hashes(self, folder_path: Path) -> Dict[str, str]:
        """Get MD5 hashes for all files in a folder, excluding skipped files."""
        hashes = {}
        if not folder_path.exists():
            return hashes
        
        # Determine directory name for skip logic
        dir_name = folder_path.name
        if folder_path.parent.name == ".ai-ley":
            dir_name = folder_path.name  # builder, docs, shared
        
        for file_path in folder_path.rglob("*"):
            if file_path.is_file():
                relative_path = file_path.relative_to(folder_path)
                
                # Skip files that shouldn't be tracked
                if self._should_skip_file(file_path, dir_name):
                    continue
                
                hashes[str(relative_path)] = self._calculate_md5_hash(file_path)
        
        return hashes
    
    def update_shared_content(self) -> None:
        """Update AI-LEY content from ai-ley repository (shared, builder, docs)."""
        # Always fetch/update ai-ley repo first to get latest changes
        print("Fetching latest changes from ai-ley repository...")
        if not self.fetch_repo("ai-ley"):
            print("Failed to fetch ai-ley repository.")
            return
        
        ai_ley_repo_path = self.external_dir / "ai-ley"
        ai_ley_base = self.base_dir / ".ai-ley"
        
        # Update shared content (instructions, personas, prompts)
        source_base = ai_ley_repo_path / ".ai-ley" / "shared"
        target_base = self.shared_dir

        for content_type in ["indexes", "instructions", "md5sums", "personas", "prompts", "templates", "uml-flows", "variables"]:
            source_dir = source_base / content_type
            target_dir = target_base / content_type
            
            if not source_dir.exists():
                print(f"Source directory not found: {source_dir}")
                continue
            
            target_dir.mkdir(parents=True, exist_ok=True)
            
            # Get hashes for comparison
            source_hashes = self._get_folder_hashes(source_dir)
            target_hashes = self._get_folder_hashes(target_dir)
            
            updated_count = 0
            for relative_path, source_hash in source_hashes.items():
                source_file = source_dir / relative_path
                target_file = target_dir / relative_path
                
                # Update if file doesn't exist or hash differs
                if (not target_file.exists() or 
                    target_hashes.get(relative_path) != source_hash):
                    
                    target_file.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(source_file, target_file)
                    updated_count += 1
                    print(f"Updated: {content_type}/{relative_path}")
            
            if updated_count == 0:
                print(f"No updates needed for {content_type}")
            else:
                print(f"Updated {updated_count} files in {content_type}")
        
        # Update builder directory
        source_builder = ai_ley_repo_path / ".ai-ley" / "builder"
        target_builder = ai_ley_base / "builder"
        
        if source_builder.exists():
            self._update_directory(source_builder, target_builder, "builder")
        else:
            print("Builder directory not found in source repository")
        
        # Update docs directory
        source_docs = ai_ley_repo_path / ".ai-ley" / "docs"
        target_docs = ai_ley_base / "docs"
        
        if source_docs.exists():
            self._update_directory(source_docs, target_docs, "docs")
        else:
            print("Docs directory not found in source repository")
        
        # Update root-level ai-ley.* files
        self.update_root_ailey_files()
        
        # Update shared markdown files (global-instructions.md, persona-conflict-flow.md)
        self.update_shared_md_files()
    
    def _update_directory(self, source_dir: Path, target_dir: Path, dir_name: str) -> None:
        """Update a complete directory with hash comparison."""
        if not source_dir.exists():
            print(f"Source directory not found: {source_dir}")
            return
        
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Get hashes for comparison
        source_hashes = self._get_folder_hashes(source_dir)
        target_hashes = self._get_folder_hashes(target_dir)
        
        updated_count = 0
        for relative_path, source_hash in source_hashes.items():
            source_file = source_dir / relative_path
            target_file = target_dir / relative_path
            
            # Update if file doesn't exist or hash differs
            if (not target_file.exists() or 
                target_hashes.get(relative_path) != source_hash):
                
                target_file.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source_file, target_file)
                updated_count += 1
                print(f"Updated: {dir_name}/{relative_path}")
        
        if updated_count == 0:
            print(f"No updates needed for {dir_name}")
        else:
            print(f"Updated {updated_count} files in {dir_name}")
    
    def update_root_ailey_files(self) -> None:
        """Update root-level ai-ley.* files from ai-ley repository."""
        ai_ley_repo_path = self.external_dir / "ai-ley"
        
        if not ai_ley_repo_path.exists():
            print("AI-LEY repository not found. Cannot update root files.")
            return
        
        print("\nUpdating root-level ai-ley.* files...")
        
        # List of root files to update
        root_files = [
            "ai-ley.py",
            "ai-ley.readme",
            "ai-ley.map.yaml"
        ]
        
        updated_count = 0
        for filename in root_files:
            source_file = ai_ley_repo_path / filename
            target_file = self.base_dir / filename
            
            if not source_file.exists():
                print(f"Source file not found: {filename} (skipping)")
                continue
            
            # Calculate hashes to check if update is needed
            source_hash = self._calculate_md5_hash(source_file)
            target_hash = self._calculate_md5_hash(target_file) if target_file.exists() else ""
            
            if source_hash != target_hash:
                # Special handling for ai-ley.py - don't overwrite if this script is running
                if filename == "ai-ley.py":
                    print(f"⚠️  {filename}: New version available")
                    print(f"    To update, run: cp .ai-ley/external/ai-ley/{filename} ./{filename}")
                    print(f"    Or manually backup and replace the file.")
                    continue
                
                # For other files, update normally
                try:
                    shutil.copy2(source_file, target_file)
                    updated_count += 1
                    print(f"✅ Updated: {filename}")
                except Exception as e:
                    print(f"❌ Failed to update {filename}: {e}")
            else:
                print(f"✓ {filename} is up to date")
        
        if updated_count > 0:
            print(f"\nUpdated {updated_count} root-level file(s)")
        else:
            print("\nAll root-level files are up to date")
    
    def update_shared_md_files(self) -> None:
        """Update global and flow instruction markdown files in .ai-ley/shared/."""
        ai_ley_repo_path = self.external_dir / "ai-ley"
        
        if not ai_ley_repo_path.exists():
            print("AI-LEY repository not found. Cannot update shared .md files.")
            return
        
        print("\nUpdating shared markdown files (.ai-ley/shared/*.md)...")
        
        # List of shared markdown files to update
        shared_md_files = [
            "global-instructions.md",
            "persona-conflict-flow.md"
        ]
        
        source_shared = ai_ley_repo_path / ".ai-ley" / "shared"
        target_shared = self.base_dir / ".ai-ley" / "shared"
        
        if not source_shared.exists():
            print("Source .ai-ley/shared directory not found.")
            return
        
        target_shared.mkdir(parents=True, exist_ok=True)
        
        updated_count = 0
        for filename in shared_md_files:
            source_file = source_shared / filename
            target_file = target_shared / filename
            
            if not source_file.exists():
                print(f"Source file not found: {filename} (skipping)")
                continue
            
            # Calculate hashes to check if update is needed
            source_hash = self._calculate_md5_hash(source_file)
            target_hash = self._calculate_md5_hash(target_file) if target_file.exists() else ""
            
            if source_hash != target_hash:
                try:
                    shutil.copy2(source_file, target_file)
                    updated_count += 1
                    print(f"✅ Updated: {filename}")
                except Exception as e:
                    print(f"❌ Failed to update {filename}: {e}")
            else:
                print(f"✓ {filename} is up to date")
        
        if updated_count > 0:
            print(f"\nUpdated {updated_count} shared markdown file(s)")
        else:
            print("\nAll shared markdown files are up to date")
    
    def fetch_all_external_repos(self) -> List[str]:
        """Fetch all external repositories from configuration (only if they already exist).
        
        Returns:
            List of repository names that were successfully fetched/updated.
        """
        git_repos = self.config.get('git_repos', {})
        
        if not git_repos:
            print("No external repositories configured.")
            return []
        
        print("\nFetching existing external repositories...")
        updated_repos = []
        fail_count = 0
        skipped_count = 0
        
        for repo_name in git_repos.keys():
            if repo_name == "ai-ley":
                continue  # Skip ai-ley repo as it's handled separately
            
            repo_path = self.external_dir / repo_name
            
            # Only fetch if the repository already exists locally
            if not repo_path.exists():
                print(f"⏭️  Skipping {repo_name} (not yet cloned locally)")
                skipped_count += 1
                continue
            
            print(f"\n📥 Fetching {repo_name}...")
            if self.fetch_repo(repo_name):
                updated_repos.append(repo_name)
            else:
                fail_count += 1
        
        success_count = len(updated_repos)
        print(f"\n✅ Successfully fetched: {success_count} repositories")
        if skipped_count > 0:
            print(f"⏭️  Skipped (not yet cloned): {skipped_count} repositories")
        if fail_count > 0:
            print(f"⚠️  Failed to fetch: {fail_count} repositories")
        
        return updated_repos
    
    def update_all_portable_repos(self, updated_repos: Optional[List[str]] = None) -> None:
        """Update content from portable repositories that were fetched.
        
        Args:
            updated_repos: List of repository names that were fetched/updated.
                          If None, will port from all existing portable repos.
        """
        git_repos = self.config.get('git_repos', {})
        portable_repos = [name for name, config in git_repos.items() 
                         if config.get('portable', False) and name != "ai-ley"]
        
        if not portable_repos:
            print("No portable repositories configured.")
            return
        
        # Filter to only repos that exist locally and were updated (if list provided)
        repos_to_port = []
        for repo_name in portable_repos:
            repo_path = self.external_dir / repo_name
            
            # Skip if repo doesn't exist locally
            if not repo_path.exists():
                continue
            
            # If updated_repos list provided, only port those that were updated
            if updated_repos is not None and repo_name not in updated_repos:
                continue
            
            repos_to_port.append(repo_name)
        
        if not repos_to_port:
            print("\nNo portable repositories to update.")
            return
        
        print("\nUpdating content from portable repositories...")
        for repo_name in repos_to_port:
            print(f"\n📦 Porting content from {repo_name}...")
            self.port_content(repo_name, skip_fetch=True)
    
    def contribute_changes(self) -> None:
        """Contribute changes back to ai-ley repository (shared, builder, docs)."""
        # Always fetch ai-ley repo first to get latest changes before contributing
        print("Fetching latest changes from ai-ley repository before contributing...")
        if not self.fetch_repo("ai-ley"):
            print("Failed to fetch ai-ley repository.")
            return
        
        repo_path = self.external_dir / "ai-ley"
        local_ai_ley_base = self.base_dir / ".ai-ley"
        target_base = repo_path / ".ai-ley"
        
        # Create branch name based on date
        from datetime import datetime
        branch_name = f"contribution-{datetime.now().strftime('%Y%m%d-%H%M%S')}"
        
        try:
            # Create and checkout new branch
            subprocess.run(['git', 'checkout', '-b', branch_name], 
                         cwd=repo_path, check=True)
            
            changes_made = False
            
            # Contribute shared content (instructions, personas, prompts)
            source_base = local_ai_ley_base / "shared"
            target_shared_base = target_base / "shared"
            for content_type in ["indexes", "instructions", "md5sums", "personas", "prompts", "templates", "uml-flows", "variables"]:
                source_dir = source_base / content_type
                target_dir = target_shared_base / content_type
                
                if not source_dir.exists():
                    continue
                
                target_dir.mkdir(parents=True, exist_ok=True)
                
                # Get hashes for comparison
                source_hashes = self._get_folder_hashes(source_dir)
                target_hashes = self._get_folder_hashes(target_dir)
                
                for relative_path, source_hash in source_hashes.items():
                    source_file = source_dir / relative_path
                    target_file = target_dir / relative_path
                    
                    # Update if file doesn't exist or hash differs
                    if (not target_file.exists() or 
                        target_hashes.get(relative_path) != source_hash):
                        
                        target_file.parent.mkdir(parents=True, exist_ok=True)
                        shutil.copy2(source_file, target_file)
                        changes_made = True
                        print(f"Staged for contribution: shared/{content_type}/{relative_path}")
            
            # Contribute builder directory
            source_builder = local_ai_ley_base / "builder"
            target_builder = target_base / "builder"
            
            if source_builder.exists():
                changes_made = self._contribute_directory(source_builder, target_builder, "builder") or changes_made
            
            # Contribute docs directory
            source_docs = local_ai_ley_base / "docs"
            target_docs = target_base / "docs"
            
            if source_docs.exists():
                changes_made = self._contribute_directory(source_docs, target_docs, "docs") or changes_made
            
            if not changes_made:
                print("No changes to contribute.")
                subprocess.run(['git', 'checkout', 'main'], cwd=repo_path, check=True)
                subprocess.run(['git', 'branch', '-d', branch_name], cwd=repo_path, check=True)
                return
            
            # Add, commit, and push changes
            subprocess.run(['git', 'add', '.'], cwd=repo_path, check=True)
            subprocess.run(['git', 'commit', '-m', 
                          'Contribution: Updated AI-LEY content from local changes'], 
                         cwd=repo_path, check=True)
            subprocess.run(['git', 'push', 'origin', branch_name], 
                         cwd=repo_path, check=True)
            
            print(f"Changes pushed to branch: {branch_name}")
            print("Please create a pull request manually on the repository website.")
            
        except subprocess.CalledProcessError as e:
            print(f"Error during contribution process: {e}")
        except OSError as e:
            print(f"File system error during contribution: {e}")
    
    def _contribute_directory(self, source_dir: Path, target_dir: Path, dir_name: str) -> bool:
        """Contribute changes from a complete directory with hash comparison."""
        if not source_dir.exists():
            return False
        
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Get hashes for comparison
        source_hashes = self._get_folder_hashes(source_dir)
        target_hashes = self._get_folder_hashes(target_dir)
        
        changes_made = False
        for relative_path, source_hash in source_hashes.items():
            source_file = source_dir / relative_path
            target_file = target_dir / relative_path
            
            # Update if file doesn't exist or hash differs
            if (not target_file.exists() or 
                target_hashes.get(relative_path) != source_hash):
                
                target_file.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source_file, target_file)
                changes_made = True
                print(f"Staged for contribution: {dir_name}/{relative_path}")
        
        return changes_made
    
    def port_content(self, repo_name: str, skip_fetch: bool = False) -> None:
        """Port content from a portable repository.
        
        Args:
            repo_name: Name of the repository to port content from.
            skip_fetch: If True, skip fetching the repo if it doesn't exist locally.
        """
        git_repos = self.config.get('git_repos', {})
        
        if repo_name not in git_repos:
            print(f"Error: Repository '{repo_name}' not found in configuration.")
            return
        
        repo_config = git_repos[repo_name]
        
        if not repo_config.get('portable', False):
            print(f"Repository '{repo_name}' is not marked as portable.")
            return
        
        repo_path = self.external_dir / repo_name
        
        if not repo_path.exists():
            if skip_fetch:
                print(f"Repository '{repo_name}' not found locally. Skipping.")
                return
            print(f"Repository '{repo_name}' not found locally. Fetching...")
            if not self.fetch_repo(repo_name):
                return
        
        folders = repo_config.get('folders', [])
        if not folders:
            # Fallback to src/target if available
            src = repo_config.get('src')
            target = repo_config.get('target')
            if src and target:
                folders = [f"{src}:{target}"]
        
        if not folders:
            print(f"No portable folders configured for '{repo_name}'.")
            return
        
        for folder_mapping in folders:
            if ':' not in folder_mapping:
                print(f"Invalid folder mapping format: {folder_mapping}")
                continue
            
            source_rel, target_rel = folder_mapping.split(':', 1)
            source_path = repo_path / source_rel
            target_path = self.base_dir / target_rel
            
            if not source_path.exists():
                print(f"Source path not found: {source_path}")
                continue
            
            try:
                target_path.parent.mkdir(parents=True, exist_ok=True)
                
                if source_path.is_file():
                    shutil.copy2(source_path, target_path)
                    print(f"Ported file: {source_rel} -> {target_rel}")
                else:
                    if target_path.exists():
                        shutil.rmtree(target_path)
                    shutil.copytree(source_path, target_path)
                    print(f"Ported directory: {source_rel} -> {target_rel}")
                    
            except OSError as e:
                print(f"Error porting {source_rel} -> {target_rel}: {e}")

    def initialize_project(self) -> None:
        """Initialize a new project with AI-LEY structure."""
        print("🚀 Initializing AI-LEY project structure...")
        
        # Create directory structure
        directories = [
            ".ai-ley/shared/instructions",
            ".ai-ley/shared/personas", 
            ".ai-ley/shared/prompts",
            ".ai-ley/shared/templates",
            ".ai-ley/shared/uml-flows",
            ".ai-ley/shared/variables",
            ".ai-ley/builder",
            ".ai-ley/docs",
            ".ai-ley/external",
            ".github/prompts",
            ".claude/commands",
            ".opencode/commands",
            ".project/plan",
            ".project/tests",
            "src/docs",
            "src/assets"
        ]
        
        for directory in directories:
            dir_path = self.base_dir / directory
            dir_path.mkdir(parents=True, exist_ok=True)
            print(f"✅ Created: {directory}")
        
        # Create basic configuration files
        self._create_initial_config_files()
        
        # Fetch and update from main repository
        print("📥 Fetching latest AI-LEY content...")
        if self.fetch_repo("ai-ley"):
            self.update_shared_content()
        else:
            print("⚠️  Could not fetch AI-LEY repository. Creating minimal structure.")
        
        print("🎉 AI-LEY project initialized successfully!")
        print("💡 Next steps:")
        print("   1. Run: ./ai-ley.py --list (to see available repositories)")
        print("   2. Run: ./ai-ley.py --update (to sync latest content)")
        print("   3. Start building with: /ask 'Your project idea'")
    
    def _create_initial_config_files(self) -> None:
        """Create initial configuration files for AI-LEY."""
        
        # Create basic folder-structure.yaml
        folder_structure_content = """# AI-LEY Folder Structure Variables
folders:
  # Core project structure
  project: .project/
  plan: .project/plan/
  tests: .project/tests/
  
  # Source code organization  
  src: src/
  docs: src/docs/
  assets: src/assets/
  
  # AI-LEY system directories
  ailey: .ai-ley/
  shared: .ai-ley/shared/
  builder: .ai-ley/builder/
  external: .ai-ley/external/

files:
  # Project planning files
  ask: .project/ASK.md
  requirements: .project/REQUIREMENTS.md
  plan: .project/PLAN.md
  
  # Documentation files  
  changelog: CHANGELOG.md
  
  # Configuration files
  folder_structure: .ai-ley/shared/variables/folder-structure.yaml
"""
        
        variables_file = self.base_dir / ".ai-ley/shared/variables/folder-structure.yaml"
        variables_file.parent.mkdir(parents=True, exist_ok=True)
        
        if not variables_file.exists():
            with open(variables_file, 'w', encoding='utf-8') as f:
                f.write(folder_structure_content)
            print(f"✅ Created: {variables_file}")
        
        # Verify README template exists
        readme_template_file = Path(__file__).parent / "ai-ley.readme"
        if readme_template_file.exists():
            print("📝 README template available in ai-ley.readme")
        else:
            print("⚠️  README template (ai-ley.readme) not found")
        
        # Note: README.md creation is left to project-specific initialization


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="AI-LEY: AI Learning Environment Yielder - Manage AI instruction sets, personas, and prompts"
    )
    
    parser.add_argument(
        '--config',
        default='ai-ley.map.yaml',
        help='Configuration file path (default: ai-ley.map.yaml)'
    )
    
    parser.add_argument(
        '--init',
        action='store_true',
        help='Initialize new project with AI-LEY structure'
    )
    
    parser.add_argument(
        '--fetch',
        metavar='REPO_NAME',
        help='Fetch a specific repository'
    )
    
    parser.add_argument(
        '--list',
        action='store_true',
        help='List all available repositories'
    )
    
    parser.add_argument(
        '--update',
        action='store_true',
        help='Update AI-LEY content from ai-ley repository (shared, builder, docs)'
    )
    
    parser.add_argument(
        '--contribute',
        action='store_true',
        help='Contribute changes back to ai-ley repository (shared, builder, docs)'
    )
    
    parser.add_argument(
        '--port',
        metavar='REPO_NAME',
        help='Port content from a portable repository'
    )
    
    args = parser.parse_args()
    
    # Show help if no arguments provided
    if len(sys.argv) == 1:
        parser.print_help()
        return
    
    try:
        manager = AILeyManager(args.config)
        
        if args.init:
            manager.initialize_project()
        elif args.list:
            manager.list_repos()
        elif args.fetch:
            manager.fetch_repo(args.fetch)
        elif args.update:
            # First update ai-ley content
            manager.update_shared_content()
            
            # Then fetch and update all external repositories
            print("\n" + "="*70)
            print("Updating external repositories...")
            print("="*70)
            updated_repos = manager.fetch_all_external_repos()
            manager.update_all_portable_repos(updated_repos)
            
            print("\n" + "="*70)
            print("✅ Update complete!")
            print("="*70)
        elif args.contribute:
            manager.contribute_changes()
        elif args.port:
            manager.port_content(args.port)
        else:
            parser.print_help()
            
    except KeyboardInterrupt:
        print("\nOperation cancelled by user.")
        sys.exit(1)
    except Exception as e:
        print(f"Unexpected error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()