# policies/security/encryption-required.sentinel - Encryption policy
import "tfplan/v2" as tfplan

# Require encryption for all S3 buckets
s3_buckets = filter tfplan.resource_changes as _, rc {
    rc.type is "aws_s3_bucket" and
    rc.mode is "managed" and
    rc.change.actions contains "create"
}

require_s3_encryption = rule {
    all s3_buckets as _, bucket {
        bucket.change.after.server_side_encryption_configuration is not null
    }
}

# Require encryption for EBS volumes
ebs_volumes = filter tfplan.resource_changes as _, rc {
    rc.type is "aws_ebs_volume" and
    rc.mode is "managed" and
    rc.change.actions contains "create"
}

require_ebs_encryption = rule {
    all ebs_volumes as _, volume {
        volume.change.after.encrypted is true
    }
}

# Main enforcement rule
main = rule {
    require_s3_encryption and require_ebs_encryption
}

# policies/compliance/tagging-standards.sentinel - Tagging compliance
import "tfplan/v2" as tfplan

mandatory_tags = [
    "Environment",
    "Project",
    "Owner",
    "CostCenter",
    "ManagedBy",
    "Compliance"
]

# Get all resources that support tags
tagged_resources = filter tfplan.resource_changes as _, rc {
    rc.mode is "managed" and
    rc.change.actions contains "create" and
    "tags" in keys(rc.change.after)
}

# Validate mandatory tags
validate_mandatory_tags = rule {
    all tagged_resources as _, resource {
        all mandatory_tags as tag {
            tag in keys(resource.change.after.tags)
        }
    }
}

main = rule {
    validate_mandatory_tags
}