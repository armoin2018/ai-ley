#!/usr/bin/env python3
"""
AI-LEY: AI Building Resource Toolkit
A tool for managing AI instruction sets, personas, and prompts.
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
        
        # Ensure directories exist
        self.external_dir.mkdir(parents=True, exist_ok=True)
        self.shared_dir.mkdir(parents=True, exist_ok=True)
    
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
    
    def _get_folder_hashes(self, folder_path: Path) -> Dict[str, str]:
        """Get MD5 hashes for all files in a folder."""
        hashes = {}
        if not folder_path.exists():
            return hashes
        
        for file_path in folder_path.rglob("*"):
            if file_path.is_file():
                relative_path = file_path.relative_to(folder_path)
                hashes[str(relative_path)] = self._calculate_md5_hash(file_path)
        
        return hashes
    
    def update_shared_content(self) -> None:
        """Update shared content from ai-ley repository."""
        # Ensure ai-ley repo is fetched
        if not (self.external_dir / "ai-ley").exists():
            print("AI-LEY repository not found locally. Fetching...")
            if not self.fetch_repo("ai-ley"):
                print("Failed to fetch ai-ley repository.")
                return
        
        source_base = self.external_dir / "ai-ley" / ".ai-ley" / "shared"
        target_base = self.shared_dir
        
        for content_type in ["instructions", "personas", "prompts"]:
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
    
    def contribute_changes(self) -> None:
        """Contribute changes back to ai-ley repository."""
        # Ensure ai-ley repo is fetched
        if not (self.external_dir / "ai-ley").exists():
            print("AI-LEY repository not found locally. Fetching...")
            if not self.fetch_repo("ai-ley"):
                print("Failed to fetch ai-ley repository.")
                return
        
        repo_path = self.external_dir / "ai-ley"
        source_base = self.shared_dir
        target_base = repo_path / ".ai-ley" / "shared"
        
        # Create branch name based on date
        from datetime import datetime
        branch_name = f"contribution-{datetime.now().strftime('%Y%m%d-%H%M%S')}"
        
        try:
            # Create and checkout new branch
            subprocess.run(['git', 'checkout', '-b', branch_name], 
                         cwd=repo_path, check=True)
            
            changes_made = False
            
            for content_type in ["instructions", "personas", "prompts"]:
                source_dir = source_base / content_type
                target_dir = target_base / content_type
                
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
                        print(f"Staged for contribution: {content_type}/{relative_path}")
            
            if not changes_made:
                print("No changes to contribute.")
                subprocess.run(['git', 'checkout', 'main'], cwd=repo_path)
                subprocess.run(['git', 'branch', '-d', branch_name], cwd=repo_path)
                return
            
            # Add, commit, and push changes
            subprocess.run(['git', 'add', '.'], cwd=repo_path, check=True)
            subprocess.run(['git', 'commit', '-m', 
                          f'Contribution: Updated shared content from local changes'], 
                         cwd=repo_path, check=True)
            subprocess.run(['git', 'push', 'origin', branch_name], 
                         cwd=repo_path, check=True)
            
            print(f"Changes pushed to branch: {branch_name}")
            print("Please create a pull request manually on the repository website.")
            
        except subprocess.CalledProcessError as e:
            print(f"Error during contribution process: {e}")
        except Exception as e:
            print(f"Unexpected error during contribution: {e}")
    
    def port_content(self, repo_name: str) -> None:
        """Port content from a portable repository."""
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
                    
            except Exception as e:
                print(f"Error porting {source_rel} -> {target_rel}: {e}")


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
        help='Update shared content from ai-ley repository'
    )
    
    parser.add_argument(
        '--contribute',
        action='store_true',
        help='Contribute changes back to ai-ley repository'
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
        
        if args.list:
            manager.list_repos()
        elif args.fetch:
            manager.fetch_repo(args.fetch)
        elif args.update:
            manager.update_shared_content()
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