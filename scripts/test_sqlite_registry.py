#!/usr/bin/env python3
"""
Test SQLite registry with sample queries
"""
import sqlite3
import json
import os

def main():
    base_path = "/Users/blainemcdonnell/git/ai-ley"
    registry_path = os.path.join(base_path, ".ai-ley/shared/variables/registry.db")
    
    if not os.path.exists(registry_path):
        print(f"SQLite registry not found at {registry_path}")
        return
    
    conn = sqlite3.connect(registry_path)
    cursor = conn.cursor()
    
    try:
        print("=== SQLite Registry Test Queries ===\n")
        
        # Query 1: Basic statistics
        print("1. Registry Statistics:")
        cursor.execute("SELECT type, COUNT(*) FROM registry_items GROUP BY type ORDER BY type;")
        stats = cursor.fetchall()
        total = 0
        for item_type, count in stats:
            print(f"   - {item_type}: {count} items")
            total += count
        print(f"   - Total: {total} items\n")
        
        # Query 2: High scoring items
        print("2. High Scoring Items (score > 4.0):")
        cursor.execute("""
            SELECT type, title, summary_score 
            FROM registry_items 
            WHERE summary_score > 4.0 
            ORDER BY summary_score DESC 
            LIMIT 10;
        """)
        results = cursor.fetchall()
        if results:
            for item_type, title, score in results:
                print(f"   - {item_type}: {title} (score: {score})")
        else:
            print("   - No items with score > 4.0 found")
        print()
        
        # Query 3: Search by keywords (Angular example)
        print("3. Items containing 'angular' in keywords or applyTo:")
        cursor.execute("""
            SELECT type, title, apply_to, keywords 
            FROM registry_items 
            WHERE keywords LIKE '%angular%' 
               OR apply_to LIKE '%angular%'
               OR title LIKE '%angular%'
            LIMIT 10;
        """)
        results = cursor.fetchall()
        if results:
            for item_type, title, apply_to, keywords in results:
                print(f"   - {item_type}: {title}")
                if apply_to:
                    try:
                        apply_to_list = json.loads(apply_to) if apply_to != 'general' else ['general']
                        print(f"     Apply To: {', '.join(apply_to_list) if isinstance(apply_to_list, list) else apply_to}")
                    except:
                        print(f"     Apply To: {apply_to}")
        else:
            print("   - No Angular-related items found")
        print()
        
        # Query 4: Recent updates
        print("4. Recently Updated Items (last 30 days):")
        cursor.execute("""
            SELECT type, title, last_updated
            FROM registry_items 
            WHERE last_updated > datetime('now', '-30 days')
            ORDER BY last_updated DESC 
            LIMIT 5;
        """)
        results = cursor.fetchall()
        if results:
            for item_type, title, last_updated in results:
                print(f"   - {item_type}: {title} (updated: {last_updated})")
        else:
            print("   - No recently updated items found")
        print()
        
        # Query 5: Framework-specific instructions
        print("5. Framework-Specific Instructions:")
        cursor.execute("""
            SELECT title, agent_mode, instruction_type
            FROM registry_items 
            WHERE type = 'instructions' 
              AND agent_mode = 'framework-specific'
            ORDER BY title
            LIMIT 10;
        """)
        results = cursor.fetchall()
        if results:
            for title, agent_mode, instruction_type in results:
                print(f"   - {title} ({instruction_type})")
        else:
            print("   - No framework-specific instructions found")
        print()
        
        # Query 6: Developer personas
        print("6. Developer Personas:")
        cursor.execute("""
            SELECT title, description
            FROM registry_items 
            WHERE type = 'personas' 
              AND (title LIKE '%developer%' OR path LIKE '%developer%')
            ORDER BY title
            LIMIT 5;
        """)
        results = cursor.fetchall()
        if results:
            for title, description in results:
                print(f"   - {title}: {description}")
        else:
            print("   - No developer personas found")
        print()
        
        # Query 7: Complex search example
        print("7. Complex Query - JavaScript/TypeScript Items with High Scores:")
        cursor.execute("""
            SELECT type, title, summary_score, keywords
            FROM registry_items 
            WHERE (keywords LIKE '%javascript%' 
                   OR keywords LIKE '%typescript%' 
                   OR apply_to LIKE '%javascript%'
                   OR apply_to LIKE '%typescript%'
                   OR title LIKE '%JavaScript%'
                   OR title LIKE '%TypeScript%')
              AND summary_score >= 3.0
            ORDER BY summary_score DESC
            LIMIT 5;
        """)
        results = cursor.fetchall()
        if results:
            for item_type, title, score, keywords in results:
                print(f"   - {item_type}: {title} (score: {score})")
        else:
            print("   - No JavaScript/TypeScript items found")
        print()
        
        print("=== Test Complete ===")
        
    except Exception as e:
        print(f"Error running test queries: {e}")
    finally:
        conn.close()

if __name__ == "__main__":
    main()