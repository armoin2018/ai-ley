# pip configuration via environment variables
export PIP_INDEX_URL=https://pypi.org/simple/
export PIP_EXTRA_INDEX_URL=https://pypi.anaconda.org/simple/
export PIP_CACHE_DIR=~/.cache/pip
export PIP_TIMEOUT=60
export PIP_RETRIES=3

# Proxy configuration
export PIP_PROXY=http://proxy.server:port
export HTTP_PROXY=http://proxy.server:port
export HTTPS_PROXY=http://proxy.server:port

# Authentication
export PIP_INDEX_URL=https://username:password@pypi.example.com/simple/

# Disable version check
export PIP_DISABLE_PIP_VERSION_CHECK=1