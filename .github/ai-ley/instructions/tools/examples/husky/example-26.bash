# .husky/pre-commit - Docker environment validation
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Check if Docker is available and project uses Docker
if command -v docker >/dev/null 2>&1 && [ -f "Dockerfile" ]; then
  echo "🐳 Validating Docker configuration..."

  # Lint Dockerfile
  docker run --rm -i hadolint/hadolint < Dockerfile || {
    echo "⚠️  Dockerfile linting issues found"
  }

  # Test Docker build (quick check)
  docker build --target development . -t temp-build-test || {
    echo "❌ Docker build failed"
    exit 1
  }

  # Cleanup
  docker rmi temp-build-test >/dev/null 2>&1
fi