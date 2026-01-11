# Optimize repository
git gc                # Garbage collection
git gc --aggressive   # More thorough optimization

# Prune remote tracking branches
git remote prune origin

# Shallow clone for large repositories
git clone --depth 1 url

# Partial clone (Git 2.19+)
git clone --filter=blob:none url

# Check repository size
git count-objects -vH