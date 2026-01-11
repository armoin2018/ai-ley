# Basic test execution
pytest                              # Run all tests
pytest tests/                       # Run tests in directory
pytest tests/test_users.py          # Run specific test file
pytest tests/test_users.py::test_create_user  # Run specific test

# Test discovery and collection
pytest --collect-only              # Show which tests would run
pytest --collect-only -q           # Quiet collection output

# Output and reporting
pytest -v                          # Verbose output
pytest -s                          # Show print statements
pytest --tb=short                  # Short traceback format
pytest --tb=long                   # Long traceback format
pytest --tb=no                     # No traceback

# Parallel execution
pytest -n auto                     # Auto-detect CPU cores
pytest -n 4                       # Use 4 processes
pytest --dist=loadscope           # Distribute by test scope

# Coverage reporting
pytest --cov=src                  # Generate coverage report
pytest --cov=src --cov-report=html  # HTML coverage report
pytest --cov=src --cov-report=xml   # XML coverage report

# Test selection
pytest -k "user"                  # Run tests matching pattern
pytest -m "unit"                  # Run tests with specific marker
pytest -m "not slow"              # Exclude tests with marker
pytest --maxfail=1                # Stop after first failure

# Advanced options
pytest --pdb                      # Drop into debugger on failure
pytest --pdbcls=IPython.terminal.debugger:Pdb  # Use IPython debugger
pytest --durations=10             # Show 10 slowest tests
pytest --setup-show               # Show fixture setup/teardown