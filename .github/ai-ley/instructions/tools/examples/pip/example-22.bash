# Use virtual environment (recommended)
python -m venv venv
source venv/bin/activate
pip install requests

# Use user install
pip install --user requests

# Fix ownership (macOS/Linux)
sudo chown -R $(whoami) ~/.local/lib/python3.x/site-packages/