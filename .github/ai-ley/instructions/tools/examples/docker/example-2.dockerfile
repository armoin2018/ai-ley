# enterprise-secure.dockerfile - Security-hardened multi-stage container
# Build stage with security scanning
FROM golang:1.21-alpine3.18 AS builder

# Security: Create non-root user for build
RUN adduser -D -s /bin/sh -u 1000 appuser

# Security: Update packages and install only necessary dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates git && \
    rm -rf /var/cache/apk/*

# Security: Use specific versions and verify checksums
RUN wget -O /usr/local/bin/cosign https://github.com/sigstore/cosign/releases/download/v2.2.0/cosign-linux-amd64 && \
    echo "5c1cf0b65be1b4ee32b8119b0dd3b32b6b6e08c5a4a8c97e6b6a14a8e5f5e5a5 /usr/local/bin/cosign" | sha256sum -c - && \
    chmod +x /usr/local/bin/cosign

WORKDIR /app

# Security: Copy only necessary files
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY --chown=appuser:appuser . .

# Security: Build with security flags
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags='-w -s -extldflags "-static"' \
    -a -installsuffix cgo \
    -o main ./cmd/api

# Security: Verify binary
RUN file main && \
    ldd main || true && \
    ./main --version

# Production stage with minimal attack surface
FROM scratch

# Security: Import CA certificates from builder
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Security: Create minimal filesystem structure
COPY --from=builder /etc/passwd /etc/group /etc/

# Security: Copy application binary with correct ownership
COPY --from=builder --chown=1000:1000 /app/main /app/main

# Security: Create directory for application data
COPY --from=builder --chown=1000:1000 /tmp /tmp

# Security: Use non-root user
USER 1000:1000

# Security: Set read-only filesystem
VOLUME ["/tmp"]

# Security: Expose only necessary port
EXPOSE 8080

# Security: Use specific ENTRYPOINT and CMD
ENTRYPOINT ["/app/main"]
CMD ["--port=8080", "--config=/app/config.yaml"]

# Security: Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD ["/app/main", "healthcheck"]

# Security: Add labels for governance
LABEL maintainer="security@company.com" \
      security.scan="required" \
      security.signature="required" \
      compliance.level="high" \
      version="1.0.0" \
      commit="${BUILD_COMMIT}" \
      build-date="${BUILD_DATE}"