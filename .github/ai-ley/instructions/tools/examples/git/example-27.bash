# Add submodule
git submodule add https://github.com/user/library.git lib/library

# Initialize submodules after cloning
git submodule init
git submodule update

# Update submodules
git submodule update --remote

# Clone repository with submodules
git clone --recursive https://github.com/user/project.git

# Add subtree (alternative to submodules)
git subtree add --prefix=lib/library https://github.com/user/library.git main --squash

# Update subtree
git subtree pull --prefix=lib/library https://github.com/user/library.git main --squash