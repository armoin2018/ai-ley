# Shallow clone for large repos
git clone --depth 1 <url>

# Partial clone (Git 2.19+)
git clone --filter=blob:none <url>

# Clean up repository
git gc --aggressive          # Garbage collection
git prune                    # Remove unreachable objects