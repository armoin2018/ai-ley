#!/bin/bash
# scripts/terraform-performance-monitor.sh

set -euo pipefail

TERRAFORM_DIR="${1:-./terraform}"
ENVIRONMENT="${2:-dev}"
METRICS_FILE="terraform-metrics-$(date +%Y%m%d-%H%M%S).json"

echo "Starting Terraform performance monitoring..."

measure_time() {
    local command="$1"
    local description="$2"

    echo "Executing: $description"
    start_time=$(date +%s.%N)

    if eval "$command"; then
        end_time=$(date +%s.%N)
        duration=$(echo "$end_time - $start_time" | bc)
        echo "✓ $description completed in ${duration}s"

        echo "{\"operation\": \"$description\", \"duration\": $duration, \"status\": \"success\", \"timestamp\": \"$(date -Iseconds)\"}" >> "$METRICS_FILE"
    else
        echo "✗ $description failed"
        return 1
    fi
}

cd "$TERRAFORM_DIR"

measure_time "terraform init -upgrade" "Terraform Initialization"
measure_time "terraform validate" "Configuration Validation"
measure_time "terraform plan -var-file=environments/$ENVIRONMENT/terraform.tfvars" "Plan Generation"

resource_count=$(terraform state list 2>/dev/null | wc -l)
echo "Total resources in state: $resource_count"