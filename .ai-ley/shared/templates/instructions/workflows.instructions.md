# Workflow Instructions

## Overview

- **Domain**: Development and Operational Workflows
- **Purpose**: Guide AI agents in implementing automated workflows and process optimization
- **Applicable To**: CI/CD pipelines, development processes, deployment workflows, and quality gates
- **Complexity Level**: Intermediate

## Core Concepts

### Essential Concepts

- **Workflow Automation**: Systematic automation of development and operational processes
- **Quality Gates**: Automated checkpoints ensuring standards compliance before progression
- **Pipeline Integration**: Seamless integration between development, testing, and deployment stages
- **Process Optimization**: Continuous improvement through metrics and feedback loops

### Key Benefits

- Accelerated delivery through automated pipeline execution and parallel processing
- Enhanced quality through automated testing, code analysis, and compliance checking
- Improved reliability with consistent process execution and error handling
- Reduced manual effort via intelligent automation and self-service capabilities

## Implementation Guidelines

### Getting Started

```yaml
# Essential workflow configuration
workflow:
  name: 'development-pipeline'
  triggers:
    - push: ['main', 'develop']
    - pull_request: ['main']
  concurrency: 'single-branch'
```

### Core Patterns

```yaml
# Pattern 1: Multi-Stage Pipeline
stages:
  validate:
    steps:
      - code_quality: 'lint_and_format'
      - security_scan: 'vulnerability_check'
      - unit_tests: 'run_test_suite'

  build:
    steps:
      - compile: 'build_artifacts'
      - package: 'create_containers'
      - sign: 'security_signing'

  deploy:
    steps:
      - staging: 'deploy_to_staging'
      - integration_tests: 'run_e2e_tests'
      - production: 'deploy_to_production'

# Pattern 2: Quality Gate Configuration
quality_gates:
  code_coverage:
    threshold: 80
    action: 'block_on_failure'

  security_scan:
    severity: 'high'
    action: 'require_approval'

  performance_test:
    response_time: '< 500ms'
    action: 'notify_team'

# Pattern 3: Conditional Execution
conditions:
  feature_branch:
    run: ['validate', 'build']
    skip: ['deploy']

  main_branch:
    run: ['validate', 'build', 'deploy']
    approval_required: 'production'
```

### Best Practices

- **Fail Fast**: Early validation and quick feedback loops to catch issues immediately
- **Parallel Execution**: Run independent tasks concurrently to reduce total pipeline time
- **Idempotent Operations**: Ensure workflow steps can be safely repeated without side effects

## Common Use Cases

### Use Case 1: CI/CD Pipeline

**When**: Automated build, test, and deployment for application development
**Implementation**:

```yaml
# Complete CI/CD workflow
cicd_pipeline:
  triggers:
    push: ['main', 'develop']
    schedule: '0 2 * * *' # Daily at 2 AM

  stages:
    pre_commit:
      - lint_code: 'eslint src/'
      - format_check: 'prettier --check'
      - security_scan: 'npm audit'

    test:
      - unit_tests: 'npm test'
      - integration_tests: 'npm run test:integration'
      - coverage_report: 'nyc report'

    build:
      - compile: 'npm run build'
      - docker_build: 'docker build -t app:${{ version }}'
      - vulnerability_scan: 'trivy image app:${{ version }}'

    deploy:
      - staging:
          environment: 'staging'
          approval: false
      - production:
          environment: 'production'
          approval: true
          conditions: ['main_branch']
```

### Use Case 2: Code Review Workflow

**When**: Automated code quality checks and review process management
**Implementation**:

```yaml
# Code review automation
code_review:
  triggers:
    pull_request: ['opened', 'synchronize']

  automated_checks:
    - code_quality:
        tools: ['sonarqube', 'codeclimate']
        blocking: true

    - security_analysis:
        tools: ['semgrep', 'bandit']
        severity_threshold: 'medium'

    - test_coverage:
        minimum_coverage: 80
        diff_coverage: 90

  review_assignment:
    algorithm: 'round_robin'
    required_reviewers: 2
    auto_assign: true

  merge_conditions:
    - all_checks_passed: true
    - approvals_count: 2
    - branch_up_to_date: true
```

### Use Case 3: Release Management

**When**: Automated versioning, changelog generation, and release deployment
**Implementation**:

```yaml
# Release workflow
release_management:
  triggers:
    tag: 'v*'

  version_management:
    - extract_version: 'from_tag'
    - validate_semver: 'strict'
    - update_changelog: 'auto_generate'

  artifact_creation:
    - build_binaries: 'multi_platform'
    - create_packages: ['rpm', 'deb', 'docker']
    - sign_artifacts: 'gpg_signing'

  deployment:
    - staging_validation: 'smoke_tests'
    - production_rollout: 'blue_green'
    - monitoring: 'post_deploy_checks'

  notification:
    - team_slack: 'release_channel'
    - customer_email: 'release_notes'
    - documentation: 'auto_update'
```

## Anti-Patterns to Avoid

- **Manual Dependencies**: Workflows requiring manual intervention that could be automated
- **Single Point of Failure**: Pipelines without proper error handling and recovery mechanisms
- **Resource Contention**: Concurrent workflows competing for limited resources without coordination
- **Insufficient Monitoring**: Workflows without proper logging, metrics, and alerting

## Integration & Tools

### Essential Tools

- **Pipeline Orchestration**: GitHub Actions, GitLab CI, Jenkins, Azure DevOps for workflow automation
- **Quality Gates**: SonarQube, CodeClimate, Security scanning tools for automated quality checks
- **Deployment**: Kubernetes, Docker, cloud deployment services for application delivery
- **Monitoring**: Prometheus, Grafana, application monitoring for pipeline observability

### Workflow Architecture Pattern

```yaml
# Production workflow architecture
workflow_architecture:
  source_control:
    triggers: ['push', 'pull_request', 'schedule']
    branch_protection: 'required_checks'

  pipeline_stages:
    validation:
      parallel: true
      timeout: '10m'
      retry_policy: 'on_failure'

    build:
      cache_strategy: 'dependency_cache'
      artifact_storage: 'registry'
      retention_policy: '30_days'

    deployment:
      environments: ['staging', 'production']
      approval_gates: ['production']
      rollback_strategy: 'automatic'

  observability:
    metrics: ['duration', 'success_rate', 'failure_reasons']
    logging: 'structured'
    alerting: 'team_notifications'
```

## AI Assistant Guidelines

When helping with Workflow development:

1. **Automation First**: Prioritize automated solutions over manual processes
2. **Quality Integration**: Include quality gates and validation at every stage
3. **Security Consideration**: Implement security scanning and compliance checks
4. **Performance Optimization**: Design for efficiency with parallel execution and caching
5. **Error Handling**: Include comprehensive error handling and recovery mechanisms
6. **Monitoring Integration**: Add observability and alerting to all workflows
7. **Documentation**: Maintain clear documentation for workflow configuration and troubleshooting
8. **Scalability Planning**: Design workflows that can handle increasing load and complexity

### Code Generation Rules

- Generate workflow configurations using established patterns and best practices
- Include comprehensive error handling, retries, and timeout configurations
- Add security scanning, quality gates, and compliance checks by default
- Implement proper artifact management, caching, and optimization strategies
- Include monitoring, logging, and alerting configurations for all workflows
- Provide clear documentation and troubleshooting guidance for generated workflows

### Quality Enforcement

- ✅ Enforce quality gates and automated testing at appropriate workflow stages
- ✅ Require security scanning and vulnerability assessment in all pipelines
- ✅ Block workflows without proper error handling and recovery mechanisms
- ✅ Promote parallel execution and optimization for faster feedback cycles
- ✅ Require comprehensive logging and monitoring for all workflow executions
- ✅ Enforce proper access controls and secrets management in workflow configurations
- 🚫 Block workflows with hardcoded credentials or insecure configurations
- 🚫 Avoid single points of failure without proper redundancy and failover
- 🚫 Reject workflows without adequate testing and validation stages

## Resources

- **DevOps**: "The DevOps Handbook" by Gene Kim
- **CI/CD**: "Continuous Delivery" by Jez Humble and Dave Farley
- **Automation**: "Infrastructure as Code" by Kief Morris
