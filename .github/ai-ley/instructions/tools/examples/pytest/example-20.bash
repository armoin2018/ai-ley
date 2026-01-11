# Run with PDB on failure
pytest --pdb

# Use IPython debugger
pytest --pdbcls=IPython.terminal.debugger:Pdb

# Show fixture setup and teardown
pytest --setup-show

# Show why tests are skipped
pytest -rs