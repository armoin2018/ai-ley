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