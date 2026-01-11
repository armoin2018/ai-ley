# Install package in development mode
pip install -e .                   # Current directory
pip install -e ./path/to/package   # Specific path
pip install -e git+https://github.com/user/repo.git#egg=package  # Git repo

# Install with extras in development mode
pip install -e ".[dev,test]"

# Uninstall editable package
pip uninstall package-name         # Use package name, not path