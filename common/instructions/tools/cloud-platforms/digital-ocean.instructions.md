`
---
applyTo: "digitalocean, **/*digitalocean*, **/*droplet*"
---

# Digital Ocean Cloud Platform Instructions

## Overview
- **Domain**: Cloud Infrastructure and Platform as a Service
- **Purpose**: Deploy, manage, and scale applications using Digital Ocean's cloud services
- **Applicable To**: Web applications, APIs, databases, container orchestration, and static sites
- **Integration Level**: Full infrastructure management and application deployment

## Core Principles

### Fundamental Concepts
1. **Developer-Friendly Cloud**: Simple, intuitive cloud services designed for developers
2. **Predictable Pricing**: Transparent, fixed pricing with no hidden costs
3. **Performance Focus**: High-performance SSD-based infrastructure with global presence
4. **Open Source Support**: Strong commitment to open source technologies and community

### Key Benefits
- Simple and intuitive interface with powerful CLI and API
- Predictable pricing with no surprise charges
- Fast SSD-based droplets with excellent performance
- Global datacenter presence for low latency
- Comprehensive marketplace with one-click applications

### Common Misconceptions
- **Myth**: Digital Ocean is only for small projects and startups
  **Reality**: Scales to enterprise-level applications with advanced services
- **Myth**: Limited compared to AWS or Azure
  **Reality**: Covers most common use cases with simpler management

## Implementation Framework

### Getting Started
#### Prerequisites
- Digital Ocean account with billing configured
- Basic understanding of Linux administration
- SSH key pair for secure access
- Domain name for production deployments (optional)

#### Initial Setup
```bash
# Install doctl (Digital Ocean CLI)
# macOS
brew install doctl

# Linux
curl -sL https://github.com/digitalocean/doctl/releases/download/v1.98.1/doctl-1.98.1-linux-amd64.tar.gz | tar -xzv
sudo mv doctl /usr/local/bin

# Authenticate with Digital Ocean
doctl auth init

# Verify authentication
doctl account get
```

### Core Methodologies
#### Infrastructure as Code
- **Purpose**: Manage infrastructure through version-controlled code
- **When to Use**: Production environments and team collaboration
- **Implementation Steps**:
  1. Define infrastructure using Terraform or doctl scripts
  2. Version control infrastructure configurations
  3. Implement automated deployment pipelines
  4. Use consistent environments across dev/staging/production
- **Success Metrics**: Reproducible deployments and infrastructure consistency

#### Application Deployment
- **Purpose**: Deploy applications with proper scaling and monitoring
- **When to Use**: All application deployments beyond development
- **Implementation Steps**:
  1. Choose appropriate service (Droplets, App Platform, Kubernetes)
  2. Configure load balancing and SSL certificates
  3. Set up monitoring and alerting
  4. Implement backup and disaster recovery
- **Success Metrics**: High availability and automated scaling

### Process Integration
#### Development Workflow
```bash
# Create development environment
doctl compute droplet create dev-server \
  --image ubuntu-22-04-x64 \
  --size s-2vcpu-2gb \
  --region nyc3 \
  --ssh-keys $(doctl compute ssh-key list --format ID --no-header)

# Set up staging environment
doctl compute droplet create staging-server \
  --image ubuntu-22-04-x64 \
  --size s-2vcpu-4gb \
  --region nyc3 \
  --ssh-keys $(doctl compute ssh-key list --format ID --no-header)
```

#### Production Deployment
```bash
# Create production droplets with load balancer
doctl compute droplet create prod-web-01 prod-web-02 \
  --image ubuntu-22-04-x64 \
  --size s-4vcpu-8gb \
  --region nyc3 \
  --ssh-keys $(doctl compute ssh-key list --format ID --no-header)

# Create load balancer
doctl compute load-balancer create \
  --name prod-lb \
  --forwarding-rules entry_protocol:https,entry_port:443,target_protocol:http,target_port:80,certificate_id:cert-id \
  --health-check protocol:http,port:80,path:/health \
  --region nyc3 \
  --droplet-ids $(doctl compute droplet list --format ID --no-header)
```

## Best Practices

### Droplet Configuration and Management
```bash
#!/bin/bash
# Production-ready droplet setup script

# Update system packages
sudo apt update && sudo apt upgrade -y

# Install essential packages
sudo apt install -y \
  nginx \
  postgresql-14 \
  redis-server \
  nodejs \
  npm \
  git \
  htop \
  ufw \
  certbot \
  python3-certbot-nginx

# Configure firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# Configure automatic security updates
echo 'Unattended-Upgrade::Automatic-Reboot "false";' | sudo tee -a /etc/apt/apt.conf.d/50unattended-upgrades
sudo systemctl enable unattended-upgrades

# Set up log rotation
sudo tee /etc/logrotate.d/app-logs << EOF
/var/log/app/*.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 644 www-data www-data
}
EOF

# Configure PostgreSQL
sudo -u postgres createuser --interactive app_user
sudo -u postgres createdb app_production
sudo -u postgres psql -c "ALTER USER app_user PASSWORD 'secure_password';"

# Set up Node.js application directory
sudo mkdir -p /var/www/app
sudo chown -R www-data:www-data /var/www/app

# Configure Nginx with SSL
sudo tee /etc/nginx/sites-available/app << 'EOF'
server {
    listen 80;
    server_name example.com www.example.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name example.com www.example.com;

    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    
    # Modern SSL configuration
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    # Security headers
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    location /health {
        access_log off;
        return 200 "healthy\n";
        add_header Content-Type text/plain;
    }
}
EOF

# Enable site and restart Nginx
sudo ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

# Get SSL certificate
sudo certbot --nginx -d example.com -d www.example.com --non-interactive --agree-tos --email admin@example.com
```

### App Platform Deployment
```yaml
# .do/app.yaml - Digital Ocean App Platform configuration
name: my-web-app
services:
- name: web
  source_dir: /
  github:
    repo: username/my-app
    branch: main
    deploy_on_push: true
  run_command: npm start
  environment_slug: node-js
  instance_count: 2
  instance_size_slug: basic-xxs
  http_port: 3000
  
  envs:
  - key: NODE_ENV
    value: production
  - key: DATABASE_URL
    type: SECRET
    value: ${my-database.DATABASE_URL}
  - key: REDIS_URL
    type: SECRET
    value: ${my-redis.REDIS_URL}

  health_check:
    http_path: /health
    initial_delay_seconds: 30
    period_seconds: 10
    timeout_seconds: 5
    success_threshold: 1
    failure_threshold: 3

- name: worker
  source_dir: /
  github:
    repo: username/my-app
    branch: main
  run_command: npm run worker
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xs

databases:
- name: my-database
  engine: PG
  version: "14"
  size: db-s-1vcpu-1gb
  num_nodes: 1

- name: my-redis
  engine: REDIS
  version: "7"
  size: db-s-1vcpu-1gb

static_sites:
- name: frontend
  source_dir: /dist
  github:
    repo: username/my-frontend
    branch: main
  build_command: npm run build
  environment_slug: node-js
  
domains:
- domain: myapp.com
  type: PRIMARY
- domain: www.myapp.com
  type: ALIAS
```

### Kubernetes on Digital Ocean
```yaml
# k8s-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
  labels:
    app: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web-app
        image: registry.digitalocean.com/my-registry/web-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: database-url
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5

---
apiVersion: v1
kind: Service
metadata:
  name: web-app-service
spec:
  selector:
    app: web-app
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: ClusterIP

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-app-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt-prod
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
  - hosts:
    - myapp.com
    secretName: web-app-tls
  rules:
  - host: myapp.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web-app-service
            port:
              number: 80
```

## Common Patterns and Examples

### Pattern 1: Auto-Scaling Architecture
**Scenario**: Automatically scale application based on traffic
**Implementation**:
```bash
# Create multiple droplets behind load balancer
for i in {1..3}; do
  doctl compute droplet create "web-server-${i}" \
    --image ubuntu-22-04-x64 \
    --size s-2vcpu-4gb \
    --region nyc3 \
    --user-data-file cloud-init.yaml \
    --ssh-keys $(doctl compute ssh-key list --format ID --no-header)
done

# Create load balancer with health checks
doctl compute load-balancer create \
  --name production-lb \
  --forwarding-rules entry_protocol:https,entry_port:443,target_protocol:http,target_port:80 \
  --health-check protocol:http,port:80,path:/health,check_interval_seconds:10 \
  --sticky-sessions type:cookies,cookie_name:lb,cookie_ttl_seconds:300 \
  --region nyc3

# Set up monitoring alerts
doctl monitoring alert policy create \
  --type droplet \
  --description "High CPU usage alert" \
  --entities $(doctl compute droplet list --format ID --no-header | tr '\n' ',') \
  --tags web-servers \
  --alerts type:cpu,compare:greater_than,value:80,window:5m \
  --emails admin@example.com
```
**Expected Outcomes**: Automatic scaling and alerting for high availability

### Pattern 2: Database Backup and Recovery
**Scenario**: Implement comprehensive backup strategy for databases
**Implementation**:
```bash
#!/bin/bash
# Automated database backup script

# Configuration
DATABASE_ID="your-database-id"
BACKUP_RETENTION_DAYS=30
S3_BUCKET="your-backup-bucket"
DATE=$(date +%Y%m%d_%H%M%S)

# Create database snapshot
echo "Creating database snapshot..."
SNAPSHOT_ID=$(doctl databases backup create $DATABASE_ID \
  --format ID --no-header)

# Wait for snapshot completion
echo "Waiting for snapshot completion..."
while true; do
  STATUS=$(doctl databases backup get $DATABASE_ID $SNAPSHOT_ID \
    --format Status --no-header)
  if [ "$STATUS" = "completed" ]; then
    break
  fi
  sleep 30
done

# Export to S3 (if needed for offsite backup)
echo "Exporting backup to S3..."
doctl databases backup download $DATABASE_ID $SNAPSHOT_ID > "backup_${DATE}.sql"
aws s3 cp "backup_${DATE}.sql" "s3://${S3_BUCKET}/database-backups/"
rm "backup_${DATE}.sql"

# Cleanup old snapshots
echo "Cleaning up old snapshots..."
OLD_SNAPSHOTS=$(doctl databases backup list $DATABASE_ID \
  --format ID,CreatedAt --no-header | \
  awk -v cutoff="$(date -d "${BACKUP_RETENTION_DAYS} days ago" +%Y-%m-%d)" \
  '$2 < cutoff {print $1}')

for snapshot in $OLD_SNAPSHOTS; do
  doctl databases backup delete $DATABASE_ID $snapshot --force
done

echo "Backup completed successfully!"
```
**Expected Outcomes**: Reliable backup and recovery procedures

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Single Point of Failure
- **Description**: Running critical services on a single droplet
- **Why It's Problematic**: No redundancy leads to service outages
- **Better Approach**: Use load balancers with multiple droplets

#### Anti-Pattern 2: Hardcoded Credentials
- **Description**: Storing secrets in code or configuration files
- **Why It's Problematic**: Security vulnerabilities and credential exposure
- **Better Approach**: Use DO's secret management or environment variables

## Tools and Resources

### Essential CLI Commands
```bash
# Droplet management
doctl compute droplet list
doctl compute droplet create my-droplet --image ubuntu-22-04-x64 --size s-1vcpu-1gb
doctl compute droplet delete droplet-id

# Load balancer management
doctl compute load-balancer list
doctl compute load-balancer add-droplets lb-id --droplet-ids droplet-id1,droplet-id2

# Database management
doctl databases list
doctl databases create my-db --engine postgres --size db-s-1vcpu-1gb

# Kubernetes management
doctl kubernetes cluster create my-cluster --region nyc3 --size s-2vcpu-2gb --count 3
doctl kubernetes cluster kubeconfig save cluster-id

# Monitoring and alerts
doctl monitoring alert policy list
doctl monitoring alert policy create --type droplet --description "CPU Alert"

# Container registry
doctl registry create my-registry
docker tag my-app registry.digitalocean.com/my-registry/my-app:latest
docker push registry.digitalocean.com/my-registry/my-app:latest
```

### Terraform Integration
```hcl
# main.tf - Infrastructure as Code
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# VPC for network isolation
resource "digitalocean_vpc" "main" {
  name     = "production-vpc"
  region   = "nyc3"
  ip_range = "10.10.0.0/16"
}

# Database cluster
resource "digitalocean_database_cluster" "postgres" {
  name       = "production-postgres"
  engine     = "pg"
  version    = "14"
  size       = "db-s-2vcpu-4gb"
  region     = "nyc3"
  node_count = 2
  
  private_network_uuid = digitalocean_vpc.main.id
}

# Kubernetes cluster
resource "digitalocean_kubernetes_cluster" "main" {
  name         = "production-k8s"
  region       = "nyc3"
  version      = "1.28.2-do.0"
  vpc_uuid     = digitalocean_vpc.main.id
  auto_upgrade = true
  
  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 3
    auto_scale = true
    min_nodes  = 3
    max_nodes  = 10
  }
}

# Load balancer
resource "digitalocean_loadbalancer" "main" {
  name   = "production-lb"
  region = "nyc3"
  vpc_uuid = digitalocean_vpc.main.id

  forwarding_rule {
    entry_protocol  = "https"
    entry_port      = 443
    target_protocol = "http"
    target_port     = 80
    certificate_name = digitalocean_certificate.main.name
  }

  healthcheck {
    protocol               = "http"
    port                   = 80
    path                   = "/health"
    check_interval_seconds = 10
    response_timeout_seconds = 5
    unhealthy_threshold    = 3
    healthy_threshold      = 5
  }
}

# SSL certificate
resource "digitalocean_certificate" "main" {
  name    = "production-cert"
  type    = "lets_encrypt"
  domains = ["example.com", "www.example.com"]
}
```

### Learning Resources
- **Digital Ocean Documentation**: https://docs.digitalocean.com/
- **Digital Ocean Tutorials**: https://www.digitalocean.com/community/tutorials
- **doctl CLI Reference**: https://docs.digitalocean.com/reference/doctl/
- **Digital Ocean API**: https://docs.digitalocean.com/reference/api/

## Quality and Compliance

### Quality Standards
- All production deployments use load balancers for high availability
- Automated backups configured for all databases and critical data
- SSL/TLS certificates properly configured and auto-renewed
- Monitoring and alerting configured for all critical services

### Security Standards
- SSH key authentication required (no password authentication)
- Firewall rules configured to restrict access to necessary ports only
- Regular security updates applied automatically
- Secrets managed through environment variables or secret management

### Performance Standards
- Load balancer health checks respond within 5 seconds
- Database connections pooled and optimized
- CDN configured for static assets when applicable
- Resource utilization monitored and alerted

## AI Assistant Guidelines

When helping with Digital Ocean Development:

1. **Architecture Planning**: Always consider high availability and scalability from the start
2. **Security First**: Implement proper security measures including firewalls, SSL, and access controls
3. **Cost Optimization**: Choose appropriate droplet sizes and services based on actual requirements
4. **Modern Practices**: Recommend App Platform or Kubernetes for modern application deployments
5. **Monitoring Strategy**: Include comprehensive monitoring and alerting from day one
6. **Backup Planning**: Implement automated backup and recovery procedures
7. **Infrastructure as Code**: Use Terraform or doctl scripts for reproducible deployments
8. **Performance Focus**: Optimize for speed and efficiency using DO's global infrastructure

### Decision Making Framework
When helping teams choose Digital Ocean approaches:

1. **Requirements Analysis**: Understand performance, scalability, and budget requirements
2. **Service Selection**: Choose between Droplets, App Platform, or Kubernetes based on needs
3. **Architecture Design**: Plan for high availability and disaster recovery
4. **Security Assessment**: Implement appropriate security measures and compliance requirements
5. **Cost Planning**: Optimize costs while meeting performance requirements
6. **Migration Strategy**: Plan migration from other cloud providers if applicable

### Code Generation Rules
- Generate Infrastructure as Code using Terraform when possible
- Include proper security configurations (firewalls, SSL, access controls)
- Use environment variables for configuration and secrets
- Include health checks and monitoring configurations
- Generate backup and recovery procedures
- Follow Digital Ocean best practices and naming conventions
- Include cost optimization recommendations
- Provide comprehensive documentation and deployment guides

### Quality Enforcement
- ✅ Enforce SSL/TLS for all public-facing services
- ✅ Require load balancers for production applications
- ✅ Block SSH password authentication in favor of key-based auth
- ✅ Enforce firewall rules for network security
- ✅ Require automated backup configurations
- ✅ Enforce proper resource tagging and naming conventions
- ✅ Require monitoring and alerting for production services
- ✅ Promote Infrastructure as Code practices