# Create virtual environment
python -m venv myenv                    # Using venv (recommended)
python -m venv myenv --prompt="MyProject"  # Custom prompt

# Activate virtual environment
# On macOS/Linux:
source myenv/bin/activate

# On Windows:
myenv\Scripts\activate

# On Windows (PowerShell):
myenv\Scripts\Activate.ps1

# Deactivate virtual environment
deactivate

# Alternative: Using virtualenv
pip install virtualenv
virtualenv myenv
source myenv/bin/activate               # macOS/Linux
myenv\Scripts\activate                  # Windows