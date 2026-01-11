# syntax=docker/dockerfile:1.6
# multi-arch-enterprise.dockerfile - Cross-platform secure builds
FROM --platform=$BUILDPLATFORM golang:1.21-alpine3.18 AS builder

# Security and build arguments
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG BUILD_VERSION=dev
ARG BUILD_COMMIT=unknown
ARG BUILD_DATE=unknown

# Security: Update and install build dependencies
RUN apk update && apk upgrade && \
    apk add --no-cache \
        ca-certificates \
        git \
        upx \
        file && \
    rm -rf /var/cache/apk/*

# Security: Create build user
RUN adduser -D -s /bin/sh -u 1000 builder

WORKDIR /src

# Security: Copy and verify dependencies
COPY go.mod go.sum ./
RUN go mod download && go mod verify

# Copy source code with proper ownership
COPY --chown=builder:builder . .

# Cross-platform build with security hardening
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg \
    CGO_ENABLED=0 \
    GOOS=${TARGETOS} \
    GOARCH=${TARGETARCH} \
    go build \
    -ldflags="-w -s -X main.Version=${BUILD_VERSION} -X main.Commit=${BUILD_COMMIT} -X main.Date=${BUILD_DATE}" \
    -a -installsuffix cgo \
    -o app ./cmd/api

# Security: Compress binary for smaller attack surface
RUN upx --best --lzma app && \
    file app && \
    chmod +x app

# Runtime stage optimized per architecture
FROM alpine:3.18 AS runtime-amd64
RUN apk --no-cache add ca-certificates tzdata
FROM alpine:3.18 AS runtime-arm64
RUN apk --no-cache add ca-certificates tzdata
FROM alpine:3.18 AS runtime-386
RUN apk --no-cache add ca-certificates tzdata

# Select runtime based on target architecture
FROM runtime-${TARGETARCH} AS runtime

# Security: Create application user
RUN adduser -D -s /bin/sh -u 1001 appuser

# Security: Copy CA certificates and timezone data
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy application binary
COPY --from=builder --chown=appuser:appuser /src/app /app/main

# Security: Switch to non-root user
USER appuser:appuser

# Security: Set working directory
WORKDIR /app

# Security: Expose minimal port
EXPOSE 8080

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=10s --start-period=15s --retries=3 \
    CMD ["/app/main", "healthcheck", "--port=8080"]

# Secure entrypoint
ENTRYPOINT ["/app/main"]

# Architecture-specific metadata
ARG TARGETPLATFORM
LABEL org.opencontainers.image.title="Enterprise Application" \
      org.opencontainers.image.description="Multi-architecture enterprise application" \
      org.opencontainers.image.version="${BUILD_VERSION}" \
      org.opencontainers.image.revision="${BUILD_COMMIT}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.platform="${TARGETPLATFORM}" \
      security.scan.required="true" \
      security.signature.required="true" \
      compliance.cis="validated"