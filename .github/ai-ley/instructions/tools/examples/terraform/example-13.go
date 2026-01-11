// tests/infrastructure_test.go - Comprehensive infrastructure testing
package test

import (
    "testing"
    "time"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/gruntwork-io/terratest/modules/aws"
    "github.com/gruntwork-io/terratest/modules/retry"
    "github.com/stretchr/testify/assert"
)

func TestInfrastructureDeployment(t *testing.T) {
    t.Parallel()

    // Configure Terraform options
    terraformOptions := &terraform.Options{
        TerraformDir: "../terraform",
        VarFiles:     []string{"environments/test/terraform.tfvars"},
        Vars: map[string]interface{}{
            "environment":   "test",
            "project_name":  "terratest",
        },
        BackendConfig: map[string]interface{}{
            "workspace": "test",
        },
    }

    // Defer cleanup
    defer terraform.Destroy(t, terraformOptions)

    // Deploy infrastructure
    terraform.InitAndApply(t, terraformOptions)

    // Test VPC creation
    vpcId := terraform.Output(t, terraformOptions, "vpc_id")
    assert.NotEmpty(t, vpcId)

    // Test subnets
    publicSubnetIds := terraform.OutputList(t, terraformOptions, "public_subnet_ids")
    privateSubnetIds := terraform.OutputList(t, terraformOptions, "private_subnet_ids")

    assert.Equal(t, 3, len(publicSubnetIds))
    assert.Equal(t, 3, len(privateSubnetIds))

    // Test security groups
    testSecurityGroupRules(t, terraformOptions)

    // Test monitoring endpoints
    testMonitoringEndpoints(t, terraformOptions)
}

func testSecurityGroupRules(t *testing.T, terraformOptions *terraform.Options) {
    region := terraform.Output(t, terraformOptions, "aws_region")
    securityGroupId := terraform.Output(t, terraformOptions, "security_group_id")

    // Validate security group rules
    rules := aws.GetSecurityGroupIngressRules(t, securityGroupId, region)

    // Test that HTTPS is allowed
    httpsAllowed := false
    for _, rule := range rules {
        if rule.FromPort == 443 && rule.ToPort == 443 {
            httpsAllowed = true
            break
        }
    }
    assert.True(t, httpsAllowed, "HTTPS should be allowed in security group")
}

func testMonitoringEndpoints(t *testing.T, terraformOptions *terraform.Options) {
    monitoringEnabled := terraform.Output(t, terraformOptions, "monitoring_enabled")
    if monitoringEnabled == "true" {
        prometheusUrl := terraform.Output(t, terraformOptions, "prometheus_url")
        grafanaUrl := terraform.Output(t, terraformOptions, "grafana_url")

        // Test Prometheus endpoint availability
        retry.DoWithRetry(t, "Test Prometheus endpoint", 10, 30*time.Second, func() (string, error) {
            return "", aws.HttpGetWithRetryE(t, prometheusUrl+"/api/v1/query?query=up", nil, 200, 3, 5*time.Second)
        })

        // Test Grafana endpoint availability
        retry.DoWithRetry(t, "Test Grafana endpoint", 10, 30*time.Second, func() (string, error) {
            return "", aws.HttpGetWithRetryE(t, grafanaUrl+"/api/health", nil, 200, 3, 5*time.Second)
        })
    }
}