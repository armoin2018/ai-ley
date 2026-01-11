# pip comes with Python 3.4+, but to upgrade:
python -m pip install --upgrade pip

# Install pip on older Python versions
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py

# Platform-specific installations
# macOS (with Homebrew Python)
brew install python          # Includes pip

# Ubuntu/Debian
sudo apt update
sudo apt install python3-pip

# CentOS/RHEL/Fedora
sudo yum install python3-pip
# or
sudo dnf install python3-pip

# Windows (Python from python.org includes pip)
# Verify installation
python -m pip --version
pip --version