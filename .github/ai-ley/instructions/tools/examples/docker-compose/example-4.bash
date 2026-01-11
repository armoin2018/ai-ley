# Application instrumentation for comprehensive metrics
cat > ./monitoring/app-instrumentation.yml << 'EOF'
version: '3.8'

services:
  # Application with metrics endpoint
  instrumented-app:
    build:
      context: ./app
      dockerfile: Dockerfile.metrics
    image: enterprise/app:metrics-latest
    container_name: instrumented-app
    restart: always
    networks:
      - app-tier
      - monitoring
    environment:
      - METRICS_ENABLED=true
      - METRICS_PORT=9090
      - TRACING_ENABLED=true
      - JAEGER_ENDPOINT=http://jaeger:14268/api/traces
      - LOG_LEVEL=info
      - LOG_FORMAT=json
    ports:
      - "8080:8080"  # Application port
      - "9090:9090"  # Metrics port
    volumes:
      - ./app/logs:/app/logs
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          cpus: '0.5'
          memory: 512M
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 15s
      timeout: 5s
      retries: 3
    labels:
      - monitoring.scrape=true
      - monitoring.path=/metrics
      - monitoring.port=9090
      - tracing.enabled=true

  # Database exporter for MySQL metrics
  mysql-exporter:
    image: prom/mysqld-exporter:v0.14.0
    container_name: mysql-metrics-exporter
    restart: always
    networks:
      - db-tier
      - monitoring
    environment:
      - DATA_SOURCE_NAME=exporter:${MYSQL_EXPORTER_PASSWORD}@(database:3306)/
    ports:
      - "9104:9104"
    deploy:
      resources:
        limits:
          cpus: '0.25'
          memory: 128M
        reservations:
          cpus: '0.1'
          memory: 64M
    depends_on:
      - database
    labels:
      - monitoring.scrape=true
      - monitoring.service=mysql-exporter

  # Redis exporter for cache metrics
  redis-exporter:
    image: oliver006/redis_exporter:v1.50.0
    container_name: redis-metrics-exporter
    restart: always
    networks:
      - app-tier
      - monitoring
    environment:
      - REDIS_ADDR=redis://redis:6379
      - REDIS_PASSWORD=${REDIS_PASSWORD}
    ports:
      - "9121:9121"
    deploy:
      resources:
        limits:
          cpus: '0.25'
          memory: 128M
        reservations:
          cpus: '0.1'
          memory: 64M
    depends_on:
      - redis
    labels:
      - monitoring.scrape=true
      - monitoring.service=redis-exporter

  # Nginx exporter for web server metrics
  nginx-exporter:
    image: nginx/nginx-prometheus-exporter:0.10.0
    container_name: nginx-metrics-exporter
    restart: always
    networks:
      - frontend-dmz
      - monitoring
    command:
      - '-nginx.scrape-uri=http://reverse-proxy:8080/nginx_status'
    ports:
      - "9113:9113"
    deploy:
      resources:
        limits:
          cpus: '0.25'
          memory: 64M
        reservations:
          cpus: '0.1'
          memory: 32M
    depends_on:
      - reverse-proxy
    labels:
      - monitoring.scrape=true
      - monitoring.service=nginx-exporter
## 🔐 Enterprise Secret Management & Configuration

### Advanced Secret Management with HashiCorp Vault Integration