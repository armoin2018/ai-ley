# Ensure proper naming
# Files: test_*.py or *_test.py
# Functions: test_*
# Classes: Test*

# Check discovery
pytest --collect-only

# Verify configuration
pytest --markers