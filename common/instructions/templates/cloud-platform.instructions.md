# Cloud Platform Instructions Template

## Platform Overview
- **Platform Name**: [Name of the cloud platform]
- **Provider**: [Company/organization providing the platform]
- **Service Model**: [IaaS, PaaS, SaaS, or hybrid]
- **Global Presence**: [Regions and availability zones]
- **Primary Use Cases**: [Main scenarios and applications]
- **Pricing Model**: [Pricing structure and cost considerations]

## Account Setup and Management
### Initial Setup
```bash
# CLI installation and setup
[platform-cli] install
[platform-cli] auth login
[platform-cli] config set project [project-id]
```

### Account Structure
```
Organization/
├── Management Account/Project
├── Production Environment
├── Staging Environment  
├── Development Environment
└── Security/Compliance Account
```

### Access Management
#### Identity and Access Management (IAM)
```json
{
  "user_policies": {
    "developer": "[developer-permissions]",
    "admin": "[admin-permissions]",
    "readonly": "[readonly-permissions]"
  },
  "service_accounts": {
    "ci_cd": "[automation-permissions]",
    "monitoring": "[monitoring-permissions]"
  }
}
```

#### Multi-Factor Authentication
- [MFA setup and requirements]
- [Security best practices]
- [Emergency access procedures]

## Core Services

### Compute Services
#### [Primary Compute Service]
- **Purpose**: [Virtual machines, containers, serverless, etc.]
- **Use Cases**: [When to use this service]
- **Configuration Example**:
```yaml
# [Service configuration example]
[compute_instance]:
  type: [instance-type]
  region: [region]
  specs:
    cpu: [cpu-specs]
    memory: [memory-specs]
    storage: [storage-specs]
  networking:
    vpc: [vpc-id]
    subnet: [subnet-id]
    security_groups: [security-group-ids]
```

#### [Container Service]
- **Purpose**: [Container orchestration and management]
- **Configuration Example**:
```yaml
# [Container service configuration]
[container_service]:
  cluster_name: [cluster-name]
  node_groups:
    - name: [node-group-name]
      instance_types: [instance-types]
      scaling: [min-max-desired]
```

#### [Serverless Service]
- **Purpose**: [Function-as-a-Service offerings]
- **Configuration Example**:
```yaml
# [Serverless configuration]
[function_name]:
  runtime: [runtime-version]
  handler: [handler-function]
  memory: [memory-allocation]
  timeout: [timeout-seconds]
  environment:
    [env_vars]
```

### Storage Services
#### [Primary Storage Service]
- **Purpose**: [Object storage, block storage, file systems]
- **Use Cases**: [Data storage scenarios]
- **Configuration Example**:
```bash
# [Storage commands]
[platform-cli] storage create [bucket-name]
[platform-cli] storage upload [local-file] [bucket-name]/[remote-path]
[platform-cli] storage sync [local-directory] [bucket-name]/[remote-directory]
```

#### [Database Services]
- **Relational Databases**: [Available SQL database options]
- **NoSQL Databases**: [Available NoSQL options]
- **Configuration Example**:
```yaml
# [Database configuration]
[database_service]:
  engine: [database-engine]
  version: [version]
  instance_class: [instance-type]
  allocated_storage: [storage-gb]
  backup_retention: [days]
  multi_az: [true/false]
```

### Networking Services
#### Virtual Private Cloud (VPC)
```yaml
# [VPC configuration]
[vpc_service]:
  cidr_block: [cidr-range]
  subnets:
    public:
      - cidr: [public-subnet-cidr]
        availability_zone: [az]
    private:
      - cidr: [private-subnet-cidr]
        availability_zone: [az]
  internet_gateway: [true/false]
  nat_gateway: [true/false]
```

#### Load Balancing
```yaml
# [Load balancer configuration]
[load_balancer]:
  type: [application/network/classic]
  scheme: [internet-facing/internal]
  listeners:
    - port: [port]
      protocol: [protocol]
      targets: [target-group]
```

#### Content Delivery Network (CDN)
```yaml
# [CDN configuration]
[cdn_service]:
  origin: [origin-domain]
  cache_behaviors:
    - path_pattern: [path-pattern]
      ttl: [cache-ttl]
      compress: [true/false]
```

## Security and Compliance

### Security Best Practices
#### Data Encryption
- **At Rest**: [Encryption services and configuration]
- **In Transit**: [SSL/TLS configuration]
- **Key Management**: [Key management service usage]

```yaml
# [Encryption configuration example]
[encryption_config]:
  kms_key_id: [key-id]
  encryption_algorithm: [algorithm]
  key_rotation: [enabled/disabled]
```

#### Network Security
```yaml
# [Security group rules]
[security_group]:
  ingress_rules:
    - port: [port]
      protocol: [protocol]
      source: [cidr/security-group-id]
      description: [rule-description]
  egress_rules:
    - port: [port]
      protocol: [protocol]
      destination: [cidr/security-group-id]
      description: [rule-description]
```

#### Monitoring and Logging
```yaml
# [Logging configuration]
[logging_service]:
  log_groups:
    - name: [log-group-name]
      retention_days: [retention-period]
  metrics:
    - name: [metric-name]
      namespace: [namespace]
      dimensions: [dimensions]
```

### Compliance Frameworks
#### [Compliance Framework 1]
- **Requirements**: [Specific compliance requirements]
- **Implementation**: [How to configure for compliance]
- **Monitoring**: [Compliance monitoring setup]

#### [Compliance Framework 2]
- **Requirements**: [Specific compliance requirements]
- **Implementation**: [How to configure for compliance]
- **Monitoring**: [Compliance monitoring setup]

## Infrastructure as Code

### [Primary IaC Tool] Integration
```hcl
# [IaC example - Terraform]
provider "[platform]" {
  region = var.region
}

resource "[platform]_[resource]" "[name]" {
  [configuration_attributes]
}
```

### [Secondary IaC Tool] Integration
```yaml
# [IaC example - CloudFormation/ARM/etc.]
[resource_type]:
  Type: [platform].[resource_type]
  Properties:
    [property_name]: [property_value]
```

### Deployment Strategies
#### Blue-Green Deployment
```yaml
# [Blue-green deployment configuration]
[deployment_config]:
  strategy: blue_green
  environments:
    blue: [blue-environment-config]
    green: [green-environment-config]
  traffic_switching: [gradual/instant]
```

#### Canary Deployment
```yaml
# [Canary deployment configuration]
[deployment_config]:
  strategy: canary
  stages:
    - traffic_percentage: [percentage]
      duration: [duration]
      success_criteria: [criteria]
```

## Monitoring and Observability

### Native Monitoring Tools
#### [Primary Monitoring Service]
- **Metrics Collection**: [How to collect and view metrics]
- **Alerting**: [How to set up alerts]
- **Dashboards**: [Dashboard creation and management]

```yaml
# [Monitoring configuration]
[monitoring_service]:
  metrics:
    - name: [metric-name]
      statistic: [statistic-type]
      threshold: [threshold-value]
      comparison_operator: [operator]
  alarms:
    - name: [alarm-name]
      actions: [action-arns]
      treat_missing_data: [behavior]
```

#### [Logging Service]
```yaml
# [Logging configuration]
[logging_service]:
  log_streams:
    - name: [stream-name]
      log_group: [group-name]
      retention: [retention-days]
  queries:
    - name: [query-name]
      query_string: [log-query]
      time_range: [time-range]
```

### Third-Party Integration
#### Popular Monitoring Tools
- **[Tool 1]**: [Integration setup and configuration]
- **[Tool 2]**: [Integration setup and configuration]
- **[Tool 3]**: [Integration setup and configuration]

## Cost Management and Optimization

### Cost Monitoring
```yaml
# [Cost monitoring setup]
[cost_service]:
  budgets:
    - name: [budget-name]
      amount: [budget-amount]
      time_period: [monthly/yearly]
      alerts:
        - threshold: [percentage]
          subscribers: [email-list]
```

### Cost Optimization Strategies
#### Right-Sizing
- [How to analyze and optimize resource sizing]
- [Tools for right-sizing recommendations]
- [Automated scaling strategies]

#### Reserved Capacity
- [Reserved instance/capacity options]
- [When to use reserved capacity]
- [Cost analysis and comparison]

#### Resource Lifecycle Management
```yaml
# [Lifecycle management]
[lifecycle_policy]:
  rules:
    - name: [rule-name]
      status: enabled
      transitions:
        - days: [days]
          storage_class: [storage-class]
        - days: [days]
          storage_class: [archive-class]
      expiration:
        days: [expiration-days]
```

## DevOps and CI/CD Integration

### CI/CD Pipeline Integration
```yaml
# [CI/CD pipeline configuration]
[pipeline_service]:
  stages:
    - name: build
      actions:
        - name: [build-action]
          provider: [provider]
          configuration: [config]
    - name: deploy
      actions:
        - name: [deploy-action]
          provider: [provider]
          configuration: [config]
```

### Automated Testing
```yaml
# [Testing configuration]
[testing_config]:
  unit_tests:
    - framework: [test-framework]
      command: [test-command]
  integration_tests:
    - environment: [test-environment]
      scripts: [test-scripts]
  load_tests:
    - tool: [load-testing-tool]
      configuration: [load-test-config]
```

### Deployment Automation
```bash
# [Deployment scripts]
#!/bin/bash

# Deploy to staging
[platform-cli] deploy --environment staging --config staging.yml

# Run tests
[platform-cli] test --environment staging --suite integration

# Deploy to production (if tests pass)
if [ $? -eq 0 ]; then
  [platform-cli] deploy --environment production --config production.yml
fi
```

## Disaster Recovery and Backup

### Backup Strategies
#### Automated Backups
```yaml
# [Backup configuration]
[backup_service]:
  schedule: [cron-expression]
  retention: [retention-days]
  cross_region: [true/false]
  encryption: [enabled/disabled]
```

#### Point-in-Time Recovery
- [PITR capabilities and configuration]
- [Recovery procedures and timelines]
- [Testing backup integrity]

### Disaster Recovery Planning
#### Multi-Region Setup
```yaml
# [Multi-region configuration]
[multi_region_config]:
  primary_region: [primary-region]
  secondary_regions:
    - region: [secondary-region]
      replication: [sync/async]
      failover: [automatic/manual]
```

#### Recovery Procedures
1. **Detection**: [How to detect failures]
2. **Assessment**: [Impact assessment procedures]
3. **Failover**: [Failover execution steps]
4. **Recovery**: [Service recovery procedures]
5. **Fallback**: [Primary region restoration]

## Performance Optimization

### Performance Monitoring
```yaml
# [Performance monitoring]
[performance_config]:
  metrics:
    - response_time: [threshold-ms]
    - throughput: [requests-per-second]
    - error_rate: [percentage-threshold]
  synthetic_monitoring:
    - endpoint: [url]
      frequency: [check-interval]
      locations: [monitoring-locations]
```

### Optimization Techniques
#### Caching Strategies
- **Application-Level Caching**: [Cache configuration]
- **Database Caching**: [Database cache setup]
- **CDN Caching**: [Content delivery optimization]

#### Auto-Scaling
```yaml
# [Auto-scaling configuration]
[auto_scaling]:
  min_capacity: [min-instances]
  max_capacity: [max-instances]
  target_metrics:
    - metric: cpu_utilization
      target_value: [percentage]
    - metric: memory_utilization
      target_value: [percentage]
  scale_out_cooldown: [seconds]
  scale_in_cooldown: [seconds]
```

## Troubleshooting

### Common Issues
#### Issue 1: [Common Issue Name]
**Symptoms**: [How to identify this issue]
**Root Causes**: [Common underlying causes]
**Solutions**: [Step-by-step resolution]
**Prevention**: [How to prevent this issue]

#### Issue 2: [Common Issue Name]
**Symptoms**: [How to identify this issue]
**Root Causes**: [Common underlying causes]
**Solutions**: [Step-by-step resolution]
**Prevention**: [How to prevent this issue]

### Debugging Tools and Techniques
#### Native Debugging Tools
- **[Tool 1]**: [Purpose and usage]
- **[Tool 2]**: [Purpose and usage]
- **[Tool 3]**: [Purpose and usage]

#### Log Analysis
```bash
# [Log analysis commands]
[platform-cli] logs list --service [service-name]
[platform-cli] logs query --query "[log-query]" --time-range [range]
[platform-cli] logs tail --service [service-name] --follow
```

### Performance Troubleshooting
#### Resource Utilization Analysis
```bash
# [Resource analysis commands]
[platform-cli] metrics get --metric cpu_utilization --resource [resource-id]
[platform-cli] metrics get --metric memory_utilization --resource [resource-id]
[platform-cli] metrics get --metric network_io --resource [resource-id]
```

## Migration Strategies

### Migration from On-Premises
#### Assessment Phase
- [Infrastructure assessment tools]
- [Application dependency mapping]
- [Cost analysis and ROI calculation]

#### Migration Approaches
1. **Lift and Shift**: [Rehosting strategy]
2. **Re-platforming**: [Minimal changes approach]
3. **Refactoring**: [Application modernization]
4. **Rebuild**: [Complete redesign approach]

### Migration from Other Cloud Platforms
#### Data Migration
```bash
# [Data migration commands]
[platform-cli] migrate create-job --source [source-config] --destination [dest-config]
[platform-cli] migrate start --job-id [job-id]
[platform-cli] migrate status --job-id [job-id]
```

#### Application Migration
- [Application assessment and modification requirements]
- [Service mapping and equivalents]
- [Testing and validation procedures]

## Best Practices

### Security Best Practices
- [Security practice 1 with implementation details]
- [Security practice 2 with implementation details]
- [Security practice 3 with implementation details]

### Performance Best Practices
- [Performance practice 1 with implementation details]
- [Performance practice 2 with implementation details]
- [Performance practice 3 with implementation details]

### Cost Optimization Best Practices
- [Cost practice 1 with implementation details]
- [Cost practice 2 with implementation details]
- [Cost practice 3 with implementation details]

### Operational Best Practices
- [Operational practice 1 with implementation details]
- [Operational practice 2 with implementation details]
- [Operational practice 3 with implementation details]

## AI Assistant Guidelines

When helping with [Platform Name]:

1. **Security First**: Always prioritize security in all recommendations
2. **Cost Awareness**: Include cost considerations in architectural decisions
3. **Scalability**: Design solutions with growth and scaling in mind
4. **Monitoring**: Include observability and monitoring in all solutions
5. **Automation**: Prefer Infrastructure as Code and automation approaches
6. **Compliance**: Consider regulatory and compliance requirements
7. **Multi-Region**: Design for availability and disaster recovery
8. **Performance**: Optimize for performance and user experience

### Architecture Decision Framework
When helping with architectural decisions:

1. **Requirements Gathering**: Understand functional and non-functional requirements
2. **Service Selection**: Choose appropriate services based on requirements
3. **Cost Modeling**: Estimate costs and optimize for budget constraints
4. **Security Design**: Implement security at every layer
5. **Performance Design**: Design for expected load and growth
6. **Operational Design**: Include monitoring, logging, and maintenance

### Code Generation Rules
- Generate infrastructure code using established IaC patterns
- Include security configurations by default
- Add monitoring and logging to all resources
- Follow platform-specific naming conventions
- Include error handling and rollback procedures
- Provide cost optimization configurations

### Quality Enforcement
- ✅ Enforce security best practices in all configurations
- ✅ Require monitoring and logging for all resources
- ✅ Block configurations that expose security vulnerabilities
- ✅ Promote cost-effective resource choices
- ✅ Enforce backup and disaster recovery planning
- ✅ Require proper access control and IAM configurations
- ✅ Block hardcoded credentials and secrets
- ✅ Promote infrastructure as code practices