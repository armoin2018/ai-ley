# Use cache for faster installs
pip install --cache-dir ~/.cache/pip requests

# Install from local cache only
pip install --find-links ~/.cache/pip --no-index requests

# Parallel downloads (pip 20.3+)
pip install requests flask django    # Downloads in parallel

# Use pre-compiled wheels
pip install --only-binary=all numpy scipy pandas

# Disable unnecessary features
pip install --no-compile requests    # Skip bytecode compilation
pip install --no-deps requests       # Skip dependency resolution