# Base requirements (requirements-base.in)
requests>=2.31.0
click>=8.1.0

# Production requirements (requirements-prod.in)
-r requirements-base.in
gunicorn>=21.0.0
psycopg2-binary>=2.9.0

# Development requirements (requirements-dev.in)
-r requirements-base.in
pytest>=7.4.0
black>=23.7.0
mypy>=1.5.0

# Generate all requirement files
pip-compile requirements-base.in
pip-compile requirements-prod.in
pip-compile requirements-dev.in

# Install for development
pip install -r requirements-dev.txt

# Install for production
pip install -r requirements-prod.txt