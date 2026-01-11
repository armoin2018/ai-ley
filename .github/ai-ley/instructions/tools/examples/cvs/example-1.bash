# Install CVS client (Ubuntu/Debian)
sudo apt-get install cvs

# Install CVS client (macOS with Homebrew)
brew install cvs

# Install CVS client (CentOS/RHEL)
sudo yum install cvs

# Verify installation
cvs --version

# Set CVSROOT environment variable
export CVSROOT=:pserver:username@cvs.example.com:/cvsroot
# or for local repository
export CVSROOT=/path/to/local/cvsroot

# Login to CVS server (for pserver)
cvs login

# Set editor for commit messages
export EDITOR=vim