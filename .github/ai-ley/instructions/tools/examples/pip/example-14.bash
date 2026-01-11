# Install from custom index
pip install --index-url https://pypi.example.com/simple/ mypackage

# Multiple indexes
pip install --extra-index-url https://pypi.example.com/simple/ mypackage

# Authentication with custom index
pip install --index-url https://username:password@pypi.example.com/simple/ mypackage

# Use personal access token
pip install --index-url https://token:${TOKEN}@pypi.example.com/simple/ mypackage

# Configuration for custom index
pip config set global.index-url https://pypi.example.com/simple/
pip config set global.trusted-host pypi.example.com