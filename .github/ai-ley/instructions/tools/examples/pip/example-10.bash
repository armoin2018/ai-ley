# Create and activate virtual environment
python -m venv myproject
source myproject/bin/activate          # macOS/Linux
myproject\Scripts\activate             # Windows

# Install packages in virtual environment
pip install django flask pytest

# Save environment state
pip freeze > requirements.txt

# Recreate environment
deactivate
rm -rf myproject
python -m venv myproject
source myproject/bin/activate
pip install -r requirements.txt

# Alternative: conda environments
conda create -n myproject python=3.11
conda activate myproject
pip install -r requirements.txt