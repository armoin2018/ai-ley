#!/usr/bin/env python3
"""
Phase 3: Generate SQLite registry database from all processed files
"""
import os
import hashlib
import json
import sqlite3
from pathlib import Path
import frontmatter
from datetime import datetime

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

def create_schema(cursor):
    """Create the registry database schema"""
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS registry_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        path TEXT UNIQUE NOT NULL,
        title TEXT,
        description TEXT,
        version TEXT,
        author TEXT,
        last_updated DATETIME,
        md5sum TEXT,
        summary_score REAL,
        apply_to TEXT, -- JSON array as string
        keywords TEXT, -- JSON array as string  
        extensions TEXT, -- JSON array as string
        agent_mode TEXT,
        instruction_type TEXT,
        guidelines TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    """)
    
    # Create indexes for better query performance
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_type ON registry_items(type);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_path ON registry_items(path);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_title ON registry_items(title);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_score ON registry_items(summary_score);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_agent_mode ON registry_items(agent_mode);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_instruction_type ON registry_items(instruction_type);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_last_updated ON registry_items(last_updated);")

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

def insert_or_update_item(cursor, item_type, name, metadata):
    """Insert or update an item in the database"""
    # Parse last_updated to proper datetime format
    last_updated = metadata.get('lastUpdated')
    if last_updated and isinstance(last_updated, str):
        try:
            # Handle ISO format with 'T' separator
            if 'T' in last_updated:
                last_updated = datetime.fromisoformat(last_updated.replace('Z', '+00:00'))
            else:
                last_updated = datetime.fromisoformat(last_updated)
        except ValueError:
            last_updated = None
    
    # Convert arrays to JSON strings
    keywords = json.dumps(metadata.get('keywords', [])) if metadata.get('keywords') else None
    extensions = json.dumps(metadata.get('extensions', [])) if metadata.get('extensions') else None
    apply_to = json.dumps(metadata.get('applyTo', [])) if metadata.get('applyTo') else None
    
    cursor.execute("""
    INSERT OR REPLACE INTO registry_items (
        type, name, path, title, description, version, author,
        last_updated, md5sum, summary_score, apply_to, keywords,
        extensions, agent_mode, instruction_type, guidelines,
        updated_at
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        item_type,
        name,
        metadata.get('path'),
        metadata.get('title'),
        metadata.get('description'),
        metadata.get('version'),
        metadata.get('author'),
        last_updated,
        metadata.get('md5sum'),
        metadata.get('summaryScore'),
        apply_to,
        keywords,
        extensions,
        metadata.get('agentMode'),
        metadata.get('instructionType'),
        metadata.get('guidelines'),
        datetime.now()
    ))

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
    registry_path = os.path.join(base_path, ".ai-ley/shared/variables/registry.db")
    
    # Create directory if it doesn't exist
    os.makedirs(os.path.dirname(registry_path), exist_ok=True)
    
    # Connect to SQLite database
    conn = sqlite3.connect(registry_path)
    cursor = conn.cursor()
    
    try:
        # Create schema
        create_schema(cursor)
        
        # Clear existing data
        cursor.execute("DELETE FROM registry_items;")
        
        # Collect all files and process them
        total_items = 0
        section_counts = {}
        
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
                insert_or_update_item(cursor, section, item_name, metadata)
                
                total_items += 1
                section_counts[section] = section_counts.get(section, 0) + 1
        
        # Commit changes
        conn.commit()
        
        # Print summary
        print(f"Phase 3 complete. SQLite registry generated with {total_items} items:")
        for section, count in section_counts.items():
            print(f"  - {section}: {count} items")
        print(f"Registry written to: {registry_path}")
        
    except Exception as e:
        print(f"Error creating SQLite registry: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == "__main__":
    main()