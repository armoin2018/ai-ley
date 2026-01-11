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