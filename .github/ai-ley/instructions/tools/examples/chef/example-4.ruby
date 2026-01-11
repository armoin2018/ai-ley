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