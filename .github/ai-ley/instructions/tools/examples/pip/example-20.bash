# Check cache usage
pip cache info

# Cache specific packages
pip download -d ~/.cache/pip requests flask

# Use local cache as index
pip install --find-links ~/.cache/pip --no-index requests

# Warm cache for requirements
pip download -r requirements.txt -d ~/.cache/pip