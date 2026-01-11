# Security-hardened production Dockerfile
FROM node:18-alpine AS base

# Security: Install security updates
RUN apk update && apk upgrade &&
    apk add --no-cache dumb-init &&
    rm -rf /var/cache/apk/*

# Security: Create non-root user
RUN addgroup -g 1001 -S appgroup &&
    adduser -S appuser -u 1001 -G appgroup

FROM base AS production

WORKDIR /app

# Security: Copy with proper ownership
COPY --chown=appuser:appgroup package*.json ./
RUN npm ci --only=production &&
    npm cache clean --force

COPY --chown=appuser:appgroup . .

# Security: Remove unnecessary packages
RUN apk del wget curl &&
    rm -rf /var/cache/apk/*

# Security: Set file permissions
RUN chmod -R 755 /app &&
    chmod -R 644 /app/package*.json

# Security: Switch to non-root user
USER appuser

# Security: Use dumb-init for signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "index.js"]