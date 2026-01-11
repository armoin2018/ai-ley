# Check for conflicts
pip check

# Use constraints file
echo "urllib3<2.0.0" > constraints.txt
pip install -c constraints.txt requests

# Create clean environment
deactivate
rm -rf venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt