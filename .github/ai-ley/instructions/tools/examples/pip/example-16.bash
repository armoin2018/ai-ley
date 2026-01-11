# Start new Python project
mkdir myproject && cd myproject
python -m venv venv
source venv/bin/activate            # macOS/Linux
# or venv\Scripts\activate          # Windows

# Install development tools
pip install --upgrade pip setuptools wheel
pip install pytest black flake8 mypy

# Create requirements files
echo "requests>=2.31.0" > requirements.in
echo "flask>=2.3.0" >> requirements.in
pip-compile requirements.in

echo "pytest>=7.4.0" > requirements-dev.in
echo "black>=23.7.0" >> requirements-dev.in
pip-compile requirements-dev.in

# Install dependencies
pip install -r requirements.txt -r requirements-dev.txt