# .husky/pre-commit - Secure environment handling
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check for sensitive data in commits
echo "🔒 Scanning for sensitive data..."

# Check for common secrets patterns
if git diff --cached | grep -E "(password|secret|key|token)" >/dev/null; then
  echo "⚠️  Potential sensitive data detected in commit"
  echo "Please review your changes before committing"
fi

# Use environment variables securely
if [ -n "$SECURITY_SCAN_ENABLED" ]; then
  npm run security:scan
fi