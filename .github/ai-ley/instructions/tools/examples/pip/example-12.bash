# Install pip-tools
pip install pip-tools

# Create requirements.in (high-level dependencies)
echo "django>=4.2.0" > requirements.in
echo "requests" >> requirements.in

# Generate locked requirements.txt
pip-compile requirements.in

# Update requirements
pip-compile --upgrade requirements.in

# Install from compiled requirements
pip-sync requirements.txt

# Development workflow with pip-tools
pip-compile requirements.in
pip-compile requirements-dev.in
pip-sync requirements.txt requirements-dev.txt