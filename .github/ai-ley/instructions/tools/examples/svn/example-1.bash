# Install SVN client (Ubuntu/Debian)
sudo apt-get install subversion

# Install SVN client (macOS with Homebrew)
brew install subversion

# Install SVN client (Windows)
# Download TortoiseSVN from https://tortoisesvn.net/

# Verify installation
svn --version

# Configure user settings
svn config --editor-cmd "code --wait"
svn config set global-ignores "*.log *.tmp .DS_Store"