# High-level dependencies (requirements.in)
django>=4.2.0
requests
celery[redis]

# Generate locked file
pip-compile requirements.in         # Creates requirements.txt with exact versions

# Regular updates
pip-compile --upgrade requirements.in

# Security updates only
pip-compile --upgrade-package django requirements.in