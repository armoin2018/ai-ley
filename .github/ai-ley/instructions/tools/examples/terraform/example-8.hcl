# modules/security/vault-integration/main.tf - HashiCorp Vault integration
terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.22"
    }
  }
}

# Configure Vault provider
provider "vault" {
  address = var.vault_address
  token   = var.vault_token

  # Auth method configuration
  auth_login {
    path = "auth/aws"
    parameters = {
      role = var.vault_aws_auth_role
    }
  }
}

# Database secrets engine
resource "vault_database_secrets_mount" "postgres" {
  path = "database"

  postgresql {
    name           = "postgres-primary"
    url            = "postgresql://{{username}}:{{password}}@${aws_db_instance.primary.endpoint}:5432/postgres"
    username       = var.db_username
    password       = var.db_password
    allowed_roles  = ["readonly", "readwrite", "admin"]
  }
}

# PKI secrets engine for certificate management
resource "vault_mount" "pki" {
  path                      = "pki"
  type                      = "pki"
  description               = "Enterprise PKI"
  default_lease_ttl_seconds = 86400
  max_lease_ttl_seconds     = 315360000
}

resource "vault_pki_secret_backend_root_cert" "enterprise" {
  depends_on = [vault_mount.pki]

  backend              = vault_mount.pki.path
  type                 = "internal"
  common_name          = "Enterprise Root CA"
  ttl                  = "315360000"
  format               = "pem"
  private_key_format   = "der"
  key_type             = "rsa"
  key_bits             = 4096
  exclude_cn_from_sans = true
  ou                   = "Enterprise Infrastructure"
  organization         = var.organization_name
}

# KMS key management
resource "aws_kms_key" "enterprise" {
  description         = "Enterprise encryption key"
  key_usage           = "ENCRYPT_DECRYPT"
  key_spec            = "SYMMETRIC_DEFAULT"
  deletion_window_in_days = 30

  key_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_iam_role.terraform_execution.arn
        }
        Action = [
          "kms:Decrypt",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })

  tags = local.enterprise_tags
}

resource "aws_kms_alias" "enterprise" {
  name          = "alias/${var.project_name}-${var.environment}"
  target_key_id = aws_kms_key.enterprise.key_id
}