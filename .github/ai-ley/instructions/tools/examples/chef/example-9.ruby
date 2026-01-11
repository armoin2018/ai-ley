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