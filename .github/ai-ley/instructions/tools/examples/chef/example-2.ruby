# Policyfile.rb - Enterprise multi-environment configuration
name 'enterprise_baseline'

# Version constraints and sources
default_source :supermarket
default_source :chef_server, 'https://chef.example.com/organizations/enterprise'

# Cookbook dependencies with version pinning
cookbook 'baseline', '~> 2.1.0', path: './cookbooks/baseline'
cookbook 'security_hardening', '~> 1.5.0', git: 'https://git.example.com/chef/security_hardening.git'
cookbook 'monitoring_agent', '= 3.2.1', chef_server: 'https://chef.example.com/organizations/enterprise'

# Community cookbooks with strict version control
cookbook 'audit', '= 9.5.0'
cookbook 'firewall', '= 2.7.1'
cookbook 'ntp', '= 3.7.0'
cookbook 'rsyslog', '= 6.0.3'

# Run lists for different environments
run_list 'baseline::default', 'security_hardening::cis_level_1', 'monitoring_agent::default'

# Named run lists for role-based deployment
named_run_list :webserver,
  'baseline::default',
  'security_hardening::web',
  'nginx::enterprise',
  'monitoring_agent::web',
  'audit::default'

named_run_list :database,
  'baseline::default',
  'security_hardening::database',
  'postgresql::enterprise',
  'monitoring_agent::database',
  'audit::default'

named_run_list :loadbalancer,
  'baseline::default',
  'security_hardening::network',
  'haproxy::enterprise',
  'monitoring_agent::loadbalancer',
  'audit::default'

# Default attributes for all environments
default['enterprise']['organization'] = 'Example Corp'
default['enterprise']['environment'] = node.environment
default['enterprise']['compliance']['frameworks'] = ['CIS', 'NIST', 'SOX']
default['enterprise']['monitoring']['enabled'] = true
default['enterprise']['backup']['enabled'] = true
default['enterprise']['logging']['centralized'] = true
default['enterprise']['security']['hardening_level'] = 'high'

# Security baseline attributes
default['security']['ssh']['permit_root_login'] = false
default['security']['ssh']['password_authentication'] = false
default['security']['ssh']['max_auth_tries'] = 3
default['security']['firewall']['default_policy'] = 'deny'
default['security']['audit']['enabled'] = true
default['security']['file_integrity']['enabled'] = true

# Monitoring attributes
default['monitoring']['prometheus']['enabled'] = true
default['monitoring']['prometheus']['retention'] = '30d'
default['monitoring']['grafana']['enabled'] = true
default['monitoring']['alertmanager']['enabled'] = true
default['monitoring']['node_exporter']['enabled'] = true

# Logging configuration
default['logging']['rsyslog']['server'] = 'logs.example.com'
default['logging']['rsyslog']['port'] = 514
default['logging']['rsyslog']['protocol'] = 'tcp'
default['logging']['logrotate']['enabled'] = true

# Backup configuration
default['backup']['schedule'] = '0 2 * * *'
default['backup']['retention_days'] = 30
default['backup']['destination'] = 's3://enterprise-backups'
default['backup']['encryption_enabled'] = true

# NTP configuration
default['ntp']['servers'] = [
  'ntp1.example.com',
  'ntp2.example.com',
  'pool.ntp.org'
]

# Compliance profiles
default['audit']['profiles'] = [
  {
    'name' => 'cis-centos7-level1',
    'compliance' => 'admin/cis-centos7-level1',
    'version' => 'latest'
  },
  {
    'name' => 'enterprise-baseline',
    'path' => '/var/chef/compliance/enterprise-baseline',
    'version' => '2.1.0'
  },
  {
    'name' => 'pci-dss',
    'compliance' => 'admin/pci-dss-level1',
    'version' => 'latest'
  }
]

# Environment-specific overrides
case node.environment
when 'production'
  default['security']['hardening_level'] = 'maximum'
  default['monitoring']['retention'] = '90d'
  default['backup']['schedule'] = '0 1,13 * * *'  # Twice daily
  default['audit']['log_level'] = 'info'

when 'staging'
  default['security']['hardening_level'] = 'high'
  default['monitoring']['retention'] = '14d'
  default['backup']['schedule'] = '0 2 * * *'     # Daily
  default['audit']['log_level'] = 'info'

when 'development'
  default['security']['hardening_level'] = 'medium'
  default['monitoring']['retention'] = '7d'
  default['backup']['schedule'] = '0 3 * * 0'     # Weekly
  default['audit']['log_level'] = 'debug'
end

# Override attributes (highest precedence)
override['enterprise']['config_management'] = 'chef'
override['enterprise']['last_policy_update'] = Time.now.utc.iso8601