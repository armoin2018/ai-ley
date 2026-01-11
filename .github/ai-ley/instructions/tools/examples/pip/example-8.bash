# Basic installation
pip install requests                    # Latest version
pip install requests==2.31.0           # Specific version
pip install "requests>=2.31.0,<3.0.0"  # Version range
pip install requests~=2.31.0           # Compatible release

# Install from requirements file
pip install -r requirements.txt
pip install -r requirements-dev.txt

# Install with extras
pip install requests[security,socks]
pip install "django[argon2,bcrypt]"

# Install from different sources
pip install requests                    # PyPI (default)
pip install --index-url https://pypi.anaconda.org/simple/ numpy
pip install --extra-index-url https://download.pytorch.org/whl/cpu torch

# Install from Git repositories
pip install git+https://github.com/user/repo.git
pip install git+https://github.com/user/repo.git@v1.0.0
pip install git+https://github.com/user/repo.git@branch-name
pip install git+ssh://git@github.com/user/repo.git

# Install from local sources
pip install .                          # Current directory
pip install -e .                       # Editable/development install
pip install ./path/to/package          # Local package
pip install file:///absolute/path/to/package

# Install from URLs
pip install https://files.pythonhosted.org/packages/.../package.whl
pip install https://github.com/user/repo/archive/main.zip

# System-level installations (use with caution)
pip install --user requests            # User-level install
sudo pip install requests              # System-wide (not recommended)

# Force reinstall
pip install --force-reinstall requests
pip install --upgrade --force-reinstall requests