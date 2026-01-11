# kubernetes.tf - Terraform Kubernetes provider
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_namespace" "production" {
  metadata {
    name = "production"
    labels = {
      environment = "production"
      managed-by  = "terraform"
    }
  }
}

resource "helm_release" "web_app" {
  name       = "web-app"
  namespace  = kubernetes_namespace.production.metadata[0].name
  chart      = "./helm/web-app"

  values = [
    file("${path.module}/helm-values/production.yaml")
  ]

  set {
    name  = "image.tag"
    value = var.app_version
  }

  set_sensitive {
    name  = "postgresql.auth.password"
    value = var.db_password
  }
}