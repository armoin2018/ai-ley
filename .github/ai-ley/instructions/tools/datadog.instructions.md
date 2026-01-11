---
name: 'datadog.instructions'
description: 'Development guidelines and best practices for Datadog.Instructions'
keywords: [compose.yml, api, application, configuration**, agent, backend, configuration, database, advanced, datadog]
---



# **🐕 Enterprise Datadog Application Performance Monitoring Platform**

## **📊 Advanced APM & Observability Intelligence**

Transform your enterprise monitoring capabilities with comprehensive Datadog-powered observability, featuring AI-driven performance insights, distributed tracing, intelligent alerting, and real-time business intelligence for mission-critical applications and infrastructure.

---

## **🚀 Enterprise Datadog Configuration Framework**

### **⚙️ Core Enterprise Configuration**

`See [example-1](./examples/datadog/example-1.python)yaml
# docker-compose.yml - Enterprise Datadog Agent Stack
version: '3.8'

services:
  # Datadog Agent - Infrastructure Monitoring
  datadog-agent:
    image: datadog/agent:latest
    container_name: datadog-agent-enterprise
    restart: unless-stopped
    environment:
      # Core Configuration
      DD_API_KEY: ${DD_API_KEY}
      DD_SITE: ${DD_SITE:-datadoghq.com}
      DD_HOSTNAME: ${DD_HOSTNAME:-datadog-agent}
      DD_TAGS: "${DD_TAGS:-env:production,team:platform,tier:enterprise}"

      # APM Configuration
      DD_APM_ENABLED: true
      DD_APM_NON_LOCAL_TRAFFIC: true
      DD_APM_RECEIVER_PORT: 8126
      DD_APM_DD_URL: https://trace.agent.${DD_SITE}
      DD_APM_ANALYZED_SPANS: |
        web-service|http.request:1,
        auth-service|grpc.request:1,
        payment-service|database.query:0.1

      # Log Management
      DD_LOGS_ENABLED: true
      DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL: true
      DD_LOGS_CONFIG_DOCKER_LABELS_AS_TAGS: true
      DD_LOGS_CONFIG_AUTO_MULTI_LINE_DETECTION: true
      DD_LOGS_CONFIG_USE_DATE_REMAPPING: true

      # Process Monitoring
      DD_PROCESS_AGENT_ENABLED: true
      DD_PROCESS_CONFIG_PROCESS_COLLECTION_ENABLED: true
      DD_PROCESS_CONFIG_CONTAINER_COLLECTION_ENABLED: true

      # Network Monitoring (Enterprise Feature)
      DD_SYSTEM_PROBE_ENABLED: true
      DD_SYSTEM_PROBE_NETWORK_ENABLED: true
      DD_SYSTEM_PROBE_SERVICE_MONITORING_ENABLED: true

      # Security Monitoring (Enterprise Feature)
      DD_RUNTIME_SECURITY_CONFIG_ENABLED: true
      DD_RUNTIME_SECURITY_CONFIG_REMOTE_CONFIGURATION_ENABLED: true
      DD_COMPLIANCE_CONFIG_ENABLED: true

      # Database Monitoring
      DD_DATABASE_MONITORING_ENABLED: true
      DD_INTEGRATIONS_POSTGRES_COLLECT_DATABASE_SIZE_METRICS: true
      DD_INTEGRATIONS_MYSQL_COLLECT_ENGINE_METRICS: true

      # Synthetic Monitoring
      DD_SYNTHETICS_CONFIG_ENABLED: true
      DD_SYNTHETICS_PRIVATE_LOCATION_WORKER: true

      # Performance & Resource Limits
      DD_DOGSTATSD_BUFFER_SIZE: 8192
      DD_DOGSTATSD_NON_LOCAL_TRAFFIC: true
      DD_DOGSTATSD_STATS_BUFFER: 10
      DD_HISTOGRAM_AGGREGATES: "max,median,avg,count"
      DD_HISTOGRAM_PERCENTILES: "0.95,0.99"

      # Enterprise Features
      DD_REMOTE_CONFIGURATION_ENABLED: true
      DD_INVENTORIES_CONFIGURATION_ENABLED: true
      DD_SBOM_CONTAINER_IMAGE_ENABLED: true
      DD_CONTAINER_IMAGE_ENABLED: true

    volumes:
      # System monitoring
                    
      # Configuration
            
      # Security monitoring
            
      # APM socket
    
    ports:
        
    networks:
        
    cap_add:
                                
    security_opt:
    
    pid: host

    deploy:
      resources:
        limits:
          memory: 1G
          cpus: '0.5'
        reservations:
          memory: 512M
          cpus: '0.25'

    healthcheck:
      test: ["CMD", "datadog-agent", "health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s

  # Datadog Cluster Agent (Enterprise Kubernetes Integration)
  datadog-cluster-agent:
    image: datadog/cluster-agent:latest
    container_name: datadog-cluster-agent-enterprise
    restart: unless-stopped
    environment:
      # Core Configuration
      DD_API_KEY: ${DD_API_KEY}
      DD_APP_KEY: ${DD_APP_KEY}
      DD_CLUSTER_AGENT_AUTH_TOKEN: ${DD_CLUSTER_AGENT_AUTH_TOKEN}
      DD_CLUSTER_NAME: ${DD_CLUSTER_NAME:-production-cluster}
      DD_SITE: ${DD_SITE:-datadoghq.com}

      # Cluster Monitoring
      DD_CLUSTER_CHECKS_ENABLED: true
      DD_EXTRA_CONFIG_PROVIDERS: "kube_endpoints kube_services"
      DD_EXTRA_LISTENERS: "kube_endpoints kube_services"

      # External Metrics
      DD_EXTERNAL_METRICS_PROVIDER_ENABLED: true
      DD_EXTERNAL_METRICS_PROVIDER_PORT: 8443
      DD_EXTERNAL_METRICS_PROVIDER_WPA_CONTROLLER: true

      # Admission Controller (Enterprise Feature)
      DD_ADMISSION_CONTROLLER_ENABLED: true
      DD_ADMISSION_CONTROLLER_MUTATE_UNLABELLED: true
      DD_ADMISSION_CONTROLLER_SERVICE_NAME: datadog-admission-controller

      # Orchestrator Explorer
      DD_ORCHESTRATOR_EXPLORER_ENABLED: true
      DD_ORCHESTRATOR_EXPLORER_CONTAINER_SCRUBBING_ENABLED: true

    ports:
        
    networks:
    
    volumes:
    
    deploy:
      resources:
        limits:
          memory: 512M
          cpus: '0.25'
        reservations:
          memory: 256M
          cpus: '0.1'

    healthcheck:
      test: ["CMD", "datadog-cluster-agent", "health"]
      interval: 30s
      timeout: 10s
      retries: 3

  # Datadog Synthetics Private Location Worker
  synthetics-worker:
    image: datadog/synthetics-private-location-worker:latest
    container_name: datadog-synthetics-worker
    restart: unless-stopped
    environment:
      DATADOG_API_KEY: ${DD_API_KEY}
      DATADOG_ACCESS_KEY: ${DD_SYNTHETICS_ACCESS_KEY}
      DATADOG_SECRET_ACCESS_KEY: ${DD_SYNTHETICS_SECRET_KEY}
      DATADOG_PRIVATE_KEY: ${DD_SYNTHETICS_PRIVATE_KEY}
      DATADOG_PUBLIC_KEY_PEM: ${DD_SYNTHETICS_PUBLIC_KEY}
      DATADOG_SITE: ${DD_SITE:-datadoghq.com}

      # Worker Configuration
      CONCURRENCY: 10
      WORKER_TIMEOUT: 300
      LOG_LEVEL: INFO

    volumes:
    
    networks:
        
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '1.0'
        reservations:
          memory: 1G
          cpus: '0.5'

  # Custom Application with Datadog Integration
  sample-app:
    image: your-registry/sample-app:latest
    container_name: sample-app-with-datadog
    restart: unless-stopped
    environment:
      # Datadog APM Configuration
      DD_AGENT_HOST: datadog-agent
      DD_TRACE_AGENT_PORT: 8126
      DD_SERVICE: sample-app
      DD_ENV: ${DD_ENV:-production}
      DD_VERSION: ${APP_VERSION:-1.0.0}
      DD_TAGS: "team:backend,tier:application"

      # APM Features
      DD_TRACE_ENABLED: true
      DD_PROFILING_ENABLED: true
      DD_RUNTIME_METRICS_ENABLED: true
      DD_TRACE_STARTUP_LOGS: true
      DD_TRACE_DEBUG: false
      DD_TRACE_SAMPLE_RATE: 1.0

      # Database Monitoring Integration
      DD_DBM_PROPAGATION_MODE: full

      # Log Integration
      DD_LOGS_INJECTION: true

    volumes:
    
    networks:
        
    depends_on:
    
    labels:
      com.datadoghq.ad.logs: '[{"source": "sample-app", "service": "sample-app", "log_processing_rules": [{"type": "multi_line", "name": "log_start_with_date", "pattern": "\d{4}-\d{2}-\d{2}"}]}]'
      com.datadoghq.ad.check_names: '["http_check"]'
      com.datadoghq.ad.init_configs: '[{}]'
      com.datadoghq.ad.instances: '[{"name": "sample-app-health", "url": "http://%%host%%:8080/health", "timeout": 5}]'

volumes:
  datadog-apm-socket:
  synthetics-worker-data:

networks:
  datadog-network:
    driver: bridge
    ipam:
      config:
        app-network:
    driver: bridge
    ipam:
      config:
      
---
# kubernetes-datadog.yaml - Enterprise Kubernetes Deployment
apiVersion: v1

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
