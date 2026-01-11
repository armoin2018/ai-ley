# Enable Git tracing
GIT_TRACE=1 git command
GIT_TRACE_PACKET=1 git push  # Network operations
GIT_TRACE_PERFORMANCE=1 git command  # Performance analysis

# Verbose output
git --verbose command
git push --verbose
git pull --verbose

# Check repository integrity
git fsck --full
git count-objects -v