# Verbose output
git --verbose <command>

# Debug information
GIT_TRACE=1 git <command>
GIT_TRACE_PACKET=1 git <command>

# Configuration debugging
git config --list --show-origin