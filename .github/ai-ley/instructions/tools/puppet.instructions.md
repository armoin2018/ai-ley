---
name: 'puppet.instructions'
description: 'Development guidelines and best practices for Puppet.Instructions'
keywords: [api, cloud, agent, common, balancer, architecture, authentication, backend, avoid, cli]
---



# Puppet Enterprise Configuration Management Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive enterprise-grade guidance for AI agents implementing Puppet configuration management solutions, emphasizing declarative infrastructure automation, roles/profiles patterns, Hiera data management, and production deployment workflows with advanced compliance frameworks, monitoring integration, and multi-environment orchestration capabilities.

### When to Use Puppet

- **Enterprise infrastructure** requiring declarative configuration management with strong compliance frameworks
- **Large-scale environments** needing centralized policy enforcement with comprehensive audit trails
- **Regulated industries** requiring detailed configuration drift detection and remediation automation
- **Multi-platform environments** spanning Windows, Linux, and network devices with unified management
- **Configuration compliance** scenarios requiring continuous validation against security standards
- **Infrastructure governance** with role-based access control and change management workflows
- **Complex dependency management** requiring sophisticated resource ordering and relationships
- **Enterprise integration** with existing ITSM, monitoring, and security tools
- **Disaster recovery** scenarios requiring rapid, consistent infrastructure reconstruction
- **Hybrid cloud environments** needing consistent configuration across on-premises and cloud platforms

### When to Avoid Puppet

- **Simple, small-scale** deployments where Ansible might be more straightforward
- **Rapid prototyping** environments where immediate execution is preferred over compilation
- **Resource-constrained** environments where agent overhead is problematic
- **Immutable infrastructure** patterns where container-based deployment is preferred

### Architecture Essentials

- **Master-Agent Architecture**: Scalable PKI-based authentication with high-availability clustering
- **Declarative DSL**: Resource-based configuration language with strong typing and validation
- **Catalog Compilation**: Server-side compilation with client-side application and reporting
- **PuppetDB Integration**: Centralized fact storage, reporting, and configuration analytics
- **Hiera Data Backend**: Hierarchical data lookup with encrypted secrets management
- **Code Manager/r10k**: Git-based environment deployment with automated testing workflows
- **Enterprise Console**: Web-based management interface with RBAC and compliance reporting
- **Forge Integration**: Community module ecosystem with enterprise validation and approval

## Enterprise Puppet Management Framework

`See [example-1](./examples/puppet/example-1.ruby)puppet
# site/profiles/manifests/base.pp - Base profile for all nodes
class profiles::base (
  String $ntp_servers = lookup('ntp_servers', Array[String], 'deep', ['pool.ntp.org']),
  Boolean $monitoring_enabled = lookup('monitoring::enabled', Boolean, 'first', true),
  String $environment = $trusted['extensions']['pp_environment'],
  String $datacenter = $trusted['extensions']['pp_datacenter'],
) {

  # System hardening
  include profiles::security::baseline

  # Time synchronization
  class { 'ntp':
    servers => $ntp_servers,
  }

  # Monitoring agent
  if $monitoring_enabled {
    include profiles::monitoring::node_exporter
  }

  # Logging configuration
  include profiles::logging::rsyslog

  # Package management
  include profiles::packages::baseline

  # User management
  include profiles::users::baseline

  # Environment-specific configurations
  case $environment {
    'production': {
      include profiles::production::baseline
      $log_level = 'warn'
    }
    'staging': {
      include profiles::staging::baseline
      $log_level = 'info'
    }
    default: {
      include profiles::development::baseline
      $log_level = 'debug'
    }
  }

  # Datacenter-specific configurations
  case $datacenter {
    'us-west-2': {
      include profiles::datacenters::us_west_2
    }
    'us-east-1': {
      include profiles::datacenters::us_east_1
    }
    'eu-west-1': {
      include profiles::datacenters::eu_west_1
    }
    default: {
      include profiles::datacenters::default
    }
  }
}

# site/profiles/manifests/webserver/nginx.pp - Nginx web server profile
class profiles::webserver::nginx (
  String $nginx_version = lookup('nginx::version', String, 'first', 'installed'),
  Hash $vhosts = lookup('nginx::vhosts', Hash, 'deep', {}),
  Boolean $ssl_enabled = lookup('nginx::ssl_enabled', Boolean, 'first', true),
  String $worker_processes = lookup('nginx::worker_processes', String, 'first', 'auto'),
  Integer $worker_connections = lookup('nginx::worker_connections', Integer, 'first', 1024),
  Boolean $rate_limiting = lookup('nginx::rate_limiting', Boolean, 'first', true),
  Hash $upstream_servers = lookup('nginx::upstream_servers', Hash, 'deep', {}),
) {

  # Nginx package and service
  package { 'nginx':
    ensure => $nginx_version,
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => [
      File['/etc/nginx/nginx.conf'],
      File['/etc/nginx/conf.d/'],
    ],
  }

  # Main nginx configuration
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('profiles/nginx/nginx.conf.epp', {
      worker_processes   => $worker_processes,
      worker_connections => $worker_connections,
      environment        => $environment,
    }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  # Virtual hosts directory
  file { '/etc/nginx/conf.d/':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    purge   => true,
    recurse => true,
    require => Package['nginx'],
  }

  # Create virtual hosts
  $vhosts.each |String $vhost_name, Hash $vhost_config| {
    file { "/etc/nginx/conf.d/${vhost_name}.conf":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('profiles/nginx/vhost.conf.epp', {
        vhost_name   => $vhost_name,
        vhost_config => $vhost_config,
        ssl_enabled  => $ssl_enabled,
      }),
      require => File['/etc/nginx/conf.d/'],
      notify  => Service['nginx'],
    }
  }

  # SSL certificate management
  if $ssl_enabled {
    include profiles::ssl::certificates

    # SSL configuration
    file { '/etc/nginx/ssl.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => file('profiles/nginx/ssl.conf'),
      require => Package['nginx'],
      notify  => Service['nginx'],
    }
  }

  # Rate limiting configuration
  if $rate_limiting {
    file { '/etc/nginx/conf.d/rate_limiting.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => file('profiles/nginx/rate_limiting.conf'),
      require => File['/etc/nginx/conf.d/'],
      notify  => Service['nginx'],
    }
  }

  # Upstream server configuration
  if !empty($upstream_servers) {
    file { '/etc/nginx/conf.d/upstreams.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('profiles/nginx/upstreams.conf.epp', {
        upstream_servers => $upstream_servers,
      }),
      require => File['/etc/nginx/conf.d/'],
      notify  => Service['nginx'],
    }
  }

  # Log rotation
  file { '/etc/logrotate.d/nginx':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('profiles/nginx/nginx.logrotate'),
    require => Package['nginx'],
  }

  # Health check script
  file { '/usr/local/bin/nginx-healthcheck.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => epp('profiles/nginx/healthcheck.sh.epp', {
      vhosts => $vhosts,
    }),
    require => Package['nginx'],
  }

  # Monitoring integration
  include profiles::monitoring::nginx

  # Firewall rules
  firewall { '100 allow http':
    dport  => [80, 443],
    proto  => tcp,
    action => accept,
  }
}

# site/roles/manifests/webserver.pp - Web server role
class roles::webserver {
  include profiles::base
  include profiles::webserver::nginx
  include profiles::security::web
  include profiles::monitoring::web
  include profiles::backup::web
  include profiles::logging::web
}

# site/roles/manifests/database.pp - Database server role
class roles::database {
  include profiles::base
  include profiles::database::postgresql
  include profiles::security::database
  include profiles::monitoring::database
  include profiles::backup::database
  include profiles::logging::database
}

# site/roles/manifests/loadbalancer.pp - Load balancer role
class roles::loadbalancer {
  include profiles::base
  include profiles::loadbalancer::haproxy
  include profiles::security::loadbalancer
  include profiles::monitoring::loadbalancer
}
`See [example-2](./examples/puppet/example-2.txt)yaml
# data/common.yaml - Common configuration data
---
# NTP Configuration
ntp_servers:

# Monitoring Configuration
monitoring:
  enabled: true
  prometheus:
    enabled: true
    port: 9100
    scrape_interval: '15s'
  grafana:
    enabled: true

*Content optimized for conciseness. See external references for additional details.*

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
