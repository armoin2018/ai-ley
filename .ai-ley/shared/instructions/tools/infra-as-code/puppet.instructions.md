---
ai-system-type: 'configuration-management'
category: 'infra-as-code'
subcategory: 'declarative-automation'
difficulty: 'advanced'
prerequisites: ['ruby', 'puppet-dsl', 'linux-administration', 'configuration-management-concepts']
technical-quality: 4.9
ai-usability: 4.9
cross-references:
  - 'ansible.instructions.md'
  - 'salt.instructions.md'
  - 'terraform.instructions.md'
  - 'chef.instructions.md'
version: '3.0'
last-updated: '2024-12-28'
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

````ruby
#!/usr/bin/env ruby
# puppet-enterprise-manager.rb - Advanced Puppet enterprise management system

require 'puppet'
require 'puppet/application/master'
require 'puppetdb'
require 'yaml'
require 'json'
require 'logger'
require 'openssl'
require 'net/https'
require 'prometheus/client'
require 'hiera'

class PuppetEnterpriseManager
  attr_accessor :config, :logger, :puppetdb_client, :hiera, :metrics_registry

  def initialize(config_file = '/etc/puppet-enterprise/manager.yaml')
    @config_file = config_file
    @config = load_configuration
    setup_logging
    initialize_puppetdb
    initialize_hiera
    setup_metrics

    @logger.info "Puppet Enterprise Manager initialized"
  end

  private

  def load_configuration
    default_config = {
      'puppet' => {
        'master_host' => 'puppet.example.com',
        'master_port' => 8140,
        'ca_host' => 'puppet.example.com',
        'ca_port' => 8140,
        'environments_path' => '/etc/puppetlabs/code/environments',
        'hiera_config' => '/etc/puppetlabs/puppet/hiera.yaml',
        'certificate_path' => '/etc/puppetlabs/puppet/ssl/certs',
        'private_key_path' => '/etc/puppetlabs/puppet/ssl/private_keys'
      },
      'enterprise' => {
        'console_enabled' => true,
        'console_host' => 'console.puppet.example.com',
        'rbac_enabled' => true,
        'compliance_monitoring' => true,
        'drift_detection' => true,
        'automated_remediation' => true,
        'backup_automation' => true,
        'disaster_recovery' => true,
        'multi_master_setup' => true,
        'load_balancer_enabled' => true
      },
      'monitoring' => {
        'prometheus_enabled' => true,
        'prometheus_gateway' => 'localhost:9091',
        'metrics_interval' => 30,
        'puppetdb_metrics' => true,
        'compilation_metrics' => true,
        'agent_metrics' => true
      },
      'security' => {
        'certificate_authority' => 'internal',
        'autosign_enabled' => false,
        'policy_based_autosign' => true,
        'certificate_renewal' => true,
        'secrets_encryption' => 'hiera-eyaml',
        'access_control_enabled' => true,
        'audit_logging' => true
      },
      'compliance' => {
        'frameworks' => ['CIS', 'NIST', 'PCI-DSS', 'HIPAA'],
        'reporting_enabled' => true,
        'remediation_enabled' => true,
        'exception_management' => true,
        'continuous_monitoring' => true
      }
    }

    if File.exist?(@config_file)
      user_config = YAML.load_file(@config_file)
      deep_merge(default_config, user_config)
    else
      default_config
    end
  end

  def deep_merge(base_hash, other_hash)
    base_hash.merge(other_hash) do |key, base_val, other_val|
      if base_val.is_a?(Hash) && other_val.is_a?(Hash)
        deep_merge(base_val, other_val)
      else
        other_val
      end
    end
  end

  def setup_logging
    log_dir = '/var/log/puppet-enterprise'
    Dir.mkdir(log_dir) unless Dir.exist?(log_dir)

    @logger = Logger.new("#{log_dir}/manager.log", 'daily')
    @logger.level = Logger::INFO
    @logger.formatter = proc do |severity, datetime, progname, msg|
      "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} [#{severity}] #{msg}\n"
    end
  end

  def initialize_puppetdb
    @puppetdb_client = PuppetDB::Client.new({
      server: @config['puppet']['master_host'],
      pem: {
        'ca_file' => "#{@config['puppet']['certificate_path']}/ca.pem",
        'cert_file' => "#{@config['puppet']['certificate_path']}/#{Socket.gethostname}.pem",
        'key_file' => "#{@config['puppet']['private_key_path']}/#{Socket.gethostname}.pem"
      }
    })
    @logger.info "PuppetDB client initialized"
  rescue => e
    @logger.error "Failed to initialize PuppetDB client: #{e.message}"
    raise
  end

  def initialize_hiera
    @hiera = Hiera.new(config: @config['puppet']['hiera_config'])
    @logger.info "Hiera initialized"
  rescue => e
    @logger.error "Failed to initialize Hiera: #{e.message}"
    raise
  end

  def setup_metrics
    @metrics_registry = Prometheus::Client.registry

    @node_count = Prometheus::Client::Gauge.new(
      :puppet_nodes_total,
      docstring: 'Total number of Puppet nodes',
      labels: [:environment, :status]
    )
    @metrics_registry.register(@node_count)

    @catalog_compilation_time = Prometheus::Client::Histogram.new(
      :puppet_catalog_compilation_duration_seconds,
      docstring: 'Catalog compilation time',
      labels: [:environment, :node]
    )
    @metrics_registry.register(@catalog_compilation_time)

    @puppet_runs = Prometheus::Client::Counter.new(
      :puppet_runs_total,
      docstring: 'Total Puppet runs',
      labels: [:environment, :status, :node]
    )
    @metrics_registry.register(@puppet_runs)

    @compliance_score = Prometheus::Client::Gauge.new(
      :puppet_compliance_score,
      docstring: 'Compliance score by framework',
      labels: [:framework, :environment, :node]
    )
    @metrics_registry.register(@compliance_score)
  end

  public

  def deploy_environment(environment_name, git_branch = 'main')
    """Deploy Puppet environment from Git repository"""
    begin
      @logger.info "Deploying environment: #{environment_name} from branch: #{git_branch}"

      # Validate environment configuration
      validate_environment_config(environment_name)

      # Deploy using r10k/Code Manager
      deploy_result = execute_r10k_deployment(environment_name, git_branch)

      if deploy_result[:success]
        # Run syntax validation
        syntax_validation = validate_puppet_syntax(environment_name)

        if syntax_validation[:valid]
          # Update environment metadata
          update_environment_metadata(environment_name, {
            deployment_time: Time.now,
            git_branch: git_branch,
            commit_hash: deploy_result[:commit_hash],
            status: 'deployed'
          })

          @logger.info "Environment #{environment_name} deployed successfully"
          return { success: true, details: deploy_result }
        else
          @logger.error "Syntax validation failed for environment: #{environment_name}"
          return { success: false, error: 'Syntax validation failed', details: syntax_validation }
        end
      else
        @logger.error "Deployment failed for environment: #{environment_name}"
        return { success: false, error: 'Deployment failed', details: deploy_result }
      end
    rescue => e
      @logger.error "Error deploying environment #{environment_name}: #{e.message}"
      return { success: false, error: e.message }
    end
  end

  def compile_catalog(node_name, environment = 'production')
    """Compile Puppet catalog for specified node"""
    begin
      @logger.info "Compiling catalog for node: #{node_name} in environment: #{environment}"

      start_time = Time.now

      # Set up Puppet context
      Puppet.initialize_settings(['--environment', environment])

      # Load node information
      node = Puppet::Node.find(node_name)

      # Compile catalog
      catalog = Puppet::Resource::Catalog.indirection.find(
        node_name,
        :use_node => node,
        :environment => environment
      )

      compilation_time = Time.now - start_time

      # Update metrics
      @catalog_compilation_time.observe(compilation_time, labels: { environment: environment, node: node_name })

      # Store compilation metadata
      catalog_metadata = {
        node: node_name,
        environment: environment,
        compilation_time: compilation_time,
        resource_count: catalog.resources.count,
        timestamp: Time.now
      }

      store_catalog_metadata(catalog_metadata)

      @logger.info "Catalog compiled successfully for #{node_name} in #{compilation_time}s"

      return {
        success: true,
        catalog: catalog.to_json,
        metadata: catalog_metadata
      }

    rescue => e
      @logger.error "Catalog compilation failed for #{node_name}: #{e.message}"
      return { success: false, error: e.message }
    end
  end

  def generate_compliance_report(framework = 'CIS', environment = 'production')
    """Generate compliance report for specified framework"""
    begin
      @logger.info "Generating compliance report for #{framework} in #{environment}"

      # Query PuppetDB for compliance data
      compliance_query = build_compliance_query(framework, environment)
      compliance_data = @puppetdb_client.request('', compliance_query)

      # Process compliance results
      report = process_compliance_data(compliance_data, framework)

      # Update compliance metrics
      update_compliance_metrics(report, framework, environment)

      # Generate report document
      report_document = format_compliance_report(report, framework, environment)

      # Store report
      report_file = "/var/lib/puppet-enterprise/reports/compliance_#{framework}_#{environment}_#{Time.now.strftime('%Y%m%d_%H%M%S')}.json"
      File.write(report_file, JSON.pretty_generate(report_document))

      @logger.info "Compliance report generated: #{report_file}"

      return {
        success: true,
        report_file: report_file,
        summary: report[:summary]
      }

    rescue => e
      @logger.error "Failed to generate compliance report: #{e.message}"
      return { success: false, error: e.message }
    end
  end

  def orchestrate_deployment(orchestration_config)
    """Execute complex multi-environment deployment orchestration"""
    begin
      orchestration_id = "orch_#{Time.now.to_i}"
      @logger.info "Starting deployment orchestration: #{orchestration_id}"

      results = {
        orchestration_id: orchestration_id,
        start_time: Time.now,
        stages: [],
        status: 'running'
      }

      # Execute deployment stages
      orchestration_config['stages'].each_with_index do |stage, index|
        stage_start = Time.now
        stage_name = stage['name'] || "stage_#{index}"

        @logger.info "Executing orchestration stage: #{stage_name}"

        begin
          # Check stage prerequisites
          if stage['prerequisites']
            prereq_result = check_stage_prerequisites(stage['prerequisites'])
            unless prereq_result[:met]
              raise "Prerequisites not met: #{prereq_result[:missing]}"
            end
          end

          # Execute stage operations
          stage_result = execute_orchestration_stage(stage)

          stage_duration = Time.now - stage_start

          stage_summary = {
            name: stage_name,
            status: stage_result[:success] ? 'completed' : 'failed',
            duration: stage_duration,
            details: stage_result,
            timestamp: stage_start
          }

          results[:stages] << stage_summary

          unless stage_result[:success]
            if orchestration_config['rollback_on_failure']
              execute_rollback(results[:stages])
            end

            results[:status] = 'failed'
            break
          end

        rescue => stage_error
          @logger.error "Orchestration stage #{stage_name} failed: #{stage_error.message}"

          stage_summary = {
            name: stage_name,
            status: 'error',
            duration: Time.now - stage_start,
            error: stage_error.message,
            timestamp: stage_start
          }

          results[:stages] << stage_summary
          results[:status] = 'error'
          break
        end
      end

      # Finalize orchestration
      results[:end_time] = Time.now
      results[:total_duration] = results[:end_time] - results[:start_time]

      if results[:status] == 'running'
        results[:status] = 'completed'
      end

      @logger.info "Orchestration #{orchestration_id} completed with status: #{results[:status]}"

      return results

    rescue => e
      @logger.error "Orchestration failed: #{e.message}"
      return { success: false, error: e.message }
    end
  end

  private

  def validate_environment_config(environment_name)
    environment_path = "#{@config['puppet']['environments_path']}/#{environment_name}"

    unless Dir.exist?(environment_path)
      raise "Environment directory does not exist: #{environment_path}"
    end

    # Validate Puppetfile
    puppetfile_path = "#{environment_path}/Puppetfile"
    unless File.exist?(puppetfile_path)
      @logger.warn "Puppetfile not found in environment: #{environment_name}"
    end

    # Validate environment.conf
    env_conf_path = "#{environment_path}/environment.conf"
    unless File.exist?(env_conf_path)
      @logger.warn "environment.conf not found in environment: #{environment_name}"
    end

    true
  end

  def execute_r10k_deployment(environment_name, git_branch)
    r10k_command = [
      'r10k', 'deploy', 'environment', environment_name,
      '--puppetfile',
      '--verbose'
    ]

    output = `#{r10k_command.join(' ')} 2>&1`
    success = $?.success?

    {
      success: success,
      output: output,
      command: r10k_command.join(' ')
    }
  end

  def validate_puppet_syntax(environment_name)
    environment_path = "#{@config['puppet']['environments_path']}/#{environment_name}"

    # Validate manifests
    manifest_validation = `puppet parser validate #{environment_path}/manifests/*.pp 2>&1`
    manifest_valid = $?.success?

    # Validate modules
    modules_path = "#{environment_path}/site"
    module_validation = ""
    module_valid = true

    if Dir.exist?(modules_path)
      Dir.glob("#{modules_path}/*/manifests/*.pp").each do |manifest|
        result = `puppet parser validate #{manifest} 2>&1`
        unless $?.success?
          module_validation += result
          module_valid = false
        end
      end
    end

    {
      valid: manifest_valid && module_valid,
      manifest_validation: manifest_validation,
      module_validation: module_validation
    }
  end

  def update_environment_metadata(environment_name, metadata)
    metadata_file = "/var/lib/puppet-enterprise/environments/#{environment_name}.json"

    # Ensure directory exists
    FileUtils.mkdir_p(File.dirname(metadata_file))

    # Update metadata
    existing_metadata = {}
    if File.exist?(metadata_file)
      existing_metadata = JSON.parse(File.read(metadata_file)) rescue {}
    end

    updated_metadata = existing_metadata.merge(metadata.transform_keys(&:to_s))

    File.write(metadata_file, JSON.pretty_generate(updated_metadata))
  end
end

# Enterprise Puppet module structure
module PuppetEnterpriseModules
  # Base profile class
  PROFILE_TEMPLATE = <<~PUPPET
    # Base profile class template
    class profiles::base (
      Boolean $ntp_enabled = true,
      Boolean $monitoring_enabled = true,
      Boolean $security_hardening = true,
      String $environment = $facts['environment'],
    ) {

      # NTP configuration
      if $ntp_enabled {
        include profiles::ntp
      }

      # Monitoring configuration
      if $monitoring_enabled {
        include profiles::monitoring
      }

      # Security hardening
      if $security_hardening {
        include profiles::security::baseline
      }

      # Environment-specific configuration
      case $environment {
        'production': {
          include profiles::production
        }
        'staging': {
          include profiles::staging
        }
        default: {
          include profiles::development
        }
      }
    }
  PUPPET

  # Role class template
  ROLE_TEMPLATE = <<~PUPPET
    # Web server role
    class roles::webserver {
      include profiles::base
      include profiles::webserver::nginx
      include profiles::security::web
      include profiles::monitoring::web
      include profiles::backup::web
    }

    # Database server role
    class roles::database {
      include profiles::base
      include profiles::database::postgresql
      include profiles::security::database
      include profiles::monitoring::database
      include profiles::backup::database
    }

    # Load balancer role
    class roles::loadbalancer {
      include profiles::base
      include profiles::loadbalancer::haproxy
      include profiles::security::loadbalancer
      include profiles::monitoring::loadbalancer
    }
  PUPPET
end

# Enterprise configuration templates
ENTERPRISE_HIERA_CONFIG = {
  'version' => 5,
  'defaults' => {
    'datadir' => 'data',
    'data_hash' => 'yaml_data'
  },
  'hierarchy' => [
    {
      'name' => 'Per-node data',
      'path' => 'nodes/%{trusted.certname}.yaml'
    },
    {
      'name' => 'Per-role data',
      'path' => 'roles/%{role}.yaml'
    },
    {
      'name' => 'Per-environment data',
      'path' => 'environments/%{environment}.yaml'
    },
    {
      'name' => 'Per-datacenter data',
      'path' => 'datacenters/%{facts.datacenter}.yaml'
    },
    {
      'name' => 'OS family data',
      'path' => 'os/%{facts.os.family}.yaml'
    },
    {
      'name' => 'Common data',
      'path' => 'common.yaml'
    },
    {
      'name' => 'Encrypted secrets',
      'lookup_key' => 'eyaml_lookup_key',
      'path' => 'secrets/%{environment}.yaml',
      'options' => {
        'pkcs7_private_key' => '/etc/puppetlabs/puppet/eyaml/private_key.pkcs7.pem',
        'pkcs7_public_key' => '/etc/puppetlabs/puppet/eyaml/public_key.pkcs7.pem'
      }
    }
  ]
}

def create_enterprise_puppet_config
  config = {
    'master' => {
      'certname' => 'puppet.example.com',
      'server' => 'puppet.example.com',
      'environment' => 'production',
      'environmentpath' => '/etc/puppetlabs/code/environments',
      'basemodulepath' => '/etc/puppetlabs/code/modules:/opt/puppetlabs/puppet/modules',
      'hiera_config' => '/etc/puppetlabs/puppet/hiera.yaml',
      'autosign' => false,
      'autosign_policy' => '/etc/puppetlabs/puppet/autosign_policy.rb',
      'dns_alt_names' => 'puppet,puppet.example.com,puppet-master.example.com',
      'reports' => 'store,puppetdb,http',
      'storeconfigs' => true,
      'storeconfigs_backend' => 'puppetdb',
      'ca' => true,
      'ca_server' => 'puppet.example.com',
      'ca_port' => 8140
    },

    'agent' => {
      'server' => 'puppet.example.com',
      'environment' => 'production',
      'runinterval' => 1800,
      'splay' => true,
      'splaylimit' => 600,
      'report' => true,
      'pluginsync' => true,
      'usecacheonfailure' => true,
      'use_cached_catalog' => false,
      'ignoremissingtypes' => false,
      'ca_server' => 'puppet.example.com',
      'ca_port' => 8140
    },

    'main' => {
      'logdir' => '/var/log/puppetlabs/puppet',
      'vardir' => '/opt/puppetlabs/puppet/cache',
      'ssldir' => '/etc/puppetlabs/puppet/ssl',
      'rundir' => '/var/run/puppetlabs',
      'factpath' => '$vardir/lib/facter:$vardir/facts',
      'prerun_command' => '/etc/puppet/etckeeper-commit-pre',
      'postrun_command' => '/etc/puppet/etckeeper-commit-post',
      'archive_files' => true,
      'archive_file_server' => 'puppet.example.com'
    }
  }

  config
end

## Implementation Framework

### Enterprise Roles and Profiles Pattern

```puppet
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
````

### Advanced Hiera Configuration

```yaml
# data/common.yaml - Common configuration data
---
# NTP Configuration
ntp_servers:
  - '0.pool.ntp.org'
  - '1.pool.ntp.org'
  - '2.pool.ntp.org'
  - '3.pool.ntp.org'

# Monitoring Configuration
monitoring:
  enabled: true
  prometheus:
    enabled: true
    port: 9100
    scrape_interval: '15s'
  grafana:
    enabled: true
    port: 3000
  alertmanager:
    enabled: true
    port: 9093

# Security Configuration
security:
  hardening_enabled: true
  fail2ban_enabled: true
  automatic_updates: true
  audit_logging: true

# SSH Configuration
ssh:
  port: 22
  permit_root_login: false
  password_authentication: false
  pubkey_authentication: true
  max_auth_tries: 3
  client_alive_interval: 300

# Firewall Configuration
firewall:
  default_policy: 'drop'
  allowed_services:
    - 'ssh'
  logging: true

# Package Management
packages:
  update_strategy: 'security'
  automatic_updates: true
  excluded_packages: []

# data/environments/production.yaml - Production-specific configuration
---
# Production NTP servers (internal)
ntp_servers:
  - 'ntp1.internal.example.com'
  - 'ntp2.internal.example.com'

# Production monitoring with enhanced alerting
monitoring:
  enabled: true
  alert_thresholds:
    cpu_warning: 70
    cpu_critical: 85
    memory_warning: 80
    memory_critical: 90
    disk_warning: 85
    disk_critical: 95
  retention_days: 90

# Enhanced security for production
security:
  hardening_enabled: true
  cis_compliance: true
  intrusion_detection: true
  file_integrity_monitoring: true

# Production backup configuration
backup:
  enabled: true
  schedule: '0 2 * * *'
  retention: '30 days'
  encryption: true
  destinations:
    - type: 's3'
      bucket: 'backups-prod-us-west-2'
      region: 'us-west-2'

# data/roles/webserver.yaml - Web server role configuration
---
# Nginx configuration for web servers
nginx:
  version: '1.20.1-1'
  worker_processes: 'auto'
  worker_connections: 4096
  ssl_enabled: true
  rate_limiting: true

  # Virtual hosts configuration
  vhosts:
    'app.example.com':
      listen_port: 80
      ssl_port: 443
      document_root: '/var/www/app'
      ssl_cert: '/etc/ssl/certs/app.example.com.crt'
      ssl_key: '/etc/ssl/private/app.example.com.key'
      upstream: 'app_backend'

  # Upstream server configuration
  upstream_servers:
    'app_backend':
      servers:
        - 'app1.internal.example.com:8080'
        - 'app2.internal.example.com:8080'
        - 'app3.internal.example.com:8080'
      method: 'least_conn'
      health_check: true

# SSL certificate configuration
ssl:
  certificates:
    'app.example.com':
      cert_source: 'puppet:///modules/profiles/ssl/app.example.com.crt'
      key_source: 'puppet:///modules/profiles/ssl/app.example.com.key'
      ca_source: 'puppet:///modules/profiles/ssl/ca.crt'

# Web server specific firewall rules
firewall_rules:
  '100 allow http':
    port: 80
    proto: 'tcp'
    action: 'accept'
  '101 allow https':
    port: 443
    proto: 'tcp'
    action: 'accept'

# data/secrets/production.yaml - Encrypted secrets (using hiera-eyaml)
---
# Database passwords (encrypted)
database:
  postgresql:
    passwords:
      app_user: >
        ENC[PKCS7,encrypted_password_data_here]
      admin_user: >
        ENC[PKCS7,encrypted_admin_password_data_here]

# SSL private keys (encrypted)
ssl:
  private_keys:
    'app.example.com': >
      ENC[PKCS7,encrypted_private_key_data_here]

# API keys and tokens (encrypted)
api_keys:
  monitoring:
    prometheus_token: >
      ENC[PKCS7,encrypted_prometheus_token_here]
    grafana_admin_password: >
      ENC[PKCS7,encrypted_grafana_password_here]

# Backup encryption keys (encrypted)
backup:
  encryption_keys:
    primary: >
      ENC[PKCS7,encrypted_backup_key_here]
```

### Enterprise Puppet Development Kit (PDK) Integration

```bash
#!/bin/bash
# puppet-enterprise-development.sh - Enterprise Puppet development workflow

set -euo pipefail

# Environment variables
PUPPET_ENVIRONMENT="${PUPPET_ENVIRONMENT:-development}"
GIT_BRANCH="${GIT_BRANCH:-main}"
MODULE_PATH="/etc/puppetlabs/code/environments/${PUPPET_ENVIRONMENT}/site"
PUPPETFILE_PATH="/etc/puppetlabs/code/environments/${PUPPET_ENVIRONMENT}/Puppetfile"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Initialize new Puppet module with PDK
init_module() {
    local module_name="$1"
    local author_name="${2:-Example Organization}"

    log "Initializing new Puppet module: $module_name"

    cd "$MODULE_PATH"
    pdk new module "$module_name" \
        --template-url="https://github.com/puppetlabs/pdk-templates" \
        --skip-interview

    cd "${MODULE_PATH}/${module_name}"

    # Update metadata.json
    jq --arg author "$author_name" \
       --arg license "proprietary" \
       --arg source "https://git.example.com/puppet-modules/${module_name}" \
       '.author = $author | .license = $license | .source = $source' \
       metadata.json > metadata.json.tmp && mv metadata.json.tmp metadata.json

    log "Module $module_name initialized successfully"
}

# Generate new class with PDK
generate_class() {
    local module_name="$1"
    local class_name="$2"

    log "Generating class $class_name in module $module_name"

    cd "${MODULE_PATH}/${module_name}"
    pdk new class "$class_name"

    # Add spec test
    pdk new test --unit "$class_name"

    log "Class $class_name generated successfully"
}

# Run comprehensive testing suite
run_tests() {
    local module_name="$1"

    log "Running comprehensive test suite for module: $module_name"

    cd "${MODULE_PATH}/${module_name}"

    # Syntax validation
    log "Running syntax validation..."
    pdk validate --parallel

    # Unit tests
    log "Running unit tests..."
    pdk test unit --verbose

    # Integration tests (if available)
    if [ -d "spec/acceptance" ]; then
        log "Running acceptance tests..."
        pdk test acceptance --verbose
    fi

    # Security scanning
    log "Running security scan..."
    if command -v bundle >/dev/null 2>&1; then
        bundle exec rake security_scan || log "Security scan not configured"
    fi

    log "Test suite completed for module: $module_name"
}

# Deploy environment with r10k
deploy_environment() {
    local environment="$1"
    local validation_level="${2:-full}"

    log "Deploying environment: $environment"

    # Deploy with r10k
    r10k deploy environment "$environment" --puppetfile --verbose

    if [ "$validation_level" = "full" ]; then
        # Validate syntax
        log "Validating Puppet syntax..."
        puppet parser validate "/etc/puppetlabs/code/environments/${environment}/manifests/site.pp"

        # Test catalog compilation for sample nodes
        log "Testing catalog compilation..."
        test_catalog_compilation "$environment"

        # Run smoke tests
        log "Running smoke tests..."
        run_smoke_tests "$environment"
    fi

    log "Environment $environment deployed successfully"
}

# Test catalog compilation
test_catalog_compilation() {
    local environment="$1"

    # Test different node types
    local test_nodes=(
        "webserver01.example.com"
        "database01.example.com"
        "loadbalancer01.example.com"
    )

    for node in "${test_nodes[@]}"; do
        log "Testing catalog compilation for node: $node"

        puppet catalog compile "$node" \
            --environment="$environment" \
            --render-as=json > "/tmp/${node}_catalog.json"

        # Validate catalog
        if jq empty "/tmp/${node}_catalog.json" 2>/dev/null; then
            log "✓ Catalog compilation successful for $node"
        else
            log "✗ Catalog compilation failed for $node"
            return 1
        fi
    done
}

# Run smoke tests
run_smoke_tests() {
    local environment="$1"

    log "Running smoke tests for environment: $environment"

    # Test Hiera data lookup
    log "Testing Hiera data lookup..."
    puppet lookup --environment="$environment" ntp_servers

    # Test module dependencies
    log "Testing module dependencies..."
    puppet module list --environment="$environment"

    # Validate environment configuration
    log "Validating environment configuration..."
    if [ -f "/etc/puppetlabs/code/environments/${environment}/environment.conf" ]; then
        log "✓ Environment configuration found"
    else
        log "✗ Environment configuration missing"
        return 1
    fi

    log "Smoke tests completed successfully"
}

# Generate compliance report
generate_compliance_report() {
    local environment="$1"
    local framework="${2:-CIS}"

    log "Generating compliance report for $framework in environment: $environment"

    # Query PuppetDB for compliance data
    puppet-query "inventory[certname] { environment = \"$environment\" }" | \
    while read -r node; do
        log "Checking compliance for node: $node"

        # Generate node-specific compliance report
        puppet compliance scan "$node" \
            --environment="$environment" \
            --framework="$framework" \
            --output-format=json > "/tmp/compliance_${node}_${framework}.json"
    done

    # Aggregate compliance data
    jq -s 'add' /tmp/compliance_*_${framework}.json > \
        "/var/lib/puppet/reports/compliance_${environment}_${framework}_$(date +%Y%m%d).json"

    log "Compliance report generated: /var/lib/puppet/reports/compliance_${environment}_${framework}_$(date +%Y%m%d).json"
}

# Main CLI interface
main() {
    case "${1:-}" in
        "init-module")
            init_module "$2" "${3:-}"
            ;;
        "generate-class")
            generate_class "$2" "$3"
            ;;
        "test")
            run_tests "$2"
            ;;
        "deploy")
            deploy_environment "$2" "${3:-full}"
            ;;
        "compliance")
            generate_compliance_report "$2" "${3:-CIS}"
            ;;
        *)
            echo "Usage: $0 {init-module|generate-class|test|deploy|compliance} [arguments...]"
            echo ""
            echo "Commands:"
            echo "  init-module <name> [author]     Initialize new Puppet module"
            echo "  generate-class <module> <class> Generate new class in module"
            echo "  test <module>                   Run comprehensive test suite"
            echo "  deploy <environment> [level]    Deploy environment with r10k"
            echo "  compliance <environment> [framework] Generate compliance report"
            exit 1
            ;;
    esac
}

# Execute main function with all arguments
main "$@"
```

## Advanced Enterprise Features

### High Availability and Load Balancing

```puppet
# High availability Puppet master configuration
# /etc/puppetlabs/puppet/puppet.conf for compile masters

[master]
certname = puppet-compile-01.example.com
ca_server = puppet-ca.example.com
ca_port = 8140

# Load balancer integration
dns_alt_names = puppet,puppet.example.com,puppet-lb.example.com

# PuppetDB configuration
storeconfigs = true
storeconfigs_backend = puppetdb
reports = store,puppetdb

# Performance tuning
jruby_max_active_instances = 4
jruby_max_requests_per_instance = 0
max_requests_per_instance = 10000

# Environment caching
environment_timeout = unlimited

# File serving optimization
file_server_mount_point = /etc/puppetlabs/code

# Certificate authority delegation
ca = false
```

```yaml
# /etc/puppetlabs/puppetserver/conf.d/ca.conf
# Certificate Authority configuration for HA setup
certificate-authority: {
  certificate-status: {
    authorization-required: true
    client-whitelist: [
      "puppet-ca.example.com",
      "puppet-compile-01.example.com",
      "puppet-compile-02.example.com",
      "puppet-compile-03.example.com"
    ]
  }
}
```

### Advanced PuppetDB Integration

```ruby
#!/usr/bin/env ruby
# puppetdb-enterprise-integration.rb - Advanced PuppetDB integration

require 'puppetdb'
require 'json'
require 'yaml'

class PuppetDBEnterpriseIntegration
  def initialize
    @client = PuppetDB::Client.new({
      server: 'https://puppetdb.example.com:8081',
      pem: {
        'ca_file' => '/etc/puppetlabs/puppet/ssl/certs/ca.pem',
        'cert_file' => '/etc/puppetlabs/puppet/ssl/certs/puppet.pem',
        'key_file' => '/etc/puppetlabs/puppet/ssl/private_keys/puppet.pem'
      }
    })
  end

  def generate_infrastructure_report
    # Query active nodes
    nodes_query = 'nodes[certname,report_timestamp,catalog_timestamp,facts_timestamp] {}'
    nodes = @client.request('', nodes_query)

    # Query fact data
    facts_query = 'facts[certname,name,value] { name in ["operatingsystem","operatingsystemrelease","processorcount","memorysize","uptime"] }'
    facts = @client.request('', facts_query)

    # Query catalog data
    catalogs_query = 'catalogs[certname,version,transaction_uuid,catalog_uuid,producer_timestamp] {}'
    catalogs = @client.request('', catalogs_query)

    # Query reports data
    reports_query = 'reports[certname,hash,start_time,end_time,status,configuration_version] { start_time > "2024-01-01" }'
    reports = @client.request('', reports_query)

    # Generate comprehensive report
    report = {
      'generated_at' => Time.now.iso8601,
      'summary' => {
        'total_nodes' => nodes.count,
        'active_nodes' => nodes.select { |n| recent_activity?(n['report_timestamp']) }.count,
        'total_reports' => reports.count,
        'successful_runs' => reports.select { |r| r['status'] == 'success' }.count
      },
      'node_details' => generate_node_details(nodes, facts, catalogs, reports),
      'compliance_status' => generate_compliance_status(nodes, reports),
      'performance_metrics' => generate_performance_metrics(reports, catalogs)
    }

    # Save report
    report_file = "/var/lib/puppet/reports/infrastructure_report_#{Time.now.strftime('%Y%m%d_%H%M%S')}.json"
    File.write(report_file, JSON.pretty_generate(report))

    puts "Infrastructure report generated: #{report_file}"
    report
  end

  def detect_configuration_drift
    # Query for failed or changed resources
    drift_query = <<~PQL
      resources[certname,type,title,file,line] {
        latest_report? = true and
        (status = "failed" or status = "changed")
      }
    PQL

    drift_resources = @client.request('', drift_query)

    # Group by node and resource type
    drift_by_node = drift_resources.group_by { |r| r['certname'] }

    drift_report = {
      'scan_time' => Time.now.iso8601,
      'total_nodes_with_drift' => drift_by_node.keys.count,
      'total_drift_resources' => drift_resources.count,
      'drift_details' => drift_by_node.map do |certname, resources|
        {
          'node' => certname,
          'drift_count' => resources.count,
          'resource_types' => resources.map { |r| r['type'] }.uniq,
          'resources' => resources
        }
      end
    }

    # Generate alerts for high-drift nodes
    high_drift_nodes = drift_by_node.select { |_, resources| resources.count > 10 }

    if high_drift_nodes.any?
      alert_high_drift_nodes(high_drift_nodes)
    end

    drift_report
  end

  def query_compliance_status(framework = 'CIS')
    # Query nodes with compliance facts
    compliance_query = <<~PQL
      facts[certname,value] {
        name = "compliance_#{framework.downcase}_score"
      }
    PQL

    compliance_facts = @client.request('', compliance_query)

    compliance_summary = {
      'framework' => framework,
      'scan_time' => Time.now.iso8601,
      'total_nodes' => compliance_facts.count,
      'average_score' => calculate_average_score(compliance_facts),
      'compliance_distribution' => calculate_compliance_distribution(compliance_facts),
      'non_compliant_nodes' => identify_non_compliant_nodes(compliance_facts)
    }

    compliance_summary
  end

  private

  def recent_activity?(timestamp)
    return false if timestamp.nil?
    Time.parse(timestamp) > (Time.now - 3600) # Active within last hour
  end

  def generate_node_details(nodes, facts, catalogs, reports)
    nodes.map do |node|
      node_facts = facts.select { |f| f['certname'] == node['certname'] }
      node_catalog = catalogs.find { |c| c['certname'] == node['certname'] }
      node_reports = reports.select { |r| r['certname'] == node['certname'] }

      {
        'certname' => node['certname'],
        'last_report' => node['report_timestamp'],
        'last_catalog' => node['catalog_timestamp'],
        'facts' => node_facts.each_with_object({}) { |f, h| h[f['name']] = f['value'] },
        'recent_reports' => node_reports.last(5),
        'catalog_version' => node_catalog&.dig('version'),
        'status' => determine_node_status(node, node_reports)
      }
    end
  end

  def generate_compliance_status(nodes, reports)
    compliant_nodes = reports
      .select { |r| r['status'] == 'success' }
      .map { |r| r['certname'] }
      .uniq

    {
      'compliant_nodes' => compliant_nodes.count,
      'total_nodes' => nodes.count,
      'compliance_percentage' => (compliant_nodes.count.to_f / nodes.count * 100).round(2)
    }
  end

  def generate_performance_metrics(reports, catalogs)
    recent_reports = reports.select do |r|
      Time.parse(r['start_time']) > (Time.now - 86400) # Last 24 hours
    end

    execution_times = recent_reports.map do |r|
      start_time = Time.parse(r['start_time'])
      end_time = Time.parse(r['end_time'])
      end_time - start_time
    end

    {
      'average_execution_time' => execution_times.sum / execution_times.count,
      'max_execution_time' => execution_times.max,
      'min_execution_time' => execution_times.min,
      'total_catalogs' => catalogs.count,
      'reports_per_day' => recent_reports.count
    }
  end

  def determine_node_status(node, reports)
    if reports.empty?
      'unreported'
    elsif reports.last['status'] == 'success'
      'compliant'
    else
      'non_compliant'
    end
  end

  def alert_high_drift_nodes(high_drift_nodes)
    high_drift_nodes.each do |certname, resources|
      puts "ALERT: High configuration drift detected on #{certname} (#{resources.count} resources)"

      # Send notification (implement based on your alerting system)
      send_alert({
        severity: 'high',
        message: "Configuration drift detected on #{certname}",
        details: {
          node: certname,
          drift_count: resources.count,
          resource_types: resources.map { |r| r['type'] }.uniq
        }
      })
    end
  end

  def calculate_average_score(compliance_facts)
    scores = compliance_facts.map { |f| f['value'].to_f }
    return 0 if scores.empty?

    scores.sum / scores.count
  end

  def calculate_compliance_distribution(compliance_facts)
    scores = compliance_facts.map { |f| f['value'].to_f }

    {
      'excellent' => scores.count { |s| s >= 90 },
      'good' => scores.count { |s| s >= 70 && s < 90 },
      'fair' => scores.count { |s| s >= 50 && s < 70 },
      'poor' => scores.count { |s| s < 50 }
    }
  end

  def identify_non_compliant_nodes(compliance_facts)
    compliance_facts
      .select { |f| f['value'].to_f < 70 }
      .map { |f| { 'certname' => f['certname'], 'score' => f['value'].to_f } }
  end

  def send_alert(alert_data)
    # Implement your alerting mechanism here
    # e.g., webhook, email, Slack, PagerDuty, etc.
    puts "ALERT: #{alert_data[:message]}"
  end
end

# Usage example
if __FILE__ == $0
  integration = PuppetDBEnterpriseIntegration.new

  puts "Generating infrastructure report..."
  integration.generate_infrastructure_report

  puts "Detecting configuration drift..."
  drift_report = integration.detect_configuration_drift
  puts "Detected drift on #{drift_report['total_nodes_with_drift']} nodes"

  puts "Checking CIS compliance..."
  compliance_report = integration.query_compliance_status('CIS')
  puts "Average CIS score: #{compliance_report['average_score']}"
end
```

## Quality Assurance and Testing

### Comprehensive Testing Framework

```ruby
# spec/spec_helper.rb - RSpec configuration for Puppet testing
require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

include RspecPuppetFacts

RSpec.configure do |c|
  c.hiera_config = 'spec/fixtures/hiera.yaml'
  c.module_path = 'spec/fixtures/modules'
  c.manifest_dir = 'spec/fixtures/manifests'

  # Coverage reporting
  c.after(:suite) do
    RSpec::Puppet::Coverage.report!(95) # Require 95% coverage
  end

  # Strict variable checking
  c.strict_variables = true

  # Custom facts for testing
  c.default_facts = {
    'operatingsystem' => 'CentOS',
    'operatingsystemrelease' => '7',
    'operatingsystemmajrelease' => '7',
    'osfamily' => 'RedHat',
    'kernel' => 'Linux',
    'architecture' => 'x86_64',
    'fqdn' => 'test.example.com',
    'hostname' => 'test',
    'domain' => 'example.com',
    'processorcount' => 2,
    'memorysize' => '4.00 GB',
    'environment' => 'test'
  }
end

# Custom matchers for enterprise testing
RSpec::Matchers.define :be_compliant_with_cis do |control|
  match do |actual|
    # Implement CIS compliance checking logic
    check_cis_compliance(actual, control)
  end

  failure_message do |actual|
    "expected #{actual} to be compliant with CIS control #{control}"
  end
end

def check_cis_compliance(resource, control)
  # Implement specific CIS control validation
  case control
  when '5.1.1'
    # Check cron daemon configuration
    resource.should contain_service('crond').with_ensure('running')
  when '5.2.1'
    # Check SSH daemon configuration
    resource.should contain_file('/etc/ssh/sshd_config').with_content(/PermitRootLogin no/)
  else
    true
  end
end
```

```puppet
# spec/classes/profiles_webserver_nginx_spec.rb - Comprehensive class testing
require 'spec_helper'

describe 'profiles::webserver::nginx' do
  let(:hiera_config) { 'spec/fixtures/hiera.yaml' }

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }

        it 'should install nginx package' do
          is_expected.to contain_package('nginx').with_ensure('installed')
        end

        it 'should start and enable nginx service' do
          is_expected.to contain_service('nginx').with(
            'ensure' => 'running',
            'enable' => true
          )
        end

        it 'should manage nginx configuration' do
          is_expected.to contain_file('/etc/nginx/nginx.conf').with(
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644'
          )
        end

        it 'should create virtual hosts directory' do
          is_expected.to contain_file('/etc/nginx/conf.d/').with(
            'ensure'  => 'directory',
            'purge'   => true,
            'recurse' => true
          )
        end
      end

      context 'with SSL enabled' do
        let(:params) { { 'ssl_enabled' => true } }

        it 'should include SSL profile' do
          is_expected.to contain_class('profiles::ssl::certificates')
        end

        it 'should create SSL configuration' do
          is_expected.to contain_file('/etc/nginx/ssl.conf')
        end
      end

      context 'with rate limiting enabled' do
        let(:params) { { 'rate_limiting' => true } }

        it 'should create rate limiting configuration' do
          is_expected.to contain_file('/etc/nginx/conf.d/rate_limiting.conf')
        end
      end

      context 'with custom virtual hosts' do
        let(:params) do
          {
            'vhosts' => {
              'example.com' => {
                'listen_port' => 80,
                'document_root' => '/var/www/example'
              }
            }
          }
        end

        it 'should create virtual host configuration' do
          is_expected.to contain_file('/etc/nginx/conf.d/example.com.conf')
        end
      end

      context 'compliance testing' do
        it 'should be compliant with CIS 2.2.16' do
          expect(catalogue).to be_compliant_with_cis('2.2.16')
        end
      end
    end
  end
end
```

## AI Assistant Guidelines

### Decision Framework for Puppet Implementation

```ruby
def should_use_puppet(requirements)
  # Strongly recommended for
  strongly_recommended = [
    requirements[:enterprise_environment],
    requirements[:compliance_requirements],
    requirements[:configuration_drift_detection],
    requirements[:declarative_configuration],
    requirements[:large_scale_infrastructure],
    requirements[:windows_linux_mixed],
    requirements[:role_based_access_control],
    requirements[:audit_trail_requirements]
  ]

  if strongly_recommended.any?
    return {
      recommended: true,
      reason: "Puppet excels in enterprise environments with strong compliance and audit requirements"
    }
  end

  # Consider alternatives if
  alternatives_needed = [
    requirements[:simple_automation_needs],
    requirements[:immediate_execution_required],
    requirements[:small_infrastructure],
    requirements[:container_based_workloads],
    requirements[:learning_curve_concerns]
  ]

  if alternatives_needed.any?
    return {
      recommended: false,
      reason: "Consider Ansible for simpler needs or container orchestration for cloud-native workloads",
      alternatives: ["Ansible", "Terraform", "Kubernetes"]
    }
  end

  # Default recommendation
  {
    recommended: true,
    reason: "Puppet provides robust configuration management suitable for most enterprise needs"
  }
end

def generate_puppet_architecture(infrastructure_requirements)
  architecture = {
    roles: [],
    profiles: [],
    modules: [],
    hiera_hierarchy: [],
    testing_strategy: {}
  }

  # Generate roles based on infrastructure
  infrastructure_requirements[:server_types].each do |server_type|
    role_name = "roles::#{server_type}"
    architecture[:roles] << {
      name: role_name,
      profiles: generate_profiles_for_role(server_type),
      description: "#{server_type.capitalize} server role with enterprise configurations"
    }
  end

  # Generate profiles
  architecture[:profiles] = generate_enterprise_profiles(infrastructure_requirements)

  # Generate module dependencies
  architecture[:modules] = identify_required_modules(infrastructure_requirements)

  # Generate Hiera hierarchy
  architecture[:hiera_hierarchy] = generate_hiera_hierarchy(infrastructure_requirements)

  # Testing strategy
  architecture[:testing_strategy] = {
    unit_tests: true,
    integration_tests: true,
    acceptance_tests: true,
    compliance_tests: infrastructure_requirements[:compliance_frameworks] || [],
    coverage_threshold: 90
  }

  architecture
end

def validate_puppet_implementation(implementation)
  validation_results = {
    valid: true,
    warnings: [],
    errors: [],
    recommendations: []
  }

  # Check roles/profiles pattern
  unless implementation[:follows_roles_profiles_pattern]
    validation_results[:errors] << "Implementation should follow roles/profiles pattern"
    validation_results[:valid] = false
  end

  # Check Hiera usage
  unless implementation[:uses_hiera_for_data]
    validation_results[:warnings] << "Consider using Hiera for data separation"
  end

  # Check testing coverage
  if implementation[:test_coverage] < 80
    validation_results[:warnings] << "Test coverage is below recommended 80%"
  end

  # Check security practices
  if implementation[:stores_secrets_in_manifests]
    validation_results[:errors] << "Secrets should not be stored in manifests - use Hiera eyaml"
    validation_results[:valid] = false
  end

  # Check module quality
  implementation[:modules].each do |mod|
    unless mod[:uses_pdk]
      validation_results[:recommendations] << "Use PDK for module #{mod[:name]} development"
    end
  end

  validation_results
end
```

### Quality Enforcement Checklist

```yaml
# puppet-quality-checklist.yaml
quality_standards:
  code_quality:
    - 'Follow roles/profiles pattern consistently'
    - 'Use PDK for module development and testing'
    - 'Implement comprehensive unit tests with >90% coverage'
    - 'Use puppet-lint for code style validation'
    - 'Implement strict type checking in manifests'

  data_management:
    - 'Store all configuration data in Hiera, not manifests'
    - 'Encrypt sensitive data using hiera-eyaml'
    - 'Implement hierarchical data lookup appropriately'
    - 'Validate Hiera data types and structures'

  security:
    - 'Never store secrets in plain text'
    - 'Use secure certificate management practices'
    - 'Implement proper file permissions and ownership'
    - 'Enable audit logging for all Puppet operations'
    - 'Regular certificate rotation and key management'

  deployment:
    - 'Use r10k or Code Manager for environment deployment'
    - 'Implement comprehensive testing pipeline'
    - 'Use branch-per-environment strategy'
    - 'Perform syntax validation before deployment'
    - 'Test catalog compilation for representative nodes'

  monitoring:
    - 'Configure PuppetDB for centralized reporting'
    - 'Implement drift detection and alerting'
    - 'Monitor catalog compilation times and failures'
    - 'Generate regular compliance reports'
    - 'Track performance metrics and trends'

  compliance:
    - 'Implement compliance profiles for required frameworks'
    - 'Regular compliance scanning and reporting'
    - 'Exception management process for non-compliant systems'
    - 'Automated remediation where appropriate'
    - 'Audit trail maintenance and retention'
```

### Enterprise Security & Compliance Automation

```puppet
# modules/enterprise_security/manifests/init.pp
# Comprehensive enterprise security hardening

class enterprise_security (
  String $compliance_framework = 'CIS',
  String $security_level = 'Level1',
  Boolean $enable_auditing = true,
  Boolean $enable_encryption = true,
  Hash $firewall_rules = {},
  Array[String] $allowed_services = [],
  Hash $user_management = {},
  String $logging_server = 'logs.enterprise.com'
) {

  # CIS Benchmark compliance
  case $compliance_framework {
    'CIS': {
      include enterprise_security::cis_hardening

      # CIS Level 1 baseline security
      file { '/etc/security/limits.conf':
        ensure  => file,
        content => template('enterprise_security/limits.conf.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
      }

      # Disable unnecessary services
      $unnecessary_services = [
        'telnet', 'rsh', 'rlogin', 'ypbind', 'tftp',
        'xinetd', 'chargen-dgram', 'chargen-stream',
        'daytime-dgram', 'daytime-stream', 'echo-dgram',
        'echo-stream', 'tcpmux-server'
      ]

      service { $unnecessary_services:
        ensure => stopped,
        enable => false,
      }

      # Secure kernel parameters
      sysctl { 'net.ipv4.ip_forward':
        value => '0',
      }

      sysctl { 'net.ipv4.conf.all.send_redirects':
        value => '0',
      }

      sysctl { 'net.ipv4.conf.default.send_redirects':
        value => '0',
      }

      sysctl { 'net.ipv4.conf.all.accept_source_route':
        value => '0',
      }
    }

    'SOC2': {
      include enterprise_security::soc2_controls

      # SOC2 Type II controls implementation
      file { '/etc/security/soc2-policy.conf':
        ensure  => file,
        content => template('enterprise_security/soc2_policy.conf.erb'),
        owner   => 'root',
        group   => 'root',
        mode    => '0600',
      }

      # Audit logging configuration for SOC2
      class { 'auditd':
        rules => [
          '-w /etc/passwd -p wa -k identity',
          '-w /etc/group -p wa -k identity',
          '-w /etc/shadow -p wa -k identity',
          '-w /etc/sudoers -p wa -k privilege-escalation',
          '-w /var/log/auth.log -p wa -k authentication',
          '-w /etc/ssh/sshd_config -p wa -k ssh-config',
        ],
        buffer_size => 8192,
        failure_mode => 1,
        max_log_file => 100,
        num_logs => 10,
      }
    }

    'PCI-DSS': {
      include enterprise_security::pci_dss_controls

      # PCI-DSS compliance requirements
      file { '/etc/security/pci-dss.conf':
        ensure  => file,
        content => template('enterprise_security/pci_dss.conf.erb'),
        owner   => 'root',
        group   => 'pci',
        mode    => '0640',
      }

      # Strong authentication requirements
      pam { 'password requisite pam_pwquality.so':
        ensure    => present,
        service   => 'common-password',
        type      => 'password',
        control   => 'requisite',
        module    => 'pam_pwquality.so',
        arguments => [
          'minlen=12',
          'minclass=4',
          'maxrepeat=2',
          'maxclassrepeat=2',
          'reject_username',
          'difok=4'
        ],
      }
    }

    'HIPAA': {
      include enterprise_security::hipaa_controls

      # HIPAA Security Rule implementation
      file { '/etc/security/hipaa-security.conf':
        ensure  => file,
        content => template('enterprise_security/hipaa_security.conf.erb'),
        owner   => 'root',
        group   => 'hipaa',
        mode    => '0600',
      }

      # Encryption at rest for PHI
      class { 'luks':
        devices => {
          '/dev/sdb1' => {
            ensure     => 'present',
            passphrase => hiera('hipaa::encryption_key', undef, 'secret'),
            mount      => '/mnt/phi-data',
            filesystem => 'ext4',
          }
        }
      }
    }
  }

  # Enterprise firewall management
  create_resources('firewall', $firewall_rules)

  # Centralized logging
  class { 'rsyslog::client':
    log_remote     => true,
    remote_servers => [$logging_server],
    port           => '514',
    protocol       => 'tcp',
  }

  # File integrity monitoring
  class { 'aide':
    aide_path      => '/usr/sbin/aide',
    aide_db_path   => '/var/lib/aide/aide.db',
    aide_db_temp_path => '/var/lib/aide/aide.db.new',
    aide_conf_path => '/etc/aide.conf',

    rules => {
      'binaries'     => 'p+i+n+u+g+s+b+m+c+md5+sha1',
      'config_files' => 'p+i+n+u+g+s+b+m+c+md5+sha1',
      'log_files'    => 'n+u+g+s',
    },

    watches => [
      '/bin',
      '/sbin',
      '/usr/bin',
      '/usr/sbin',
      '/etc',
      '/boot',
    ],
  }

  # Advanced threat detection
  package { ['rkhunter', 'chkrootkit', 'clamav', 'clamav-daemon']:
    ensure => present,
  }

  cron { 'security_scan':
    command => '/usr/local/bin/security-scan.sh > /var/log/security-scan.log 2>&1',
    user    => 'root',
    hour    => '2',
    minute  => '0',
  }

  file { '/usr/local/bin/security-scan.sh':
    ensure  => file,
    content => template('enterprise_security/security_scan.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
}
```

### Enterprise Monitoring & Observability Integration

```puppet
# modules/enterprise_monitoring/manifests/init.pp
# Comprehensive monitoring and observability platform

class enterprise_monitoring (
  String $prometheus_server = 'prometheus.enterprise.com',
  String $grafana_server = 'grafana.enterprise.com',
  String $jaeger_server = 'jaeger.enterprise.com',
  String $elasticsearch_server = 'elasticsearch.enterprise.com',
  Hash $monitoring_config = {},
  Array[String] $custom_metrics = [],
  Boolean $enable_apm = true,
  String $environment = 'production'
) {

  # Prometheus Node Exporter
  class { 'prometheus::node_exporter':
    version            => '1.6.1',
    install_method     => 'url',
    manage_user        => true,
    manage_group       => true,
    purge_config_dir   => true,
    restart_on_change  => true,
    init_style         => 'systemd',
    service_enable     => true,
    service_ensure     => 'running',

    collectors_enable  => [
      'boottime',
      'cpu',
      'diskstats',
      'filesystem',
      'loadavg',
      'meminfo',
      'netdev',
      'stat',
      'time',
      'systemd',
    ],

    collectors_disable => [
      'arp',
      'bcache',
      'conntrack',
      'entropy',
      'edac',
      'hwmon',
      'infiniband',
      'ipvs',
      'mdadm',
      'netclass',
      'netstat',
      'sockstat',
      'textfile',
      'vmstat',
      'wifi',
      'xfs',
      'zfs',
    ],

    web_listen_address => '0.0.0.0:9100',
    web_telemetry_path => '/metrics',
  }

  # Filebeat for log shipping
  class { 'filebeat':
    major_version => '8',
    config        => {
      'filebeat' => {
        'inputs' => [
          {
            'type'    => 'log',
            'enabled' => true,
            'paths'   => [
              '/var/log/*.log',
              '/var/log/**/*.log',
              '/var/log/puppet/*.log',
            ],
            'fields' => {
              'environment' => $environment,
              'service'     => 'puppet-managed',
              'datacenter'  => $facts['datacenter'],
            },
            'fields_under_root' => true,
          },
          {
            'type'    => 'systemd',
            'enabled' => true,
          }
        ],
      },
      'processors' => [
        {
          'add_host_metadata' => {
            'when.not.contains.tags' => 'forwarded',
          }
        },
        {
          'add_docker_metadata' => undef,
        }
      ],
      'output' => {
        'elasticsearch' => {
          'hosts'    => ["${elasticsearch_server}:9200"],
          'username' => hiera('monitoring::elasticsearch::username'),
          'password' => hiera('monitoring::elasticsearch::password', undef, 'secret'),
          'index'    => "puppet-logs-${environment}-%{+yyyy.MM.dd}",
        }
      },
      'setup' => {
        'template' => {
          'name'     => "puppet-logs-${environment}",
          'pattern'  => "puppet-logs-${environment}-*",
          'settings' => {
            'index.number_of_shards'   => 1,
            'index.number_of_replicas' => 1,
          }
        },
        'kibana' => {
          'host' => "http://kibana.enterprise.com:5601",
        }
      }
    }
  }

  # Puppet-specific monitoring with PuppetDB queries
  file { '/usr/local/bin/puppet-metrics-collector.py':
    ensure  => file,
    content => template('enterprise_monitoring/puppet_metrics.py.erb'),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0755',
  }

  cron { 'puppet_metrics_collection':
    command => '/usr/local/bin/puppet-metrics-collector.py',
    user    => 'puppet',
    minute  => '*/5',
  }

  # Application Performance Monitoring
  if $enable_apm {
    package { 'elastic-apm-agent':
      ensure => present,
    }

    file { '/etc/elastic-apm-agent/apm-agent.conf':
      ensure  => file,
      content => template('enterprise_monitoring/apm_agent.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['elastic-apm-agent'],
      notify  => Service['elastic-apm-agent'],
    }

    service { 'elastic-apm-agent':
      ensure  => running,
      enable  => true,
      require => [Package['elastic-apm-agent'], File['/etc/elastic-apm-agent/apm-agent.conf']],
    }
  }

  # Custom metrics collection
  $custom_metrics.each |String $metric| {
    file { "/usr/local/bin/collect-${metric}.sh":
      ensure  => file,
      content => template("enterprise_monitoring/${metric}_collector.sh.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
    }

    cron { "collect_${metric}":
      command => "/usr/local/bin/collect-${metric}.sh",
      user    => 'root',
      minute  => '*/2',
    }
  }

  # Health check endpoints
  file { '/usr/local/bin/health-check.rb':
    ensure  => file,
    content => template('enterprise_monitoring/health_check.rb.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  service { 'puppet-health-check':
    ensure    => running,
    enable    => true,
    subscribe => File['/usr/local/bin/health-check.rb'],
  }
}
```

### Enterprise CI/CD & GitOps Integration

```puppet
# modules/enterprise_cicd/manifests/init.pp
# Comprehensive CI/CD pipeline integration

class enterprise_cicd (
  String $git_server = 'gitlab.enterprise.com',
  String $jenkins_server = 'jenkins.enterprise.com',
  String $artifact_registry = 'nexus.enterprise.com',
  Hash $pipeline_config = {},
  Array[String] $deployment_environments = ['development', 'staging', 'production'],
  Boolean $enable_automated_testing = true,
  String $puppet_environment_path = '/etc/puppetlabs/code/environments'
) {

  # Git repository management with r10k
  class { 'r10k':
    version                => '3.15.4',
    sources                => {
      'puppet' => {
        'remote'  => "https://${git_server}/infrastructure/puppet-control.git",
        'basedir' => $puppet_environment_path,
        'prefix'  => false,
      }
    },
    manage_modulepath      => false,
    manage_ruby_dependency => 'include',
    mcollective            => true,
    manage_configfile_symlink => false,
    configfile             => '/etc/puppetlabs/r10k/r10k.yaml',
    cachedir               => '/opt/puppetlabs/puppet/cache/r10k',
  }

  # Automated testing framework
  if $enable_automated_testing {
    package { ['puppet-lint', 'metadata-json-lint', 'rspec-puppet', 'beaker']:
      ensure   => present,
      provider => 'puppet_gem',
    }

    file { '/usr/local/bin/puppet-test-suite.sh':
      ensure  => file,
      content => template('enterprise_cicd/test_suite.sh.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0755',
    }

    # Pre-commit hooks for quality gates
    file { "${puppet_environment_path}/.git/hooks/pre-commit":
      ensure  => file,
      content => template('enterprise_cicd/pre_commit_hook.sh.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0755',
    }
  }

  # Jenkins agent configuration
  class { 'jenkins::slave':
    masterurl        => "http://${jenkins_server}:8080",
    ui_user          => hiera('jenkins::ui_user'),
    ui_pass          => hiera('jenkins::ui_pass', undef, 'secret'),
    executors        => 4,
    manage_slave_user => true,
    slave_user        => 'jenkins',
    slave_home        => '/home/jenkins',

    labels => [
      'puppet',
      'infrastructure',
      $facts['os']['name'].downcase(),
      $facts['os']['release']['major'],
    ],

    slave_mode => 'exclusive',
  }

  # Deployment automation
  $deployment_environments.each |String $env| {
    file { "/usr/local/bin/deploy-puppet-${env}.sh":
      ensure  => file,
      content => template('enterprise_cicd/deploy_environment.sh.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0755',
    }

    # Environment-specific validation
    file { "/usr/local/bin/validate-puppet-${env}.sh":
      ensure  => file,
      content => template('enterprise_cicd/validate_environment.sh.erb'),
      owner   => 'puppet',
      group   => 'puppet',
      mode    => '0755',
    }
  }

  # Artifact management
  file { '/etc/puppetlabs/puppet/artifact-sync.conf':
    ensure  => file,
    content => template('enterprise_cicd/artifact_sync.conf.erb'),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0644',
  }

  cron { 'sync_puppet_artifacts':
    command => '/usr/local/bin/sync-puppet-artifacts.sh',
    user    => 'puppet',
    hour    => '*/2',
    minute  => '0',
  }

  # Webhook handlers for GitOps
  file { '/usr/local/bin/puppet-webhook-handler.rb':
    ensure  => file,
    content => template('enterprise_cicd/webhook_handler.rb.erb'),
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0755',
  }

  service { 'puppet-webhook-handler':
    ensure    => running,
    enable    => true,
    subscribe => File['/usr/local/bin/puppet-webhook-handler.rb'],
  }
}
```

This comprehensive Level 3 Puppet implementation provides enterprise-grade configuration management with advanced compliance frameworks, monitoring integration, testing automation, and production deployment patterns suitable for large-scale enterprise environments.

```

```
