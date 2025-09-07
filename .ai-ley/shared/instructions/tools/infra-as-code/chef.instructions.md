---
agentMode: general
applyTo: general
author: AI-LEY
description: Awaiting summary.
extensions:
  - .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:47.955998'
summaryScore: 3.0
title: Chef.Instructions
version: 1.0.0
---

# Chef — Enterprise Infrastructure as Code at Scale

## Enterprise Overview

Chef provides comprehensive infrastructure automation through Ruby-based cookbooks, recipes, and policies. This enterprise-grade configuration management system supports policy-as-code, idempotent configuration management, compliance automation, and multi-platform deployment strategies. Chef's ecosystem includes Chef Infra Client/Server for centralized management, Chef Solo/Workstation for standalone operations, Chef InSpec for security compliance testing, and Test Kitchen for comprehensive integration testing.

Enterprise implementations leverage Chef's scalable architecture for managing thousands of nodes across hybrid cloud environments, with advanced features including automated compliance reporting, drift detection, role-based access controls, and sophisticated CI/CD pipeline integration for infrastructure as code workflows.

## Core Enterprise Architecture

### Chef Server Enterprise Configuration

```ruby
#!/usr/bin/env ruby
# chef-enterprise-server.rb - Enterprise Chef Server configuration

require 'chef'
require 'chef/config'
require 'chef/log'
require 'json'
require 'yaml'

class ChefEnterpriseServer
  def initialize(config_file = '/etc/chef/chef-server.rb')
    @config_file = config_file
    @base_config = load_enterprise_config
    setup_logging
  end

  def configure_enterprise_server
    Chef::Log.info("Configuring Chef Server for enterprise deployment")

    # High availability configuration
    configure_ha_cluster

    # Performance optimization
    configure_performance_settings

    # Security hardening
    configure_security_settings

    # Backup and disaster recovery
    configure_backup_settings

    # Monitoring and alerting
    configure_monitoring_settings

    # Compliance and audit logging
    configure_audit_settings

    write_configuration
    Chef::Log.info("Enterprise Chef Server configuration completed")
  end

  private

  def load_enterprise_config
    {
      # HA Cluster Configuration
      topology: 'ha',
      ha: {
        provider: 'aws',
        aws_mode: 'ebs_shared',
        eip: ENV['CHEF_SERVER_EIP'],
        vip: ENV['CHEF_SERVER_VIP']
      },

      # Performance Settings
      nginx: {
        enable_non_ssl: false,
        ssl_protocols: 'TLSv1.2 TLSv1.3',
        ssl_ciphers: 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256',
        client_max_body_size: '250m',
        keepalive_timeout: 65,
        gzip: 'on',
        gzip_comp_level: 2,
        gzip_types: [
          'text/plain',
          'text/css',
          'application/json',
          'application/javascript',
          'text/xml',
          'application/xml',
          'application/xml+rss',
          'text/javascript'
        ]
      },

      # Erchef (Chef Server API) Configuration
      erchef: {
        nginx_bookshelf_caching: ':off',
        s3_url_expiry_window_size: 100,
        s3_parallel_ops_timeout: 5000,
        s3_parallel_ops_fanout: 20,
        db_pool_size: 20,
        db_pool_queue_max: 40,
        db_pooler_timeout: 10000,
        udp_socket_pool_size: 30,
        authz_pooler_timeout: 10000,
        depsolver_timeout: 120000,
        depsolver_worker_count: 4
      },

      # PostgreSQL Configuration
      postgresql: {
        enable: true,
        data_dir: '/var/opt/opscode/postgresql/data',
        checkpoint_segments: 32,
        checkpoint_completion_target: 0.9,
        wal_buffers: '16MB',
        shared_buffers: '1GB',
        work_mem: '64MB',
        effective_cache_size: '4GB',
        log_rotation: {
          file_maxbytes: '104857600',
          num_to_keep: 10
        }
      },

      # Elasticsearch Configuration (for Analytics)
      opscode_elasticsearch: {
        enable: true,
        heap_size: '2g',
        new_size: '256m',
        java_opts: '-server -Xss256k -XX:+UseCompressedOops'
      },

      # Bookshelf (Cookbook Storage)
      bookshelf: {
        enable: true,
        vip_port: 4321,
        storage_type: 's3',
        s3_bucket: ENV['CHEF_S3_BUCKET'],
        s3_encrypt_new_files: true,
        s3_region: ENV['AWS_REGION']
      },

      # Security Configuration
      security: {
        ssl_verify_mode: ':verify_peer',
        ssl_ca_file: '/etc/chef/trusted_certs/ca.crt',
        ssl_client_cert: '/etc/chef/client.pem',
        ssl_client_key: '/etc/chef/client.key'
      },

      # Audit and Compliance
      audit: {
        enable: true,
        log_location: '/var/log/opscode/audit.log',
        log_level: 'info',
        log_rotation: {
          file_maxbytes: '104857600',
          num_to_keep: 30
        }
      }
    }
  end

  def configure_ha_cluster
    ha_config = @base_config[:ha]

    Chef::Log.info("Configuring HA cluster with provider: #{ha_config[:provider]}")

    config_content = <<~CONFIG
      topology "#{@base_config[:topology]}"

      # HA Configuration
      ha['provider'] = "#{ha_config[:provider]}"
      ha['aws_mode'] = "#{ha_config[:aws_mode]}"

      # VIP Configuration
      server "#{Socket.gethostname}",
        :ipaddress => "#{get_server_ip}",
        :role => "backend",
        :bootstrap => true

      # Backend VIP
      backend_vip "#{ha_config[:vip]}",
        :ipaddress => "#{ha_config[:vip]}",
        :device => "eth0"
    CONFIG

    write_config_section('ha', config_content)
  end

  def configure_performance_settings
    nginx_config = @base_config[:nginx]
    erchef_config = @base_config[:erchef]
    postgresql_config = @base_config[:postgresql]

    config_content = <<~CONFIG
      # Nginx Performance Settings
      nginx['enable_non_ssl'] = #{nginx_config[:enable_non_ssl]}
      nginx['ssl_protocols'] = "#{nginx_config[:ssl_protocols]}"
      nginx['ssl_ciphers'] = "#{nginx_config[:ssl_ciphers]}"
      nginx['client_max_body_size'] = "#{nginx_config[:client_max_body_size]}"
      nginx['keepalive_timeout'] = #{nginx_config[:keepalive_timeout]}
      nginx['gzip'] = "#{nginx_config[:gzip]}"
      nginx['gzip_comp_level'] = #{nginx_config[:gzip_comp_level]}
      nginx['gzip_types'] = #{nginx_config[:gzip_types].to_s.gsub("'", '"')}

      # Erchef Performance Settings
      erchef['nginx_bookshelf_caching'] = #{erchef_config[:nginx_bookshelf_caching]}
      erchef['s3_url_expiry_window_size'] = #{erchef_config[:s3_url_expiry_window_size]}
      erchef['s3_parallel_ops_timeout'] = #{erchef_config[:s3_parallel_ops_timeout]}
      erchef['s3_parallel_ops_fanout'] = #{erchef_config[:s3_parallel_ops_fanout]}
      erchef['db_pool_size'] = #{erchef_config[:db_pool_size]}
      erchef['db_pool_queue_max'] = #{erchef_config[:db_pool_queue_max]}
      erchef['db_pooler_timeout'] = #{erchef_config[:db_pooler_timeout]}
      erchef['udp_socket_pool_size'] = #{erchef_config[:udp_socket_pool_size]}
      erchef['authz_pooler_timeout'] = #{erchef_config[:authz_pooler_timeout]}
      erchef['depsolver_timeout'] = #{erchef_config[:depsolver_timeout]}
      erchef['depsolver_worker_count'] = #{erchef_config[:depsolver_worker_count]}

      # PostgreSQL Performance Settings
      postgresql['checkpoint_segments'] = #{postgresql_config[:checkpoint_segments]}
      postgresql['checkpoint_completion_target'] = #{postgresql_config[:checkpoint_completion_target]}
      postgresql['wal_buffers'] = "#{postgresql_config[:wal_buffers]}"
      postgresql['shared_buffers'] = "#{postgresql_config[:shared_buffers]}"
      postgresql['work_mem'] = "#{postgresql_config[:work_mem]}"
      postgresql['effective_cache_size'] = "#{postgresql_config[:effective_cache_size]}"
    CONFIG

    write_config_section('performance', config_content)
  end

  def configure_security_settings
    security_config = @base_config[:security]

    config_content = <<~CONFIG
      # SSL/TLS Security Configuration
      nginx['ssl_verify_mode'] = #{security_config[:ssl_verify_mode]}
      nginx['ssl_verify_depth'] = 2
      nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"
      nginx['ssl_prefer_server_ciphers'] = "on"
      nginx['ssl_session_cache'] = "shared:SSL:4m"
      nginx['ssl_session_timeout'] = "10m"

      # HSTS Security Headers
      nginx['custom_config'] = "add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload';"

      # Certificate Configuration
      nginx['ssl_certificate'] = "#{security_config[:ssl_ca_file]}"
      nginx['ssl_certificate_key'] = "#{security_config[:ssl_client_key]}"

      # API Security
      erchef['strict_search_result_acls'] = true
      erchef['validation_client_name'] = 'chef-validator'
    CONFIG

    write_config_section('security', config_content)
  end

  def configure_backup_settings
    config_content = <<~CONFIG
      # Backup Configuration
      backup['enable'] = true
      backup['location'] = '/var/opt/opscode/backups'
      backup['strategy'] = 'export'
      backup['export_dir'] = '/var/opt/opscode/backups/export'

      # S3 Backup Configuration
      backup['s3_bucket'] = "#{ENV['CHEF_BACKUP_S3_BUCKET']}"
      backup['s3_region'] = "#{ENV['AWS_REGION']}"
      backup['s3_encrypt'] = true

      # Retention Policy
      backup['retention'] = {
        'daily' => 7,
        'weekly' => 4,
        'monthly' => 12
      }
    CONFIG

    write_config_section('backup', config_content)
  end

  def configure_monitoring_settings
    config_content = <<~CONFIG
      # Monitoring and Metrics Configuration
      rabbitmq['management_enabled'] = true
      rabbitmq['management_port'] = 15672

      # Data Collection
      data_collector['enable'] = true
      data_collector['server'] = "#{ENV['CHEF_AUTOMATE_SERVER']}"
      data_collector['token'] = "#{ENV['CHEF_AUTOMATE_TOKEN']}"

      # Compliance Reporting
      profiles['root_url'] = "#{ENV['CHEF_AUTOMATE_SERVER']}"

      # Log Management
      logging['chef_log_level'] = 'info'
      logging['root_log_level'] = 'info'
      logging['svlogd_size'] = 1000000
      logging['svlogd_num'] = 10
    CONFIG

    write_config_section('monitoring', config_content)
  end

  def configure_audit_settings
    audit_config = @base_config[:audit]

    config_content = <<~CONFIG
      # Audit Logging Configuration
      audit_log['enable'] = #{audit_config[:enable]}
      audit_log['location'] = "#{audit_config[:log_location]}"
      audit_log['level'] = "#{audit_config[:log_level]}"
      audit_log['file_maxbytes'] = #{audit_config[:log_rotation][:file_maxbytes]}
      audit_log['num_to_keep'] = #{audit_config[:log_rotation][:num_to_keep]}

      # Audit Events
      audit_log['events'] = [
        'user_create',
        'user_update',
        'user_delete',
        'node_create',
        'node_update',
        'node_delete',
        'cookbook_upload',
        'cookbook_delete',
        'role_create',
        'role_update',
        'role_delete',
        'environment_create',
        'environment_update',
        'environment_delete'
      ]
    CONFIG

    write_config_section('audit', config_content)
  end

  def write_configuration
    File.open(@config_file, 'w') do |f|
      f.write("# Chef Server Enterprise Configuration\n")
      f.write("# Generated by Chef Enterprise Server Configuration Tool\n")
      f.write("# #{Time.now}\n\n")

      @config_sections&.each do |section, content|
        f.write("# #{section.capitalize} Configuration\n")
        f.write(content)
        f.write("\n")
      end
    end

    Chef::Log.info("Configuration written to #{@config_file}")
  end

  def write_config_section(section, content)
    @config_sections ||= {}
    @config_sections[section] = content
  end

  def get_server_ip
    Socket.ip_address_list.detect(&:ipv4_private?).ip_address
  end

  def setup_logging
    Chef::Config[:log_level] = :info
    Chef::Config[:log_location] = '/var/log/chef/chef-server-config.log'
  end
end

# Enterprise cookbook structure generator
class ChefEnterpriseGenerator
  def self.generate_enterprise_cookbook(name, options = {})
    cookbook_path = File.join(options[:path] || '.', name)

    # Create directory structure
    directories = %w[
      attributes
      definitions
      files/default
      libraries
      providers
      recipes
      resources
      templates/default
      spec/unit/recipes
      test/integration/default
      .delivery
      policyfiles
    ]

    directories.each do |dir|
      FileUtils.mkdir_p(File.join(cookbook_path, dir))
    end

    # Generate metadata.rb
    generate_metadata(cookbook_path, name, options)

    # Generate Berksfile and Policyfile
    generate_berksfile(cookbook_path)
    generate_policyfile(cookbook_path, name)

    # Generate default recipe
    generate_default_recipe(cookbook_path, name)

    # Generate spec and integration tests
    generate_spec_helper(cookbook_path)
    generate_integration_tests(cookbook_path, name)

    # Generate Delivery configuration
    generate_delivery_config(cookbook_path)

    puts "Generated enterprise cookbook: #{name} at #{cookbook_path}"
  end

  private

  def self.generate_metadata(cookbook_path, name, options)
    metadata_content = <<~METADATA
      name             '#{name}'
      maintainer       '#{options[:maintainer] || 'Enterprise Team'}'
      maintainer_email '#{options[:email] || 'infrastructure@example.com'}'
      license          '#{options[:license] || 'All Rights Reserved'}'
      description      'Enterprise #{name} cookbook with compliance and security controls'
      long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
      version          '#{options[:version] || '1.0.0'}'
      chef_version     '>= 16.0' if respond_to?(:chef_version)

      # Platform support
      supports 'ubuntu', '>= 18.04'
      supports 'centos', '>= 7.0'
      supports 'redhat', '>= 7.0'
      supports 'amazon', '>= 2.0'

      # Dependencies
      depends 'audit', '~> 9.0'
      depends 'firewall', '~> 2.7'
      depends 'logrotate', '~> 2.2'
      depends 'ntp', '~> 3.7'

      # Issues and source URLs
      issues_url 'https://github.com/example/#{name}/issues' if respond_to?(:issues_url)
      source_url 'https://github.com/example/#{name}' if respond_to?(:source_url)

      # Cookbook attributes
      attribute '#{name}/config',
                :display_name => '#{name.capitalize} Configuration',
                :description => 'Configuration hash for #{name}',
                :type => 'hash',
                :default => {}

      attribute '#{name}/security_enabled',
                :display_name => 'Security Controls Enabled',
                :description => 'Enable security hardening controls',
                :type => 'string',
                :default => 'true'
    METADATA

    File.write(File.join(cookbook_path, 'metadata.rb'), metadata_content)
  end

  def self.generate_berksfile(cookbook_path)
    berksfile_content = <<~BERKSFILE
      source 'https://supermarket.chef.io'

      metadata

      # Community cookbooks
      cookbook 'audit', '~> 9.0'
      cookbook 'firewall', '~> 2.7'
      cookbook 'logrotate', '~> 2.2'
      cookbook 'ntp', '~> 3.7'

      # Testing dependencies
      group :integration do
        cookbook 'test-helper', path: 'test/fixtures/cookbooks/test-helper'
      end
    BERKSFILE

    File.write(File.join(cookbook_path, 'Berksfile'), berksfile_content)
  end

  def self.generate_policyfile(cookbook_path, name)
    policyfile_content = <<~POLICYFILE
      # #{name} Policyfile.rb - Enterprise policy configuration

      name '#{name}'

      # Version constraints
      default_source :supermarket

      # Cookbook sources
      cookbook '#{name}', path: '.'
      cookbook 'audit', '~> 9.0'
      cookbook 'firewall', '~> 2.7'
      cookbook 'logrotate', '~> 2.2'
      cookbook 'ntp', '~> 3.7'

      # Run list
      run_list '#{name}::default'

      # Environment-specific policies
      named_run_list :production, '#{name}::production', 'audit::default'
      named_run_list :staging, '#{name}::staging', 'audit::default'
      named_run_list :development, '#{name}::development'

      # Default attributes
      default['#{name}']['config'] = {
        'environment' => 'production',
        'security_enabled' => true,
        'monitoring_enabled' => true,
        'compliance_profiles' => ['cis-level-1', 'company-baseline']
      }

      # Override attributes for production
      default['audit']['profiles'] = [
        {
          'name' => 'cis-centos7-level1',
          'compliance' => 'admin/cis-centos7-level1'
        },
        {
          'name' => 'company-baseline',
          'path' => '/var/chef/compliance/company-baseline'
        }
      ]

      # Security settings
      default['firewall']['allow_ssh'] = true
      default['ntp']['servers'] = ['time.example.com', 'time2.example.com']

      # Logging configuration
      default['rsyslog']['server_ip'] = '10.0.1.50'
      default['rsyslog']['port'] = 514
      default['rsyslog']['protocol'] = 'udp'
    POLICYFILE

    File.write(File.join(cookbook_path, 'Policyfile.rb'), policyfile_content)
  end

  def self.generate_default_recipe(cookbook_path, name)
    recipe_content = <<~RECIPE
      #
      # Cookbook:: #{name}
      # Recipe:: default
      #
      # Copyright:: #{Time.now.year}, Example Organization, All Rights Reserved.
      #

      # Include security baseline
      include_recipe '#{name}::security_baseline' if node['#{name}']['security_enabled']

      # Include monitoring setup
      include_recipe '#{name}::monitoring' if node['#{name}']['monitoring_enabled']

      # Main application configuration
      template "/etc/#{name}/#{name}.conf" do
        source '#{name}.conf.erb'
        owner 'root'
        group 'root'
        mode '0644'
        variables(
          config: node['#{name}']['config'],
          environment: node.environment
        )
        notifies :restart, "service[#{name}]", :delayed
      end

      # Service management
      service '#{name}' do
        action [:enable, :start]
        supports restart: true, reload: true, status: true
      end

      # Log rotation
      logrotate_app '#{name}' do
        cookbook 'logrotate'
        path "/var/log/#{name}/*.log"
        frequency 'daily'
        rotate 30
        compress true
        delaycompress true
        missingok true
        notifempty true
        create "0644 #{name} #{name}"
        postrotate "systemctl reload #{name} > /dev/null 2>&1 || true"
      end

      # Firewall configuration
      if node['#{name}']['firewall_enabled']
        firewall_rule "#{name}-http" do
          port 80
          protocol :tcp
          action :allow
        end

        firewall_rule "#{name}-https" do
          port 443
          protocol :tcp
          action :allow
        end
      end

      # Compliance validation
      if node['#{name}']['compliance_enabled']
        ruby_block 'validate-#{name}-compliance' do
          block do
            Chef::Log.info("Running compliance validation for #{name}")
            # Add compliance validation logic here
          end
          action :run
        end
      end

      # Health check script
      template "/usr/local/bin/#{name}-healthcheck" do
        source 'healthcheck.sh.erb'
        owner 'root'
        group 'root'
        mode '0755'
        variables(
          service_name: '#{name}',
          config: node['#{name}']['config']
        )
      end

      # Cron job for health monitoring
      cron '#{name}-health-check' do
        minute '*/5'
        command "/usr/local/bin/#{name}-healthcheck"
        user 'root'
        mailto node['#{name}']['alert_email'] if node['#{name}']['alert_email']
      end
    RECIPE

    File.write(File.join(cookbook_path, 'recipes', 'default.rb'), recipe_content)
  end

  def self.generate_spec_helper(cookbook_path)
    spec_content = <<~SPEC
      require 'chefspec'
      require 'chefspec/berkshelf'
      require 'chefspec/cacher'

      RSpec.configure do |config|
        config.color = true
        config.formatter = :documentation
        config.log_level = :error
      end

      # ChefSpec configuration
      ChefSpec.configure do |config|
        config.platform = 'ubuntu'
        config.version = '18.04'
        config.log_level = :error
      end

      # Shared context for all specs
      shared_context 'cookbook testing' do
        let(:chef_run) do
          ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '18.04') do |node|
            node.automatic['fqdn'] = 'test.example.com'
            node.automatic['hostname'] = 'test'
            node.automatic['platform'] = 'ubuntu'
            node.automatic['platform_version'] = '18.04'
            node.automatic['kernel']['name'] = 'Linux'
          end
        end
      end

      # Custom matchers
      def stub_command_and_return(command, return_value)
        stub_command(command).and_return(return_value)
      end

      # Helper methods
      def stub_commands
        stub_command_and_return('which git', '/usr/bin/git')
        stub_command_and_return('systemctl is-active example', 'active')
      end
    SPEC

    File.write(File.join(cookbook_path, 'spec', 'spec_helper.rb'), spec_content)
  end

  def self.generate_integration_tests(cookbook_path, name)
    test_content = <<~TEST
      # Integration tests for #{name} cookbook

      describe package('#{name}') do
        it { should be_installed }
      end

      describe service('#{name}') do
        it { should be_enabled }
        it { should be_running }
      end

      describe file("/etc/#{name}/#{name}.conf") do
        it { should exist }
        it { should be_file }
        it { should be_mode 644 }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
      end

      describe port(80) do
        it { should be_listening }
      end

      describe port(443) do
        it { should be_listening }
      end

      # Security tests
      describe file('/etc/shadow') do
        it { should be_mode 640 }
      end

      describe command('ps aux | grep #{name}') do
        its('stdout') { should match /#{name}/ }
      end

      # Log file tests
      describe file("/var/log/#{name}/#{name}.log") do
        it { should exist }
        it { should be_file }
      end

      # Health check script tests
      describe file("/usr/local/bin/#{name}-healthcheck") do
        it { should exist }
        it { should be_file }
        it { should be_mode 755 }
        it { should be_executable }
      end

      describe command("/usr/local/bin/#{name}-healthcheck") do
        its('exit_status') { should eq 0 }
      end
    TEST

    File.write(File.join(cookbook_path, 'test', 'integration', 'default', 'default_test.rb'), test_content)
  end

  def self.generate_delivery_config(cookbook_path)
    delivery_content = <<~DELIVERY
      version "2"
      build_cookbook "build-cookbook"

      # Pipeline phases
      phases = ["unit", "lint", "syntax", "provision", "deploy", "smoke", "functional", "cleanup"]

      # Delivery configuration
      delivery_truck do
        unit_test_command "chef exec rspec"
        lint_command "chef exec foodcritic ."
        syntax_command "chef exec knife cookbook test ."

        # Integration testing
        provision_command "chef exec kitchen create all"
        deploy_command "chef exec kitchen converge all"
        smoke_command "chef exec kitchen verify all"
        functional_command "chef exec kitchen verify all --test-base-path=test/integration"
        cleanup_command "chef exec kitchen destroy all"

        # Publish to Chef Server
        publish_command "chef exec berks upload"
      end

      # Environment-specific delivery
      environments = ["development", "staging", "production"]

      environments.each do |env|
        phase env do
          command "chef exec knife environment from file environments/#{env}.json"
          command "chef exec knife role from file roles/*.json" if File.exist?("roles")
          command "chef exec berks upload --no-freeze"
        end
      end
    DELIVERY

    FileUtils.mkdir_p(File.join(cookbook_path, '.delivery'))
    File.write(File.join(cookbook_path, '.delivery', 'config.json'), delivery_content)
  end
end

# Usage examples
if __FILE__ == $0
  # Configure enterprise Chef Server
  server = ChefEnterpriseServer.new
  server.configure_enterprise_server

  # Generate enterprise cookbook
  ChefEnterpriseGenerator.generate_enterprise_cookbook(
    'webapp',
    maintainer: 'DevOps Team',
    email: 'devops@example.com',
    version: '2.0.0'
  )
end
```

## Enterprise Policyfiles and Dependency Management

### Advanced Policyfile Configuration

```ruby
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
```

### Enterprise Berkshelf Configuration

```ruby
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
```

## Custom Resources and Libraries

### Enterprise Custom Resources

```ruby
# resources/enterprise_service.rb - Custom resource for enterprise service management
provides :enterprise_service
unified_mode true

description 'Manages enterprise services with monitoring, logging, and compliance'

property :service_name, String, name_property: true,
         description: 'Name of the service to manage'

property :package_name, String,
         description: 'Package name if different from service name'

property :config_template, String, default: lazy { "#{service_name}.conf.erb" },
         description: 'Template file for service configuration'

property :config_path, String, default: lazy { "/etc/#{service_name}/#{service_name}.conf" },
         description: 'Path to service configuration file'

property :user, String, default: lazy { service_name },
         description: 'User to run the service as'

property :group, String, default: lazy { service_name },
         description: 'Group to run the service as'

property :port, Integer,
         description: 'Port the service listens on'

property :monitoring_enabled, [true, false], default: true,
         description: 'Enable monitoring for this service'

property :logging_enabled, [true, false], default: true,
         description: 'Enable centralized logging'

property :backup_enabled, [true, false], default: false,
         description: 'Enable backup for service data'

property :firewall_enabled, [true, false], default: true,
         description: 'Configure firewall rules'

property :health_check_enabled, [true, false], default: true,
         description: 'Enable health check monitoring'

property :compliance_profiles, Array, default: [],
         description: 'InSpec compliance profiles to apply'

property :service_config, Hash, default: {},
         description: 'Service-specific configuration hash'

action_class do
  def package_resource
    @package_resource ||= package package_name || new_resource.service_name do
      action :nothing
    end
  end

  def user_resource
    @user_resource ||= user new_resource.user do
      system true
      shell '/bin/false'
      home "/var/lib/#{new_resource.service_name}"
      action :nothing
    end
  end

  def group_resource
    @group_resource ||= group new_resource.group do
      system true
      action :nothing
    end
  end

  def config_directory
    ::File.dirname(new_resource.config_path)
  end

  def log_directory
    "/var/log/#{new_resource.service_name}"
  end

  def data_directory
    "/var/lib/#{new_resource.service_name}"
  end
end

action :install do
  # Create user and group
  group_resource.run_action(:create)
  user_resource.run_action(:create)

  # Install package
  package_resource.run_action(:install)

  # Create directories
  directory config_directory do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end

  directory log_directory do
    owner new_resource.user
    group new_resource.group
    mode '0755'
    recursive true
  end

  directory data_directory do
    owner new_resource.user
    group new_resource.group
    mode '0750'
    recursive true
  end

  # Generate configuration
  template new_resource.config_path do
    source new_resource.config_template
    cookbook cookbook_name
    owner new_resource.user
    group new_resource.group
    mode '0640'
    variables(
      service_name: new_resource.service_name,
      config: new_resource.service_config,
      user: new_resource.user,
      group: new_resource.group,
      port: new_resource.port,
      log_directory: log_directory,
      data_directory: data_directory
    )
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end

  # Configure service
  service new_resource.service_name do
    action [:enable, :start]
    supports restart: true, reload: true, status: true
  end

  # Configure logging
  if new_resource.logging_enabled
    logrotate_app new_resource.service_name do
      path "#{log_directory}/*.log"
      frequency 'daily'
      rotate 30
      compress true
      delaycompress true
      missingok true
      notifempty true
      create "0644 #{new_resource.user} #{new_resource.group}"
      postrotate "systemctl reload #{new_resource.service_name} > /dev/null 2>&1 || true"
    end

    # Configure rsyslog forwarding
    rsyslog_conf "#{new_resource.service_name}-forward" do
      content <<~RSYSLOG
        # Forward #{new_resource.service_name} logs to central server
        $ModLoad imfile
        $InputFileName #{log_directory}/#{new_resource.service_name}.log
        $InputFileTag #{new_resource.service_name}:
        $InputFileStateFile #{new_resource.service_name}-state
        $InputFileSeverity info
        $InputFileFacility local0
        $InputRunFileMonitor
        local0.* @@#{node['logging']['rsyslog']['server']}:#{node['logging']['rsyslog']['port']}
      RSYSLOG
      notifies :restart, 'service[rsyslog]', :delayed
    end
  end

  # Configure firewall
  if new_resource.firewall_enabled && new_resource.port
    firewall_rule "#{new_resource.service_name}-port" do
      port new_resource.port
      protocol :tcp
      action :allow
      command :allow
    end
  end

  # Configure monitoring
  if new_resource.monitoring_enabled
    # Prometheus node exporter textfile collector
    file "/var/lib/node_exporter/textfile_collector/#{new_resource.service_name}.prom" do
      owner 'node_exporter'
      group 'node_exporter'
      mode '0644'
      content lazy {
        <<~METRICS
          # HELP #{new_resource.service_name}_up Service is running
          # TYPE #{new_resource.service_name}_up gauge
          #{new_resource.service_name}_up{service="#{new_resource.service_name}"} 1

          # HELP #{new_resource.service_name}_config_last_change Last configuration change timestamp
          # TYPE #{new_resource.service_name}_config_last_change gauge
          #{new_resource.service_name}_config_last_change{service="#{new_resource.service_name}"} #{Time.now.to_i}
        METRICS
      }
      action :create_if_missing
    end
  end

  # Configure health checks
  if new_resource.health_check_enabled
    template "/usr/local/bin/#{new_resource.service_name}-healthcheck" do
      source 'healthcheck.sh.erb'
      cookbook cookbook_name
      owner 'root'
      group 'root'
      mode '0755'
      variables(
        service_name: new_resource.service_name,
        port: new_resource.port,
        config: new_resource.service_config
      )
    end

    cron "#{new_resource.service_name}-healthcheck" do
      minute '*/5'
      command "/usr/local/bin/#{new_resource.service_name}-healthcheck"
      user 'root'
      action :create
    end
  end

  # Apply compliance profiles
  if new_resource.compliance_profiles.any?
    new_resource.compliance_profiles.each do |profile|
      audit_profile profile do
        action [:fetch, :execute]
      end
    end
  end

  # Configure backup
  if new_resource.backup_enabled
    cron "#{new_resource.service_name}-backup" do
      minute '0'
      hour '2'
      command "/usr/local/bin/backup-#{new_resource.service_name}"
      user 'root'
      action :create
    end

    template "/usr/local/bin/backup-#{new_resource.service_name}" do
      source 'backup_script.sh.erb'
      cookbook cookbook_name
      owner 'root'
      group 'root'
      mode '0755'
      variables(
        service_name: new_resource.service_name,
        data_directory: data_directory,
        backup_destination: node['backup']['destination']
      )
    end
  end
end

action :remove do
  service new_resource.service_name do
    action [:stop, :disable]
  end

  package_resource.run_action(:remove)

  [config_directory, log_directory, data_directory].each do |dir|
    directory dir do
      recursive true
      action :delete
    end
  end

  user_resource.run_action(:remove)
  group_resource.run_action(:remove)
end
```

### Enterprise Library Functions

```ruby
# libraries/enterprise_helpers.rb - Enterprise helper functions
module EnterpriseHelpers
  module Common
    # Get environment-specific configuration
    def enterprise_config(service_name, default = {})
      base_config = node['enterprise']['services'][service_name] || {}
      env_config = node['enterprise']['environments'][node.environment] || {}
      service_env_config = env_config[service_name] || {}

      default.merge(base_config).merge(service_env_config)
    end

    # Generate secure random password
    def generate_secure_password(length = 32)
      require 'securerandom'
      SecureRandom.base64(length)[0, length]
    end

    # Get secrets from HashiCorp Vault
    def vault_secret(path, key = nil)
      require 'vault'

      Vault.configure do |config|
        config.address = node['vault']['address']
        config.token = node['vault']['token']
        config.ssl_verify = node['vault']['ssl_verify']
      end

      secret = Vault.logical.read(path)
      return nil if secret.nil?

      if key
        secret.data[key.to_sym]
      else
        secret.data
      end
    rescue => e
      Chef::Log.error("Failed to fetch secret from Vault: #{e.message}")
      nil
    end

    # Encrypt sensitive data using Chef Vault
    def chef_vault_item(vault, item)
      require 'chef-vault'
      ChefVault::Item.load(vault, item)
    rescue ChefVault::Exceptions::KeysNotFound => e
      Chef::Log.error("Chef Vault keys not found: #{e.message}")
      {}
    rescue => e
      Chef::Log.error("Failed to load Chef Vault item: #{e.message}")
      {}
    end

    # Validate IP address format
    def valid_ip?(ip)
      return false unless ip.is_a?(String)

      octets = ip.split('.')
      return false unless octets.length == 4

      octets.all? { |octet| octet.to_i.between?(0, 255) }
    end

    # Check if service is listening on port
    def port_listening?(port, protocol = 'tcp')
      case protocol.downcase
      when 'tcp'
        system("netstat -tln | grep -q ':#{port} '")
      when 'udp'
        system("netstat -uln | grep -q ':#{port} '")
      else
        false
      end
    end

    # Get system memory in MB
    def system_memory_mb
      if node['memory'] && node['memory']['total']
        node['memory']['total'].gsub(/kB$/, '').to_i / 1024
      else
        2048  # Default fallback
      end
    end

    # Calculate optimal worker processes
    def optimal_worker_count(multiplier = 1)
      cpu_count = node['cpu'] ? node['cpu']['total'].to_i : 2
      [cpu_count * multiplier, 1].max
    end

    # Format bytes to human readable
    def human_bytes(bytes)
      units = %w[B KB MB GB TB PB]
      size = bytes.to_f
      unit_index = 0

      while size >= 1024 && unit_index < units.length - 1
        size /= 1024
        unit_index += 1
      end

      "#{size.round(2)} #{units[unit_index]}"
    end

    # Check if running in production
    def production_environment?
      node.environment == 'production'
    end

    # Get datacenter from node attributes
    def datacenter
      node['datacenter'] || node['ec2']['placement_availability_zone'][0..-2] || 'unknown'
    end

    # Generate SSL certificate paths
    def ssl_paths(service_name)
      base_path = "/etc/ssl/#{service_name}"
      {
        cert: "#{base_path}/#{service_name}.crt",
        key: "#{base_path}/#{service_name}.key",
        ca: "#{base_path}/ca.crt",
        dhparam: "#{base_path}/dhparam.pem"
      }
    end
  end

  module Security
    # Generate strong SSL/TLS configuration
    def strong_ssl_config
      {
        protocols: 'TLSv1.2 TLSv1.3',
        ciphers: [
          'ECDHE-ECDSA-AES128-GCM-SHA256',
          'ECDHE-RSA-AES128-GCM-SHA256',
          'ECDHE-ECDSA-AES256-GCM-SHA384',
          'ECDHE-RSA-AES256-GCM-SHA384',
          'ECDHE-ECDSA-CHACHA20-POLY1305',
          'ECDHE-RSA-CHACHA20-POLY1305',
          'DHE-RSA-AES128-GCM-SHA256',
          'DHE-RSA-AES256-GCM-SHA384'
        ].join(':'),
        prefer_server_ciphers: 'off',
        session_cache: 'shared:SSL:10m',
        session_timeout: '10m',
        session_tickets: 'off'
      }
    end

    # Generate security headers
    def security_headers
      {
        'X-Frame-Options' => 'DENY',
        'X-Content-Type-Options' => 'nosniff',
        'X-XSS-Protection' => '1; mode=block',
        'Strict-Transport-Security' => 'max-age=31536000; includeSubDomains; preload',
        'Referrer-Policy' => 'strict-origin-when-cross-origin',
        'Content-Security-Policy' => "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'",
        'Feature-Policy' => "geolocation 'none'; microphone 'none'; camera 'none'"
      }
    end

    # Check if system meets CIS benchmarks
    def cis_compliant?(control)
      case control
      when '1.1.1.1'  # Ensure mounting of cramfs filesystems is disabled
        !system('modprobe -n -v cramfs | grep -v "install /bin/true"')
      when '1.4.1'    # Ensure permissions on bootloader config are configured
        File.stat('/boot/grub2/grub.cfg').mode & 0o077 == 0
      when '5.2.5'    # Ensure SSH X11 forwarding is disabled
        File.read('/etc/ssh/sshd_config').include?('X11Forwarding no')
      else
        true  # Default to compliant for unknown controls
      end
    rescue
      false
    end
  end

  module Monitoring
    # Generate Prometheus metrics
    def prometheus_metrics(service_name, metrics = {})
      content = []

      metrics.each do |metric_name, metric_data|
        content << "# HELP #{service_name}_#{metric_name} #{metric_data[:help]}"
        content << "# TYPE #{service_name}_#{metric_name} #{metric_data[:type]}"

        if metric_data[:labels]
          label_str = metric_data[:labels].map { |k, v| "#{k}=\"#{v}\"" }.join(',')
          content << "#{service_name}_#{metric_name}{#{label_str}} #{metric_data[:value]}"
        else
          content << "#{service_name}_#{metric_name} #{metric_data[:value]}"
        end
      end

      content.join("\n") + "\n"
    end

    # Check service health
    def service_healthy?(service_name, port = nil)
      service_running = system("systemctl is-active #{service_name} > /dev/null 2>&1")

      if port
        port_open = port_listening?(port)
        service_running && port_open
      else
        service_running
      end
    end

    # Get system load average
    def system_load
      if File.exist?('/proc/loadavg')
        File.read('/proc/loadavg').split(' ')[0..2].map(&:to_f)
      else
        [0.0, 0.0, 0.0]
      end
    end
  end
end

# Include helper modules in Chef::Recipe and Chef::Resource
Chef::Recipe.include(EnterpriseHelpers::Common)
Chef::Recipe.include(EnterpriseHelpers::Security)
Chef::Recipe.include(EnterpriseHelpers::Monitoring)

Chef::Resource.include(EnterpriseHelpers::Common)
Chef::Resource.include(EnterpriseHelpers::Security)
Chef::Resource.include(EnterpriseHelpers::Monitoring)
```

## Enterprise Testing Framework

### Test Kitchen Configuration

```yaml
# .kitchen.yml - Enterprise Test Kitchen configuration
---
driver:
  name: docker
  privileged: true
  use_sudo: false

provisioner:
  name: chef_zero
  product_name: chef
  install_strategy: once
  multiple_converge: 2
  enforce_idempotency: true
  deprecations_as_errors: true
  client_rb:
    audit_mode: :enabled
    chef_license: accept

transport:
  name: docker

verifier:
  name: inspec
  format: junit
  output: test/reports/inspec-junit.xml
  reporter:
    - cli
    - junit:test/reports/inspec-junit.xml
    - json:test/reports/inspec.json

platforms:
  # Enterprise Linux platforms
  - name: centos-7
    driver_config:
      image: centos:7
      platform: rhel
      run_command: /usr/sbin/init
      provision_command:
        - yum install -y initscripts systemd-sysv net-tools
        - systemctl set-default multi-user.target

  - name: centos-8
    driver_config:
      image: centos:8
      platform: rhel
      run_command: /usr/sbin/init
      provision_command:
        - dnf install -y systemd net-tools
        - systemctl set-default multi-user.target
```

## AI Assistant Guidelines

### Decision Framework for Chef Implementation

```ruby
def should_use_chef(requirements)
  # Strongly recommended for enterprise environments with Ruby expertise
  strongly_recommended = [
    requirements[:enterprise_environment],
    requirements[:ruby_expertise_available],
    requirements[:policy_as_code_requirements],
    requirements[:compliance_automation_needed],
    requirements[:existing_chef_infrastructure],
    requirements[:complex_multi_platform_support],
    requirements[:advanced_testing_requirements]
  ]

  if strongly_recommended.any?
    return {
      recommended: true,
      reason: "Chef excels in enterprise environments with strong Ruby expertise and complex compliance requirements"
    }
  end

  # Consider alternatives if needed
  alternatives_needed = [
    requirements[:simple_automation_needs],
    requirements[:python_team_preference],
    requirements[:immediate_execution_required],
    requirements[:limited_ruby_knowledge],
    requirements[:small_infrastructure],
    requirements[:cloud_native_workloads]
  ]

  if alternatives_needed.any?
    return {
      recommended: false,
      reason: "Consider Ansible for simpler needs, Terraform for cloud infrastructure, or Kubernetes operators for cloud-native workloads",
      alternatives: ["Ansible", "Terraform", "Kubernetes"]
    }
  end

  # Default recommendation
  {
    recommended: true,
    reason: "Chef provides robust infrastructure automation suitable for enterprise environments"
  }
end
```

### Enterprise Security & Compliance Automation

```ruby
# cookbooks/enterprise_security/recipes/default.rb
# Comprehensive enterprise security hardening

# CIS Benchmark compliance cookbook
case node['compliance']['framework']
when 'CIS'
  include_recipe 'enterprise_security::cis_hardening'

  # CIS Level 1 baseline security controls
  template '/etc/security/limits.conf' do
    source 'cis_limits.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables({
      max_logins: node['security']['cis']['max_logins'],
      max_processes: node['security']['cis']['max_processes']
    })
  end

  # Disable unnecessary services per CIS guidelines
  %w{
    telnet rsh rlogin ypbind tftp xinetd
    chargen-dgram chargen-stream daytime-dgram
    daytime-stream echo-dgram echo-stream tcpmux-server
  }.each do |service_name|
    service service_name do
      action [:stop, :disable]
      only_if { service_exists?(service_name) }
    end
  end

  # Secure kernel parameters
  sysctl 'net.ipv4.ip_forward' do
    value 0
    action :apply
  end

  sysctl 'net.ipv4.conf.all.send_redirects' do
    value 0
    action :apply
  end

  sysctl 'net.ipv4.conf.default.send_redirects' do
    value 0
    action :apply
  end

  # File system hardening
  mount '/tmp' do
    device '/dev/disk/by-label/tmp'
    fstype 'ext4'
    options 'nodev,nosuid,noexec'
    action [:mount, :enable]
  end

  mount '/var/tmp' do
    device '/dev/disk/by-label/var-tmp'
    fstype 'ext4'
    options 'nodev,nosuid,noexec'
    action [:mount, :enable]
  end

when 'SOC2'
  include_recipe 'enterprise_security::soc2_controls'

  # SOC2 Type II compliance controls
  template '/etc/security/soc2-policy.conf' do
    source 'soc2_policy.conf.erb'
    owner 'root'
    group 'root'
    mode '0600'
    sensitive true
    variables({
      organization: node['organization']['name'],
      compliance_officer: node['organization']['compliance_officer'],
      audit_retention_days: node['compliance']['soc2']['audit_retention_days']
    })
  end

  # Advanced audit logging for SOC2
  package 'auditd' do
    action :install
  end

  template '/etc/audit/rules.d/soc2.rules' do
    source 'soc2_audit.rules.erb'
    owner 'root'
    group 'root'
    mode '0640'
    notifies :restart, 'service[auditd]', :immediately
    variables({
      watch_paths: node['compliance']['soc2']['watch_paths'],
      key_identifiers: node['compliance']['soc2']['key_identifiers']
    })
  end

  service 'auditd' do
    action [:enable, :start]
    supports restart: true, reload: true, status: true
  end

when 'PCI-DSS'
  include_recipe 'enterprise_security::pci_dss_controls'

  # PCI-DSS compliance requirements
  group 'pci' do
    gid 1500
    action :create
  end

  template '/etc/security/pci-dss.conf' do
    source 'pci_dss.conf.erb'
    owner 'root'
    group 'pci'
    mode '0640'
    variables({
      cardholder_data_environment: node['pci']['cardholder_data_environment'],
      encryption_algorithms: node['pci']['encryption_algorithms'],
      key_management_procedures: node['pci']['key_management_procedures']
    })
  end

  # Strong password policy for PCI compliance
  template '/etc/pam.d/common-password' do
    source 'pci_password_policy.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables({
      min_length: node['pci']['password']['min_length'],
      complexity_requirements: node['pci']['password']['complexity_requirements'],
      history_count: node['pci']['password']['history_count']
    })
  end

  # Network security controls
  firewall_rule 'pci_default_deny' do
    port 'all'
    action :deny
    position 1
  end

  node['pci']['allowed_services'].each do |service_config|
    firewall_rule "allow_#{service_config['name']}" do
      port service_config['port']
      protocol service_config['protocol']
      source service_config['source']
      action :allow
    end
  end

when 'HIPAA'
  include_recipe 'enterprise_security::hipaa_controls'

  # HIPAA Security Rule implementation
  group 'hipaa' do
    gid 1600
    action :create
  end

  template '/etc/security/hipaa-security.conf' do
    source 'hipaa_security.conf.erb'
    owner 'root'
    group 'hipaa'
    mode '0600'
    sensitive true
    variables({
      covered_entity: node['hipaa']['covered_entity'],
      business_associate: node['hipaa']['business_associate'],
      phi_locations: node['hipaa']['phi_locations']
    })
  end

  # Encryption at rest for PHI
  package 'cryptsetup' do
    action :install
  end

  execute 'setup_phi_encryption' do
    command lazy {
      "cryptsetup luksFormat #{node['hipaa']['phi_device']} --key-file=#{node['hipaa']['encryption_key_file']}"
    }
    creates node['hipaa']['phi_mount_point']
    sensitive true
  end

  mount node['hipaa']['phi_mount_point'] do
    device "/dev/mapper/#{node['hipaa']['phi_volume_name']}"
    fstype 'ext4'
    options 'noatime,nodiratime'
    action [:mount, :enable]
  end
end

# File integrity monitoring with AIDE
package 'aide' do
  action :install
end

template '/etc/aide/aide.conf' do
  source 'aide.conf.erb'
  owner 'root'
  group 'root'
  mode '0600'
  variables({
    monitored_paths: node['security']['aide']['monitored_paths'],
    exclusion_patterns: node['security']['aide']['exclusion_patterns'],
    notification_email: node['security']['aide']['notification_email']
  })
end

cron 'aide_check' do
  minute '0'
  hour '2'
  command '/usr/bin/aide --check | mail -s "AIDE Integrity Check - #{node['hostname']}" #{node['security']['aide']['notification_email']}'
  user 'root'
end

# Centralized logging with rsyslog
template '/etc/rsyslog.d/50-enterprise-security.conf' do
  source '50-enterprise-security.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[rsyslog]', :immediately
  variables({
    log_server: node['logging']['central_server'],
    log_port: node['logging']['port'],
    facility: node['logging']['facility']
  })
end

service 'rsyslog' do
  action [:enable, :start]
  supports restart: true, reload: true, status: true
end
```

### Enterprise Monitoring & Observability Integration

```ruby
# cookbooks/enterprise_monitoring/recipes/default.rb
# Comprehensive monitoring and observability platform

# Prometheus Node Exporter
ark 'node_exporter' do
  url "https://github.com/prometheus/node_exporter/releases/download/v#{node['monitoring']['node_exporter']['version']}/node_exporter-#{node['monitoring']['node_exporter']['version']}.linux-amd64.tar.gz"
  version node['monitoring']['node_exporter']['version']
  checksum node['monitoring']['node_exporter']['checksum']
  creates 'node_exporter'
  owner 'prometheus'
  group 'prometheus'
end

user 'prometheus' do
  system true
  shell '/bin/false'
  home '/var/lib/prometheus'
  action :create
end

directory '/var/lib/prometheus' do
  owner 'prometheus'
  group 'prometheus'
  mode '0755'
  action :create
end

systemd_unit 'node_exporter.service' do
  content({
    Unit: {
      Description: 'Node Exporter',
      After: 'network.target'
    },
    Service: {
      User: 'prometheus',
      Group: 'prometheus',
      Type: 'simple',
      ExecStart: '/usr/local/node_exporter/node_exporter --web.listen-address=0.0.0.0:9100 --collector.systemd --collector.processes',
      Restart: 'always'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  })
  action [:create, :enable, :start]
end

# Chef-specific metrics collection
cookbook_file '/usr/local/bin/chef-metrics-collector.rb' do
  source 'chef-metrics-collector.rb'
  owner 'root'
  group 'root'
  mode '0755'
end

cron 'chef_metrics_collection' do
  minute '*/5'
  command '/usr/local/bin/chef-metrics-collector.rb'
  user 'root'
end

# Filebeat for log shipping
ark 'filebeat' do
  url "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{node['monitoring']['filebeat']['version']}-linux-x86_64.tar.gz"
  version node['monitoring']['filebeat']['version']
  checksum node['monitoring']['filebeat']['checksum']
  creates 'filebeat'
  owner 'root'
  group 'root'
end

template '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  owner 'root'
  group 'root'
  mode '0600'
  sensitive true
  notifies :restart, 'service[filebeat]', :immediately
  variables({
    elasticsearch_hosts: node['monitoring']['elasticsearch']['hosts'],
    elasticsearch_username: node['monitoring']['elasticsearch']['username'],
    elasticsearch_password: node['monitoring']['elasticsearch']['password'],
    kibana_host: node['monitoring']['kibana']['host'],
    environment: node['chef_environment']
  })
end

systemd_unit 'filebeat.service' do
  content({
    Unit: {
      Description: 'Filebeat Log Shipper',
      After: 'network.target'
    },
    Service: {
      Type: 'simple',
      ExecStart: '/usr/local/filebeat/filebeat -c /etc/filebeat/filebeat.yml',
      Restart: 'always',
      User: 'root'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  })
  action [:create, :enable, :start]
end

# Application Performance Monitoring
if node['monitoring']['apm']['enabled']
  package 'elastic-apm-agent' do
    action :install
  end

  template '/etc/elastic-apm-agent/apm-agent.conf' do
    source 'apm-agent.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables({
      service_name: "chef-managed-#{node['hostname']}",
      service_version: node['monitoring']['apm']['service_version'],
      server_url: node['monitoring']['apm']['server_url'],
      secret_token: node['monitoring']['apm']['secret_token'],
      environment: node['chef_environment']
    })
  end

  service 'elastic-apm-agent' do
    action [:enable, :start]
    subscribes :restart, 'template[/etc/elastic-apm-agent/apm-agent.conf]', :immediately
  end
end

# Health check endpoints
template '/usr/local/bin/chef-health-check.rb' do
  source 'chef-health-check.rb.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    chef_server_url: node['chef_server']['url'],
    health_check_port: node['monitoring']['health_check']['port'],
    check_interval: node['monitoring']['health_check']['interval']
  })
end

systemd_unit 'chef-health-check.service' do
  content({
    Unit: {
      Description: 'Chef Health Check Service',
      After: 'network.target'
    },
    Service: {
      Type: 'simple',
      ExecStart: '/usr/local/bin/chef-health-check.rb',
      Restart: 'always',
      User: 'root'
    },
    Install: {
      WantedBy: 'multi-user.target'
    }
  })
  action [:create, :enable, :start]
end
```

### Enterprise CI/CD & Testing Automation

```ruby
# cookbooks/enterprise_cicd/recipes/default.rb
# Comprehensive CI/CD pipeline integration

# Test Kitchen configuration for cookbook testing
directory node['test_kitchen']['config_path'] do
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0755'
  recursive true
  action :create
end

template "#{node['test_kitchen']['config_path']}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0644'
  variables({
    driver: node['test_kitchen']['driver'],
    platforms: node['test_kitchen']['platforms'],
    suites: node['test_kitchen']['suites'],
    provisioner: node['test_kitchen']['provisioner']
  })
end

# ChefSpec unit testing framework
gem_package 'chefspec' do
  version node['testing']['chefspec']['version']
  action :install
end

gem_package 'rspec' do
  version node['testing']['rspec']['version']
  action :install
end

# Foodcritic linting
gem_package 'foodcritic' do
  version node['testing']['foodcritic']['version']
  action :install
end

gem_package 'rubocop' do
  version node['testing']['rubocop']['version']
  action :install
end

# Cookstyle (Chef's Ruby style guide)
gem_package 'cookstyle' do
  version node['testing']['cookstyle']['version']
  action :install
end

# InSpec compliance testing
gem_package 'inspec' do
  version node['testing']['inspec']['version']
  action :install
end

# Berkshelf dependency management
gem_package 'berkshelf' do
  version node['dependency_management']['berkshelf']['version']
  action :install
end

template "#{node['test_kitchen']['config_path']}/Berksfile" do
  source 'Berksfile.erb'
  owner node['test_kitchen']['user']
  group node['test_kitchen']['group']
  mode '0644'
  variables({
    cookbook_sources: node['dependency_management']['cookbook_sources'],
    dependencies: node['dependency_management']['dependencies']
  })
end

# Jenkins build agent configuration
if node['cicd']['jenkins']['enabled']
  include_recipe 'jenkins::java'

  jenkins_slave node['jenkins']['slave']['name'] do
    description "Chef cookbook testing agent - #{node['hostname']}"
    remote_fs node['jenkins']['slave']['home']
    executors node['jenkins']['slave']['executors']
    labels node['jenkins']['slave']['labels']
    usage_mode 'exclusive'
    availability 'always'
    env node['jenkins']['slave']['environment_variables']
    jvm_options node['jenkins']['slave']['jvm_options']

    # Credential configuration
    slave_user node['jenkins']['slave']['user']
    slave_password node['jenkins']['slave']['password']

    # Connection configuration
    master_url node['jenkins']['master']['url']
    master_username node['jenkins']['master']['username']
    master_password node['jenkins']['master']['password']
  end
end

# GitLab CI runner configuration
if node['cicd']['gitlab']['enabled']
  package 'gitlab-runner' do
    action :install
  end

  execute 'register_gitlab_runner' do
    command lazy {
      "gitlab-runner register " \
      "--non-interactive " \
      "--url #{node['gitlab']['url']} " \
      "--registration-token #{node['gitlab']['runner_token']} " \
      "--executor shell " \
      "--description 'Chef Enterprise Runner - #{node['hostname']}' " \
      "--tag-list '#{node['gitlab']['runner_tags'].join(',')}''"
    }
    not_if 'gitlab-runner verify'
    sensitive true
  end

  service 'gitlab-runner' do
    action [:enable, :start]
  end
end

# Automated cookbook testing pipeline
template '/usr/local/bin/chef-test-pipeline.sh' do
  source 'chef-test-pipeline.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    cookbook_path: node['chef']['cookbook_path'],
    test_results_path: node['testing']['results_path'],
    notification_webhook: node['testing']['notification_webhook'],
    quality_gates: node['testing']['quality_gates']
  })
end

# Cookbook deployment automation
template '/usr/local/bin/chef-deploy-cookbook.sh' do
  source 'chef-deploy-cookbook.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    chef_server_url: node['chef_server']['url'],
    deployment_environments: node['deployment']['environments'],
    approval_required: node['deployment']['approval_required'],
    rollback_enabled: node['deployment']['rollback_enabled']
  })
end

# Policy-based deployment with Policyfiles
if node['chef']['policyfile']['enabled']
  gem_package 'chef-dk' do
    action :install
  end

  template "#{node['chef']['repo_path']}/Policyfile.rb" do
    source 'Policyfile.rb.erb'
    owner node['chef']['user']
    group node['chef']['group']
    mode '0644'
    variables({
      policy_name: node['chef']['policyfile']['name'],
      run_list: node['chef']['policyfile']['run_list'],
      cookbook_sources: node['chef']['policyfile']['cookbook_sources'],
      attributes: node['chef']['policyfile']['attributes']
    })
  end

  execute 'install_policyfile' do
    command 'chef install'
    cwd node['chef']['repo_path']
    user node['chef']['user']
    environment 'HOME' => node['chef']['home_path']
    subscribes :run, "template[#{node['chef']['repo_path']}/Policyfile.rb]", :immediately
  end
end
```

This comprehensive Level 3 Chef implementation provides enterprise-grade infrastructure automation with advanced compliance frameworks, comprehensive testing, CI/CD integration, monitoring capabilities, and production-ready deployment patterns suitable for large-scale enterprise environments.
