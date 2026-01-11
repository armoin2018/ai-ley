# Bypass hooks for emergency commit
git commit --no-verify -m "hotfix: critical security patch"

# Skip specific hook types
HUSKY_SKIP_HOOKS=1 git commit -m "skip all hooks"

# Debug hook execution
HUSKY_DEBUG=1 git commit -m "debug hook execution"