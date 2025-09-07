import os
from datetime import datetime

import frontmatter


def process_file(file_path):
    """
    Processes a single file, ensuring it has the required YAML frontmatter.
    Handles potential encoding issues.
    """
    try:
        # Try reading with utf-8 first
        with open(file_path, 'r', encoding='utf-8') as f:
            post = frontmatter.load(f)
    except UnicodeDecodeError:
        try:
            # If utf-8 fails, try with latin-1
            with open(file_path, 'r', encoding='latin-1') as f:
                post = frontmatter.load(f)
            print(f"Used 'latin-1' encoding for {file_path}")
        except Exception as e:
            print(f"Error loading frontmatter from {file_path} with fallback encoding: {e}")
            return
    except Exception as e:
        print(f"Error loading frontmatter from {file_path}: {e}")
        # If frontmatter fails to load, create a new one
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
        except UnicodeDecodeError:
            with open(file_path, 'r', encoding='latin-1') as f:
                content = f.read()
        post = frontmatter.Post(content)


    metadata = post.metadata
    updated = False

    # Default values for missing keys
    defaults = {
        'applyTo': 'general',
        'agentMode': 'general',
        'instructionType': 'general',
        'guidelines': 'N/A',
        'title': os.path.splitext(os.path.basename(file_path))[0].replace('-', ' ').title(),
        'description': 'Awaiting summary.',
        'version': '1.0.0',
        'author': 'AI-LEY',
        'lastUpdated': datetime.now().isoformat(),
        'keywords': [],
        'extensions': ['.md'],
        'summaryScore': 3.0
    }

    for key, value in defaults.items():
        if key not in metadata:
            metadata[key] = value
            updated = True

    if updated:
        post.metadata = metadata
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(frontmatter.dumps(post))
            print(f"Updated frontmatter for {file_path}")
        except Exception as e:
            print(f"Error writing updated frontmatter to {file_path}: {e}")
    else:
        print(f"No updates needed for {file_path}")

def main():
    worklist_path = "/Users/blainemcdonnell/git/ai-ley/.project/WORKLIST.md"
    
    if not os.path.exists(worklist_path) or os.path.getsize(worklist_path) == 0:
        print("Worklist not found or is empty. Forcing a full scan.")
        # If worklist is empty, we'll force a full scan by creating a temporary one
        base_path = "/Users/blainemcdonnell/git/ai-ley/.ai-ley/shared"
        folders_to_scan = [
            os.path.join(base_path, "personas"),
            os.path.join(base_path, "instructions"),
            os.path.join(base_path, "prompts"),
            os.path.join(base_path, "schemas"),
            os.path.join(base_path, "policies"),
        ]
        all_files = []
        for folder in folders_to_scan:
            if not os.path.isdir(folder):
                continue
            for root, _, files in os.walk(folder):
                for file in files:
                    if file not in ["README.md", "CHANGES.md", ".gitkeep"]:
                        all_files.append(os.path.relpath(os.path.join(root, file), "/Users/blainemcdonnell/git/ai-ley"))
        
        with open(worklist_path, 'w', encoding='utf-8') as f:
            for item in all_files:
                f.write(f"{item}\n")
        print(f"Created a temporary worklist with {len(all_files)} items.")


    with open(worklist_path, 'r', encoding='utf-8') as f:
        worklist = [line.strip() for line in f.readlines() if line.strip()]

    for file_rel_path in worklist:
        file_abs_path = os.path.join("/Users/blainemcdonnell/git/ai-ley", file_rel_path)
        if os.path.exists(file_abs_path):
            process_file(file_abs_path)
        else:
            print(f"File not found: {file_abs_path}")

    # Clear the worklist after processing
    with open(worklist_path, 'w', encoding='utf-8') as f:
        f.write("")
    print("Worklist processed and cleared.")


if __name__ == "__main__":
    main()
