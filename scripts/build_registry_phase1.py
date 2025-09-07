import hashlib
import json
import os


def get_md5(file_path):
    """Computes the MD5 hash of a file."""
    hash_md5 = hashlib.md5()
    try:
        with open(file_path, "rb") as f:
            for chunk in iter(lambda: f.read(4096), b""):
                hash_md5.update(chunk)
        return hash_md5.hexdigest()
    except IOError as e:
        print(f"Could not read file {file_path} for MD5 calculation: {e}")
        return None

def main():
    """
    Scans specified folders, compares file MD5 hashes with the existing registry,
    and creates a worklist of files that are new or have been modified.
    """
    base_path = "/Users/blainemcdonnell/git/ai-ley/.ai-ley/shared"
    registry_path = os.path.join(base_path, "variables/registry.json")
    worklist_path = "/Users/blainemcdonnell/git/ai-ley/.project/WORKLIST.md"
    
    folders_to_scan = {
        "personas": os.path.join(base_path, "personas"),
        "instructions": os.path.join(base_path, "instructions"),
        "prompts": os.path.join(base_path, "prompts"),
        "schemas": os.path.join(base_path, "schemas"),
        "policies": os.path.join(base_path, "policies"),
    }

    existing_registry = {}
    if os.path.exists(registry_path):
        try:
            with open(registry_path, 'r', encoding='utf-8') as f:
                existing_registry = json.load(f)
        except (IOError, json.JSONDecodeError) as e:
            print(f"Error reading or parsing registry file {registry_path}: {e}")
            # Proceed with an empty registry if the file is corrupted
            existing_registry = {}

    worklist = []

    for key, folder_path in folders_to_scan.items():
        if not os.path.isdir(folder_path):
            print(f"Warning: Folder for '{key}' not found at {folder_path}")
            continue
        for root, _, files in os.walk(folder_path):
            for file in files:
                if file in ["README.md", "CHANGES.md", ".gitkeep"]:
                    continue
                
                file_path = os.path.join(root, file)
                relative_path = os.path.relpath(file_path, "/Users/blainemcdonnell/git/ai-ley")
                
                file_md5 = get_md5(file_path)
                if file_md5 is None:
                    continue
                
                name = os.path.splitext(file)[0]

                entry = existing_registry.get(key, {}).get(name)
                
                if not entry or entry.get("md5sum") != file_md5:
                    worklist.append(relative_path)

    # Create .project directory if it doesn't exist
    os.makedirs(os.path.dirname(worklist_path), exist_ok=True)

    try:
        with open(worklist_path, 'w', encoding='utf-8') as f:
            for item in worklist:
                f.write(f"{item}\n")
    except IOError as e:
        print(f"Error writing to worklist file {worklist_path}: {e}")


    print(f"Worklist created at {worklist_path} with {len(worklist)} items.")

if __name__ == "__main__":
    main()
