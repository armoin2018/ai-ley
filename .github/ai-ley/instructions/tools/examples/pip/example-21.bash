# Build wheels for dependencies
pip wheel -r requirements.txt -w ./wheels

# Install from pre-built wheels
pip install --find-links ./wheels -r requirements.txt

# Build wheel for current package
pip wheel .

# Build source distribution
python setup.py sdist