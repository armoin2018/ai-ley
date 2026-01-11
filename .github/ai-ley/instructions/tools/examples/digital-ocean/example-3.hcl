# terraform/main.tf - Digital Ocean infrastructure as code
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    # Configure remote state storage
    bucket = "devcorp-terraform-state"
    key    = "digitalocean/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Variables
variable "do_token" {
  description = "Digital Ocean API token"
  type        = string
  sensitive   = true
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "webcorp"
}

# VPC Configuration
resource "digitalocean_vpc" "main" {
  name     = "${var.project_name}-${var.environment}-vpc"
  region   = "nyc3"
  ip_range = "10.0.0.0/16"

  tags = [
    "Environment:${var.environment}",
    "Project:${var.project_name}",
    "ManagedBy:terraform"
  ]
}

# Database Configuration
resource "digitalocean_database_cluster" "postgres" {
  name       = "${var.project_name}-postgres"
  engine     = "pg"
  version    = "15"
  size       = "db-s-4vcpu-8gb"
  region     = "nyc3"
  node_count = 1

  maintenance_window {
    day  = "sunday"
    hour = "02:00"
  }

  tags = [
    "Environment:${var.environment}",
    "Service:database",
    "Engine:postgresql"
  ]
}

resource "digitalocean_database_cluster" "redis" {
  name       = "${var.project_name}-redis"
  engine     = "redis"
  version    = "7"
  size       = "db-s-2vcpu-4gb"
  region     = "nyc3"
  node_count = 1

  tags = [
    "Environment:${var.environment}",
    "Service:cache",
    "Engine:redis"
  ]
}

# Kubernetes Cluster
resource "digitalocean_kubernetes_cluster" "main" {
  name    = "${var.project_name}-k8s"
  region  = "nyc3"
  version = "1.28.2-do.0"
  vpc_uuid = digitalocean_vpc.main.id

  maintenance_policy {
    start_time = "02:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default-pool"
    size       = "s-4vcpu-8gb"
    node_count = 3
    auto_scale = true
    min_nodes  = 2
    max_nodes  = 8

    tags = [
      "Environment:${var.environment}",
      "NodePool:default"
    ]
  }

  tags = [
    "Environment:${var.environment}",
    "Service:kubernetes"
  ]
}

# Load Balancer
resource "digitalocean_loadbalancer" "web" {
  name   = "${var.project_name}-web-lb"
  region = "nyc3"
  vpc_uuid = digitalocean_vpc.main.id

  forwarding_rule {
    entry_protocol  = "https"
    entry_port      = 443
    target_protocol = "http"
    target_port     = 80
    certificate_name = digitalocean_certificate.cert.name
  }

  forwarding_rule {
    entry_protocol  = "http"
    entry_port      = 80
    target_protocol = "http"
    target_port     = 80
  }

  healthcheck {
    protocol   = "http"
    port       = 80
    path       = "/health"
    check_interval_seconds   = 10
    response_timeout_seconds = 5
    healthy_threshold        = 3
    unhealthy_threshold      = 3
  }

  droplet_tag = "web-server"

  tags = [
    "Environment:${var.environment}",
    "Service:load-balancer"
  ]
}

# SSL Certificate
resource "digitalocean_certificate" "cert" {
  name    = "${var.project_name}-cert"
  type    = "lets_encrypt"
  domains = ["${var.project_name}.com", "www.${var.project_name}.com"]
}

# Firewall
resource "digitalocean_firewall" "web" {
  name = "${var.project_name}-web-firewall"

  droplet_ids = digitalocean_droplet.web[*].id

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["10.0.0.0/16"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Web Server Droplets
resource "digitalocean_droplet" "web" {
  count  = 3
  name   = "${var.project_name}-web-${count.index + 1}"
  image  = "ubuntu-22-04-x64"
  region = "nyc3"
  size   = "s-4vcpu-8gb"
  vpc_uuid = digitalocean_vpc.main.id

  ssh_keys = [digitalocean_ssh_key.default.id]

  tags = [
    "Environment:${var.environment}",
    "Service:web-server",
    "web-server"
  ]

  user_data = file("${path.module}/scripts/web-server-setup.sh")

  monitoring = true
  backups    = true
}

# SSH Key
resource "digitalocean_ssh_key" "default" {
  name       = "${var.project_name}-ssh-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

# Volumes for persistent storage
resource "digitalocean_volume" "data" {
  count                   = 3
  region                  = "nyc3"
  name                    = "${var.project_name}-data-${count.index + 1}"
  size                    = 100
  initial_filesystem_type = "ext4"
  description             = "Data volume for ${var.project_name}"

  tags = [
    "Environment:${var.environment}",
    "Service:storage"
  ]
}

resource "digitalocean_volume_attachment" "data" {
  count      = 3
  droplet_id = digitalocean_droplet.web[count.index].id
  volume_id  = digitalocean_volume.data[count.index].id
}

# Outputs
output "load_balancer_ip" {
  value = digitalocean_loadbalancer.web.ip
}

output "database_host" {
  value = digitalocean_database_cluster.postgres.host
  sensitive = true
}

output "redis_host" {
  value = digitalocean_database_cluster.redis.host
  sensitive = true
}

output "kubernetes_endpoint" {
  value = digitalocean_kubernetes_cluster.main.endpoint
  sensitive = true
}