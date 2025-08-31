---
title: 'Google Cloud Platform (GCP) Enterprise Cloud Instructions'
description: 'Comprehensive guide for Google Cloud Platform development, deployment, and management including Compute Engine, App Engine, Cloud Functions, and Kubernetes'
category: 'Cloud Platforms'

tags:
  [
    'gcp',
    'google-cloud',
    'compute-engine',
    'app-engine',
    'cloud-functions',
    'kubernetes',
    'gke',
    'firebase',
  ]
version: '1.0'
last_updated: '2025-08-14'
applyTo:
  - '**/app.yaml'
  - '**/cloudbuild.yaml'
  - '**/Dockerfile'
  - '**/k8s/**'
  - '**/gcp/**'
  - '**/.gcloudignore'
---

# Google Cloud Platform (GCP) Enterprise Cloud Instructions

## Tool Overview

- **Tool Name**: Google Cloud Platform (GCP)
- **Version**: Cloud SDK 450.0+ (Latest stable with Cloud Run v2 support)
- **Category**: Cloud Platforms - Enterprise Infrastructure
- **Purpose**: Comprehensive cloud computing platform for application development, deployment, data analytics, and machine learning
- **Prerequisites**: Google account, billing enabled, Cloud SDK installed, Docker for containerization

## When to Use GCP

### ✅ **Use GCP When**

- Building enterprise-scale applications requiring robust infrastructure
- Need advanced data analytics, BigQuery, and machine learning capabilities
- Working with Kubernetes and container orchestration (GKE)
- Building applications requiring Firebase integration and real-time features
- Need global scalability with advanced networking and security
- Working with microservices architecture and serverless computing
- Building AI/ML applications with TensorFlow and AutoML
- Need hybrid and multi-cloud deployment strategies

### ❌ **Avoid GCP When**

- Building simple static websites or basic web applications
- Working with small-scale projects with limited requirements
- Team lacks cloud infrastructure expertise and training
- Budget constraints for enterprise-level cloud services
- Need simple deployment without complex infrastructure management
- Working with applications not requiring advanced cloud features
- Building applications primarily targeting other cloud ecosystems

## AI Agent Decision Matrix

### Project Type Assessment

| Project Type               | GCP Recommendation                        | Configuration Priority           |
| -------------------------- | ----------------------------------------- | -------------------------------- |
| Enterprise Web App         | ✅ **Essential** - Full platform features | High - Multi-service setup       |
| Microservices Architecture | ✅ **Essential** - GKE + Cloud Run        | High - Container orchestration   |
| Data Analytics Platform    | ✅ **Essential** - BigQuery + AI/ML       | High - Data pipeline setup       |
| Mobile Application         | ✅ **Recommended** - Firebase integration | Medium - Backend services        |
| Static Website             | 🔄 **Consider** - May be overkill         | Low - Simple hosting             |
| IoT Application            | ✅ **Recommended** - IoT Core + Pub/Sub   | High - Event-driven architecture |

### Complexity Assessment

| Factor            | Low Complexity         | Medium Complexity         | High Complexity           |
| ----------------- | ---------------------- | ------------------------- | ------------------------- |
| **Setup Time**    | 2 hours (App Engine)   | 1 day (GKE cluster)       | 1 week (enterprise setup) |
| **Services Used** | App Engine + Cloud SQL | Multiple compute services | Full platform integration |
| **Architecture**  | Single service         | Microservices             | Enterprise multi-cloud    |
| **Team Size**     | 1-3 developers         | 5-10 developers           | 10+ with DevOps team      |

## Installation & Setup

### Google Cloud SDK Installation

```bash
# macOS installation
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Homebrew installation (macOS)
brew install --cask google-cloud-sdk

# Linux installation
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Windows installation (PowerShell)
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe", "$env:Temp\GoogleCloudSDKInstaller.exe")
& $env:Temp\GoogleCloudSDKInstaller.exe

# Verify installation
gcloud --version
gcloud components list

# Initialize and authenticate
gcloud init
gcloud auth login
gcloud auth application-default login
```

### Project Setup and Configuration

```bash
# Create new project
gcloud projects create PROJECT_ID --name="My Project"

# Set current project
gcloud config set project PROJECT_ID

# Enable necessary APIs
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable storage-api.googleapis.com

# Configure default region and zone
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a

# Verify configuration
gcloud config list
gcloud info
```

### Docker and Kubernetes Setup

```bash
# Install Docker (if not already installed)
# macOS
brew install docker

# Configure Docker for GCP
gcloud auth configure-docker

# Install kubectl
gcloud components install kubectl

# Get GKE credentials
gcloud container clusters get-credentials CLUSTER_NAME --zone=us-central1-a
```

## Configuration

### App Engine Configuration (app.yaml)

```yaml
# app.yaml - App Engine Standard Environment
runtime: python39
service: default

env_variables:
  DATABASE_URL: 'postgresql://user:password@/dbname?host=/cloudsql/PROJECT:REGION:INSTANCE'
  SECRET_KEY: 'your-secret-key'
  ENVIRONMENT: 'production'

automatic_scaling:
  min_instances: 1
  max_instances: 10
  target_cpu_utilization: 0.6
  target_throughput_utilization: 0.6

resources:
  cpu: 1
  memory_gb: 0.5
  disk_size_gb: 10

handlers:
  - url: /static
    static_dir: static
    secure: always

  - url: /.*
    script: auto
    secure: always

# Health checks
readiness_check:
  path: '/health'
  check_interval_sec: 5
  timeout_sec: 4
  failure_threshold: 2
  success_threshold: 2

liveness_check:
  path: '/health'
  check_interval_sec: 30
  timeout_sec: 4
  failure_threshold: 4
  success_threshold: 2

# VPC configuration
vpc_access_connector:
  name: 'projects/PROJECT_ID/locations/REGION/connectors/CONNECTOR_NAME'

# Service account
service_account: 'my-service-account@PROJECT_ID.iam.gserviceaccount.com'
```

### Cloud Build Configuration (cloudbuild.yaml)

```yaml
# cloudbuild.yaml - CI/CD pipeline
steps:
  # Install dependencies
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['ci']

  # Run tests
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['test']
    env:
      - 'NODE_ENV=test'

  # Build application
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['run', 'build']
    env:
      - 'NODE_ENV=production'

  # Build Docker image
  - name: 'gcr.io/cloud-builders/docker'
    args:
      [
        'build',
        '-t',
        'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA',
        '-t',
        'gcr.io/$PROJECT_ID/my-app:latest',
        '.',
      ]

  # Push to Container Registry
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA']

  # Deploy to Cloud Run
  - name: 'gcr.io/cloud-builders/gcloud'
    args:
      [
        'run',
        'deploy',
        'my-app',
        '--image',
        'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA',
        '--region',
        'us-central1',
        '--platform',
        'managed',
        '--allow-unauthenticated',
        '--set-env-vars',
        'NODE_ENV=production',
      ]

# Trigger configuration
trigger:
  branch: '^main$'

# Substitutions for environment variables
substitutions:
  _ENVIRONMENT: 'production'
  _REGION: 'us-central1'

# Build options
options:
  logging: CLOUD_LOGGING_ONLY
  machineType: 'E2_HIGHCPU_8'
  substitution_option: 'ALLOW_LOOSE'

# Service account for build
serviceAccount: 'projects/$PROJECT_ID/serviceAccounts/cloudbuild@$PROJECT_ID.iam.gserviceaccount.com'

# Build timeout
timeout: '1600s'
```

### Kubernetes Deployment Configuration

```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  namespace: default
  labels:
    app: my-app
    version: v1
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
        version: v1
    spec:
      serviceAccountName: my-app-service-account
      containers:
        - name: my-app
          image: gcr.io/PROJECT_ID/my-app:latest
          ports:
            - containerPort: 8080
              name: http
          env:
            - name: NODE_ENV
              value: 'production'
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: url
          resources:
            requests:
              memory: '256Mi'
              cpu: '250m'
            limits:
              memory: '512Mi'
              cpu: '500m'
          livenessProbe:
            httpGet:
              path: /health
              port: 8080
            initialDelaySeconds: 30
            periodSeconds: 10
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
            initialDelaySeconds: 5
            periodSeconds: 5
      imagePullSecrets:
        - name: gcr-json-key

---
# k8s/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: my-app-service
  labels:
    app: my-app
spec:
  type: LoadBalancer
  selector:
    app: my-app
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
      name: http

---
# k8s/ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-app-ingress
  annotations:
    kubernetes.io/ingress.global-static-ip-name: 'my-app-ip'
    networking.gke.io/managed-certificates: 'my-app-ssl-cert'
    kubernetes.io/ingress.class: 'gce'
spec:
  rules:
    - host: myapp.example.com
      http:
        paths:
          - path: /*
            pathType: ImplementationSpecific
            backend:
              service:
                name: my-app-service
                port:
                  number: 80

---
# k8s/managed-certificate.yaml
apiVersion: networking.gke.io/v1
kind: ManagedCertificate
metadata:
  name: my-app-ssl-cert
spec:
  domains:
    - myapp.example.com
    - www.myapp.example.com
```

### Terraform Infrastructure as Code

```hcl
# main.tf - GCP infrastructure
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  backend "gcs" {
    bucket = "my-terraform-state-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "subnet" {
  name          = "my-subnet"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
}

# GKE Cluster
resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = var.zone

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.subnet.name

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-medium"
    disk_size_gb = 20

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }
}

# Cloud SQL Database
resource "google_sql_database_instance" "main" {
  name             = "my-database-instance"
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled                        = true
      start_time                     = "03:00"
      location                       = var.region
      point_in_time_recovery_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc_network.id
    }

    database_flags {
      name  = "log_statement"
      value = "all"
    }
  }

  deletion_protection = true
}

# Service Accounts
resource "google_service_account" "kubernetes" {
  account_id   = "my-gke-service-account"
  display_name = "GKE Service Account"
}

# Cloud Storage Bucket
resource "google_storage_bucket" "static_assets" {
  name     = "${var.project_id}-static-assets"
  location = "US"

  uniform_bucket_level_access = true

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD"]
    response_header = ["*"]
    max_age_seconds = 3600
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }
}

# Variables
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}
```

## Core Features

### App Engine Deployment

- **Purpose**: Fully managed serverless platform for web applications
- **Usage**: Deploy web applications without infrastructure management
- **Example**:

```python
# main.py - Flask application for App Engine
from flask import Flask, request, jsonify
from google.cloud import datastore
import os

app = Flask(__name__)
datastore_client = datastore.Client()

@app.route('/')
def hello():
    return jsonify({
        'message': 'Hello from App Engine!',
        'version': os.environ.get('GAE_VERSION', 'unknown')
    })

@app.route('/api/users', methods=['GET', 'POST'])
def users():
    if request.method == 'POST':
        # Create new user
        user_data = request.get_json()

        # Create entity
        key = datastore_client.key('User')
        entity = datastore.Entity(key=key)
        entity.update(user_data)

        # Save to Datastore
        datastore_client.put(entity)

        return jsonify({'id': entity.id, **user_data}), 201

    else:
        # Get all users
        query = datastore_client.query(kind='User')
        users = list(query.fetch())

        return jsonify([{
            'id': user.id,
            **dict(user)
        } for user in users])

@app.route('/health')
def health_check():
    return jsonify({'status': 'healthy'}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
```

```bash
# Deploy to App Engine
gcloud app deploy app.yaml --project=PROJECT_ID
gcloud app browse  # Open deployed application
```

### Cloud Functions (Serverless)

- **Purpose**: Event-driven serverless compute platform
- **Usage**: Handle HTTP requests, process events, integrate with other GCP services
- **Example**:

```python
# main.py - Cloud Function
import functions_framework
from google.cloud import pubsub_v1
from google.cloud import storage
import json

@functions_framework.http
def process_image(request):
    """HTTP Cloud Function for image processing."""

    # Parse request
    request_json = request.get_json(silent=True)
    if not request_json or 'bucket' not in request_json:
        return {'error': 'Invalid request'}, 400

    bucket_name = request_json['bucket']
    file_name = request_json['file_name']

    try:
        # Initialize clients
        storage_client = storage.Client()
        publisher = pubsub_v1.PublisherClient()

        # Download image from Cloud Storage
        bucket = storage_client.bucket(bucket_name)
        blob = bucket.blob(file_name)

        if not blob.exists():
            return {'error': 'File not found'}, 404

        # Process image (example: resize, compress, etc.)
        processed_data = process_image_data(blob.download_as_bytes())

        # Upload processed image
        output_blob = bucket.blob(f"processed/{file_name}")
        output_blob.upload_from_string(processed_data)

        # Publish completion message
        topic_path = publisher.topic_path('PROJECT_ID', 'image-processed')
        message_data = json.dumps({
            'original_file': file_name,
            'processed_file': f"processed/{file_name}",
            'bucket': bucket_name
        }).encode('utf-8')

        publisher.publish(topic_path, message_data)

        return {
            'status': 'success',
            'processed_file': f"processed/{file_name}"
        }

    except Exception as e:
        print(f"Error processing image: {e}")
        return {'error': 'Processing failed'}, 500

def process_image_data(image_bytes):
    """Process image data (placeholder implementation)."""
    # Implement actual image processing logic
    return image_bytes

# Deploy Cloud Function
# gcloud functions deploy process-image
#   --runtime python39
#   --trigger-http
#   --allow-unauthenticated
#   --memory 512MB
#   --timeout 300s
```

### Cloud Run (Containerized Applications)

- **Purpose**: Fully managed serverless platform for containerized applications
- **Usage**: Deploy containerized applications with automatic scaling
- **Example**:

```dockerfile
# Dockerfile for Cloud Run
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production

# Copy application code
COPY . .

# Build application
RUN npm run build

# Expose port
EXPOSE 8080

# Set environment
ENV NODE_ENV=production
ENV PORT=8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3
  CMD node healthcheck.js

# Start application
CMD ["npm", "start"]
```

```javascript
// server.js - Express.js application for Cloud Run
const express = require('express');
const { Datastore } = require('@google-cloud/datastore');
const { PubSub } = require('@google-cloud/pubsub');

const app = express();
const datastore = new Datastore();
const pubsub = new PubSub();

app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// API endpoints
app.get('/api/tasks', async (req, res) => {
  try {
    const query = datastore.createQuery('Task');
    const [tasks] = await datastore.runQuery(query);

    res.json(
      tasks.map((task) => ({
        id: task[datastore.KEY].id,
        ...task,
      })),
    );
  } catch (error) {
    console.error('Error fetching tasks:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/tasks', async (req, res) => {
  try {
    const { title, description } = req.body;

    // Validate input
    if (!title) {
      return res.status(400).json({ error: 'Title is required' });
    }

    // Create task entity
    const taskKey = datastore.key('Task');
    const task = {
      title,
      description: description || '',
      completed: false,
      createdAt: new Date().toISOString(),
    };

    // Save to Datastore
    await datastore.save({ key: taskKey, data: task });

    // Publish event
    const messageData = JSON.stringify({
      event: 'task_created',
      taskId: taskKey.id,
      ...task,
    });

    await pubsub.topic('task-events').publish(Buffer.from(messageData));

    res.status(201).json({
      id: taskKey.id,
      ...task,
    });
  } catch (error) {
    console.error('Error creating task:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
```

```bash
# Deploy to Cloud Run
gcloud run deploy my-app
  --source .
  --platform managed
  --region us-central1
  --allow-unauthenticated
  --set-env-vars NODE_ENV=production
  --memory 512Mi
  --cpu 1
  --concurrency 100
  --max-instances 10
```

### Google Kubernetes Engine (GKE)

- **Purpose**: Managed Kubernetes cluster for container orchestration
- **Usage**: Deploy and manage containerized applications at scale
- **Example**:

```bash
# Create GKE cluster
gcloud container clusters create my-cluster
  --zone us-central1-a
  --num-nodes 3
  --enable-autoscaling
  --min-nodes 1
  --max-nodes 10
  --enable-autorepair
  --enable-autoupgrade
  --machine-type e2-medium
  --disk-size 20GB

# Get cluster credentials
gcloud container clusters get-credentials my-cluster --zone us-central1-a

# Deploy application
kubectl apply -f k8s/
kubectl get deployments
kubectl get services
kubectl get ingress
```

## Common Commands

```bash
# Essential GCP commands
gcloud config list                    # Show current configuration
gcloud projects list                  # List all projects
gcloud services list --enabled        # List enabled APIs
gcloud auth list                      # Show authenticated accounts

# Compute Engine
gcloud compute instances list         # List VM instances
gcloud compute instances create       # Create VM instance
gcloud compute ssh INSTANCE_NAME      # SSH into instance

# App Engine
gcloud app deploy                     # Deploy application
gcloud app browse                     # Open deployed app
gcloud app logs tail -s default       # View logs
gcloud app versions list              # List app versions

# Cloud Run
gcloud run services list              # List Cloud Run services
gcloud run deploy SERVICE_NAME        # Deploy service
gcloud run services describe SERVICE  # Service details

# Container Registry
gcloud builds submit --tag gcr.io/PROJECT_ID/IMAGE_NAME  # Build and push image
gcloud container images list          # List container images
gcloud container images delete        # Delete image

# Kubernetes Engine
gcloud container clusters list        # List GKE clusters
gcloud container clusters create      # Create cluster
gcloud container clusters delete      # Delete cluster
kubectl get nodes                     # List cluster nodes

# Cloud SQL
gcloud sql instances list             # List database instances
gcloud sql instances create           # Create database instance
gcloud sql connect INSTANCE_NAME      # Connect to database

# Cloud Storage
gsutil ls                             # List buckets
gsutil cp file.txt gs://bucket-name/  # Upload file
gsutil rsync -r ./folder gs://bucket/ # Sync directory

# IAM and Security
gcloud iam service-accounts list      # List service accounts
gcloud projects add-iam-policy-binding # Add IAM policy
gcloud auth activate-service-account  # Activate service account

# Monitoring and Logging
gcloud logging logs list              # List log entries
gcloud monitoring metrics list        # List metrics
gcloud error-reporting events list    # List error events
```

## Workflow Integration

### Development Workflow

1. **Local Development**: Use Cloud SDK and emulators for local testing
2. **Version Control**: Integrate with Cloud Source Repositories or GitHub
3. **CI/CD Pipeline**: Use Cloud Build for automated testing and deployment
4. **Staging Environment**: Deploy to separate GCP project for testing
5. **Production Deployment**: Use blue-green or canary deployment strategies
6. **Monitoring**: Set up Cloud Monitoring, Logging, and Error Reporting

### CI/CD Pipeline with Cloud Build

```yaml
# cloudbuild-full.yaml - Complete CI/CD pipeline
steps:
  # Restore dependencies
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['ci']

  # Run unit tests
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['run', 'test:unit']
    env:
      - 'NODE_ENV=test'

  # Run integration tests
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['run', 'test:integration']
    env:
      - 'NODE_ENV=test'
      - 'DATABASE_URL=${_TEST_DATABASE_URL}'

  # Security scanning
  - name: 'gcr.io/cloud-builders/gcloud'
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        npm audit --audit-level high
        npm run lint

  # Build application
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['run', 'build']
    env:
      - 'NODE_ENV=production'
      - 'REACT_APP_API_URL=${_API_URL}'

  # Build Docker image
  - name: 'gcr.io/cloud-builders/docker'
    args:
      [
        'build',
        '-t',
        'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:$COMMIT_SHA',
        '-t',
        'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:latest',
        '--build-arg',
        'NODE_ENV=production',
        '.',
      ]

  # Push to Container Registry
  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:$COMMIT_SHA']

  # Run container security scan
  - name: 'gcr.io/cloud-builders/gcloud'
    args: ['container', 'images', 'scan', 'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:$COMMIT_SHA']

  # Deploy to staging
  - name: 'gcr.io/cloud-builders/gcloud'
    args:
      [
        'run',
        'deploy',
        '${_SERVICE_NAME}-staging',
        '--image',
        'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:$COMMIT_SHA',
        '--region',
        '${_REGION}',
        '--platform',
        'managed',
        '--no-allow-unauthenticated',
        '--set-env-vars',
        'NODE_ENV=staging,DATABASE_URL=${_STAGING_DATABASE_URL}',
      ]

  # Run smoke tests against staging
  - name: 'node:18'
    entrypoint: 'npm'
    args: ['run', 'test:smoke']
    env:
      - 'TEST_URL=https://${_SERVICE_NAME}-staging-${_HASH}-uc.a.run.app'

  # Deploy to production (only on main branch)
  - name: 'gcr.io/cloud-builders/gcloud'
    args:
      [
        'run',
        'deploy',
        '${_SERVICE_NAME}',
        '--image',
        'gcr.io/$PROJECT_ID/${_SERVICE_NAME}:$COMMIT_SHA',
        '--region',
        '${_REGION}',
        '--platform',
        'managed',
        '--allow-unauthenticated',
        '--set-env-vars',
        'NODE_ENV=production,DATABASE_URL=${_PROD_DATABASE_URL}',
        '--traffic',
        '100',
      ]

# Environment-specific substitutions
substitutions:
  _SERVICE_NAME: 'my-app'
  _REGION: 'us-central1'
  _API_URL: 'https://api.myapp.com'
  _TEST_DATABASE_URL: 'postgresql://test-db-url'
  _STAGING_DATABASE_URL: 'postgresql://staging-db-url'
  _PROD_DATABASE_URL: 'postgresql://prod-db-url'

# Build options
options:
  machineType: 'E2_HIGHCPU_8'
  substitution_option: 'ALLOW_LOOSE'
  logging: 'CLOUD_LOGGING_ONLY'

# Service account
serviceAccount: 'projects/$PROJECT_ID/serviceAccounts/cloudbuild@$PROJECT_ID.iam.gserviceaccount.com'

timeout: '2400s'
```

### Package.json Scripts Integration

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "test": "jest",
    "test:unit": "jest --testPathPattern=__tests__/unit",
    "test:integration": "jest --testPathPattern=__tests__/integration",
    "test:smoke": "jest --testPathPattern=__tests__/smoke",
    "lint": "eslint . --ext .js,.jsx,.ts,.tsx",
    "gcp:deploy": "gcloud app deploy",
    "gcp:logs": "gcloud app logs tail -s default",
    "docker:build": "docker build -t gcr.io/$PROJECT_ID/my-app .",
    "docker:push": "docker push gcr.io/$PROJECT_ID/my-app",
    "k8s:apply": "kubectl apply -f k8s/",
    "terraform:plan": "terraform plan",
    "terraform:apply": "terraform apply"
  }
}
```

## Best Practices

### ✅ **Infrastructure Best Practices**

- **Use Infrastructure as Code** - Manage infrastructure with Terraform or Deployment Manager
- **Implement least privilege IAM** - Grant minimal necessary permissions to users and services
- **Use VPC networks** - Isolate resources with proper network segmentation
- **Enable audit logging** - Track all API calls and resource access
- **Implement backup strategies** - Regular backups for databases and critical data
- **Use managed services** - Prefer managed services over self-managed infrastructure

### ✅ **Security Best Practices**

- **Enable Security Command Center** - Monitor security findings and compliance
- **Use service accounts** - Authenticate applications with service accounts
- **Implement network security** - Use firewalls, VPC, and private Google access
- **Encrypt data** - Use Cloud KMS for encryption key management
- **Monitor access patterns** - Set up alerts for unusual access patterns
- **Regular security audits** - Perform regular security assessments and penetration testing

### ✅ **Cost Optimization**

- **Use committed use discounts** - Purchase committed use contracts for predictable workloads
- **Implement resource monitoring** - Monitor resource usage and optimize sizing
- **Use preemptible instances** - Reduce costs with preemptible VM instances
- **Set up billing alerts** - Monitor spending with budget alerts and quotas
- **Regular cost reviews** - Analyze costs and optimize resource allocation
- **Use sustained use discounts** - Benefit from automatic discounts for long-running workloads

### ❌ **Common Pitfalls to Avoid**

- **Don't use default service accounts** - Create specific service accounts for applications
- **Avoid overprivileged IAM** - Don't grant unnecessary permissions
- **Don't ignore security updates** - Keep all components updated with security patches
- **Avoid single points of failure** - Design for high availability and disaster recovery
- **Don't hardcode secrets** - Use Secret Manager for sensitive configuration
- **Avoid vendor lock-in** - Design applications with portability in mind

## Advanced GCP Usage

### Multi-Cloud and Hybrid Architecture

```yaml
# anthos-config.yaml - Anthos configuration
apiVersion: v1
kind: ConfigMap
metadata:
  name: anthos-config
  namespace: gke-connect
data:
  PROJECT_ID: 'my-project-id'
  CLUSTER_NAME: 'hybrid-cluster'
  CLUSTER_LOCATION: 'us-central1'

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hybrid-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: hybrid-app
  template:
    metadata:
      labels:
        app: hybrid-app
    spec:
      containers:
        - name: app
          image: gcr.io/PROJECT_ID/hybrid-app:latest
          env:
            - name: CLOUD_PROVIDER
              value: 'gcp'
            - name: REGION
              value: 'us-central1'
          ports:
            - containerPort: 8080
```

### Advanced Monitoring and Alerting

```yaml
# monitoring/alerting-policy.yaml
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: app-alerts
spec:
  groups:
    - name: application.rules
      rules:
        - alert: HighErrorRate
          expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
          for: 5m
          labels:
            severity: critical
          annotations:
            summary: 'High error rate detected'
            description: 'Error rate is {{ $value }} errors per second'

        - alert: HighLatency
          expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 0.5
          for: 10m
          labels:
            severity: warning
          annotations:
            summary: 'High latency detected'
            description: '95th percentile latency is {{ $value }} seconds'
```

### Data Pipeline with Cloud Dataflow

```python
# dataflow_pipeline.py - Apache Beam pipeline
import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
from apache_beam.io import ReadFromText, WriteToText
from google.cloud import bigquery

class ProcessEventsFn(beam.DoFn):
    def process(self, element):
        import json

        # Parse JSON event
        event = json.loads(element)

        # Transform event data
        processed_event = {
            'user_id': event.get('user_id'),
            'event_type': event.get('event_type'),
            'timestamp': event.get('timestamp'),
            'properties': json.dumps(event.get('properties', {})),
            'processed_at': beam.io.gcp.bigquery.TimestampValue.now()
        }

        yield processed_event

def run_pipeline():
    pipeline_options = PipelineOptions([
        '--project=my-project-id',
        '--region=us-central1',
        '--runner=DataflowRunner',
        '--temp_location=gs://my-temp-bucket/temp',
        '--staging_location=gs://my-temp-bucket/staging'
    ])

    with beam.Pipeline(options=pipeline_options) as pipeline:
        events = (
            pipeline
            | 'Read from Pub/Sub' >> beam.io.ReadFromPubSub(
                subscription='projects/my-project-id/subscriptions/events-subscription'
            )
            | 'Decode messages' >> beam.Map(lambda x: x.decode('utf-8'))
            | 'Process events' >> beam.ParDo(ProcessEventsFn())
            | 'Write to BigQuery' >> beam.io.WriteToBigQuery(
                table='my-project-id:analytics.events',
                schema={
                    'fields': [
                        {'name': 'user_id', 'type': 'STRING'},
                        {'name': 'event_type', 'type': 'STRING'},
                        {'name': 'timestamp', 'type': 'TIMESTAMP'},
                        {'name': 'properties', 'type': 'STRING'},
                        {'name': 'processed_at', 'type': 'TIMESTAMP'}
                    ]
                },
                create_disposition=beam.io.BigQueryDisposition.CREATE_IF_NEEDED,
                write_disposition=beam.io.BigQueryDisposition.WRITE_APPEND
            )
        )

if __name__ == '__main__':
    run_pipeline()
```

## Integration with Other Tools

### Firebase Integration

```javascript
// firebase-config.js
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getFirestore } from 'firebase/firestore';
import { getStorage } from 'firebase/storage';
import { getAnalytics } from 'firebase/analytics';

const firebaseConfig = {
  apiKey: process.env.REACT_APP_FIREBASE_API_KEY,
  authDomain: process.env.REACT_APP_FIREBASE_AUTH_DOMAIN,
  projectId: process.env.REACT_APP_FIREBASE_PROJECT_ID,
  storageBucket: process.env.REACT_APP_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: process.env.REACT_APP_FIREBASE_MESSAGING_SENDER_ID,
  appId: process.env.REACT_APP_FIREBASE_APP_ID,
  measurementId: process.env.REACT_APP_FIREBASE_MEASUREMENT_ID,
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize services
export const auth = getAuth(app);
export const db = getFirestore(app);
export const storage = getStorage(app);
export const analytics = getAnalytics(app);

export default app;
```

### BigQuery Analytics Integration

```python
# analytics/bigquery_client.py
from google.cloud import bigquery
from google.cloud.exceptions import NotFound
import pandas as pd

class BigQueryAnalytics:
    def __init__(self, project_id):
        self.client = bigquery.Client(project=project_id)
        self.project_id = project_id

    def create_dataset(self, dataset_id, location='US'):
        """Create a BigQuery dataset."""
        dataset_ref = self.client.dataset(dataset_id)
        dataset = bigquery.Dataset(dataset_ref)
        dataset.location = location

        try:
            dataset = self.client.create_dataset(dataset)
            print(f"Created dataset {dataset.dataset_id}")
        except Exception as e:
            print(f"Dataset {dataset_id} already exists or error: {e}")

    def run_query(self, query):
        """Execute a BigQuery SQL query."""
        try:
            query_job = self.client.query(query)
            return query_job.result()
        except Exception as e:
            print(f"Query failed: {e}")
            return None

    def get_user_analytics(self, start_date, end_date):
        """Get user analytics for a date range."""
        query = f"""
        SELECT
            user_id,
            COUNT(*) as total_events,
            COUNT(DISTINCT event_type) as unique_event_types,
            MIN(timestamp) as first_event,
            MAX(timestamp) as last_event
        FROM `{self.project_id}.analytics.events`
        WHERE DATE(timestamp) BETWEEN '{start_date}' AND '{end_date}'
        GROUP BY user_id
        ORDER BY total_events DESC
        LIMIT 100
        """

        results = self.run_query(query)
        if results:
            return pd.DataFrame([dict(row) for row in results])
        return pd.DataFrame()

    def stream_insert(self, table_id, rows):
        """Stream data into BigQuery table."""
        table_ref = self.client.dataset('analytics').table(table_id)
        table = self.client.get_table(table_ref)

        errors = self.client.insert_rows_json(table, rows)
        if errors:
            print(f"Failed to insert rows: {errors}")
            return False
        return True
```

## Troubleshooting

### Common Issues

#### Authentication Errors

**Problem**: Authentication failures when accessing GCP services
**Symptoms**: Permission denied errors, invalid credentials
**Solution**:

```bash
# Check current authentication
gcloud auth list
gcloud config list

# Re-authenticate
gcloud auth login
gcloud auth application-default login

# Set correct project
gcloud config set project PROJECT_ID

# Check service account permissions
gcloud projects get-iam-policy PROJECT_ID
```

#### Quota and Limits Issues

**Problem**: API quota exceeded or resource limits reached
**Symptoms**: Quota exceeded errors, resource creation failures
**Solution**:

```bash
# Check current quotas
gcloud compute project-info describe --project=PROJECT_ID

# Request quota increase
gcloud alpha resource-manager quotes list --project=PROJECT_ID

# Monitor API usage
gcloud logging logs list --filter="protoPayload.authenticationInfo.principalEmail=SERVICE_ACCOUNT_EMAIL"
```

#### Deployment Failures

**Problem**: Application deployment failures
**Symptoms**: Build errors, deployment timeouts, service unavailable
**Solution**:

```bash
# Check build logs
gcloud builds log BUILD_ID

# Check service logs
gcloud run services logs SERVICE_NAME --region=REGION

# Debug locally
gcloud builds submit --config=cloudbuild.yaml .

# Check resource allocation
gcloud run services describe SERVICE_NAME --region=REGION
```

### Debug Mode

```bash
# Verbose mode for debugging
gcloud --verbosity=debug COMMAND

# Enable API request logging
export GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
export GOOGLE_CLOUD_PROJECT=PROJECT_ID
export GCLOUD_LOG_LEVEL=DEBUG

# Cloud Build debugging
gcloud builds submit --substitutions=_DEBUG=true

# Container debugging
gcloud run services proxy SERVICE_NAME --port=8080
```

### Performance Optimization

```yaml
# cloudbuild-optimized.yaml
steps:
  # Use cached dependencies
  - name: 'gcr.io/cloud-builders/docker'
    entrypoint: 'bash'
    args:
      - '-c'
      - |
        docker pull gcr.io/$PROJECT_ID/build-cache:latest || true
        docker build 
          --cache-from gcr.io/$PROJECT_ID/build-cache:latest 
          -t gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA 
          -t gcr.io/$PROJECT_ID/build-cache:latest .
        docker push gcr.io/$PROJECT_ID/build-cache:latest

options:
  # Use faster machine type
  machineType: 'E2_HIGHCPU_32'

  # Use SSD for faster I/O
  diskSizeGb: 100

  # Parallel builds
  workerPool: 'projects/$PROJECT_ID/locations/us-central1/workerPools/high-perf-pool'
```

## Security Considerations

### Security Best Practices

- **Implement Identity and Access Management (IAM)** - Use role-based access control
- **Enable Security Command Center** - Monitor security findings across GCP resources
- **Use VPC Service Controls** - Create security perimeters around sensitive resources
- **Implement audit logging** - Enable Cloud Audit Logs for all services
- **Use Secret Manager** - Store and manage sensitive information securely
- **Regular security assessments** - Perform vulnerability scans and penetration testing

### Secure Configuration Examples

```yaml
# iam-policy.yaml - Least privilege IAM policy
apiVersion: v1
kind: ConfigMap
metadata:
  name: iam-roles
data:
  roles.yaml: |
    roles:
      - name: "custom-app-role"
        title: "Application Service Role"
        description: "Minimal permissions for application"
        permissions:
          - "datastore.entities.create"
          - "datastore.entities.get"
          - "datastore.entities.update"
          - "storage.objects.get"
          - "storage.objects.create"
          - "pubsub.messages.publish"
          - "logging.logEntries.create"

---
# security-policy.yaml
apiVersion: networking.gke.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  egress:
    - to: []
      ports:
        - protocol: TCP
          port: 443 # HTTPS only
        - protocol: UDP
          port: 53 # DNS
```

## AI Assistant Guidelines

When helping with GCP:

1. **Always suggest managed services** when appropriate for reduced operational overhead
2. **Provide complete infrastructure configurations** with Terraform and YAML examples
3. **Include security best practices** with IAM, VPC, and audit logging
4. **Suggest appropriate service combinations** based on application requirements
5. **Provide debugging strategies** for common deployment and configuration issues
6. **Include monitoring and alerting** setup for production applications
7. **Reference cost optimization** techniques for efficient resource usage
8. **Suggest multi-cloud strategies** when vendor lock-in is a concern

### Code Generation Rules

- Generate complete Terraform configurations for infrastructure as code
- Include proper IAM roles and service accounts with least privilege
- Provide comprehensive Cloud Build pipelines with testing and security scanning
- Follow GCP best practices for networking, security, and resource organization
- Include proper error handling and logging in application code
- Generate Kubernetes manifests with security contexts and resource limits
- Provide monitoring and alerting configurations for production deployments
- Include backup and disaster recovery strategies in infrastructure designs

### CLI Configuration

```bash
# Global configuration
[tool] config set [option] [value]

# Project-specific configuration
[tool] config --local [option] [value]
```

## Core Features

### [Feature 1]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 2]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

### [Feature 3]

- **Purpose**: [What this feature does]
- **Usage**: [How to use it]
- **Example**:

```bash
[tool] [command] [options]
```

## Common Commands

```bash
# Essential daily commands
[tool] [basic-command]              # Description
[tool] [frequent-command] [options] # Description
[tool] [status-command]             # Check status
[tool] [help-command]               # Get help

# Advanced operations
[tool] [advanced-command] [options] # Description
[tool] [config-command]             # Configuration management
[tool] [debug-command]              # Debugging and troubleshooting
```

## Workflow Integration

### Development Workflow

1. **Setup**: [Initial setup steps]
2. **Development**: [How to use during development]
3. **Testing**: [Integration with testing process]
4. **Pre-commit**: [Pre-commit hooks or checks]
5. **CI/CD**: [Continuous integration usage]

### Automation Scripts

```bash
# Package.json scripts (if applicable)
{
  "scripts": {
    "[script-name]": "[tool] [command]",
    "[workflow-script]": "[tool] [workflow-command]"
  }
}
```

### Git Hooks Integration

```bash
# Pre-commit hook example
#!/bin/sh
[tool] [validation-command]
```

## Best Practices

### Configuration Best Practices

- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

### Usage Patterns

- [Pattern 1: When and how to use]
- [Pattern 2: When and how to use]
- [Pattern 3: When and how to use]

### Performance Optimization

- [Optimization tip 1]
- [Optimization tip 2]
- [Optimization tip 3]

## Common Use Cases

### [Use Case 1]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 2]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

### [Use Case 3]

**Scenario**: [Description of the scenario]
**Implementation**:

```bash
[tool] [specific-commands]
```

**Expected Result**: [What should happen]

## Integration with Other Tools

### [Related Tool 1]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

### [Related Tool 2]

- **Integration Purpose**: [Why integrate]
- **Setup**: [How to configure integration]
- **Usage**: [How they work together]

## Troubleshooting

### Common Issues

#### [Issue 1]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 2]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

#### [Issue 3]

**Problem**: [Description of the problem]
**Symptoms**: [How to identify this issue]
**Solution**: [Step-by-step fix]

### Debug Mode

```bash
# Enable verbose/debug output
[tool] --verbose [command]
[tool] --debug [command]

# Log analysis
[tool] logs
[tool] status --detailed
```

### Performance Issues

- [Performance issue 1 and solution]
- [Performance issue 2 and solution]
- [Performance issue 3 and solution]

## Security Considerations

### Security Best Practices

- [Security practice 1]
- [Security practice 2]
- [Security practice 3]

### Sensitive Data Handling

- [How the tool handles secrets]
- [Configuration for secure usage]
- [Best practices for credentials]

### Network Security

- [Network-related security considerations]
- [Proxy and firewall configurations]
- [Certificate and SSL handling]

## Advanced Configuration

### Custom Plugins/Extensions

```[config-format]
# Plugin configuration
[plugin-config-example]
```

### Scripting and Automation

```bash
# Advanced scripting examples
[automation-script-example]
```

### Performance Tuning

```[config-format]
# Performance optimization settings
[performance-config-example]
```

## Version Management

### Version Compatibility

- **Tool Version**: [Version requirements]
- **Node.js**: [If applicable]
- **Python**: [If applicable]
- **OS Support**: [Supported operating systems]

### Migration Guides

- **From [Old Version]**: [Migration steps]
- **Breaking Changes**: [Important changes to note]
- **Deprecation Notices**: [Features being deprecated]

## Useful Resources

- **Official Documentation**: [URL]
- **GitHub Repository**: [URL]
- **Community Resources**: [URLs]
- **Tutorials**: [URLs]
- **Plugin/Extension Registry**: [URL]
- **Stack Overflow Tag**: [Tag name]

## Tool-Specific Guidelines

### Code Organization

- [How the tool affects code structure]
- [File organization recommendations]
- [Naming conventions]

### Maintenance

- [Regular maintenance tasks]
- [Update procedures]
- [Cleanup and optimization]

## Examples and Templates

### Basic Example

```[language]
// Example usage in context
[practical-example]
```

### Advanced Example

```[language]
// Advanced usage pattern
[advanced-example]
```

### Template Files

```[format]
# Template configuration
[template-example]
```

## AI Assistant Guidelines

When helping with [Tool Name]:

1. **Always suggest the most current stable version**
2. **Provide working configuration examples**
3. **Include error handling in scripts**
4. **Mention security implications when relevant**
5. **Suggest integration with development workflow**
6. **Provide troubleshooting steps for common issues**
7. **Include performance considerations**
8. **Reference official documentation**

### Code Generation Rules

- Generate configurations that follow tool best practices
- Include comments explaining important settings
- Provide multiple options when appropriate
- Include validation and error checking
- Follow the project's existing patterns and conventions
