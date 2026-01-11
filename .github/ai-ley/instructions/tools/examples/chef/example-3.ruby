# Berksfile - Enterprise cookbook dependency management
source 'https://supermarket.chef.io'

# Metadata cookbook dependencies
metadata

# Internal cookbook sources
source chef_api: 'https://chef.example.com/organizations/enterprise',
       node_name: ENV['CHEF_CLIENT_NAME'],
       client_key: ENV['CHEF_CLIENT_KEY']

# Git-based cookbook sources
source git: 'https://git.example.com/chef-cookbooks'

# Enterprise cookbooks from internal Git repositories
cookbook 'enterprise_baseline',
  git: 'https://git.example.com/chef-cookbooks/enterprise_baseline.git',
  tag: 'v2.1.0'

cookbook 'security_hardening',
  git: 'https://git.example.com/chef-cookbooks/security_hardening.git',
  branch: 'production'

cookbook 'monitoring_stack',
  git: 'https://git.example.com/chef-cookbooks/monitoring_stack.git',
  ref: 'a1b2c3d4e5f6'

# Community cookbooks with version constraints
cookbook 'audit', '~> 9.5'
cookbook 'firewall', '~> 2.7'
cookbook 'ntp', '~> 3.7'
cookbook 'openssh', '~> 2.8'
cookbook 'sudo', '~> 5.4'
cookbook 'logrotate', '~> 2.2'
cookbook 'cron', '~> 6.3'

# Database cookbooks
cookbook 'postgresql', '~> 7.1'
cookbook 'mysql', '~> 8.8'
cookbook 'redis', '~> 5.2'

# Web server cookbooks
cookbook 'nginx', '~> 12.1'
cookbook 'apache2', '~> 8.2'

# Load balancer cookbooks
cookbook 'haproxy', '~> 12.0'

# Monitoring cookbooks
cookbook 'prometheus', '~> 1.2'
cookbook 'grafana', '~> 10.2'

# Testing cookbooks (integration group)
group :integration do
  cookbook 'test_helper', path: 'test/fixtures/cookbooks/test_helper'
  cookbook 'docker', '~> 7.0'
end

# Development cookbooks
group :development do
  cookbook 'vagrant', '~> 1.0'
  cookbook 'kitchen-docker', '~> 2.12'
end

# Environment-specific cookbooks
group :production do
  cookbook 'newrelic', '~> 2.44'
  cookbook 'splunk_client', '~> 1.8'
end

# Platform-specific cookbooks
group :windows do
  cookbook 'windows', '~> 8.0'
  cookbook 'iis', '~> 8.0'
  cookbook 'sql_server', '~> 6.0'
end