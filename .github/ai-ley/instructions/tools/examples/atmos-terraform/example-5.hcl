# components/terraform/vpc/main.tf - Enterprise VPC component
terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Data sources
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

# Local values
locals {
  name = var.name
  region = data.aws_region.current.name

  # Generate availability zones if not provided
  availability_zones = length(var.availability_zones) > 0 ? var.availability_zones : slice(data.aws_availability_zones.available.names, 0, min(3, length(data.aws_availability_zones.available.names)))

  # Calculate subnet CIDRs if not provided
  public_subnets = length(var.public_subnets) > 0 ? var.public_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 1)
  ]

  private_subnets = length(var.private_subnets) > 0 ? var.private_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 101)
  ]

  database_subnets = length(var.database_subnets) > 0 ? var.database_subnets : [
    for k in range(length(local.availability_zones)) :
    cidrsubnet(var.vpc_cidr_block, 8, k + 201)
  ]

  # Common tags
  common_tags = merge(
    var.tags,
    {
      Component   = "vpc"
      Module      = "terraform-aws-vpc"
      Environment = var.environment
      Region      = local.region
    }
  )
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    local.common_tags,
    var.vpc_tags,
    {
      Name = "${local.name}-vpc"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  count = var.create_igw ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name}-igw"
    }
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(local.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.public_subnets[count.index]
  availability_zone       = local.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    var.public_subnet_tags,
    {
      Name = "${local.name}-public-${local.availability_zones[count.index]}"
      Type = "Public"
    }
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(local.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_subnets[count.index]
  availability_zone = local.availability_zones[count.index]

  tags = merge(
    local.common_tags,
    var.private_subnet_tags,
    {
      Name = "${local.name}-private-${local.availability_zones[count.index]}"
      Type = "Private"
    }
  )
}