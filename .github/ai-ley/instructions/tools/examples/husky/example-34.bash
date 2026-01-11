# .husky/pre-commit - Network-aware security
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Only run network-dependent checks when online
if ping -c 1 google.com >/dev/null 2>&1; then
  echo "🌐 Network available, running online security checks..."
  npm audit --audit-level moderate
else
  echo "🔌 No network connection, skipping online security checks"
fi