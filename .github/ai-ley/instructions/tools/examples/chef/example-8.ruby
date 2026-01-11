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