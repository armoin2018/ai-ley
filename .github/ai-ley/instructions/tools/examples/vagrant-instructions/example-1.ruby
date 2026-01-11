# Vagrantfile - Enterprise multi-provider orchestration
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'
require 'json'

# Load enterprise configuration
enterprise_config = YAML.load_file('config/enterprise.yml')
secrets = JSON.parse(File.read('config/secrets.json'))

Vagrant.configure("2") do |config|
  # Enterprise defaults
  config.vm.box_check_update = true
  config.vm.boot_timeout = 600
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  # Global provisioning for enterprise standards
  config.vm.provision "enterprise_baseline", type: "ansible" do |ansible|
    ansible.playbook = "provisioning/enterprise-baseline.yml"
    ansible.inventory_path = "provisioning/inventory/enterprise"
    ansible.vault_password_file = ".vault_pass"
    ansible.extra_vars = {
      enterprise_domain: enterprise_config['domain'],
      compliance_framework: enterprise_config['compliance']['framework'],
      monitoring_enabled: enterprise_config['monitoring']['enabled']
    }
  end

  # Enterprise monitoring agent
  config.vm.provision "monitoring", type: "shell", run: "always" do |shell|
    shell.path = "scripts/install_monitoring_agent.sh"
    shell.args = [
      enterprise_config['monitoring']['prometheus_endpoint'],
      enterprise_config['monitoring']['grafana_endpoint']
    ]
  end

  # Multi-environment configuration
  enterprise_config['environments'].each do |env_name, env_config|
    env_config['nodes'].each do |node_config|
      config.vm.define "#{env_name}-#{node_config['name']}" do |node|
        # Provider-specific configuration
        case env_config['provider']
        when 'virtualbox'
          configure_virtualbox_provider(node, node_config, env_config)
        when 'vmware'
          configure_vmware_provider(node, node_config, env_config)
        when 'docker'
          configure_docker_provider(node, node_config, env_config)
        when 'aws'
          configure_aws_provider(node, node_config, env_config)
        when 'azure'
          configure_azure_provider(node, node_config, env_config)
        end

        # Enterprise networking
        configure_enterprise_networking(node, node_config, env_config)

        # Role-based provisioning
        configure_role_provisioning(node, node_config, env_config)

        # Security hardening
        configure_security_hardening(node, node_config, env_config)
      end
    end
  end
end

# Provider configuration methods
def configure_virtualbox_provider(node, node_config, env_config)
  node.vm.provider "virtualbox" do |vb|
    vb.name = "#{env_config['name']}-#{node_config['name']}"
    vb.memory = node_config['resources']['memory']
    vb.cpus = node_config['resources']['cpus']
    vb.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0')

    # Enterprise VirtualBox settings
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]

    # Security enhancements
    vb.customize ["modifyvm", :id, "--vrde", "off"]
    vb.customize ["modifyvm", :id, "--clipboard", "disabled"]
    vb.customize ["modifyvm", :id, "--draganddrop", "disabled"]
  end
end

def configure_vmware_provider(node, node_config, env_config)
  ["vmware_desktop", "vmware_fusion", "vmware_workstation"].each do |provider|
    node.vm.provider provider do |vmware|
      vmware.vmx["displayName"] = "#{env_config['name']}-#{node_config['name']}"
      vmware.vmx["memsize"] = node_config['resources']['memory']
      vmware.vmx["numvcpus"] = node_config['resources']['cpus']
      vmware.vmx["cpuid.coresPerSocket"] = "1"

      # Enterprise VMware settings
      vmware.vmx["ethernet0.connectionType"] = "nat"
      vmware.vmx["ethernet1.connectionType"] = "hostonly"
      vmware.vmx["isolation.tools.hgfs.disable"] = "false"
      vmware.vmx["isolation.tools.dnd.disable"] = "true"
      vmware.vmx["isolation.tools.copy.enable"] = "false"
      vmware.vmx["isolation.tools.paste.enabled"] = "false"

      # Security hardening
      vmware.vmx["RemoteDisplay.vnc.enabled"] = "false"
      vmware.vmx["tools.syncTime"] = "true"
      vmware.vmx["uuid.action"] = "create"
    end
  end
end

def configure_docker_provider(node, node_config, env_config)
  node.vm.provider "docker" do |docker|
    docker.image = node_config['image'] || "ubuntu:22.04"
    docker.name = "#{env_config['name']}-#{node_config['name']}"
    docker.has_ssh = true
    docker.create_args = [
      "--memory=#{node_config['resources']['memory']}m",
      "--cpus=#{node_config['resources']['cpus']}",
      "--security-opt", "no-new-privileges:true",
      "--security-opt", "apparmor:unconfined",
      "--cap-add", "SYS_ADMIN",
      "--tmpfs", "/tmp",
      "--tmpfs", "/run",
      "--volume", "/sys/fs/cgroup:/sys/fs/cgroup:ro"
    ]

    # Enterprise Docker networking
    if env_config['network']
      docker.create_args << "--network=#{env_config['network']['name']}"
    end

    # Volume mounts for development
    node_config['volumes']&.each do |volume|
      docker.volumes << "#{volume['host']}:#{volume['container']}:#{volume['options']}"
    end
  end
end

def configure_aws_provider(node, node_config, env_config)
  node.vm.provider "aws" do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY_ID']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.session_token = ENV['AWS_SESSION_TOKEN']
    aws.keypair_name = env_config['aws']['keypair_name']
    aws.region = env_config['aws']['region']
    aws.availability_zone = env_config['aws']['availability_zone']

    # Instance configuration
    aws.instance_type = node_config['aws']['instance_type']
    aws.ami = node_config['aws']['ami']
    aws.subnet_id = env_config['aws']['subnet_id']
    aws.security_groups = env_config['aws']['security_groups']
    aws.associate_public_ip = node_config['aws']['public_ip']

    # Enterprise AWS settings
    aws.monitoring = true
    aws.ebs_optimized = true
    aws.terminate_on_shutdown = true
    aws.block_device_mapping = [
      {
        'DeviceName' => '/dev/sda1',
        'Ebs.VolumeSize' => node_config['aws']['disk_size'],
        'Ebs.VolumeType' => 'gp3',
        'Ebs.Encrypted' => true,
        'Ebs.DeleteOnTermination' => true
      }
    ]

    # Tags for enterprise compliance
    aws.tags = {
      'Name' => "#{env_config['name']}-#{node_config['name']}",
      'Environment' => env_config['environment'],
      'Project' => env_config['project'],
      'Owner' => env_config['owner'],
      'ManagedBy' => 'Vagrant',
      'Compliance' => env_config['compliance']['framework'],
      'CreatedDate' => Time.now.strftime('%Y-%m-%d'),
      'AutoShutdown' => env_config['auto_shutdown'].to_s
    }

    override.vm.box = "dummy"
    override.ssh.username = node_config['aws']['ssh_username']
    override.ssh.private_key_path = env_config['aws']['private_key_path']
  end
end