# Initialize new repository
git init
git init --bare  # Bare repository for server

# Clone existing repository
git clone https://github.com/user/repo.git
git clone git@github.com:user/repo.git  # SSH
git clone --depth 1 https://github.com/user/repo.git  # Shallow clone

# Clone specific branch
git clone -b feature-branch https://github.com/user/repo.git

# Clone to specific directory
git clone https://github.com/user/repo.git my-project