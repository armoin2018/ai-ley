# modules/enterprise-vpc/main.tf - Enterprise VPC module
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
  }
}

# VPC with enterprise networking
resource "aws_vpc" "enterprise" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Enhanced VPC features
  assign_generated_ipv6_cidr_block     = var.enable_ipv6
  enable_network_address_usage_metrics = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc"
    Type = "Enterprise VPC"
  })
}

# Multi-AZ subnet architecture
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  vpc_id                  = aws_vpc.enterprise.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-public-subnet-${count.index + 1}"
    Type = "Public"
    Tier = "Public"
    "kubernetes.io/role/elb" = "1"
  })
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)

  vpc_id            = aws_vpc.enterprise.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + 11)
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-private-subnet-${count.index + 1}"
    Type = "Private"
    Tier = "Application"
    "kubernetes.io/role/internal-elb" = "1"
  })
}

# VPC Flow Logs for security monitoring
resource "aws_flow_log" "enterprise" {
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.vpc_flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.enterprise.id

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-vpc-flow-log"
  })
}