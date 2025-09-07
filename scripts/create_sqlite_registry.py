#!/usr/bin/env python3
"""
Create SQLite registry database and migrate from JSON
"""
import os
import json
import sqlite3
from datetime import datetime

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

def migrate_from_json(cursor, json_path):
    """Migrate data from JSON registry to SQLite"""
    if not os.path.exists(json_path):
        print(f"JSON registry not found at {json_path}")
        return
    
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # Clear existing data
    cursor.execute("DELETE FROM registry_items;")
    
    total_migrated = 0
    
    for item_type, items in data.items():
        if not isinstance(items, dict):
            continue
            
        for name, metadata in items.items():
            if not isinstance(metadata, dict):
                continue
                
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
                extensions, agent_mode, instruction_type, guidelines
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
                metadata.get('guidelines')
            ))
            total_migrated += 1
    
    print(f"Migrated {total_migrated} items from JSON to SQLite")

def main():
    base_path = "/Users/blainemcdonnell/git/ai-ley"
    json_registry_path = os.path.join(base_path, ".ai-ley/shared/variables/registry.json")
    sqlite_registry_path = os.path.join(base_path, ".ai-ley/shared/variables/registry.db")
    
    # Create directory if it doesn't exist
    os.makedirs(os.path.dirname(sqlite_registry_path), exist_ok=True)
    
    # Connect to SQLite database
    conn = sqlite3.connect(sqlite_registry_path)
    cursor = conn.cursor()
    
    try:
        # Create schema
        print("Creating SQLite schema...")
        create_schema(cursor)
        
        # Migrate from JSON
        print("Migrating data from JSON...")
        migrate_from_json(cursor, json_registry_path)
        
        # Commit changes
        conn.commit()
        
        # Get statistics
        cursor.execute("SELECT type, COUNT(*) FROM registry_items GROUP BY type ORDER BY type;")
        stats = cursor.fetchall()
        
        print(f"\nSQLite registry created at: {sqlite_registry_path}")
        print("Statistics:")
        total = 0
        for item_type, count in stats:
            print(f"  - {item_type}: {count} items")
            total += count
        print(f"  - Total: {total} items")
        
    except Exception as e:
        print(f"Error creating SQLite registry: {e}")
        conn.rollback()
    finally:
        conn.close()

if __name__ == "__main__":
    main()