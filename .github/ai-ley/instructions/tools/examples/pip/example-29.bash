# Enable verbose output
pip install --verbose requests
pip -v install requests

# Debug specific issues
pip debug --verbose               # Show environment info
pip config debug                 # Show configuration sources

# Check pip installation
python -m pip --version
python -c "import pip; print(pip.__file__)"

# Verify package integrity
pip install --force-reinstall --no-deps requests
python -c "import requests; print(requests.__version__)"