# Advanced multi-stage build for Go application
# Stage 1: Build environment with all tools
FROM golang:1.21-alpine AS builder

# Install build dependencies
RUN apk add --no-cache git ca-certificates tzdata

# Create non-root user for final stage
RUN adduser -D -g '' appuser

WORKDIR /src

# Copy dependency files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download
RUN go mod verify

# Copy source code
COPY . .

# Build statically linked binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64
    go build -ldflags='-w -s -extldflags "-static"'
    -a -installsuffix cgo -o app ./cmd/server

# Stage 2: Minimal runtime environment
FROM scratch AS runner

# Copy time zone data
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo

# Copy SSL certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy user account information
COPY --from=builder /etc/passwd /etc/passwd

# Copy built application
COPY --from=builder /src/app /app

# Use non-root user
USER appuser

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3
  CMD ["/app", "-health-check"]

# Run application
ENTRYPOINT ["/app"]