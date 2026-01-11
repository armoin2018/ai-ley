# Add trusted host
pip install --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org requests

# Update certificates (macOS)
/Applications/Python\ 3.x/Install\ Certificates.command

# Configure globally
pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org"