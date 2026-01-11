# backend.tf - Enterprise state management configuration
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "enterprise-org"

    workspaces {
      prefix = "infrastructure-"
    }
  }
}

# Alternative: S3 backend with enhanced security
# terraform {
#   backend "s3" {
#     bucket               = "enterprise-terraform-state"
#     key                  = "infrastructure/${var.environment}/terraform.tfstate"
#     region               = "us-west-2"
#     encrypt              = true
#     kms_key_id           = "arn:aws:kms:us-west-2:123456789012:key/12345678-1234-1234-1234-123456789012"
#     dynamodb_table       = "terraform-state-locks"
#     workspace_key_prefix = "workspaces"
#
#     # Enhanced security settings
#     assume_role = {
#       role_arn     = "arn:aws:iam::123456789012:role/TerraformStateRole"
#       session_name = "terraform-backend"
#     }
#   }
# }

# State bucket with enterprise security
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project_name}-terraform-state-${random_id.state_suffix.hex}"

  tags = merge(local.enterprise_tags, {
    Name = "Terraform State Bucket"
    Purpose = "Infrastructure State Management"
  })

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.enterprise.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# DynamoDB table for state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "${var.project_name}-terraform-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.enterprise.arn
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = merge(local.enterprise_tags, {
    Name = "Terraform State Locks"
    Purpose = "State Lock Management"
  })
}

# Random suffix for unique naming
resource "random_id" "state_suffix" {
  byte_length = 4
}