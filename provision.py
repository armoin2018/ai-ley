#!/usr/bin/env python3
"""
Agentic Template Provisioning Script
Provisions AI-specific configurations and project types based on user selection.
"""

import argparse
import os
import shutil
import subprocess
from datetime import datetime
from pathlib import Path

try:
    import yaml
except ImportError:
    print("Error: PyYAML is required. Install it with: pip install PyYAML")
    exit(1)


class TemplateProvisioner:
    def __init__(self):
        self.base_dir = Path(__file__).parent
        self.templates_dir = self.base_dir / "templates"
        self.common_dir = self.base_dir / "common"
        self.external_resources_map = self.base_dir / "external-resources.map.yaml"
        self.provision_map = self.base_dir / "provision.map.yaml"
        self.active_ai_tools = set()  # Track currently provisioned AI tools

    def load_config(self):
        """Load the mapping configuration from map.yaml"""
        with open(self.base_dir / "map.yaml", 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def load_external_resources_config(self):
        """Load external resources repo mapping from external-resources.map.yaml"""
        if not self.external_resources_map.exists():
            raise FileNotFoundError(f"Missing external resources map: {self.external_resources_map}")
        with open(self.external_resources_map, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    
    def load_provision_map_config(self):
        """Load provision mapping configuration from provision.map.yaml"""
        if not self.provision_map.exists():
            # Fall back to legacy map.yaml behavior
            return None
        with open(self.provision_map, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)
    
    def substitute_variables(self, content, variables):
        """Substitute template variables in content"""
        if isinstance(content, str):
            for key, value in variables.items():
                content = content.replace(f"{{{{{key}}}}}", str(value))
        return content
    
    def process_file_with_variables(self, from_path, to_path, variables):
        """Copy file and substitute variables"""
        try:
            with open(from_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Substitute variables
            content = self.substitute_variables(content, variables)
            
            with open(to_path, 'w', encoding='utf-8') as f:
                f.write(content)
            
            print(f"  Processed {from_path} -> {to_path}")
        except UnicodeDecodeError:
            # Binary file, just copy
            shutil.copy2(from_path, to_path)
            print(f"  Copied {from_path} -> {to_path}")
            
    def provision_project_type(self, project_type, variables=None):
        """Provision base project structure for specified project type"""
        config = self.load_config()
        
        if 'project_types' not in config or project_type not in config['project_types']:
            raise ValueError(f"Unknown project type: {project_type}")
        
        project_config = config['project_types'][project_type]
        default_variables = config.get('template_vars', {})
        
        # Merge variables
        if variables:
            default_variables.update(variables)
        
        print(f"Provisioning {project_config['name']}...")
        print(f"  Description: {project_config['description']}")
        
        for file_config in project_config['files']:
            from_path = self.base_dir / file_config['from']
            to_path = self.base_dir / file_config['to']
            
            # Create target directory if it doesn't exist
            to_path.parent.mkdir(parents=True, exist_ok=True)
            
            if from_path.is_file():
                self.process_file_with_variables(from_path, to_path, default_variables)
            elif from_path.is_dir():
                if to_path.exists():
                    shutil.rmtree(to_path)
                self.copy_directory_with_variables(from_path, to_path, default_variables)
            else:
                print(f"  Warning: Source not found: {from_path}")
        
        print(f"Project type '{project_type}' provisioned successfully!")
    
    def copy_directory_with_variables(self, from_dir, to_dir, variables):
        """Copy directory recursively and substitute variables in text files"""
        for item in from_dir.rglob('*'):
            if item.is_file():
                relative_path = item.relative_to(from_dir)
                target_file = to_dir / relative_path
                target_file.parent.mkdir(parents=True, exist_ok=True)
                
                self.process_file_with_variables(item, target_file, variables)
        
        print(f"  Copied directory {from_dir} -> {to_dir}")
            
    def provision_ai_tool(self, ai_tool, concurrent_mode=False, git_repos=False, no_overwrite=False):
        """Provision template for specified AI tool"""
        # Try new provision.map.yaml first, fall back to legacy map.yaml
        provision_config = self.load_provision_map_config()
        
        if provision_config:
            return self._provision_ai_tool_new(ai_tool, provision_config, concurrent_mode, git_repos, no_overwrite)
        else:
            return self._provision_ai_tool_legacy(ai_tool)
    
    def _provision_ai_tool_new(self, ai_tool, provision_config, concurrent_mode=False, git_repos=False, no_overwrite=False):
        """Provision AI tool using new provision.map.yaml format"""
        if ai_tool not in provision_config['ai_tools']:
            raise ValueError(f"Unknown AI tool: {ai_tool}")
        
        tool_config = provision_config['ai_tools'][ai_tool]
        settings = provision_config.get('settings', {})
        concurrent_settings = provision_config.get('concurrent_support', {})
        
        # Override overwrite setting if no_overwrite is specified
        if no_overwrite:
            settings = settings.copy()
            settings['overwrite_existing_files'] = False
        
        # Check for conflicts if concurrent mode is enabled
        if concurrent_mode and concurrent_settings.get('enabled', True):
            self._check_concurrent_conflicts(ai_tool, tool_config, provision_config)
        
        print(f"Provisioning {tool_config['name']} configuration...")
        
        target_base = self.base_dir / tool_config['target_base']
        
        # Clean target directory if configured
        if settings.get('clean_target_dirs', True) and target_base.exists():
            shutil.rmtree(target_base)
        
        target_base.mkdir(parents=True, exist_ok=True)
        
        # Process each mapping
        for mapping in tool_config['mappings']:
            self._process_mapping(mapping, target_base, settings)
        
        # Process git repository integrations if configured and enabled
        git_repo_mappings = tool_config.get('git_repo_mappings', {})
        if git_repos and git_repo_mappings:
            print(f"  Processing git repository integrations...")
            self._process_git_repo_mappings(git_repo_mappings, target_base, provision_config, settings)
        elif git_repos and not git_repo_mappings:
            print(f"  No git repository mappings configured for {ai_tool}")
        elif git_repo_mappings and not git_repos:
            print(f"  Git repository integrations available but not enabled (use --git-repos flag)")
        
        # Track this AI tool as active
        if concurrent_mode:
            self.active_ai_tools.add(ai_tool)
        
        print(f"{tool_config['name']} configuration completed!")
    
    def _provision_ai_tool_legacy(self, ai_tool):
        """Provision AI tool using legacy map.yaml format"""
        config = self.load_config()
        
        if ai_tool not in config['targets']:
            raise ValueError(f"Unknown AI tool: {ai_tool}")
            
        target_config = config['targets'][ai_tool]
        
        print(f"Provisioning AI tool configuration for {ai_tool}...")
        
        for copy_instruction in target_config['copies']:
            from_path = self.base_dir / copy_instruction['from']
            to_path = self.base_dir / copy_instruction['to']
            
            # Create target directory if it doesn't exist
            to_path.parent.mkdir(parents=True, exist_ok=True)
            
            if from_path.is_file():
                shutil.copy2(from_path, to_path)
                print(f"  Copied {from_path} -> {to_path}")
            elif from_path.is_dir():
                if to_path.exists():
                    shutil.rmtree(to_path)
                shutil.copytree(from_path, to_path)
                print(f"  Copied directory {from_path} -> {to_path}")
            else:
                print(f"  Warning: Source not found: {from_path}")
        
        # Handle common/prompts copying with special rules
        self._copy_prompts_for_ai_tool(ai_tool)
                
        print(f"AI tool configuration for {ai_tool} completed!")
    
    def _copy_prompts_for_ai_tool(self, ai_tool):
        """Copy prompts with AI tool specific rules"""
        # Check for prompts in both common/prompts and docs/prompts
        prompts_sources = [
            self.common_dir / "prompts",
            self.base_dir / "docs" / "prompts"
        ]
        
        prompts_source = None
        for source in prompts_sources:
            if source.exists() and any(source.iterdir()):
                prompts_source = source
                break
        
        if not prompts_source:
            print(f"  Warning: No prompts found in {[str(s) for s in prompts_sources]}")
            return
            
        if ai_tool == "claude-code":
            # For Claude: copy to .claude/commands and remove .prompt extension
            prompts_target = self.base_dir / ".claude" / "commands"
            prompts_target.mkdir(parents=True, exist_ok=True)
            
            for prompt_file in prompts_source.glob("*.prompt"):
                target_name = prompt_file.name.replace(".prompt", "")
                target_file = prompts_target / target_name
                shutil.copy2(prompt_file, target_file)
                print(f"  Copied {prompt_file} -> {target_file}")
                
            # Also copy non-.prompt files (including .puml files)
            for prompt_file in prompts_source.iterdir():
                if prompt_file.is_file() and not prompt_file.name.endswith(".prompt"):
                    target_file = prompts_target / prompt_file.name
                    shutil.copy2(prompt_file, target_file)
                    print(f"  Copied {prompt_file} -> {target_file}")
                    
        elif ai_tool == "copilot":
            # For Copilot: copy to .github/prompts
            prompts_target = self.base_dir / ".github" / "prompts"
            prompts_target.mkdir(parents=True, exist_ok=True)
            
            if prompts_target.exists():
                shutil.rmtree(prompts_target)
            shutil.copytree(prompts_source, prompts_target)
            print(f"  Copied directory {prompts_source} -> {prompts_target}")
        
    def list_available_ai_tools(self):
        """List all available AI tool templates"""
        provision_config = self.load_provision_map_config()
        if provision_config:
            return list(provision_config['ai_tools'].keys())
        else:
            config = self.load_config()
            return list(config['targets'].keys())
    
    def list_available_project_types(self):
        """List all available project types"""
        config = self.load_config()
        return config.get('project_types', {})
        
    def clean_provisioned_files(self, ai_tool):
        """Clean up provisioned files for specified AI tool"""
        config = self.load_config()
        
        if ai_tool not in config['targets']:
            raise ValueError(f"Unknown AI tool: {ai_tool}")
            
        target_config = config['targets'][ai_tool]
        
        print(f"Cleaning provisioned files for {ai_tool}...")
        
        for copy_instruction in target_config['copies']:
            to_path = self.base_dir / copy_instruction['to']
            
            if to_path.exists():
                if to_path.is_file():
                    to_path.unlink()
                    print(f"  Removed {to_path}")
                elif to_path.is_dir():
                    shutil.rmtree(to_path)
                    print(f"  Removed directory {to_path}")
                    
        print(f"Cleanup for {ai_tool} completed!")

    def pull_external_repo(self, repo_key, target_dir):
        """Clone or update external repo and copy mapped folders into target_dir/subfolder"""
        config = self.load_external_resources_config()
        if not config or not isinstance(config, dict) or 'repos' not in config or not config['repos'] or repo_key not in config['repos']:
            raise ValueError(f"Unknown repo key: {repo_key}")
        repo_cfg = config['repos'][repo_key]
        repo_url = repo_cfg['url']
        subfolder = repo_cfg['subfolder']
        folders = repo_cfg['folders']

        # Use a cache directory for repo clones
        cache_dir = self.base_dir / '.external_repo_cache'
        cache_dir.mkdir(exist_ok=True)
        repo_local = cache_dir / repo_key

        # Clone or update repo
        if repo_local.exists():
            print(f"Updating repo {repo_key}...")
            os.system(f"cd {repo_local} && git pull")
        else:
            print(f"Cloning repo {repo_key} from {repo_url}...")
            os.system(f"git clone {repo_url} {repo_local}")

        # Copy mapped folders into target_dir/subfolder
        target_base = Path(target_dir) / subfolder
        for folder in folders:
            src_folder = repo_local / folder
            dst_folder = target_base / folder
            if src_folder.exists():
                if dst_folder.exists():
                    shutil.rmtree(dst_folder)
                shutil.copytree(src_folder, dst_folder)
                print(f"  Copied {src_folder} -> {dst_folder}")
            else:
                print(f"  Warning: {src_folder} not found in repo {repo_key}")

        print(f"External resources from {repo_key} pulled into {target_base}")
    
    def _process_git_repo_mappings(self, git_repo_mappings, target_base, provision_config, settings):
        """Process git repository mappings for an AI tool"""
        git_repos_config = provision_config.get('git_repos', {})
        overwrite_existing = settings.get('overwrite_existing_files', True)
        
        for repo_key, repo_mapping_config in git_repo_mappings.items():
            if repo_key not in git_repos_config:
                print(f"  Warning: Git repo '{repo_key}' not found in git_repos configuration")
                continue
            
            repo_config = git_repos_config[repo_key]
            
            # Clone or update the repository
            repo_cache_path = self._ensure_git_repo_cached(repo_key, repo_config)
            
            # Process mappings for this repository
            mappings = repo_mapping_config.get('mappings', [])
            for mapping in mappings:
                self._process_git_repo_mapping(repo_cache_path, mapping, target_base, settings, overwrite_existing)
    
    def _ensure_git_repo_cached(self, repo_key, repo_config):
        """Ensure git repository is cloned and up to date"""
        cache_dir = repo_config.get('cache_dir', '.git_repo_cache')
        cache_base = self.base_dir / cache_dir
        cache_base.mkdir(exist_ok=True)
        
        repo_cache_path = cache_base / repo_key
        repo_url = repo_config['url']
        branch = repo_config.get('branch', 'main')
        
        try:
            if repo_cache_path.exists():
                print(f"  Updating git repo {repo_key}...")
                os.system(f"cd {repo_cache_path} && git fetch && git reset --hard origin/{branch}")
            else:
                print(f"  Cloning git repo {repo_key} from {repo_url}...")
                os.system(f"git clone -b {branch} {repo_url} {repo_cache_path}")
        except Exception as e:
            print(f"  Error with git repo {repo_key}: {e}")
            return None
        
        return repo_cache_path
    
    def _process_git_repo_mapping(self, repo_cache_path, mapping, target_base, settings, overwrite_existing):
        """Process a single git repository mapping"""
        if not repo_cache_path or not repo_cache_path.exists():
            print(f"  Warning: Repository cache path not found: {repo_cache_path}")
            return
            
        source_path = repo_cache_path / mapping['source']
        target_path = target_base / mapping['target']
        
        if not source_path.exists():
            print(f"  Warning: Source path not found in git repo: {source_path}")
            return
        
        # Create target directory
        target_path.parent.mkdir(parents=True, exist_ok=True)
        
        if source_path.is_file():
            self._process_git_repo_file(source_path, target_path, mapping, settings, overwrite_existing)
        elif source_path.is_dir():
            self._process_git_repo_directory(source_path, target_path, mapping, settings, overwrite_existing)
    
    def _process_git_repo_file(self, source_path, target_path, mapping, settings, overwrite_existing):
        """Process a single file from git repository with transforms"""
        transforms = mapping.get('file_transforms', [])
        
        # Apply file name transformations
        final_target = target_path
        for transform in transforms:
            final_target = self._apply_file_transform(source_path, final_target, transform)
        
        # Check if we should skip existing files
        if final_target.exists() and not overwrite_existing:
            print(f"  Skipping existing file: {final_target}")
            return
        
        # Copy file with variable substitution if it's a text file
        if self._is_text_file(source_path, settings):
            variables = settings.get('template_vars', {})
            self.process_file_with_variables(source_path, final_target, variables)
        else:
            shutil.copy2(source_path, final_target)
            print(f"  Copied from git repo: {source_path} -> {final_target}")
    
    def _process_git_repo_directory(self, source_path, target_path, mapping, settings, overwrite_existing):
        """Process a directory from git repository with transforms"""
        transforms = mapping.get('file_transforms', [])
        
        # Create target directory
        target_path.mkdir(parents=True, exist_ok=True)
        
        # Process each file in the directory
        for item in source_path.rglob('*'):
            if item.is_file():
                relative_path = item.relative_to(source_path)
                target_file = target_path / relative_path
                
                # Apply file transformations
                final_target = target_file
                for transform in transforms:
                    final_target = self._apply_file_transform(item, final_target, transform)
                
                # Check if we should skip existing files
                if final_target.exists() and not overwrite_existing:
                    print(f"  Skipping existing file: {final_target}")
                    continue
                
                # Ensure target directory exists
                final_target.parent.mkdir(parents=True, exist_ok=True)
                
                # Copy file with variable substitution if it's a text file
                if self._is_text_file(item, settings):
                    variables = settings.get('template_vars', {})
                    self.process_file_with_variables(item, final_target, variables)
                else:
                    shutil.copy2(item, final_target)
                    print(f"  Copied from git repo: {item} -> {final_target}")
        
        print(f"  Copied git repo directory {source_path} -> {target_path}")
    
    def _apply_file_transform(self, source_file, target_file, transform):
        """Apply a single file transformation rule"""
        import re
        
        if transform.get('preserve_all', False):
            # Keep all files as-is
            return target_file
        elif transform.get('preserve_others', False):
            # Only apply specific transforms, keep others as-is
            if 'from_extension' in transform and 'to_extension' in transform:
                if source_file.name.endswith(transform['from_extension']):
                    new_name = source_file.name.replace(
                        transform['from_extension'],
                        transform['to_extension']
                    )
                    return target_file.parent / new_name
            elif 'from_pattern' in transform and 'to_pattern' in transform:
                pattern = transform['from_pattern']
                replacement = transform['to_pattern']
                new_name = re.sub(pattern, replacement, source_file.name)
                if new_name != source_file.name:
                    return target_file.parent / new_name
            return target_file
        elif 'from_extension' in transform and 'to_extension' in transform:
            if source_file.name.endswith(transform['from_extension']):
                new_name = source_file.name.replace(
                    transform['from_extension'],
                    transform['to_extension']
                )
                return target_file.parent / new_name
        elif 'from_pattern' in transform and 'to_pattern' in transform:
            pattern = transform['from_pattern']
            replacement = transform['to_pattern']
            new_name = re.sub(pattern, replacement, source_file.name)
            return target_file.parent / new_name
        
        return target_file
    
    def _check_concurrent_conflicts(self, ai_tool, tool_config, provision_config):
        """Check for conflicts when provisioning multiple AI tools concurrently"""
        concurrent_settings = provision_config.get('concurrent_support', {})
        conflict_resolution = concurrent_settings.get('conflict_resolution', 'error')
        
        target_base = self.base_dir / tool_config['target_base']
        
        # Check if target directory would conflict with existing AI tool directories
        for active_tool in self.active_ai_tools:
            if active_tool == ai_tool:
                continue
                
            active_tool_config = provision_config['ai_tools'][active_tool]
            active_target_base = self.base_dir / active_tool_config['target_base']
            
            # Check for overlapping target directories
            if target_base == active_target_base:
                if conflict_resolution == 'error':
                    raise ValueError(f"Conflict: {ai_tool} and {active_tool} both target {target_base}")
                elif conflict_resolution == 'skip':
                    print(f"  Skipping {ai_tool} due to conflict with {active_tool}")
                    return False
                elif conflict_resolution == 'backup':
                    backup_path = target_base.with_suffix(f".{active_tool}.backup")
                    if target_base.exists():
                        shutil.move(str(target_base), str(backup_path))
                        print(f"  Backed up {target_base} to {backup_path}")
        
        return True
    
    def _process_mapping(self, mapping, target_base, settings):
        """Process a single mapping from provision.map.yaml"""
        source_path = self.base_dir / mapping['source']
        target_path = target_base / mapping['target']
        
        if not source_path.exists():
            print(f"  Warning: Source not found: {source_path}")
            return
        
        # Create target directory
        target_path.parent.mkdir(parents=True, exist_ok=True)
        
        if source_path.is_file():
            self._process_file_mapping(source_path, target_path, mapping, settings)
        elif source_path.is_dir():
            self._process_directory_mapping(source_path, target_path, mapping, settings)
    
    def _process_file_mapping(self, source_path, target_path, mapping, settings):
        """Process a single file mapping with transforms"""
        transforms = mapping.get('file_transforms', [])
        
        # Apply file name transformations
        final_target = target_path
        for transform in transforms:
            if 'from_extension' in transform and 'to_extension' in transform:
                if source_path.name.endswith(transform['from_extension']):
                    new_name = source_path.name.replace(
                        transform['from_extension'], 
                        transform['to_extension']
                    )
                    final_target = target_path.parent / new_name
                    break
        
        # Copy file with variable substitution if it's a text file
        if self._is_text_file(source_path, settings):
            variables = settings.get('template_vars', {})
            self.process_file_with_variables(source_path, final_target, variables)
        else:
            shutil.copy2(source_path, final_target)
            print(f"  Copied {source_path} -> {final_target}")
    
    def _process_directory_mapping(self, source_path, target_path, mapping, settings):
        """Process a directory mapping with transforms"""
        transforms = mapping.get('file_transforms', [])
        
        # Clean target if it exists
        if target_path.exists():
            shutil.rmtree(target_path)
        
        target_path.mkdir(parents=True, exist_ok=True)
        
        # Process each file in the directory
        for item in source_path.rglob('*'):
            if item.is_file():
                relative_path = item.relative_to(source_path)
                target_file = target_path / relative_path
                
                # Apply file transformations
                final_target = target_file
                for transform in transforms:
                    if transform.get('preserve_all', False):
                        # Keep all files as-is
                        break
                    elif transform.get('preserve_others', False):
                        # Only transform specific extensions, keep others as-is
                        if ('from_extension' in transform and 
                            item.name.endswith(transform['from_extension'])):
                            new_name = item.name.replace(
                                transform['from_extension'],
                                transform['to_extension']
                            )
                            final_target = target_file.parent / new_name
                        break
                    elif 'from_extension' in transform and 'to_extension' in transform:
                        if item.name.endswith(transform['from_extension']):
                            new_name = item.name.replace(
                                transform['from_extension'],
                                transform['to_extension']
                            )
                            final_target = target_file.parent / new_name
                            break
                
                # Ensure target directory exists
                final_target.parent.mkdir(parents=True, exist_ok=True)
                
                # Copy file with variable substitution if it's a text file
                if self._is_text_file(item, settings):
                    variables = settings.get('template_vars', {})
                    self.process_file_with_variables(item, final_target, variables)
                else:
                    shutil.copy2(item, final_target)
                    print(f"  Copied {item} -> {final_target}")
        
        print(f"  Copied directory {source_path} -> {target_path}")
    
    def _is_text_file(self, file_path, settings):
        """Determine if a file should be treated as text for variable substitution"""
        text_extensions = settings.get('text_extensions', [
            '.md', '.yml', '.yaml', '.json', '.js', '.ts', '.py', '.prompt'
        ])
        binary_extensions = settings.get('binary_extensions', [
            '.png', '.jpg', '.jpeg', '.gif', '.ico', '.pdf'
        ])
        
        file_ext = file_path.suffix.lower()
        
        if file_ext in binary_extensions:
            return False
        if file_ext in text_extensions:
            return True
        
        # Default: try to detect if file is text
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                f.read(1024)  # Read first 1KB to test
            return True
        except (UnicodeDecodeError, PermissionError):
            return False

    def update_from_template_repo(self, template_repo_url=None, branch='main', force=False, backup=True):
        """Update local files from the agentic-template repository if repo files are newer"""
        if template_repo_url is None:
            template_repo_url = "https://github.com/armoin2018/agentic-template.git"
        
        print(f"Updating from agentic-template repository: {template_repo_url}")
        
        # Create cache directory for the template repo
        cache_dir = self.base_dir / '.template_repo_cache'
        cache_dir.mkdir(exist_ok=True)
        template_repo_path = cache_dir / 'agentic-template'
        
        # Clone or update the template repository
        try:
            if template_repo_path.exists():
                print("  Updating existing template repository...")
                result = subprocess.run(
                    ['git', 'pull', 'origin', branch],
                    cwd=template_repo_path,
                    capture_output=True,
                    text=True,
                    check=True
                )
                print(f"  Git pull result: {result.stdout.strip()}")
            else:
                print("  Cloning template repository...")
                result = subprocess.run(
                    ['git', 'clone', '-b', branch, template_repo_url, str(template_repo_path)],
                    capture_output=True,
                    text=True,
                    check=True
                )
                print("  Repository cloned successfully")
        except subprocess.CalledProcessError as e:
            print(f"  Error with git operation: {e}")
            print(f"  Git stderr: {e.stderr}")
            return False
        
        # Define files/directories to update from template
        update_paths = [
            'common/',
            'templates/',
            'provision.py',
            'provision.map.yaml',
            'external-resources.map.yaml',
            'map.yaml',
            '.github/copilot-instructions.md'
        ]
        
        updated_files = []
        skipped_files = []
        backed_up_files = []
        
        for update_path in update_paths:
            source_path = template_repo_path / update_path
            target_path = self.base_dir / update_path
            
            if not source_path.exists():
                print(f"  Warning: Source path not found in template: {update_path}")
                continue
            
            if source_path.is_file():
                result = self._update_file(source_path, target_path, force, backup)
                if result['action'] == 'updated':
                    updated_files.append(update_path)
                elif result['action'] == 'backed_up':
                    backed_up_files.append(update_path)
                elif result['action'] == 'skipped':
                    skipped_files.append(update_path)
            elif source_path.is_dir():
                results = self._update_directory(source_path, target_path, force, backup)
                updated_files.extend(results['updated'])
                backed_up_files.extend(results['backed_up'])
                skipped_files.extend(results['skipped'])
        
        # Print summary
        print("\nUpdate Summary:")
        if updated_files:
            print(f"  Updated files ({len(updated_files)}):")
            for file_path in updated_files:
                print(f"    ✓ {file_path}")
        
        if backed_up_files:
            print(f"  Backed up files ({len(backed_up_files)}):")
            for file_path in backed_up_files:
                print(f"    📦 {file_path}")
        
        if skipped_files:
            print(f"  Skipped files (local newer or same) ({len(skipped_files)}):")
            for file_path in skipped_files:
                print(f"    ⏭ {file_path}")
        
        if not updated_files and not backed_up_files:
            print("  No files needed updating - local files are up to date!")
        
        return True
    
    def _update_file(self, source_path, target_path, force=False, backup=True):
        """Update a single file if source is newer"""
        if not target_path.exists():
            # File doesn't exist locally, copy it
            target_path.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(source_path, target_path)
            print(f"  Added new file: {target_path}")
            return {'action': 'updated', 'path': str(target_path)}
        
        # Get modification times
        source_mtime = source_path.stat().st_mtime
        target_mtime = target_path.stat().st_mtime
        
        if force or source_mtime > target_mtime:
            # Source is newer (or force is enabled), update the file
            if backup and target_path.exists():
                backup_path = target_path.with_suffix(f"{target_path.suffix}.backup.{int(datetime.now().timestamp())}")
                shutil.copy2(target_path, backup_path)
                print(f"  Backed up {target_path} to {backup_path}")
                
            shutil.copy2(source_path, target_path)
            print(f"  Updated: {target_path}")
            
            if backup:
                return {'action': 'backed_up', 'path': str(target_path)}
            else:
                return {'action': 'updated', 'path': str(target_path)}
        else:
            # Local file is newer or same, skip
            return {'action': 'skipped', 'path': str(target_path)}
    
    def _update_directory(self, source_dir, target_dir, force=False, backup=True):
        """Update all files in a directory recursively"""
        results = {'updated': [], 'backed_up': [], 'skipped': []}
        
        # Create target directory if it doesn't exist
        target_dir.mkdir(parents=True, exist_ok=True)
        
        # Process each file in the source directory
        for source_file in source_dir.rglob('*'):
            if source_file.is_file():
                # Calculate relative path and corresponding target file
                relative_path = source_file.relative_to(source_dir)
                target_file = target_dir / relative_path
                
                result = self._update_file(source_file, target_file, force, backup)
                
                # Store relative path for reporting
                relative_str = str(target_dir.name / relative_path)
                if result['action'] == 'updated':
                    results['updated'].append(relative_str)
                elif result['action'] == 'backed_up':
                    results['backed_up'].append(relative_str)
                elif result['action'] == 'skipped':
                    results['skipped'].append(relative_str)
        
        return results


def main():
    parser = argparse.ArgumentParser(description='Provision AI tool templates and project types')
    subparsers = parser.add_subparsers(dest='command', help='Available commands')

    # List command
    list_parser = subparsers.add_parser('list', help='List available templates')
    list_parser.add_argument('--type', choices=['ai-tools', 'projects', 'all'], 
                           default='all', help='Type of templates to list')

    # Provision command
    provision_parser = subparsers.add_parser('provision', help='Provision templates')
    provision_parser.add_argument('--ai-tool', '-t', 
                                help='AI tool to provision (claude-code, copilot)')
    provision_parser.add_argument('--project-type', '-p',
                                help='Project type to provision (docusaurus, mkdocs, minimal)')
    provision_parser.add_argument('--concurrent', action='store_true',
                                help='Enable concurrent AI tool provisioning mode')
    provision_parser.add_argument('--git-repos', action='store_true',
                                help='Include git repository integrations')
    provision_parser.add_argument('--no-overwrite', action='store_true',
                                help='Do not overwrite existing files from git repos (default: overwrite)')
    provision_parser.add_argument('--project-name', default='my-project',
                                help='Project name for variable substitution')
    provision_parser.add_argument('--project-title', 
                                help='Project title for variable substitution')
    provision_parser.add_argument('--project-description', default='A new project',
                                help='Project description for variable substitution')
    provision_parser.add_argument('--project-url', default='https://example.com',
                                help='Project URL for variable substitution')
    provision_parser.add_argument('--project-repo-url', 
                                help='Project repository URL for variable substitution')

    # Clean command
    clean_parser = subparsers.add_parser('clean', help='Clean provisioned files')
    clean_parser.add_argument('--ai-tool', '-t', required=True,
                            help='AI tool to clean (claude-code, copilot)')

    # Pull external repo resources command
    pull_repo_parser = subparsers.add_parser('pull-repo', help='Pull resources from external repo')
    pull_repo_parser.add_argument('--repo', required=True, help='Repo key from external-resources.map.yaml')
    pull_repo_parser.add_argument('--target-dir', required=True, help='Target directory in client project')

    # Update command
    update_parser = subparsers.add_parser('update', help='Update local files from agentic-template repository')
    update_parser.add_argument('--repo-url', 
                              help='Template repository URL (default: https://github.com/armoin2018/agentic-template.git)')
    update_parser.add_argument('--branch', default='main',
                              help='Branch to pull from (default: main)')
    update_parser.add_argument('--force', action='store_true',
                              help='Force update all files regardless of modification time')
    update_parser.add_argument('--no-backup', action='store_true',
                              help='Do not create backup files (default: create backups)')

    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        return 1

    provisioner = TemplateProvisioner()

    try:
        if args.command == 'list':
            if args.type in ['ai-tools', 'all']:
                ai_tools = provisioner.list_available_ai_tools()
                print("Available AI Tools:")
                for tool in ai_tools:
                    print(f"  - {tool}")
                print()
            if args.type in ['projects', 'all']:
                project_types = provisioner.list_available_project_types()
                if isinstance(project_types, dict):
                    print("Available Project Types:")
                    for ptype, pconfig in project_types.items():
                        print(f"  - {ptype}: {pconfig.get('name', '')}")
                        print(f"    {pconfig.get('description', '')}")
                    print()
        elif args.command == 'provision':
            variables = {
                'PROJECT_NAME': args.project_name,
                'PROJECT_TITLE': args.project_title or args.project_name.replace('-', ' ').title(),
                'PROJECT_DESCRIPTION': args.project_description,
                'PROJECT_URL': args.project_url,
                'PROJECT_REPO_URL': args.project_repo_url or f"https://github.com/example/{args.project_name}",
                'PROJECT_BASE_URL': '/',
                'PROJECT_TAGLINE': args.project_description,
            }
            if args.project_type:
                provisioner.provision_project_type(args.project_type, variables)
            if args.ai_tool:
                # Pass git repos and overwrite flags to provisioning
                git_repos = getattr(args, 'git_repos', False)
                no_overwrite = getattr(args, 'no_overwrite', False)
                provisioner.provision_ai_tool(args.ai_tool, args.concurrent, git_repos, no_overwrite)
            if not args.project_type and not args.ai_tool:
                print("Error: Specify either --project-type or --ai-tool (or both)")
                return 1
        elif args.command == 'clean':
            provisioner.clean_provisioned_files(args.ai_tool)
        elif args.command == 'pull-repo':
            provisioner.pull_external_repo(args.repo, args.target_dir)
        elif args.command == 'update':
            backup = not args.no_backup
            success = provisioner.update_from_template_repo(
                template_repo_url=args.repo_url,
                branch=args.branch,
                force=args.force,
                backup=backup
            )
            if not success:
                print("Update failed!")
                return 1
    except ValueError as e:
        print(f"Error: {e}")
        return 1
    except FileNotFoundError as e:
        print(f"File not found: {e}")
        return 1
    return 0

if __name__ == "__main__":
    exit(main())