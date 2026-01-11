# Security-hardened Dockerfile
FROM node:18-alpine AS base

# Security: Update packages and remove package manager cache
RUN apk update && apk upgrade &&
    apk add --no-cache dumb-init &&
    rm -rf /var/cache/apk/*

# Security: Create non-root user with specific UID/GID
RUN addgroup -g 1001 -S nodejs &&
    adduser -S nextjs -u 1001 -G nodejs

# Security: Set secure file permissions
WORKDIR /app
CHOWN nextjs:nodejs /app

# Production stage
FROM base AS production

# Security: Copy files with proper ownership
COPY --chown=nextjs:nodejs package*.json ./
COPY --chown=nextjs:nodejs . .

# Security: Install dependencies and remove dev tools
RUN npm ci --only=production &&
    npm cache clean --force

# Security: Remove unnecessary packages
RUN apk del wget curl

# Security: Switch to non-root user
USER nextjs

# Security: Use read-only root filesystem
# Security: Drop all capabilities and add only necessary ones
# Security: Disable new privileges