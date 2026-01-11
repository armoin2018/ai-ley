# terraform/docker.tf - Terraform configuration for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Build Docker image
resource "docker_image" "app" {
  name = "myapp:${var.app_version}"
  build {
    context    = "../"
    dockerfile = "Dockerfile"
    build_args = {
      NODE_ENV = var.environment
      VERSION  = var.app_version
    }
  }
  keep_locally = false
}

# Create Docker network
resource "docker_network" "app_network" {
  name = "myapp-network"
  driver = "bridge"

  ipam_config {
    subnet  = "172.20.0.0/16"
    gateway = "172.20.0.1"
  }
}

# Database container
resource "docker_container" "database" {
  name  = "myapp-db"
  image = "postgres:15"

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}"
  ]

  volumes {
    host_path      = "${path.cwd}/data/postgres"
    container_path = "/var/lib/postgresql/data"
  }

  networks_advanced {
    name = docker_network.app_network.name
  }

  restart = "unless-stopped"
}

# Application container
resource "docker_container" "app" {
  name  = "myapp"
  image = docker_image.app.image_id

  ports {
    internal = 3000
    external = 3000
  }

  env = [
    "NODE_ENV=${var.environment}",
    "DATABASE_URL=postgresql://${var.db_user}:${var.db_password}@${docker_container.database.name}:5432/${var.db_name}"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.database]
  restart    = "unless-stopped"

  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:3000/health"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }
}

# Variables
variable "app_version" {
  description = "Application version"
  type        = string
  default     = "latest"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "myapp"
}

variable "db_user" {
  description = "Database user"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Outputs
output "app_url" {
  value = "http://localhost:3000"
}

output "container_id" {
  value = docker_container.app.id
}