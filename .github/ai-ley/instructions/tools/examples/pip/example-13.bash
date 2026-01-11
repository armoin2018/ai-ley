# constraints.txt - Constrain transitive dependencies
setuptools<60.0.0
urllib3<2.0.0

# Install with constraints
pip install -c constraints.txt requests
pip install -r requirements.txt -c constraints.txt