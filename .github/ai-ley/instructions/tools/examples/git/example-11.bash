# Initialize new Git repository
git init

# Initialize with specific branch name
git init -b main

# Clone existing repository
git clone https://github.com/username/repository.git
git clone git@github.com:username/repository.git

# Clone specific branch
git clone -b branch-name https://github.com/username/repository.git

# Clone with specific directory name
git clone https://github.com/username/repository.git my-project

# Shallow clone for large repositories
git clone --depth 1 https://github.com/username/repository.git