# disaster-recovery.tf - Multi-region DR implementation
module "primary_region" {
  source = "./modules/regional-infrastructure"

  region                = var.aws_regions.primary.region
  availability_zones    = var.aws_regions.primary.availability_zones
  is_primary_region     = true
  enable_cross_region_backup = true

  providers = {
    aws = aws.primary
  }

  tags = local.enterprise_tags
}

# Cross-region VPC peering for DR
resource "aws_vpc_peering_connection" "primary_to_dr" {
  vpc_id        = module.primary_region.vpc_id
  peer_vpc_id   = module.disaster_recovery_region.vpc_id
  peer_region   = var.aws_regions.disaster_recovery.region
  auto_accept   = false

  tags = merge(local.enterprise_tags, {
    Name = "${var.name_prefix}-primary-to-dr-peering"
  })
}