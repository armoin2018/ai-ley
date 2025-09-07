#!/usr/bin/env python3
"""
Phase 3: Generate JSON registry file from all processed files
"""
import os
import hashlib
import json
import yaml
from pathlib import Path
import frontmatter

def get_md5(filepath):
    """Calculate MD5 hash of a file"""
    hash_md5 = hashlib.md5()
    try:
        with open(filepath, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
    except Exception as e:
        print(f"Error calculating MD5 for {filepath}: {e}")
        return None

def extract_metadata(filepath):
    """Extract metadata from a file's frontmatter"""
    try:
        # Try reading with utf-8 first
        with open(filepath, 'r', encoding='utf-8') as f:
            post = frontmatter.load(f)
    except UnicodeDecodeError:
        try:
            # If utf-8 fails, try with latin-1
            with open(filepath, 'r', encoding='latin-1') as f:
                post = frontmatter.load(f)
        except Exception as e:
            print(f"Error loading frontmatter from {filepath}: {e}")
            return None
    except Exception as e:
        print(f"Error loading frontmatter from {filepath}: {e}")
        return None
    
    metadata = post.metadata.copy()
    
    # Add computed fields
    metadata['path'] = os.path.relpath(filepath, "/Users/blainemcdonnell/git/ai-ley")
    metadata['md5sum'] = get_md5(filepath)
    
    # Ensure keywords is a list
    if 'keywords' in metadata and isinstance(metadata['keywords'], str):
        metadata['keywords'] = [kw.strip() for kw in metadata['keywords'].split(',')]
    
    # Ensure extensions is a list
    if 'extensions' in metadata and isinstance(metadata['extensions'], str):
        metadata['extensions'] = [ext.strip() for ext in metadata['extensions'].split(',')]
    
    return metadata

def scan_folder(folder_path, exclude_files):
    """Scan a folder recursively for files"""
    files = []
    if not os.path.exists(folder_path):
        return files
    
    for root, dirs, filenames in os.walk(folder_path):
        for filename in filenames:
            if filename not in exclude_files and not filename.startswith('.'):
                filepath = os.path.join(root, filename)
                files.append(filepath)
    
    return files

def determine_section(filepath):
    """Determine which section of the registry a file belongs to"""
    rel_path = os.path.relpath(filepath, "/Users/blainemcdonnell/git/ai-ley")
    
    if '/personas/' in rel_path:
        return 'personas'
    elif '/instructions/' in rel_path:
        return 'instructions'
    elif '/workflows/' in rel_path:
        return 'workflows'
    elif '/schemas/' in rel_path:
        return 'schemas'
    elif '/prompts/' in rel_path:
        return 'prompts'
    elif '/policies/' in rel_path:
        return 'policies'
    else:
        return 'unknown'

def get_item_name(filepath):
    """Generate a unique item name for the registry"""
    rel_path = os.path.relpath(filepath, "/Users/blainemcdonnell/git/ai-ley")
    
    # Remove the base shared path and file extension
    name = rel_path.replace('.ai-ley/shared/', '').replace('.md', '').replace('.yaml', '').replace('.yml', '')
    
    # Replace path separators with underscores to create unique names
    name = name.replace('/', '_').replace('\\', '_')
    
    return name

def main():
    base_path = "/Users/blainemcdonnell/git/ai-ley"
    
    # Define folders to scan
    folders_to_scan = [
        ".ai-ley/shared/personas",
        ".ai-ley/shared/instructions", 
        ".ai-ley/shared/workflows",
        ".ai-ley/shared/schemas",
        ".ai-ley/shared/prompts",
        ".ai-ley/shared/policies"
    ]
    
    exclude_files = ["README.md", "CHANGES.md", ".gitkeep"]
    registry_path = os.path.join(base_path, ".ai-ley/shared/variables/registry.json")
    
    # Initialize registry structure
    registry = {
        "personas": {},
        "instructions": {},
        "workflows": {},
        "schemas": {},
        "prompts": {},
        "policies": {}
    }
    
    # Collect all files and process them
    for folder in folders_to_scan:
        folder_path = os.path.join(base_path, folder)
        files = scan_folder(folder_path, exclude_files)
        
        for filepath in files:
            section = determine_section(filepath)
            if section == 'unknown':
                print(f"Warning: Could not determine section for {filepath}")
                continue
                
            metadata = extract_metadata(filepath)
            if metadata is None:
                print(f"Warning: Could not extract metadata from {filepath}")
                continue
            
            item_name = get_item_name(filepath)
            registry[section][item_name] = metadata
    
    # Write the registry
    os.makedirs(os.path.dirname(registry_path), exist_ok=True)
    
    with open(registry_path, 'w', encoding='utf-8') as f:
        json.dump(registry, f, indent=2, ensure_ascii=False)
    
    # Print summary
    total_items = sum(len(section) for section in registry.values())
    print(f"Phase 3 complete. Registry generated with {total_items} items:")
    for section, items in registry.items():
        print(f"  - {section}: {len(items)} items")
    print(f"Registry written to: {registry_path}")

if __name__ == "__main__":
    main()