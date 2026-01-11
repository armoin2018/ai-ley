# docker-build-optimizer.sh - Optimize Docker builds
cat > docker-build-optimizer.sh << 'EOF'
#!/bin/bash
set -euo pipefail

IMAGE_NAME="${1:-}"
DOCKERFILE_PATH="${2:-Dockerfile}"
BUILD_CONTEXT="${3:-.}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [OPTIMIZER] $*"
}

# Analyze Dockerfile for optimization opportunities
analyze_dockerfile() {
    local dockerfile="$1"

    log "Analyzing Dockerfile for optimization opportunities..."

    local issues=0

    # Check for layer optimization
    if grep -c "RUN" "$dockerfile" > 5; then
        log "⚠️ Too many RUN instructions ($(grep -c "RUN" "$dockerfile")). Consider combining them."
        ((issues++))
    fi

    # Check for COPY optimization
    if grep -q "COPY \. " "$dockerfile"; then
        log "⚠️ Copying entire context (COPY . ). Consider using .dockerignore or specific paths."
        ((issues++))
    fi

    # Main execution
    if [ -z "$IMAGE_NAME" ]; then
        echo "Usage: $0 <image_name> [dockerfile_path] [build_context]"
        exit 1
    fi

    analyze_dockerfile "$DOCKERFILE_PATH"
    log "Docker build optimization completed for: $IMAGE_NAME"
fi
EOF

chmod +x docker-build-optimizer.sh