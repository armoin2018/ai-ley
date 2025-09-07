---
agentMode: general
applyTo: general
author: AI-LEY
description: Enterprise Vagrant virtualization platform with advanced multi-provider orchestration, infrastructure automation, development environment standardization, compliance frameworks, security hardening, comprehensive monitoring integration, and production-scale deployment patterns.
extensions:
  - .md
  - .rb
  - .yml
  - .yaml
  - .sh
  - .ps1
  - .json
guidelines: Enterprise Virtualization & Development Environment Automation with Vagrant orchestration, multi-provider support, infrastructure automation, compliance frameworks, security hardening, monitoring integration, and comprehensive CI/CD pipeline orchestration.
instructionType: general
keywords:
  - vagrant
  - virtualization
  - development-environment
  - infrastructure-automation
  - multi-provider
  - compliance
  - security
  - monitoring
  - enterprise
  - orchestration
  - devops
  - ci-cd
lastUpdated: '2025-09-05T00:00:00.000000'
summaryScore: 5.0
title: Vagrant Enterprise Virtualization & Automation Platform
version: 3.0.0
---

# Vagrant Enterprise Virtualization & Automation at Scale

## Enterprise Overview

Vagrant Enterprise Virtualization Platform provides comprehensive development environment automation, infrastructure virtualization, and multi-provider orchestration across VirtualBox, VMware, Hyper-V, Docker, AWS, and hybrid cloud environments. This enterprise implementation features advanced Ruby-based configuration, compliance automation, security hardening, and production-scale monitoring integration.

Enterprise deployments utilize advanced features including multi-provider support, distributed environment orchestration, automated compliance validation, security frameworks, comprehensive testing suites, GitOps integration, performance monitoring, and sophisticated CI/CD pipeline orchestration for managing complex virtualization automation at enterprise scale.

## 🧠 Enterprise Context

- **Project Type**: Enterprise Virtualization & Development Environment Automation at Scale
- **Architecture**: Provider-agnostic / Multi-cloud / Container-native / Infrastructure-as-Code / Distributed
- **Platform**: Vagrant 2.4+ / VirtualBox 7+ / VMware vSphere / Docker / AWS / Azure / GCP
- **Orchestration**: Multi-provider deployments / Progressive provisioning / Blue-green environments / Zero-downtime updates
- **Compliance**: SOC2, PCI-DSS, HIPAA, FedRAMP, CIS benchmarks, NIST frameworks, Development Security
- **Scale**: 1K+ environments, 500+ Vagrantfiles, 100+ providers across 50+ development teams
- **Technologies**: Ruby DSL, Ansible, Docker, Kubernetes, Terraform integration, Git, CI/CD pipelines

## 📚 Advanced Enterprise Vagrantfile Patterns & Architecture

### Multi-Provider Enterprise Configuration

```ruby
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
```

### Enterprise Configuration Management

````yaml
# config/enterprise.yml - Enterprise-wide configuration
enterprise:
  domain: "enterprise.local"
  organization: "ACME Corporation"
  timezone: "UTC"

compliance:
  framework: "SOC2"
  enabled_controls:
    - encryption_at_rest
    - encryption_in_transit
    - access_logging
    - vulnerability_scanning
    - security_hardening

monitoring:
  enabled: true
  prometheus_endpoint: "http://prometheus.enterprise.local:9090"
  grafana_endpoint: "http://grafana.enterprise.local:3000"
  log_aggregation: "http://elk.enterprise.local:9200"

security:
  ssh_hardening: true
  firewall_enabled: true
  antivirus_enabled: true
  vulnerability_scanning: true

networking:
  dns_servers:
    - "8.8.8.8"
    - "8.8.4.4"
  ntp_servers:
    - "pool.ntp.org"
  proxy:
    enabled: false
    http_proxy: ""
    https_proxy: ""

environments:
  development:
    name: "dev"
    environment: "development"
    project: "enterprise-platform"
    owner: "development-team"
    provider: "virtualbox"
    auto_shutdown: true

    network:
      name: "enterprise-dev"
      subnet: "192.168.100.0/24"

    compliance:
      framework: "CIS"
      level: "basic"

    nodes:
      - name: "web01"
        role: "web"
        image: "ubuntu/jammy64"
        resources:
          memory: 2048
          cpus: 2
          disk: 20
        network:
          private_ip: "192.168.100.10"
          ports:
            - guest: 80, host: 8080
            - guest: 443, host: 8443
        volumes:
          - host: "./app", container: "/var/www/html", options: "rw"

      - name: "db01"
        role: "database"
        image: "ubuntu/jammy64"
        resources:
          memory: 4096
          cpus: 2
          disk: 50
        network:
          private_ip: "192.168.100.11"
          ports:
            - guest: 5432, host: 5432
        volumes:
          - host: "./data", container: "/var/lib/postgresql/data", options: "rw"

  staging:
    name: "staging"
    environment: "staging"
    project: "enterprise-platform"
    owner: "qa-team"
    provider: "aws"
    auto_shutdown: false

    aws:
      region: "us-west-2"
      availability_zone: "us-west-2a"
      keypair_name: "enterprise-staging"
      subnet_id: "subnet-12345678"
      security_groups: ["sg-12345678"]
      private_key_path: "~/.ssh/enterprise-staging.pem"

    compliance:
      framework: "SOC2"
      level: "enhanced"

    nodes:
      - name: "web01"
        role: "web"
        aws:
          instance_type: "t3.medium"
          ami: "ami-0c02fb55956c7d316"
          ssh_username: "ubuntu"
          disk_size: 30
          public_ip: true
        network:
          private_ip: "10.0.1.10"

      - name: "db01"
        role: "database"
        aws:
          instance_type: "r5.large"
          ami: "ami-0c02fb55956c7d316"
          ssh_username: "ubuntu"
          disk_size: 100
          public_ip: false
        network:
          private_ip: "10.0.1.11"

  production:
    name: "prod"
    environment: "production"
    project: "enterprise-platform"
    owner: "ops-team"
    provider: "vmware"
    auto_shutdown: false

    compliance:
      framework: "SOC2"
      level: "maximum"

    nodes:
      - name: "web01"
        role: "web-primary"
        resources:
          memory: 8192
          cpus: 4
          disk: 100
        network:
          private_ip: "10.10.1.10"

      - name: "web02"
        role: "web-secondary"
        resources:
          memory: 8192
          cpus: 4
          disk: 100
        network:
          private_ip: "10.10.1.11"
```

## 🛠️ Enterprise Installation & Setup

### Vagrant Enterprise Platform
```bash
# Install Vagrant (latest stable)
# macOS
brew install vagrant

# Ubuntu/Debian with HashiCorp repository
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant

# Install essential plugins for enterprise environments
vagrant plugin install vagrant-hostmanager    # DNS management
vagrant plugin install vagrant-env            # Environment variables
vagrant plugin install vagrant-reload         # VM restart capability
vagrant plugin install vagrant-disksize       # Dynamic disk sizing
vagrant plugin install vagrant-vbguest        # VirtualBox Guest Additions
vagrant plugin install vagrant-cachier        # Package caching
vagrant plugin install vagrant-aws            # AWS provider
vagrant plugin install vagrant-azure          # Azure provider
vagrant plugin install vagrant-google         # GCP provider
vagrant plugin install vagrant-docker-compose # Docker Compose integration
vagrant plugin install vagrant-proxyconf      # Corporate proxy support

# Verify installation
vagrant version
vagrant plugin list
```

### Enterprise Project Structure
```bash
# Create comprehensive enterprise project structure
mkdir -p vagrant-enterprise/{
  config/{environments,secrets,templates},
  provisioning/{roles,playbooks,inventory,scripts},
  plugins/{custom,extensions},
  boxes/{custom,enterprise},
  shared/{keys,certificates,configs},
  docs/{architecture,runbooks,compliance},
  tests/{integration,security,performance},
  scripts/{deployment,monitoring,backup}
}

# Initialize enterprise Vagrantfile
cat > vagrant-enterprise/Vagrantfile << 'EOF'
# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'lib/enterprise_config'
require_relative 'lib/provider_manager'
require_relative 'lib/security_manager'

# Enterprise Vagrant Configuration
enterprise = EnterpriseConfig.load('config/enterprise.yml')

Vagrant.configure("2") do |config|
  enterprise.environments.each do |env|
    configure_environment(config, env, enterprise)
  end
end
EOF

# Create enterprise library structure
mkdir -p vagrant-enterprise/lib
cat > vagrant-enterprise/lib/enterprise_config.rb << 'EOF'
# Enterprise configuration management
require 'yaml'
require 'json'
require 'erb'

class EnterpriseConfig
  attr_reader :config, :environments, :security, :compliance

  def self.load(config_file)
    new(config_file)
  end

  def initialize(config_file)
    @config = YAML.load_file(config_file)
    @environments = parse_environments
    @security = SecurityConfig.new(@config['security'])
    @compliance = ComplianceConfig.new(@config['compliance'])
  end

  private

  def parse_environments
    @config['environments'].map do |env_name, env_config|
      Environment.new(env_name, env_config, @config['enterprise'])
    end
  end
end
EOF
```

## 🔐 Enterprise Security & Compliance Framework

### Security Hardening Provisioning
```bash
#!/bin/bash
# scripts/security-hardening.sh - Enterprise security baseline

set -euo pipefail

# Configuration
LOG_FILE="/var/log/enterprise-hardening.log"
COMPLIANCE_FRAMEWORK="${1:-SOC2}"
ENVIRONMENT="${2:-development}"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Starting enterprise security hardening for $ENVIRONMENT environment..."

# System updates and security patches
log "Applying security updates..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
apt-get install -y unattended-upgrades apt-listchanges

# Configure automatic security updates
cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";
EOF

# Install security tools
log "Installing security tools..."
apt-get install -y
    fail2ban
    ufw
    rkhunter
    chkrootkit
    aide
    auditd
    clamav
    clamav-daemon
    clamav-freshclam
    lynis
    openssh-server

# SSH hardening
log "Hardening SSH configuration..."
SSH_CONFIG="/etc/ssh/sshd_config"
cp "$SSH_CONFIG" "$SSH_CONFIG.backup"

# SSH security settings
cat >> "$SSH_CONFIG" << EOF

# Enterprise SSH Hardening
Protocol 2
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
X11Forwarding no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
AllowUsers vagrant
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
IgnoreRhosts yes
HostbasedAuthentication no
EOF

systemctl restart sshd

# Firewall configuration
log "Configuring firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow http
ufw allow https

# Allow specific enterprise services
if [ "$ENVIRONMENT" = "development" ]; then
    ufw allow 3000:3010/tcp  # Development ports
    ufw allow 8000:8010/tcp  # Additional dev services
elif [ "$ENVIRONMENT" = "production" ]; then
    ufw allow 80/tcp
    ufw allow 443/tcp
    ufw allow from 10.0.0.0/8 to any port 22  # Internal network only
fi

ufw --force enable

# Fail2Ban configuration
log "Configuring Fail2Ban..."
cat > /etc/fail2ban/jail.local << EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 3
backend = auto

[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600

[apache-auth]
enabled = true
port = http,https
filter = apache-auth
logpath = /var/log/apache2/*error.log
maxretry = 3
EOF

systemctl enable fail2ban
systemctl start fail2ban

# File integrity monitoring with AIDE
log "Setting up file integrity monitoring..."
if [ "$COMPLIANCE_FRAMEWORK" = "SOC2" ] || [ "$COMPLIANCE_FRAMEWORK" = "PCI-DSS" ]; then
    aide --init
    mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

    # Create cron job for daily AIDE checks
    cat > /etc/cron.daily/aide << 'EOF'
#!/bin/bash
/usr/bin/aide --check 2>&1 | mail -s "AIDE Report $(hostname)" admin@enterprise.local
EOF
    chmod +x /etc/cron.daily/aide
fi

# ClamAV antivirus setup
log "Configuring antivirus scanning..."
freshclam --quiet
systemctl enable clamav-daemon
systemctl start clamav-daemon

# Daily virus scan
cat > /etc/cron.daily/clamav-scan << 'EOF'
#!/bin/bash
clamscan -r --remove --exclude-dir='^/sys' --exclude-dir='^/proc' --exclude-dir='^/dev' / 2>&1 | mail -s "ClamAV Scan Report $(hostname)" security@enterprise.local
EOF
chmod +x /etc/cron.daily/clamav-scan

# Audit logging
log "Configuring audit logging..."
cat > /etc/audit/rules.d/enterprise.rules << EOF
# Enterprise audit rules for $COMPLIANCE_FRAMEWORK compliance

# System calls
-a always,exit -F arch=b64 -S execve
-a always,exit -F arch=b32 -S execve

# File access monitoring
-w /etc/passwd -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/sudoers -p wa -k sudo_rules

# Network monitoring
-a always,exit -F arch=b64 -S socket -F a0=10 -k network_ipv4
-a always,exit -F arch=b64 -S socket -F a0=2 -k network_ipv4

# Login monitoring
-w /var/log/lastlog -p wa -k logins
-w /var/log/faillog -p wa -k logins

# SSH monitoring
-w /etc/ssh/sshd_config -p wa -k ssh_config

# Critical system files
-w /boot -p wa -k boot
-w /etc/crontab -p wa -k cron
-w /etc/cron.hourly/ -p wa -k cron
-w /etc/cron.daily/ -p wa -k cron
-w /etc/cron.weekly/ -p wa -k cron
-w /etc/cron.monthly/ -p wa -k cron
EOF

systemctl enable auditd
systemctl start auditd

# System hardening
log "Applying system hardening..."

# Kernel parameter hardening
cat > /etc/sysctl.d/99-enterprise-hardening.conf << EOF
# Enterprise security hardening
net.ipv4.ip_forward = 0
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
kernel.exec-shield = 1
kernel.randomize_va_space = 2
EOF

sysctl -p /etc/sysctl.d/99-enterprise-hardening.conf

log "Enterprise security hardening completed successfully."
```

### Compliance Validation Automation
```yaml
# provisioning/compliance-validation.yml - Ansible compliance playbook
---
- name: Enterprise Compliance Validation
  hosts: all
  become: true
  vars:
    compliance_framework: "{{ ansible_compliance_framework | default('SOC2') }}"
    environment_type: "{{ ansible_environment | default('development') }}"

  tasks:
    - name: Load compliance requirements
      include_vars: "vars/compliance/{{ compliance_framework | lower }}.yml"

    - name: Create compliance report directory
      file:
        path: "/var/log/compliance"
        state: directory
        mode: '0755'

    - name: Run OpenSCAP security scan
      shell: |
        oscap xccdf eval
          --profile "{{ compliance_profile }}"
          --results "/var/log/compliance/oscap-{{ ansible_hostname }}-{{ ansible_date_time.date }}.xml"
          --report "/var/log/compliance/oscap-{{ ansible_hostname }}-{{ ansible_date_time.date }}.html"
          /usr/share/xml/scap/ssg/content/ssg-ubuntu2204-ds.xml
      register: oscap_scan
      failed_when: false
      when: compliance_framework in ['SOC2', 'PCI-DSS', 'HIPAA']

    - name: Validate SSH configuration
      lineinfile:
        path: /etc/ssh/sshd_config
        regexp: "{{ item.regexp }}"
        line: "{{ item.line }}"
        state: present
      loop:
        - { regexp: '^PermitRootLogin', line: 'PermitRootLogin no' }
        - { regexp: '^PasswordAuthentication', line: 'PasswordAuthentication no' }
        - { regexp: '^X11Forwarding', line: 'X11Forwarding no' }
        - { regexp: '^MaxAuthTries', line: 'MaxAuthTries 3' }
      register: ssh_validation

    - name: Check firewall status
      command: ufw status
      register: firewall_status
      changed_when: false

    - name: Validate file permissions
      file:
        path: "{{ item.path }}"
        mode: "{{ item.mode }}"
        owner: "{{ item.owner | default('root') }}"
        group: "{{ item.group | default('root') }}"
      loop:
        - { path: '/etc/passwd', mode: '0644' }
        - { path: '/etc/shadow', mode: '0640', group: 'shadow' }
        - { path: '/etc/ssh/sshd_config', mode: '0600' }
        - { path: '/var/log', mode: '0755' }
      register: file_permissions

    - name: Check for required security packages
      package_facts:
        manager: "auto"

    - name: Validate security packages are installed
      assert:
        that:
          - "'fail2ban' in ansible_facts.packages"
          - "'ufw' in ansible_facts.packages"
          - "'aide' in ansible_facts.packages"
          - "'auditd' in ansible_facts.packages"
        fail_msg: "Required security packages are not installed"
        success_msg: "All required security packages are installed"

    - name: Generate compliance report
      template:
        src: compliance-report.j2
        dest: "/var/log/compliance/compliance-report-{{ ansible_hostname }}-{{ ansible_date_time.date }}.json"
      vars:
        hostname: "{{ ansible_hostname }}"
        framework: "{{ compliance_framework }}"
        scan_date: "{{ ansible_date_time.date }}"
        ssh_config: "{{ ssh_validation.changed }}"
        firewall_enabled: "{{ 'Status: active' in firewall_status.stdout }}"
        security_packages: "{{ ansible_facts.packages.keys() | list }}"
        file_permissions_ok: "{{ file_permissions.changed == false }}"

    - name: Upload compliance results to central server
      uri:
        url: "{{ compliance_server }}/api/v1/compliance/vagrant"
        method: POST
        headers:
          Authorization: "Bearer {{ compliance_api_token }}"
          Content-Type: "application/json"
        body_format: json
        body:
          hostname: "{{ ansible_hostname }}"
          environment: "{{ environment_type }}"
          framework: "{{ compliance_framework }}"
          timestamp: "{{ ansible_date_time.iso8601 }}"
          results: "{{ lookup('file', '/var/log/compliance/compliance-report-' + ansible_hostname + '-' + ansible_date_time.date + '.json') | from_json }}"
      when: compliance_server is defined
```
```## Core Features

### Environment Lifecycle Management

- **Purpose**: Create, start, stop, and destroy development environments
- **Usage**: Manage VM states and configurations
- **Example**:

```bash
vagrant up        # Create and start VM
vagrant halt      # Stop VM
vagrant destroy   # Delete VM completely
vagrant reload    # Restart VM with new configuration
````

### Provisioning Automation

- **Purpose**: Automatically configure environments with required software and settings
- **Usage**: Run scripts, install packages, configure services during VM creation
- **Example**:

```bash
# Shell provisioning
vagrant provision

# With specific provisioner
vagrant provision --provision-with shell,ansible
```

### Box Management

- **Purpose**: Manage reusable VM templates and base images
- **Usage**: Add, update, and remove base boxes for environments
- **Example**:

```bash
vagrant box add ubuntu/focal64
vagrant box list
vagrant box update
vagrant box remove ubuntu/focal64
```

## Common Commands

```bash
# Essential daily commands
vagrant up                          # Start environment
vagrant ssh                         # Connect to VM
vagrant status                      # Check VM status
vagrant halt                        # Stop VM

# Development workflow
vagrant reload                      # Restart with new config
vagrant provision                   # Run provisioning scripts
vagrant suspend                     # Pause VM (saves state)
vagrant resume                      # Resume paused VM

# Environment management
vagrant destroy -f                  # Force destroy without confirmation
vagrant global-status               # List all Vagrant environments
vagrant box outdated               # Check for box updates
```

## Integration & Workflow

### Development Workflow Integration

1. **Setup**: Initialize Vagrantfile, configure providers and provisioning
2. **Development**: Use shared folders for live code editing, port forwarding for testing
3. **Testing**: Provision clean environments for isolated testing scenarios
4. **Pre-commit**: Validate Vagrantfile syntax and provisioning scripts
5. **CI/CD**: Use Vagrant for creating consistent build and test environments

### Automation & Scripts

```bash
# Package.json scripts
{
  "scripts": {
    "dev:start": "vagrant up && vagrant ssh",
    "dev:clean": "vagrant destroy -f && vagrant up",
    "dev:provision": "vagrant provision",
    "dev:status": "vagrant global-status"
  }
}

# Makefile integration
.PHONY: dev-start dev-clean dev-ssh
dev-start:
	vagrant up

dev-clean:
	vagrant destroy -f
	vagrant up

dev-ssh:
	vagrant ssh
```

### Tool Integration

#### Docker Integration

- **Purpose**: Use Docker as Vagrant provider for containerized environments
- **Setup**: Install Docker provider plugin
- **Usage**: Faster startup times with container-based development environments

```bash
vagrant plugin install vagrant-docker-compose
```

#### Ansible Integration

- **Purpose**: Advanced configuration management with Ansible playbooks
- **Setup**: Configure Ansible provisioner in Vagrantfile
- **Usage**: Complex multi-service environment automation

```ruby
config.vm.provision "ansible" do |ansible|
  ansible.playbook = "provision/site.yml"
  ansible.inventory_path = "provision/inventory"
end
```

## Best Practices

### Configuration Best Practices

- Use specific box versions to ensure environment consistency across team members
- Configure adequate memory and CPU resources based on development requirements
- Use relative paths for shared folders to maintain portability across operating systems
- Implement proper provisioning idempotency to allow multiple provision runs safely

### Usage Patterns

- **Development Pattern**: Single-machine environments with shared folders for active development
- **Testing Pattern**: Multi-machine environments simulating production architectures
- **Learning Pattern**: Disposable environments for experimenting with new technologies safely

### Performance Optimization

- Enable VirtualBox guest additions for improved shared folder performance
- Use NFS or rsync for faster file synchronization on macOS and Linux
- Allocate appropriate resources based on host machine capabilities and concurrent usage
- Use linked clones to reduce disk space usage for multiple similar environments

## Common Use Cases

### Full-Stack Development Environment

**Scenario**: Set up complete development environment with web server, database, and caching layer
**Implementation**:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  config.vm.provision "shell", inline: <<-SHELL
    # Node.js and npm
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    apt-get install -y nodejs

    # PostgreSQL
    apt-get install -y postgresql postgresql-contrib
    sudo -u postgres createuser -s vagrant

    # Redis
    apt-get install -y redis-server
    systemctl start redis-server
  SHELL
end
```

**Expected Result**: Isolated development environment accessible on host machine ports

### Microservices Testing Environment

**Scenario**: Create multi-service environment for integration testing
**Implementation**:

```ruby
(1..3).each do |i|
  config.vm.define "service#{i}" do |node|
    node.vm.box = "ubuntu/focal64"
    node.vm.network "private_network", ip: "192.168.56.#{10+i}"
    node.vm.provision "shell", path: "scripts/service#{i}.sh"
  end
end
```

**Expected Result**: Network of interconnected VMs simulating distributed service architecture

### Legacy System Reproduction

**Scenario**: Reproduce specific legacy environment for maintenance and testing
**Implementation**:

```ruby
config.vm.box = "centos/7"
config.vm.provision "shell", inline: <<-SHELL
  yum install -y java-1.8.0-openjdk
  yum install -y tomcat
  # Configure specific versions matching production
SHELL
```

**Expected Result**: Exact replica of legacy production environment for safe testing

## Troubleshooting

### Common Issues

#### VirtualBox Guest Additions Mismatch

**Problem**: Shared folders not working or slow performance
**Symptoms**: Mount errors, file sync issues, poor I/O performance
**Solution**: Install vagrant-vbguest plugin for automatic guest additions management

```bash
vagrant plugin install vagrant-vbguest
vagrant reload
```

#### Network Connectivity Issues

**Problem**: Cannot access forwarded ports or private networks
**Symptoms**: Connection refused errors, network timeouts
**Solution**: Check firewall settings and port conflicts

```bash
# Check port usage
netstat -tulpn | grep :3000

# Test connectivity
telnet localhost 3000
```

#### Provisioning Failures

**Problem**: Provisioning scripts fail during vagrant up
**Symptoms**: Error messages during provision phase, incomplete environment setup
**Solution**: Run provisioning separately and check logs

```bash
vagrant provision --debug
vagrant ssh
# Manual verification inside VM
```

### Debug Mode

```bash
# Enable verbose output
vagrant up --debug
vagrant provision --debug

# Check VM status
vagrant status
vagrant global-status

# SSH debugging
vagrant ssh-config
```

## 📊 Enterprise Monitoring & Observability Framework

### Prometheus Monitoring Integration

```ruby
# lib/monitoring_provider.rb - Enterprise monitoring configuration
class MonitoringProvider
  def self.configure(config, vm, environment)
    vm.vm.provision "shell", inline: <<-SCRIPT
      # Install Prometheus Node Exporter
      wget -q https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
      tar xvfz node_exporter-1.6.1.linux-amd64.tar.gz
      sudo cp node_exporter-1.6.1.linux-amd64/node_exporter /usr/local/bin/
      sudo useradd --no-create-home --shell /bin/false node_exporter

      # Create systemd service for Node Exporter
      sudo tee /etc/systemd/system/node_exporter.service > /dev/null << 'EOF'
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter \
  --web.listen-address=0.0.0.0:9100 \
  --collector.systemd \
  --collector.processes

[Install]
WantedBy=multi-user.target
EOF

      sudo systemctl daemon-reload
      sudo systemctl enable node_exporter
      sudo systemctl start node_exporter

      # Configure Prometheus server if this is the monitoring node
      if [ "#{environment.role}" = "monitoring" ]; then
        wget -q https://github.com/prometheus/prometheus/releases/download/v2.45.0/prometheus-2.45.0.linux-amd64.tar.gz
        tar xvfz prometheus-2.45.0.linux-amd64.tar.gz
        sudo cp prometheus-2.45.0.linux-amd64/prometheus /usr/local/bin/
        sudo cp prometheus-2.45.0.linux-amd64/promtool /usr/local/bin/
        sudo useradd --no-create-home --shell /bin/false prometheus
        sudo mkdir -p /etc/prometheus/{rules,targets} /var/lib/prometheus
        sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus

        # Dynamic Prometheus configuration
        sudo tee /etc/prometheus/prometheus.yml > /dev/null << 'PROM_EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s
  external_labels:
    environment: '#{environment.name}'
    cluster: 'vagrant-enterprise'

rule_files:
  - "/etc/prometheus/rules/*.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets: ['localhost:9093']

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets:
PROM_EOF

        # Add all environment nodes to monitoring
        echo "#{config.environments.map { |env| env.nodes.map { |node| "        - '#{node.name}:9100'" } }.flatten.join("\n")}" | sudo tee -a /etc/prometheus/prometheus.yml

        sudo tee -a /etc/prometheus/prometheus.yml > /dev/null << 'PROM_EOF'

  - job_name: 'application-metrics'
    metrics_path: /metrics
    static_configs:
      - targets:
        - 'web01:8080'
        - 'app01:8080'
        - 'api01:8080'

  - job_name: 'database-metrics'
    static_configs:
      - targets:
        - 'db01:9187'  # PostgreSQL exporter
        - 'db01:9104'  # MySQL exporter
PROM_EOF

        # Create enterprise alerting rules
        sudo tee /etc/prometheus/rules/vagrant-alerts.yml > /dev/null << 'ALERT_EOF'
groups:
  - name: vagrant-infrastructure
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Instance {{ \$labels.instance }} down"
          description: "{{ \$labels.instance }} has been down for more than 1 minute."

      - alert: HighCPUUsage
        expr: 100 - (avg by(instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage on {{ \$labels.instance }}"
          description: "CPU usage is above 80% for more than 5 minutes."

      - alert: HighMemoryUsage
        expr: (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100 > 90
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: "High memory usage on {{ \$labels.instance }}"
          description: "Memory usage is above 90% for more than 2 minutes."

      - alert: DiskSpaceLow
        expr: 100 - ((node_filesystem_avail_bytes{mountpoint="/"} * 100) / node_filesystem_size_bytes{mountpoint="/"}) > 85
        for: 1m
        labels:
          severity: warning
        annotations:
          summary: "Low disk space on {{ \$labels.instance }}"
          description: "Disk usage is above 85% on root filesystem."
ALERT_EOF

        # Create Prometheus systemd service
        sudo tee /etc/systemd/system/prometheus.service > /dev/null << 'SERVICE_EOF'
[Unit]
Description=Prometheus Server
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
Restart=on-failure
ExecStart=/usr/local/bin/prometheus \
  --config.file /etc/prometheus/prometheus.yml \
  --storage.tsdb.path /var/lib/prometheus/ \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.enable-lifecycle \
  --web.enable-admin-api

[Install]
WantedBy=multi-user.target
SERVICE_EOF

        sudo systemctl daemon-reload
        sudo systemctl enable prometheus
        sudo systemctl start prometheus

        echo "Prometheus server started on port 9090"
      fi
    SCRIPT
  end
end
```

### Grafana Dashboard Automation

```yaml
# provisioning/grafana-setup.yml - Automated Grafana deployment
---
- name: Deploy Enterprise Grafana Stack
  hosts: monitoring
  become: true
  vars:
    grafana_version: '10.0.0'
    grafana_admin_password: '{{ vault_grafana_password }}'

  tasks:
    - name: Add Grafana APT repository
      apt_repository:
        repo: 'deb https://packages.grafana.com/oss/deb stable main'
        key_url: 'https://packages.grafana.com/gpg.key'

    - name: Install Grafana Enterprise
      apt:
        name: 'grafana={{ grafana_version }}'
        state: present
        update_cache: true

    - name: Configure Grafana
      template:
        src: templates/grafana.ini.j2
        dest: /etc/grafana/grafana.ini
        backup: true
      notify: restart grafana

    - name: Start and enable Grafana
      systemd:
        name: grafana-server
        state: started
        enabled: true

    - name: Wait for Grafana to start
      wait_for:
        port: 3000
        delay: 10

    - name: Configure Prometheus data source
      uri:
        url: 'http://localhost:3000/api/datasources'
        method: POST
        headers:
          Authorization: "Basic {{ ('admin:' + grafana_admin_password) | b64encode }}"
          Content-Type: 'application/json'
        body_format: json
        body:
          name: 'Vagrant Prometheus'
          type: 'prometheus'
          url: 'http://localhost:9090'
          access: 'proxy'
          isDefault: true
          jsonData:
            timeInterval: '15s'
            queryTimeout: '60s'
        status_code: [200, 409]

    - name: Import Vagrant infrastructure dashboard
      uri:
        url: 'http://localhost:3000/api/dashboards/db'
        method: POST
        headers:
          Authorization: "Basic {{ ('admin:' + grafana_admin_password) | b64encode }}"
          Content-Type: 'application/json'
        body_format: json
        body:
          dashboard:
            id: null
            title: 'Vagrant Enterprise Infrastructure'
            tags: ['vagrant', 'infrastructure', 'enterprise']
            timezone: 'browser'
            refresh: '30s'
            panels:
              - id: 1
                title: 'Infrastructure Overview'
                type: 'stat'
                targets:
                  - expr: 'count(up == 1)'
                    legendFormat: 'Online Instances'
                  - expr: 'count(up == 0)'
                    legendFormat: 'Offline Instances'
                gridPos: { h: 4, w: 6, x: 0, y: 0 }
                fieldConfig:
                  defaults:
                    color:
                      mode: 'thresholds'
                    thresholds:
                      steps:
                        - color: 'red'
                          value: 0
                        - color: 'green'
                          value: 1

              - id: 2
                title: 'CPU Usage by Instance'
                type: 'timeseries'
                targets:
                  - expr: '100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)'
                    legendFormat: '{{ instance }}'
                gridPos: { h: 8, w: 12, x: 0, y: 4 }
                fieldConfig:
                  defaults:
                    unit: 'percent'
                    max: 100
                    min: 0

              - id: 3
                title: 'Memory Usage'
                type: 'timeseries'
                targets:
                  - expr: '(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100'
                    legendFormat: '{{ instance }}'
                gridPos: { h: 8, w: 12, x: 12, y: 4 }

              - id: 4
                title: 'Network Traffic'
                type: 'timeseries'
                targets:
                  - expr: 'irate(node_network_receive_bytes_total{device!="lo"}[5m])'
                    legendFormat: '{{ instance }} - {{ device }} RX'
                  - expr: 'irate(node_network_transmit_bytes_total{device!="lo"}[5m])'
                    legendFormat: '{{ instance }} - {{ device }} TX'
                gridPos: { h: 8, w: 24, x: 0, y: 12 }

              - id: 5
                title: 'Disk Usage'
                type: 'bargauge'
                targets:
                  - expr: '100 - ((node_filesystem_avail_bytes{mountpoint="/"} * 100) / node_filesystem_size_bytes{mountpoint="/"})'
                    legendFormat: '{{ instance }}'
                gridPos: { h: 8, w: 12, x: 0, y: 20 }

              - id: 6
                title: 'Active Alerts'
                type: 'table'
                targets:
                  - expr: 'ALERTS{alertstate="firing"}'
                    format: 'table'
                gridPos: { h: 8, w: 12, x: 12, y: 20 }
            time:
              from: 'now-1h'
              to: 'now'
          overwrite: true
        status_code: [200, 412]

  handlers:
    - name: restart grafana
      systemd:
        name: grafana-server
        state: restarted
```

### Centralized Logging with ELK Stack

```bash
#!/bin/bash
# scripts/setup-logging-stack.sh - Enterprise ELK stack deployment

set -euo pipefail

ELASTIC_VERSION="8.8.0"
ENVIRONMENT="${1:-development}"
LOG_RETENTION_DAYS="${2:-30}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a /var/log/elk-setup.log
}

log "Starting ELK stack deployment for $ENVIRONMENT environment..."

# Install Java (required for Elasticsearch)
log "Installing Java runtime..."
apt-get update -q
apt-get install -y openjdk-11-jdk

# Add Elastic repository
log "Adding Elastic repository..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
apt-get update -q

# Install Elasticsearch
log "Installing Elasticsearch $ELASTIC_VERSION..."
apt-get install -y elasticsearch=$ELASTIC_VERSION

# Configure Elasticsearch for Vagrant environment
log "Configuring Elasticsearch..."
cat > /etc/elasticsearch/elasticsearch.yml << EOF
# Vagrant Enterprise Elasticsearch Configuration
cluster.name: vagrant-${ENVIRONMENT}-logs
node.name: \${HOSTNAME}
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch

# Network configuration
network.host: 0.0.0.0
http.port: 9200
discovery.type: single-node

# Security configuration
xpack.security.enabled: false
xpack.security.http.ssl.enabled: false
xpack.security.transport.ssl.enabled: false

# Performance tuning
bootstrap.memory_lock: true

# Index lifecycle management
action.destructive_requires_name: true
indices.lifecycle.history_index_enabled: true
EOF

# Set heap size based on available memory
MEMORY_GB=$(free -g | awk '/^Mem:/{print int($2/2)}')
if [ $MEMORY_GB -gt 4 ]; then
    HEAP_SIZE="4g"
elif [ $MEMORY_GB -gt 2 ]; then
    HEAP_SIZE="${MEMORY_GB}g"
else
    HEAP_SIZE="1g"
fi

sed -i "s/#-Xms1g/-Xms$HEAP_SIZE/" /etc/elasticsearch/jvm.options
sed -i "s/#-Xmx1g/-Xmx$HEAP_SIZE/" /etc/elasticsearch/jvm.options

systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch

# Wait for Elasticsearch to be ready
log "Waiting for Elasticsearch to be ready..."
until curl -s -f http://localhost:9200/_cluster/health; do
    sleep 5
done

# Install Logstash
log "Installing Logstash..."
apt-get install -y logstash=$ELASTIC_VERSION

# Configure Logstash pipeline
log "Configuring Logstash pipeline..."
mkdir -p /etc/logstash/conf.d

cat > /etc/logstash/conf.d/vagrant-pipeline.conf << EOF
input {
  beats {
    port => 5044
  }

  file {
    path => "/vagrant/logs/*.log"
    start_position => "beginning"
    tags => ["vagrant", "application"]
  }

  syslog {
    port => 514
    tags => ["syslog", "system"]
  }
}

filter {
  # Add environment metadata
  mutate {
    add_field => {
      "environment" => "$ENVIRONMENT"
      "infrastructure" => "vagrant"
    }
  }

  # Parse different log types
  if "application" in [tags] {
    if [message] =~ /^\{.*\}$/ {
      json {
        source => "message"
      }
    } else {
      grok {
        match => {
          "message" => "%{TIMESTAMP_ISO8601:timestamp} %{LOGLEVEL:log_level} %{GREEDYDATA:log_message}"
        }
      }
    }

    if [timestamp] {
      date {
        match => [ "timestamp", "ISO8601" ]
      }
    }
  }

  if "syslog" in [tags] {
    grok {
      match => {
        "message" => "%{SYSLOGTIMESTAMP:timestamp} %{IPORHOST:host} %{DATA:program}(?:\\[%{POSINT:pid}\\])?: %{GREEDYDATA:log_message}"
      }
    }
  }

  # Parse web access logs
  if [fields][log_type] == "access" {
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }

    if [timestamp] {
      date {
        match => [ "timestamp", "dd/MMM/yyyy:HH:mm:ss Z" ]
      }
    }
  }

  # GeoIP enrichment for web logs
  if [clientip] {
    geoip {
      source => "clientip"
    }
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "vagrant-%{environment}-%{+YYYY.MM.dd}"

    # Apply index template
    template_name => "vagrant-logs"
    template => "/etc/logstash/templates/vagrant-template.json"
    template_overwrite => true
  }

  # Debug output in development
  if "${ENVIRONMENT}" == "development" {
    stdout {
      codec => rubydebug
    }
  }
}
EOF

# Create index template
mkdir -p /etc/logstash/templates
cat > /etc/logstash/templates/vagrant-template.json << EOF
{
  "index_patterns": ["vagrant-*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0,
    "index.lifecycle.name": "vagrant-logs-policy",
    "index.lifecycle.rollover_alias": "vagrant-logs",
    "index.refresh_interval": "10s"
  },
  "mappings": {
    "properties": {
      "@timestamp": {
        "type": "date"
      },
      "message": {
        "type": "text",
        "analyzer": "standard"
      },
      "environment": {
        "type": "keyword"
      },
      "infrastructure": {
        "type": "keyword"
      },
      "host": {
        "properties": {
          "name": {
            "type": "keyword"
          }
        }
      },
      "log_level": {
        "type": "keyword"
      },
      "application": {
        "type": "keyword"
      },
      "clientip": {
        "type": "ip"
      },
      "geoip": {
        "properties": {
          "location": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}
EOF

systemctl enable logstash
systemctl start logstash

# Install Kibana
log "Installing Kibana..."
apt-get install -y kibana=$ELASTIC_VERSION

# Configure Kibana
cat > /etc/kibana/kibana.yml << EOF
# Vagrant Enterprise Kibana Configuration
server.port: 5601
server.host: "0.0.0.0"
server.name: "vagrant-kibana-${ENVIRONMENT}"
elasticsearch.hosts: ["http://localhost:9200"]

# Logging
logging.appenders.file.type: file
logging.appenders.file.fileName: /var/log/kibana/kibana.log
logging.appenders.file.layout.type: json
logging.root.appenders: [default, file]
logging.root.level: info

# Security
server.publicBaseUrl: "http://kibana.vagrant.local:5601"
EOF

systemctl enable kibana
systemctl start kibana

# Install and configure Filebeat
log "Installing Filebeat for log shipping..."
apt-get install -y filebeat=$ELASTIC_VERSION

cat > /etc/filebeat/filebeat.yml << EOF
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
    - /var/log/syslog
    - /var/log/auth.log
    - /vagrant/logs/*.log
    - /opt/*/logs/*.log
  fields:
    log_type: system
    environment: $ENVIRONMENT
    infrastructure: vagrant
  fields_under_root: true
  multiline.pattern: '^\\d{4}-\\d{2}-\\d{2}'
  multiline.negate: true
  multiline.match: after

- type: log
  enabled: true
  paths:
    - /var/log/apache2/access.log
    - /var/log/nginx/access.log
  fields:
    log_type: access
    environment: $ENVIRONMENT
  fields_under_root: true

- type: log
  enabled: true
  paths:
    - /var/log/apache2/error.log
    - /var/log/nginx/error.log
  fields:
    log_type: error
    environment: $ENVIRONMENT
  fields_under_root: true

output.logstash:
  hosts: ["localhost:5044"]

processors:
- add_host_metadata:
    when.not.contains.tags: forwarded
- add_docker_metadata: ~

logging.level: info
logging.to_files: true
logging.files:
  path: /var/log/filebeat
  name: filebeat
  keepfiles: 7
  permissions: 0640

# ILM policy
setup.ilm.enabled: true
setup.ilm.rollover_alias: "vagrant-logs"
setup.ilm.pattern: "{now/d}-000001"
setup.ilm.policy: "vagrant-logs-policy"
EOF

systemctl enable filebeat
systemctl start filebeat

log "ELK stack deployment completed successfully!"
log "Services accessible at:"
log "  - Elasticsearch: http://localhost:9200"
log "  - Kibana: http://localhost:5601"
log "  - Logstash: localhost:5044 (Beats input)"
```

### Jenkins Pipeline Automation

```groovy
// Jenkinsfile - Enterprise Vagrant Pipeline
pipeline {
    agent {
        label 'vagrant-capable'
    }

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['development', 'staging', 'production'],
            description: 'Target environment for deployment'
        )
        choice(
            name: 'COMPLIANCE_FRAMEWORK',
            choices: ['SOC2', 'PCI-DSS', 'HIPAA', 'CIS', 'NIST'],
            description: 'Compliance framework to validate against'
        )
        booleanParam(
            name: 'DESTROY_EXISTING',
            defaultValue: false,
            description: 'Destroy existing infrastructure before provisioning'
        )
        booleanParam(
            name: 'SKIP_TESTS',
            defaultValue: false,
            description: 'Skip integration and compliance tests'
        )
    }

    environment {
        VAGRANT_ENV = "${params.ENVIRONMENT}"
        COMPLIANCE_FRAMEWORK = "${params.COMPLIANCE_FRAMEWORK}"
        VAULT_TOKEN = credentials('vault-token')
        AWS_CREDENTIALS = credentials('aws-credentials')
    }

    stages {
        stage('Preparation') {
            steps {
                script {
                    echo "Starting Vagrant deployment for ${params.ENVIRONMENT} environment"
                    sh '''
                        # Verify prerequisites
                        vagrant --version
                        VBoxManage --version || echo "VirtualBox not available"
                        docker --version || echo "Docker not available"
                        ansible --version

                        # Clean workspace
                        rm -rf .vagrant/
                        vagrant global-status --prune
                    '''
                }
            }
        }

        stage('Configuration Validation') {
            parallel {
                stage('Syntax Validation') {
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Validate Vagrantfile syntax
                                ruby -c Vagrantfile
                                echo "Vagrantfile syntax: PASSED"

                                # Validate YAML configurations
                                yamllint config/enterprise.yml
                                echo "YAML validation: PASSED"

                                # Validate Ansible playbooks
                                find provisioning/playbooks -name "*.yml" -exec ansible-playbook --syntax-check {} \\;
                                echo "Ansible syntax validation: PASSED"
                            '''
                        }
                    }
                }

                stage('Security Scanning') {
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Infrastructure as Code security scanning
                                checkov -f Vagrantfile --framework vagrant --output cli

                                # Shell script security analysis
                                find scripts -name "*.sh" -exec shellcheck {} \\;

                                # Ansible security linting
                                ansible-lint provisioning/playbooks/ || true

                                # Secret detection
                                trufflehog --regex --entropy=False .
                            '''
                        }
                    }
                }
            }
        }

        stage('Infrastructure Destroy') {
            when {
                equals expected: true, actual: params.DESTROY_EXISTING
            }
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        echo "Destroying existing infrastructure..."
                        vagrant destroy -f --parallel || true

                        # Clean up any orphaned resources
                        VBoxManage list runningvms | grep -E "vagrant-enterprise" | cut -d'"' -f2 | xargs -I {} VBoxManage controlvm {} poweroff || true
                        VBoxManage list vms | grep -E "vagrant-enterprise" | cut -d'"' -f2 | xargs -I {} VBoxManage unregistervm {} --delete || true
                    '''
                }
            }
        }

        stage('Infrastructure Provisioning') {
            steps {
                script {
                    timeout(time: 45, unit: 'MINUTES') {
                        sh '''
                            cd vagrant-enterprise

                            # Set environment variables
                            export VAGRANT_ENVIRONMENT=${VAGRANT_ENV}
                            export COMPLIANCE_FRAMEWORK=${COMPLIANCE_FRAMEWORK}
                            export ANSIBLE_HOST_KEY_CHECKING=False

                            # Provision infrastructure with detailed logging
                            vagrant up --provision --parallel --debug 2>&1 | tee vagrant-deployment.log

                            # Verify all VMs are running
                            vagrant status | grep "running" | wc -l > vm_count.txt
                            RUNNING_VMS=$(cat vm_count.txt)
                            echo "Running VMs: $RUNNING_VMS"

                            if [ "$RUNNING_VMS" -eq 0 ]; then
                                echo "ERROR: No VMs are running"
                                exit 1
                            fi
                        '''
                    }
                }
            }
        }

        stage('Health Checks') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Wait for services to be ready
                        echo "Waiting for services to initialize..."
                        sleep 60

                        # Check VM accessibility
                        vagrant ssh-config > ssh_config

                        # Test SSH connectivity to all VMs
                        for vm in $(vagrant status | grep "running" | awk '{print $1}'); do
                            echo "Testing SSH to $vm..."
                            vagrant ssh $vm -c "uptime" || exit 1
                        done

                        # Check network connectivity
                        vagrant ssh monitoring -c "curl -f http://web01:80" || echo "Warning: Web service not yet ready"
                    '''
                }
            }
        }

        stage('Compliance Validation') {
            when {
                not { equals expected: true, actual: params.SKIP_TESTS }
            }
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Run compliance validation playbook
                        ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \\
                            provisioning/compliance-validation.yml \\
                            --extra-vars "compliance_framework=${COMPLIANCE_FRAMEWORK}" \\
                            --extra-vars "environment=${VAGRANT_ENV}"

                        # Generate compliance report
                        python3 scripts/generate_compliance_report.py \\
                            --environment=${VAGRANT_ENV} \\
                            --framework=${COMPLIANCE_FRAMEWORK} \\
                            --output=reports/compliance-${BUILD_NUMBER}.json
                    '''
                }
            }
        }

        stage('Integration Testing') {
            parallel {
                stage('Service Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Service availability tests
                                python3 -m pytest tests/integration/test_services.py \\
                                    --environment=${VAGRANT_ENV} \\
                                    --junitxml=reports/service-tests.xml \\
                                    --verbose
                            '''
                        }
                    }
                }

                stage('Security Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Security validation tests
                                python3 -m pytest tests/security/ \\
                                    --environment=${VAGRANT_ENV} \\
                                    --compliance=${COMPLIANCE_FRAMEWORK} \\
                                    --junitxml=reports/security-tests.xml
                            '''
                        }
                    }
                }

                stage('Performance Tests') {
                    when {
                        not { equals expected: true, actual: params.SKIP_TESTS }
                    }
                    steps {
                        script {
                            sh '''
                                cd vagrant-enterprise

                                # Performance benchmarks
                                python3 tests/performance/benchmark_suite.py \\
                                    --environment=${VAGRANT_ENV} \\
                                    --output=reports/performance-${BUILD_NUMBER}.json
                            '''
                        }
                    }
                }
            }
        }

        stage('Monitoring Setup') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Deploy monitoring stack
                        ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory \\
                            provisioning/monitoring-stack.yml

                        # Wait for monitoring services
                        sleep 30

                        # Verify monitoring endpoints
                        vagrant ssh monitoring -c "curl -f http://localhost:9090/api/v1/status/config" || echo "Prometheus not ready"
                        vagrant ssh monitoring -c "curl -f http://localhost:3000/api/health" || echo "Grafana not ready"

                        # Import dashboards
                        python3 scripts/import_dashboards.py --environment=${VAGRANT_ENV}
                    '''
                }
            }
        }

        stage('Documentation Generation') {
            steps {
                script {
                    sh '''
                        cd vagrant-enterprise

                        # Generate environment documentation
                        python3 scripts/generate_documentation.py \\
                            --environment=${VAGRANT_ENV} \\
                            --compliance=${COMPLIANCE_FRAMEWORK} \\
                            --output=docs/environment-${BUILD_NUMBER}.md

                        # Generate architecture diagrams
                        python3 scripts/generate_diagrams.py \\
                            --environment=${VAGRANT_ENV} \\
                            --output=docs/diagrams/

                        # Create infrastructure inventory
                        vagrant status --machine-readable > reports/infrastructure-inventory.json
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                // Archive artifacts
                archiveArtifacts artifacts: 'vagrant-enterprise/reports/**/*', fingerprint: true
                archiveArtifacts artifacts: 'vagrant-enterprise/docs/**/*', fingerprint: true
                archiveArtifacts artifacts: 'vagrant-enterprise/vagrant-deployment.log', fingerprint: true

                // Publish test results
                publishTestResults testResultsPattern: 'vagrant-enterprise/reports/*-tests.xml'

                // Publish HTML reports
                publishHTML([
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'vagrant-enterprise/reports',
                    reportFiles: '*.html',
                    reportName: 'Infrastructure Report'
                ])
            }
        }

        success {
            script {
                emailext (
                    subject: "✅ Vagrant Infrastructure Success - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """
                    <h2>Vagrant Infrastructure Deployment Successful</h2>
                    <p><strong>Environment:</strong> ${params.ENVIRONMENT}</p>
                    <p><strong>Compliance Framework:</strong> ${params.COMPLIANCE_FRAMEWORK}</p>
                    <p><strong>Build:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>

                    <h3>Access URLs:</h3>
                    <ul>
                        <li><a href="http://monitoring.vagrant.local:3000">Grafana Dashboard</a></li>
                        <li><a href="http://monitoring.vagrant.local:9090">Prometheus</a></li>
                        <li><a href="http://monitoring.vagrant.local:5601">Kibana Logs</a></li>
                    </ul>

                    <p>Infrastructure is ready for use.</p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.CHANGE_AUTHOR_EMAIL},devops@enterprise.local"
                )
            }
        }

        failure {
            script {
                // Collect debug information
                sh '''
                    cd vagrant-enterprise || exit 0

                    # Collect VM states
                    vagrant status > debug/vm-status.txt || true
                    vagrant global-status > debug/global-status.txt || true

                    # Collect system logs
                    journalctl -u vagrant-* > debug/systemd-logs.txt || true

                    # Collect Vagrant logs
                    cp .vagrant/logs/* debug/ 2>/dev/null || true
                '''

                emailext (
                    subject: "❌ Vagrant Infrastructure Failed - ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                    body: """
                    <h2>Vagrant Infrastructure Deployment Failed</h2>
                    <p><strong>Environment:</strong> ${params.ENVIRONMENT}</p>
                    <p><strong>Compliance Framework:</strong> ${params.COMPLIANCE_FRAMEWORK}</p>
                    <p><strong>Build:</strong> ${env.BUILD_NUMBER}</p>
                    <p><strong>Duration:</strong> ${currentBuild.durationString}</p>

                    <p>Please check the console output and debug artifacts for details.</p>
                    <p><a href="${env.BUILD_URL}">View Build</a></p>
                    """,
                    mimeType: 'text/html',
                    to: "${env.CHANGE_AUTHOR_EMAIL},devops@enterprise.local",
                    attachLog: true
                )
            }
        }

        cleanup {
            script {
                if (params.ENVIRONMENT == 'development') {
                    sh '''
                        cd vagrant-enterprise || exit 0
                        # Keep development environments running
                        echo "Development environment preserved"
                    '''
                } else {
                    sh '''
                        cd vagrant-enterprise || exit 0
                        # Clean up non-development environments
                        vagrant destroy -f --parallel || true
                        vagrant global-status --prune || true
                    '''
                }
            }
        }
    }
}
```

### GitHub Actions Workflow

````yaml
# .github/workflows/vagrant-infrastructure.yml
name: 🏗️ Vagrant Enterprise Infrastructure

on:
  push:
    branches: [main, develop, 'feature/vagrant-*']
    paths: ['vagrant-enterprise/**']
  pull_request:
    branches: [main]
    paths: ['vagrant-enterprise/**']
  schedule:
    - cron: '0 2 * * *' # Daily validation at 2 AM
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        default: 'development'
        type: choice
        options:
          - development
          - staging
          - production
      compliance_framework:
        description: 'Compliance framework'
        required: true
        default: 'SOC2'
        type: choice
        options:
          - SOC2
          - PCI-DSS
          - HIPAA
          - CIS
          - NIST
      destroy_existing:
        description: 'Destroy existing infrastructure'
        required: false
        default: false
        type: boolean

env:
  VAGRANT_ENV: ${{ github.event.inputs.environment || 'development' }}
  COMPLIANCE_FRAMEWORK: ${{ github.event.inputs.compliance_framework || 'SOC2' }}

jobs:
  validate:
    name: 🔍 Validate Configuration
    runs-on: ubuntu-latest
    outputs:
      matrix: ${{ steps.set-matrix.outputs.matrix }}

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v4

      - name: 🔧 Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'

      - name: 🐍 Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: 📦 Install Dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y yamllint shellcheck
          pip install checkov ansible-lint truffleHog pytest

      - name: ✅ Syntax Validation
        run: |
          cd vagrant-enterprise
          ruby -c Vagrantfile
          yamllint config/enterprise.yml
          find provisioning/playbooks -name "*.yml" -exec ansible-lint {} \;

      - name: 🔒 Security Scanning
        run: |
          cd vagrant-enterprise
          checkov -f Vagrantfile --framework vagrant
          find scripts -name "*.sh" -exec shellcheck {} \;
          trufflehog --regex --entropy=False .

      - name: 📋 Set Test Matrix
        id: set-matrix
        run: |
          echo "matrix={\"environment\":[\"development\",\"staging\"],\"compliance\":[\"SOC2\",\"PCI-DSS\"]}" >> $GITHUB_OUTPUT

  security-scan:
    name: 🛡️ Security Analysis
    runs-on: ubuntu-latest
    needs: validate

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v4

      - name: 🔍 Run Trivy Vulnerability Scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: 'vagrant-enterprise/'
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: 📤 Upload Trivy Results
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: 'trivy-results.sarif'

      - name: 🔐 SAST with Semgrep
        uses: returntocorp/semgrep-action@v1
        with:
          config: auto

  provision-test:
    name: 🚀 Provision & Test
    runs-on: ubuntu-latest
    needs: [validate, security-scan]
    if: github.event_name != 'schedule'
    strategy:
      matrix: ${{fromJson(needs.validate.outputs.matrix)}}
      fail-fast: false

    env:
      TEST_ENVIRONMENT: ${{ matrix.environment }}
      TEST_COMPLIANCE: ${{ matrix.compliance }}

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v4

      - name: 💾 Free Disk Space
        uses: jlumbroso/free-disk-space@main
        with:
          tool-cache: false
          android: true
          dotnet: true
          haskell: true
          large-packages: true
          swap-storage: true

      - name: ⚡ Enable KVM
        run: |
          echo 'KERNEL=="kvm", GROUP="kvm", MODE="0666", OPTIONS+="static_node=kvm"' | sudo tee /etc/udev/rules.d/99-kvm4all.rules
          sudo udevadm control --reload-rules
          sudo udevadm trigger --name-match=kvm

      - name: 📦 Setup Vagrant with VirtualBox
        run: |
          # Install VirtualBox
          sudo apt-get update
          sudo apt-get install -y virtualbox virtualbox-ext-pack

          # Install Vagrant
          wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
          echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
          sudo apt-get update
          sudo apt-get install -y vagrant

          # Install required plugins
          vagrant plugin install vagrant-vbguest
          vagrant plugin install vagrant-hostmanager

      - name: 🔧 Configure Environment
        run: |
          cd vagrant-enterprise

          # Create lightweight test configuration
          cp config/environments/ci-test.yml config/enterprise.yml

          # Set resource limits for CI
          export VAGRANT_MEMORY="512"
          export VAGRANT_CPUS="1"
          export VAGRANT_DISK="10"

      - name: 🏗️ Provision Infrastructure
        timeout-minutes: 30
        run: |
          cd vagrant-enterprise

          export VAGRANT_ENVIRONMENT=$TEST_ENVIRONMENT
          export COMPLIANCE_FRAMEWORK=$TEST_COMPLIANCE

          # Use minimal configuration for CI
          vagrant up --provider virtualbox --provision

      - name: 🧪 Run Integration Tests
        run: |
          cd vagrant-enterprise

          # Install test dependencies
          pip install -r tests/requirements.txt

          # Run test suite
          python -m pytest tests/integration/ \
            --environment=$TEST_ENVIRONMENT \
            --compliance=$TEST_COMPLIANCE \
            --junitxml=test-results.xml \
            --verbose

      - name: 📊 Collect Metrics
        if: always()
        run: |
          cd vagrant-enterprise

          # Collect VM metrics
          vagrant ssh -c "free -h && df -h && uptime" || true

          # Generate test report
          python scripts/generate_test_report.py \
            --environment=$TEST_ENVIRONMENT \
            --output=test-report.html

      - name: 📤 Upload Test Results
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: test-results-${{ matrix.environment }}-${{ matrix.compliance }}
          path: |
            vagrant-enterprise/test-results.xml
            vagrant-enterprise/test-report.html
            vagrant-enterprise/logs/

      - name: 🧹 Cleanup
        if: always()
        run: |
          cd vagrant-enterprise
          vagrant destroy -f || true
          vagrant global-status --prune || true

  compliance-audit:
    name: 🔒 Compliance Audit
    runs-on: ubuntu-latest
    needs: validate
    if: github.event_name == 'schedule' || github.event.inputs.compliance_framework != ''

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v4

      - name: 🐍 Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: 📦 Install Compliance Tools
        run: |
          pip install compliance-checker ansible-lint
          sudo apt-get install -y lynis

      - name: 🔍 Run Compliance Validation
        run: |
          cd vagrant-enterprise

          # Run compliance checks
          python scripts/compliance_validator.py \
            --framework=$COMPLIANCE_FRAMEWORK \
            --output=compliance-report.json

          # Security hardening validation
          ansible-playbook provisioning/compliance-validation.yml \
            --check --diff

      - name: 📊 Generate Compliance Report
        run: |
          cd vagrant-enterprise

          python scripts/generate_compliance_dashboard.py \
            --input=compliance-report.json \
            --output=compliance-dashboard.html

      - name: 📤 Upload Compliance Results
        uses: actions/upload-artifact@v3
        with:
          name: compliance-report-${{ env.COMPLIANCE_FRAMEWORK }}
          path: |
            vagrant-enterprise/compliance-report.json
            vagrant-enterprise/compliance-dashboard.html

  deploy:
    name: 🚀 Deploy to Environment
    runs-on: ubuntu-latest
    needs: [provision-test, compliance-audit]
    if: github.ref == 'refs/heads/main' && github.event_name != 'schedule'
    environment:
      name: ${{ github.event.inputs.environment || 'staging' }}
      url: http://monitoring.vagrant.local:3000

    steps:
      - name: 📥 Checkout Repository
        uses: actions/checkout@v4

      - name: 🔧 Deploy Infrastructure
        run: |
          echo "Deploying Vagrant infrastructure to $VAGRANT_ENV environment"
          echo "Compliance framework: $COMPLIANCE_FRAMEWORK"

          # In a real scenario, this would trigger deployment
          # to the target environment (staging/production)

      - name: 📝 Update Documentation
        run: |
          cd vagrant-enterprise

          # Generate deployment documentation
          python scripts/generate_deployment_docs.py \
            --environment=$VAGRANT_ENV \
            --version=${{ github.sha }} \
            --output=docs/deployments/

      - name: 💬 Notify Teams
        uses: 8398a7/action-slack@v3
        if: always()
        with:
          status: ${{ job.status }}
          channel: '#devops'
          text: |
            Vagrant Infrastructure Deployment: ${{ job.status }}
            Environment: ${{ env.VAGRANT_ENV }}
            Compliance: ${{ env.COMPLIANCE_FRAMEWORK }}
            Commit: ${{ github.sha }}
        env:
## ⚡ Enterprise Performance Optimization

### Resource Management & Tuning
```ruby
# lib/performance_optimizer.rb - Enterprise performance optimization
class PerformanceOptimizer
  def self.optimize_vm(config, vm, environment, node_config)
    # Dynamic resource allocation based on environment and role
    resources = calculate_optimal_resources(environment.name, node_config.role)

    vm.vm.provider "virtualbox" do |vb|
      # Memory optimization
      vb.memory = resources[:memory]
      vb.cpus = resources[:cpus]

      # Performance tweaks for VirtualBox
      vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
      vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
      vb.customize ["modifyvm", :id, "--largepages", "on"]
      vb.customize ["modifyvm", :id, "--vtxvpid", "on"]
      vb.customize ["modifyvm", :id, "--vtxux", "on"]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--chipset", "ich9"]

      # Disk performance optimization
      vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
      vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
      vb.customize ["storagectl", :id, "--name", "SATA Controller", "--hostiocache", "on"]
      vb.customize ["storagectl", :id, "--name", "SATA Controller", "--bootable", "on"]

      # Graphics and audio optimization
      vb.customize ["modifyvm", :id, "--vram", "128"]
      vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
      vb.customize ["modifyvm", :id, "--audio", "none"]
      vb.customize ["modifyvm", :id, "--usb", "off"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]

      # CPU performance features
      vb.customize ["modifyvm", :id, "--paravirtprovider", "kvm"]
      vb.customize ["modifyvm", :id, "--pae", "on"]
      vb.customize ["modifyvm", :id, "--longmode", "on"]
    end

    vm.vm.provider "vmware_desktop" do |vmw|
      # VMware-specific optimizations
      vmw.vmx["memsize"] = resources[:memory]
      vmw.vmx["numvcpus"] = resources[:cpus]
      vmw.vmx["cpuid.coresPerSocket"] = "2"

      # Performance optimization
      vmw.vmx["ethernet0.virtualDev"] = "vmxnet3"
      vmw.vmx["scsi0.virtualDev"] = "pvscsi"
      vmw.vmx["mainMem.useNamedFile"] = "FALSE"
      vmw.vmx["sched.mem.pshare.enable"] = "FALSE"
      vmw.vmx["prefvmx.useRecommendedLockedMemSize"] = "TRUE"

      # Disable unnecessary features
      vmw.vmx["isolation.tools.unity.disable"] = "TRUE"
      vmw.vmx["unity.allowCompositingInGuest"] = "FALSE"
      vmw.vmx["unity.enableLaunchMenu"] = "FALSE"
      vmw.vmx["unity.showBadges"] = "FALSE"
      vmw.vmx["unity.showBorders"] = "FALSE"
    end

    # Shared folder optimization
    if node_config.volumes&.any?
      vm.vm.synced_folder ".", "/vagrant", disabled: true  # Disable default sync

      node_config.volumes.each do |volume|
        mount_options = determine_optimal_mount_options(volume, environment.name)
        vm.vm.synced_folder volume.host, volume.container, mount_options
      end
    end
  end

  private

  def self.calculate_optimal_resources(environment, role)
    base_resources = {
      development: { memory: 1024, cpus: 1 },
      staging: { memory: 2048, cpus: 2 },
      production: { memory: 4096, cpus: 4 }
    }

    role_multipliers = {
      web: { memory: 1.0, cpus: 1.0 },
      application: { memory: 1.5, cpus: 1.2 },
      database: { memory: 2.0, cpus: 1.5 },
      monitoring: { memory: 1.8, cpus: 1.3 },
      cache: { memory: 1.2, cpus: 0.8 },
      load_balancer: { memory: 0.8, cpus: 1.1 }
    }

    base = base_resources[environment.to_sym] || base_resources[:development]
    multiplier = role_multipliers[role.to_sym] || role_multipliers[:web]

    {
      memory: (base[:memory] * multiplier[:memory]).to_i,
      cpus: [1, (base[:cpus] * multiplier[:cpus]).to_i].max
    }
  end

  def self.determine_optimal_mount_options(volume, environment)
    case environment
    when "development"
      {
        type: "nfs",
        nfs_version: 4,
        nfs_udp: false,
        mount_options: ["rw", "vers=4", "tcp", "fsc", "actimeo=1"]
      }
    when "staging", "production"
      {
        type: "rsync",
        rsync__exclude: [".git/", "node_modules/", "*.log"],
        rsync__auto: true,
        rsync__delay: 1
      }
    else
      { type: "virtualbox" }
    end
  end
end
````

### High-Performance Provisioning Strategies

```bash
#!/bin/bash
# scripts/performance-provisioning.sh - Optimized provisioning for enterprise environments

set -euo pipefail

ENVIRONMENT="${1:-development}"
NODE_ROLE="${2:-web}"
PERFORMANCE_PROFILE="${3:-standard}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [PERF] $*" | tee -a /var/log/performance-optimization.log
}

log "Starting performance optimization for $NODE_ROLE in $ENVIRONMENT environment"

# System performance tuning
optimize_system_performance() {
    log "Applying system performance optimizations..."

    # Kernel parameters for performance
    cat > /etc/sysctl.d/99-performance.conf << EOF
# Network performance
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.core.rmem_default = 262144
net.core.wmem_default = 262144
net.ipv4.tcp_rmem = 4096 65536 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.tcp_congestion_control = bbr
net.core.netdev_max_backlog = 5000

# File system performance
fs.file-max = 2097152
vm.swappiness = 10
vm.dirty_ratio = 15
vm.dirty_background_ratio = 5
vm.vfs_cache_pressure = 50

# Memory management
vm.min_free_kbytes = 65536
kernel.sched_migration_cost_ns = 5000000
kernel.sched_autogroup_enabled = 0
EOF

    sysctl -p /etc/sysctl.d/99-performance.conf

    # I/O scheduler optimization
    echo "mq-deadline" > /sys/block/sda/queue/scheduler 2>/dev/null || echo "deadline" > /sys/block/sda/queue/scheduler

    # CPU frequency scaling
    if [ -f /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor ]; then
        echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    fi
}

# Role-specific optimizations
optimize_for_role() {
    case $NODE_ROLE in
        "web"|"load_balancer")
            log "Applying web server optimizations..."

            # Nginx optimization
            if command -v nginx >/dev/null; then
                cat > /etc/nginx/conf.d/performance.conf << EOF
worker_processes auto;
worker_rlimit_nofile 65535;
worker_connections 4096;
use epoll;
multi_accept on;
sendfile on;
tcp_nopush on;
tcp_nodelay on;
keepalive_timeout 30;
keepalive_requests 1000;
client_max_body_size 50M;
client_body_buffer_size 128k;
client_header_buffer_size 3m;
large_client_header_buffers 4 256k;
gzip on;
gzip_vary on;
gzip_min_length 1024;
gzip_types text/plain text/css text/xml text/javascript application/javascript application/xml+rss application/json;
open_file_cache max=1000 inactive=20s;
open_file_cache_valid 30s;
open_file_cache_min_uses 2;
open_file_cache_errors on;
EOF
            fi

            # Apache optimization
            if command -v apache2 >/dev/null; then
                cat > /etc/apache2/conf-available/performance.conf << EOF
<IfModule mpm_prefork_module>
    StartServers 8
    MinSpareServers 5
    MaxSpareServers 20
    ServerLimit 256
    MaxRequestWorkers 256
    MaxConnectionsPerChild 1000
</IfModule>

<IfModule mpm_worker_module>
    StartServers 4
    MaxRequestWorkers 400
    MinSpareThreads 25
    MaxSpareThreads 75
    ThreadsPerChild 25
    MaxConnectionsPerChild 1000
</IfModule>

<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
    DeflateCompressionLevel 6
</IfModule>

EnableSendfile On
EnableMMAP On
EOF
                a2enconf performance
            fi
            ;;

        "database")
            log "Applying database optimizations..."

            # PostgreSQL optimization
            if command -v psql >/dev/null; then
                MEMORY_MB=$(free -m | awk '/^Mem:/{print $2}')
                SHARED_BUFFERS=$((MEMORY_MB / 4))
                EFFECTIVE_CACHE_SIZE=$((MEMORY_MB * 3 / 4))

                cat >> /etc/postgresql/*/main/postgresql.conf << EOF

# Performance optimizations
shared_buffers = ${SHARED_BUFFERS}MB
effective_cache_size = ${EFFECTIVE_CACHE_SIZE}MB
maintenance_work_mem = 256MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 4MB
min_wal_size = 1GB
max_wal_size = 4GB
max_worker_processes = 8
max_parallel_workers_per_gather = 4
max_parallel_workers = 8
max_parallel_maintenance_workers = 4
EOF
            fi

            # MySQL optimization
            if command -v mysql >/dev/null; then
                cat >> /etc/mysql/mysql.conf.d/performance.cnf << EOF
[mysqld]
innodb_buffer_pool_size = 512M
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 2
innodb_flush_method = O_DIRECT
query_cache_size = 128M
query_cache_type = 1
max_connections = 200
thread_cache_size = 8
table_open_cache = 2048
innodb_buffer_pool_instances = 4
innodb_io_capacity = 2000
innodb_read_io_threads = 4
innodb_write_io_threads = 4
EOF
            fi
            ;;

        "application")
            log "Applying application server optimizations..."

            # Node.js optimization
            if command -v node >/dev/null; then
                cat > /etc/systemd/system/nodejs-app.service.d/performance.conf << EOF
[Service]
Environment=NODE_ENV=production
Environment=UV_THREADPOOL_SIZE=128
Environment=NODE_OPTIONS="--max_old_space_size=2048 --optimize_for_size"
LimitNOFILE=65536
EOF
            fi

            # Java optimization
            if command -v java >/dev/null; then
                JAVA_OPTS="-Xmx1024m -Xms512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+UseStringDeduplication"
                echo "JAVA_OPTS=\"$JAVA_OPTS\"" > /etc/environment
            fi
            ;;

        "monitoring")
            log "Applying monitoring optimizations..."

            # Prometheus optimization
            if [ -d /etc/prometheus ]; then
                cat >> /etc/default/prometheus << EOF
ARGS="--storage.tsdb.retention.time=30d --storage.tsdb.retention.size=10GB --query.max-concurrency=20 --query.timeout=30s --web.max-connections=512"
EOF
            fi
            ;;
    esac
}

# Container optimizations for Docker provider
optimize_container_performance() {
    if command -v docker >/dev/null; then
        log "Applying container performance optimizations..."

        # Docker daemon optimization
        cat > /etc/docker/daemon.json << EOF
{
  "storage-driver": "overlay2",
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  },
  "default-ulimits": {
    "nofile": {
      "hard": 65536,
      "soft": 65536
    }
  },
  "max-concurrent-downloads": 10,
  "max-concurrent-uploads": 5
}
EOF
        systemctl restart docker
    fi
}

# Disk I/O optimization
optimize_disk_io() {
    log "Optimizing disk I/O performance..."

    # Mount options optimization
    if grep -q "/var/log" /proc/mounts; then
        mount -o remount,noatime,nodiratime /var/log || true
    fi

    # Tmpfs for temporary files
    if ! grep -q "tmpfs /tmp" /etc/fstab; then
        echo "tmpfs /tmp tmpfs defaults,noatime,mode=1777,size=512M 0 0" >> /etc/fstab
        mount -a
    fi

    # Readahead optimization
    if [ -b /dev/sda ]; then
        blockdev --setra 4096 /dev/sda
    fi
}

# Network performance optimization
optimize_network() {
    log "Optimizing network performance..."

    # Network interface optimization
    for interface in $(ls /sys/class/net/ | grep -v lo); do
        ethtool -K $interface gso on gro on tso on ufo on 2>/dev/null || true
        ethtool -G $interface rx 4096 tx 4096 2>/dev/null || true
    done

    # IRQ balancing
    if command -v irqbalance >/dev/null; then
        systemctl enable irqbalance
        systemctl start irqbalance
    fi
}

# Memory optimization
optimize_memory() {
    log "Optimizing memory usage..."

    # Huge pages for database workloads
    if [ "$NODE_ROLE" = "database" ]; then
        echo "vm.nr_hugepages = 128" >> /etc/sysctl.d/99-performance.conf
        sysctl -w vm.nr_hugepages=128
    fi

    # Memory compaction
    echo 1 > /proc/sys/vm/compact_memory 2>/dev/null || true

    # Drop caches if memory usage is high
    MEMORY_USAGE=$(free | awk '/^Mem:/{printf "%.0f", $3/$2*100}')
    if [ "$MEMORY_USAGE" -gt 80 ]; then
        log "High memory usage detected ($MEMORY_USAGE%), dropping caches"
        sync && echo 3 > /proc/sys/vm/drop_caches
    fi
}

# Performance monitoring setup
setup_performance_monitoring() {
    log "Setting up performance monitoring..."

    # Install performance monitoring tools
    apt-get update -qq
    apt-get install -y htop iotop iftop nethogs sysstat dstat

    # Setup SAR data collection
    sed -i 's/ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
    systemctl enable sysstat
    systemctl start sysstat

    # Create performance monitoring script
    cat > /usr/local/bin/performance-monitor.sh << 'EOF'
#!/bin/bash
LOGFILE="/var/log/performance-monitor.log"
INTERVAL=60

while true; do
    echo "=== $(date) ===" >> $LOGFILE
    echo "CPU:" >> $LOGFILE
    top -bn1 | head -20 >> $LOGFILE
    echo -e "\nMemory:" >> $LOGFILE
    free -h >> $LOGFILE
    echo -e "\nDisk I/O:" >> $LOGFILE
    iostat -x 1 1 >> $LOGFILE
    echo -e "\nNetwork:" >> $LOGFILE
    ss -tuln >> $LOGFILE
    echo -e "\n" >> $LOGFILE
    sleep $INTERVAL
done
EOF
    chmod +x /usr/local/bin/performance-monitor.sh

    # Create systemd service for performance monitoring
    cat > /etc/systemd/system/performance-monitor.service << EOF
[Unit]
Description=Performance Monitor
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/performance-monitor.sh
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable performance-monitor
    systemctl start performance-monitor
}

# Main optimization workflow
main() {
    case $PERFORMANCE_PROFILE in
        "high")
            optimize_system_performance
            optimize_for_role
            optimize_container_performance
            optimize_disk_io
            optimize_network
            optimize_memory
            setup_performance_monitoring
            ;;
        "standard")
            optimize_system_performance
            optimize_for_role
            optimize_disk_io
            ;;
        "minimal")
            optimize_system_performance
            ;;
        *)
            log "Unknown performance profile: $PERFORMANCE_PROFILE"
            exit 1
            ;;
    esac

    log "Performance optimization completed for $NODE_ROLE in $ENVIRONMENT environment"
}

# Error handling
trap 'log "Performance optimization failed at line $LINENO"' ERR

# Execute main function
main "$@"
```

### Scalability Patterns & Auto-scaling

```ruby
# lib/scalability_manager.rb - Enterprise scalability management
class ScalabilityManager
  def self.configure_auto_scaling(config, environment)
    return unless environment.auto_scaling&.enabled

    scaling_config = environment.auto_scaling

    # Create scaling controller VM
    config.vm.define "scaling-controller" do |controller|
      controller.vm.box = "ubuntu/jammy64"
      controller.vm.hostname = "scaling-controller"
      controller.vm.network "private_network", ip: scaling_config.controller_ip

      controller.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
      end

      # Install scaling infrastructure
      controller.vm.provision "shell", inline: <<-SCRIPT
        # Install Docker and docker-compose
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        usermod -aG docker vagrant

        # Install metrics collection
        docker run -d --name cadvisor \\
          --volume=/:/rootfs:ro \\
          --volume=/var/run:/var/run:rw \\
          --volume=/sys:/sys:ro \\
          --volume=/var/lib/docker/:/var/lib/docker:ro \\
          --publish=8080:8080 \\
          --detach=true \\
          --name=cadvisor \\
          gcr.io/cadvisor/cadvisor:latest

        # Install scaling decision engine
        cat > /usr/local/bin/scaling-engine.py << 'PYTHON_EOF'
#!/usr/bin/env python3
import json
import time
import subprocess
import requests
from datetime import datetime
import yaml

class VagrantScalingEngine:
    def __init__(self, config_file):
        with open(config_file, 'r') as f:
            self.config = yaml.safe_load(f)
        self.metrics_endpoint = self.config['metrics']['endpoint']
        self.scaling_rules = self.config['scaling']['rules']
        self.max_instances = self.config['scaling']['max_instances']
        self.min_instances = self.config['scaling']['min_instances']
        self.cooldown_period = self.config['scaling']['cooldown_seconds']
        self.last_scaling_time = 0

    def get_current_metrics(self):
        try:
            response = requests.get(f"{self.metrics_endpoint}/api/v1/query",
                                  params={'query': 'avg(cpu_usage_percent)'})
            if response.status_code == 200:
                data = response.json()
                if data['data']['result']:
                    return float(data['data']['result'][0]['value'][1])
        except Exception as e:
            print(f"Error fetching metrics: {e}")
        return None

    def get_current_instance_count(self):
        result = subprocess.run(['vagrant', 'status'],
                              capture_output=True, text=True)
        return result.stdout.count('running')

    def scale_up(self):
        current_count = self.get_current_instance_count()
        if current_count < self.max_instances:
            new_instance = f"web{current_count + 1:02d}"
            print(f"Scaling up: Creating {new_instance}")
            subprocess.run(['vagrant', 'up', new_instance])
            return True
        return False

    def scale_down(self):
        current_count = self.get_current_instance_count()
        if current_count > self.min_instances:
            last_instance = f"web{current_count:02d}"
            print(f"Scaling down: Destroying {last_instance}")
            subprocess.run(['vagrant', 'destroy', '-f', last_instance])
            return True
        return False

    def should_scale(self, metric_value):
        current_time = time.time()
        if current_time - self.last_scaling_time < self.cooldown_period:
            return None

        for rule in self.scaling_rules:
            if rule['metric'] == 'cpu_usage':
                if metric_value > rule['scale_up_threshold']:
                    return 'up'
                elif metric_value < rule['scale_down_threshold']:
                    return 'down'
        return None

    def run(self):
        while True:
            try:
                metric_value = self.get_current_metrics()
                if metric_value is not None:
                    scaling_action = self.should_scale(metric_value)

                    if scaling_action == 'up':
                        if self.scale_up():
                            self.last_scaling_time = time.time()
                            print(f"Scaled up due to CPU usage: {metric_value}%")
                    elif scaling_action == 'down':
                        if self.scale_down():
                            self.last_scaling_time = time.time()
                            print(f"Scaled down due to CPU usage: {metric_value}%")

                time.sleep(30)  # Check every 30 seconds
            except KeyboardInterrupt:
                print("Scaling engine stopped")
                break
            except Exception as e:
                print(f"Error in scaling engine: {e}")
                time.sleep(30)

if __name__ == "__main__":
    engine = VagrantScalingEngine('/vagrant/config/scaling.yml')
    engine.run()
PYTHON_EOF

        chmod +x /usr/local/bin/scaling-engine.py

        # Create scaling configuration
        mkdir -p /vagrant/config
        cat > /vagrant/config/scaling.yml << 'YAML_EOF'
metrics:
  endpoint: "http://monitoring:9090"

scaling:
  min_instances: 2
  max_instances: 8
  cooldown_seconds: 300
  rules:
    - metric: "cpu_usage"
      scale_up_threshold: 75
      scale_down_threshold: 25
    - metric: "memory_usage"
      scale_up_threshold: 80
      scale_down_threshold: 30
    - metric: "response_time"
      scale_up_threshold: 2000  # milliseconds
      scale_down_threshold: 500
YAML_EOF

        # Create systemd service for scaling engine
        cat > /etc/systemd/system/vagrant-scaling.service << 'SERVICE_EOF'
[Unit]
Description=Vagrant Auto-scaling Engine
After=network.target vagrant.target
Requires=vagrant.target

[Service]
Type=simple
User=vagrant
WorkingDirectory=/vagrant
ExecStart=/usr/local/bin/scaling-engine.py
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
SERVICE_EOF

        systemctl daemon-reload
        systemctl enable vagrant-scaling
        systemctl start vagrant-scaling
      SCRIPT
    end

    # Configure load balancer for scaled instances
    configure_load_balancer(config, scaling_config)
  end

  private

  def self.configure_load_balancer(config, scaling_config)
    config.vm.define "load-balancer" do |lb|
      lb.vm.box = "ubuntu/jammy64"
      lb.vm.hostname = "load-balancer"
      lb.vm.network "private_network", ip: scaling_config.lb_ip
      lb.vm.network "forwarded_port", guest: 80, host: 8080
      lb.vm.network "forwarded_port", guest: 443, host: 8443

      lb.vm.provision "shell", inline: <<-SCRIPT
        # Install and configure HAProxy
        apt-get update -qq
        apt-get install -y haproxy

        # Dynamic HAProxy configuration
        cat > /etc/haproxy/haproxy.cfg << 'HAPROXY_EOF'
global
    log 127.0.0.1:514 local0
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    mode http
    log global
    option httplog
    option dontlognull
    option log-health-checks
    option forwardfor
    option http-server-close
    timeout connect 5000
    timeout client 50000
    timeout server 50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http

frontend web_frontend
    bind *:80
    bind *:443 ssl crt /etc/ssl/certs/haproxy.pem
    redirect scheme https if !{ ssl_fc }
    default_backend web_servers

backend web_servers
    balance roundrobin
    option httpchk GET /health
    http-check expect status 200

    # Dynamic server configuration
    server-template web 8 192.168.50.10:80 check init-addr none

stats enable
stats uri /stats
stats refresh 30s
stats admin if TRUE
HAPROXY_EOF

        # Create SSL certificate for HTTPS
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 \\
            -keyout /etc/ssl/private/haproxy.key \\
            -out /etc/ssl/certs/haproxy.crt \\
            -subj "/CN=load-balancer.vagrant.local"
        cat /etc/ssl/certs/haproxy.crt /etc/ssl/private/haproxy.key > /etc/ssl/certs/haproxy.pem

        # Start HAProxy
        systemctl enable haproxy
        systemctl start haproxy

        # Install server discovery script
        cat > /usr/local/bin/update-haproxy.py << 'PYTHON_EOF'
#!/usr/bin/env python3
import subprocess
import re
import time

def get_running_web_servers():
    result = subprocess.run(['vagrant', 'status'], capture_output=True, text=True)
    servers = []
    for line in result.stdout.split('\\n'):
        match = re.match(r'(web\\d+)\\s+running', line)
        if match:
            server_name = match.group(1)
            # Extract IP from vagrant ssh-config
            config_result = subprocess.run(['vagrant', 'ssh-config', server_name],
                                         capture_output=True, text=True)
            ip_match = re.search(r'HostName (\\S+)', config_result.stdout)
            if ip_match:
                servers.append((server_name, ip_match.group(1)))
    return servers

def update_haproxy_config(servers):
    config_path = '/etc/haproxy/haproxy.cfg'
    with open(config_path, 'r') as f:
        config = f.read()

    # Replace server-template with actual servers
    server_lines = []
    for i, (name, ip) in enumerate(servers, 1):
        server_lines.append(f"    server {name} {ip}:80 check")

    new_config = re.sub(
        r'    server-template web \\d+ [^\\n]+',
        '\\n'.join(server_lines),
        config
    )

    with open(config_path, 'w') as f:
        f.write(new_config)

    # Reload HAProxy
    subprocess.run(['systemctl', 'reload', 'haproxy'])

def main():
    while True:
        try:
            servers = get_running_web_servers()
            update_haproxy_config(servers)
            print(f"Updated HAProxy config with {len(servers)} servers")
            time.sleep(60)  # Check every minute
        except Exception as e:
            print(f"Error updating HAProxy config: {e}")
            time.sleep(60)

if __name__ == "__main__":
    main()
PYTHON_EOF

        chmod +x /usr/local/bin/update-haproxy.py

        # Create systemd service for HAProxy updater
        cat > /etc/systemd/system/haproxy-updater.service << 'SERVICE_EOF'
[Unit]
Description=HAProxy Configuration Updater
After=network.target haproxy.service
Requires=haproxy.service

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/update-haproxy.py
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
SERVICE_EOF

        systemctl daemon-reload
        systemctl enable haproxy-updater
        systemctl start haproxy-updater
      SCRIPT
    end
  end
end
```

## Advanced Configuration

### Custom Plugins and Providers

```bash
# Install useful plugins
vagrant plugin install vagrant-hostmanager    # Host file management
vagrant plugin install vagrant-cachier        # Package caching
vagrant plugin install vagrant-reload         # Restart capability during provision
```

### Docker Provider Configuration

```ruby
config.vm.provider "docker" do |d|
  d.build_dir = "."
  d.build_args = ["-t", "my-app"]
  d.ports = ["3000:3000"]
  d.volumes = ["/host/path:/container/path"]
end
```

## 🔧 Enterprise Troubleshooting & Diagnostics

### Advanced Debugging Framework

```bash
#!/bin/bash
# Advanced troubleshooting toolkit for Vagrant environments

# Create comprehensive diagnostic script
cat > /usr/local/bin/vagrant-troubleshoot << 'EOF'
#!/bin/bash
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $*"
}

error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $*"
}

# Main troubleshooting menu
show_menu() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║              Vagrant Troubleshooting Toolkit           ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
    echo
    echo "1) System Diagnostics"
    echo "2) Network Troubleshooting"
    echo "3) Performance Analysis"
    echo "4) Service Health Check"
    echo "5) Vagrant-specific Issues"
    echo "6) Security Audit"
    echo "7) Collect Full Diagnostic Report"
    echo "8) Automated Problem Resolution"
    echo "9) Real-time Performance Monitor"
    echo "0) Exit"
    echo
    read -p "Select option: " choice
}

system_diagnostics() {
    log "Running system diagnostics..."

    echo -e "\n${GREEN}=== System Information ===${NC}"
    echo "Hostname: $(hostname)"
    echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo "Architecture: $(uname -m)"

    echo -e "\n${GREEN}=== Hardware Resources ===${NC}"
    echo "CPU: $(nproc) cores"
    echo "Memory: $(free -h | awk '/^Mem:/{print $2}')"
    echo "Swap: $(free -h | awk '/^Swap:/{print $2}')"

    echo -e "\n${GREEN}=== Disk Usage ===${NC}"
    df -h | grep -E '^/dev|^tmpfs' | head -5

    echo -e "\n${GREEN}=== System Load ===${NC}"
    echo "Load Average: $(cat /proc/loadavg)"
    echo "Running Processes: $(ps aux | wc -l)"

    echo -e "\n${GREEN}=== Memory Details ===${NC}"
    free -h

    # Check for common issues
    echo -e "\n${GREEN}=== Issue Detection ===${NC}"

    # High CPU usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    if (( $(echo "$cpu_usage > 80" | bc -l 2>/dev/null || echo 0) )); then
        warn "High CPU usage detected: ${cpu_usage}%"
    fi

    # High memory usage
    mem_usage=$(free | awk '/^Mem:/{printf "%.1f", $3/$2*100}')
    if (( $(echo "$mem_usage > 80" | bc -l 2>/dev/null || echo 0) )); then
        warn "High memory usage detected: ${mem_usage}%"
    fi

    # High disk usage
    root_usage=$(df / | awk 'NR==2{print $5}' | sed 's/%//')
    if [ "$root_usage" -gt 80 ]; then
        warn "High disk usage on root filesystem: ${root_usage}%"
    fi
}

network_troubleshooting() {
    log "Running network diagnostics..."

    echo -e "\n${GREEN}=== Network Interfaces ===${NC}"
    ip addr show | grep -E "(inet|UP|DOWN)"

    echo -e "\n${GREEN}=== Routing Table ===${NC}"
    ip route show

    echo -e "\n${GREEN}=== DNS Configuration ===${NC}"
    cat /etc/resolv.conf | head -10

    echo -e "\n${GREEN}=== Connectivity Tests ===${NC}"

    # Test local connectivity
    if ping -c 1 127.0.0.1 >/dev/null 2>&1; then
        success "Localhost connectivity: OK"
    else
        error "Localhost connectivity: FAILED"
    fi

    # Test gateway connectivity
    gateway=$(ip route | grep default | awk '{print $3}' | head -1)
    if [ -n "$gateway" ]; then
        if ping -c 1 "$gateway" >/dev/null 2>&1; then
            success "Gateway connectivity ($gateway): OK"
        else
            error "Gateway connectivity ($gateway): FAILED"
        fi
    fi

    # Test DNS resolution
    if nslookup google.com >/dev/null 2>&1; then
        success "DNS resolution: OK"
    else
        error "DNS resolution: FAILED"
    fi

    # Test external connectivity
    if ping -c 1 8.8.8.8 >/dev/null 2>&1; then
        success "External connectivity: OK"
    else
        error "External connectivity: FAILED"
    fi

    echo -e "\n${GREEN}=== Active Connections ===${NC}"
    ss -tuln | head -20

    echo -e "\n${GREEN}=== Firewall Status ===${NC}"
    if command -v ufw >/dev/null; then
        ufw status
    elif command -v iptables >/dev/null; then
        iptables -L | head -10
    fi
}

performance_analysis() {
    log "Running performance analysis..."

    echo -e "\n${GREEN}=== CPU Performance ===${NC}"
    echo "CPU Usage by Process:"
    ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -10

    echo -e "\n${GREEN}=== Memory Performance ===${NC}"
    echo "Memory Usage by Process:"
    ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -10

    echo -e "\n${GREEN}=== Disk I/O Performance ===${NC}"
    if command -v iostat >/dev/null; then
        iostat -x 1 2 | tail -10
    else
        echo "iostat not available - install sysstat package"
    fi

    echo -e "\n${GREEN}=== Load Analysis ===${NC}"
    echo "Current Load: $(cat /proc/loadavg)"
    echo "CPU Cores: $(nproc)"

    load_1min=$(cat /proc/loadavg | awk '{print $1}')
    cpu_cores=$(nproc)
    if (( $(echo "$load_1min > $cpu_cores" | bc -l 2>/dev/null || echo 0) )); then
        warn "System load ($load_1min) exceeds CPU cores ($cpu_cores)"
    fi

    echo -e "\n${GREEN}=== I/O Analysis ===${NC}"
    if command -v iotop >/dev/null; then
        echo "Top I/O processes:"
        timeout 5 iotop -a -o -b -n 3 | head -10 || echo "iotop monitoring completed"
    fi
}

service_health_check() {
    log "Checking service health..."

    echo -e "\n${GREEN}=== Critical Services ===${NC}"
    critical_services=("ssh" "systemd-resolved" "systemd-networkd")

    for service in "${critical_services[@]}"; do
        if systemctl is-active "$service" >/dev/null 2>&1; then
            success "$service: RUNNING"
        else
            error "$service: NOT RUNNING"
            echo "  Last 5 log entries:"
            journalctl -u "$service" -n 5 --no-pager | sed 's/^/    /'
        fi
    done

    echo -e "\n${GREEN}=== Application Services ===${NC}"
    app_services=("apache2" "nginx" "mysql" "postgresql" "docker")

    for service in "${app_services[@]}"; do
        if systemctl is-active "$service" >/dev/null 2>&1; then
            success "$service: RUNNING"
        elif systemctl list-unit-files | grep -q "$service"; then
            warn "$service: INSTALLED but NOT RUNNING"
        else
            echo "$service: Not installed"
        fi
    done

    echo -e "\n${GREEN}=== Failed Services ===${NC}"
    failed_services=$(systemctl --failed --no-pager -q | wc -l)
    if [ "$failed_services" -gt 0 ]; then
        warn "$failed_services failed services detected:"
        systemctl --failed --no-pager
    else
        success "No failed services detected"
    fi
}

vagrant_specific_issues() {
    log "Checking Vagrant-specific issues..."

    echo -e "\n${GREEN}=== Vagrant Environment ===${NC}"

    # Check if we're in a Vagrant environment
    if [ -d "/vagrant" ]; then
        success "Vagrant shared folder detected"

        # Test write permissions
        if touch /vagrant/.test_write 2>/dev/null; then
            success "Vagrant shared folder is writable"
            rm -f /vagrant/.test_write
        else
            error "Vagrant shared folder is not writable"
        fi
    else
        warn "No Vagrant shared folder detected at /vagrant"
    fi

    # Check VirtualBox Guest Additions
    if command -v VBoxControl >/dev/null; then
        if VBoxControl --version >/dev/null 2>&1; then
            version=$(VBoxControl --version | head -1)
            success "VirtualBox Guest Additions: $version"
        else
            error "VirtualBox Guest Additions not functioning"
        fi
    else
        echo "VirtualBox Guest Additions: Not installed/detected"
    fi

    # Check VMware Tools
    if command -v vmware-toolbox-cmd >/dev/null; then
        if vmware-toolbox-cmd -v >/dev/null 2>&1; then
            version=$(vmware-toolbox-cmd -v)
            success "VMware Tools: $version"
        else
            error "VMware Tools not functioning"
        fi
    fi

    echo -e "\n${GREEN}=== Shared Folder Mounts ===${NC}"
    mount | grep -E "(vboxsf|vmhgfs|9p)" || echo "No shared folders currently mounted"

    echo -e "\n${GREEN}=== Vagrant Box Information ===${NC}"
    if [ -f "/home/vagrant/.vagrant.d/boxes" ]; then
        echo "Vagrant boxes directory exists"
    fi

    # Check SSH configuration
    echo -e "\n${GREEN}=== SSH Configuration ===${NC}"
    if [ -f "/home/vagrant/.ssh/authorized_keys" ]; then
        key_count=$(wc -l < /home/vagrant/.ssh/authorized_keys)
        success "SSH authorized keys: $key_count keys configured"
    else
        warn "No SSH authorized keys found"
    fi
}

security_audit() {
    log "Running security audit..."

    echo -e "\n${GREEN}=== SSH Security ===${NC}"

    # Check SSH configuration
    if grep -q "PermitRootLogin yes" /etc/ssh/sshd_config 2>/dev/null; then
        error "Root SSH login is enabled"
    else
        success "Root SSH login is disabled or properly configured"
    fi

    if grep -q "PasswordAuthentication yes" /etc/ssh/sshd_config 2>/dev/null; then
        warn "Password authentication is enabled"
    else
        success "Password authentication is disabled"
    fi

    echo -e "\n${GREEN}=== Failed Login Attempts ===${NC}"
    if [ -f "/var/log/auth.log" ]; then
        failed_logins=$(grep "Failed password" /var/log/auth.log | wc -l)
        if [ "$failed_logins" -gt 0 ]; then
            warn "$failed_logins failed login attempts found"
            echo "Recent failed attempts:"
            grep "Failed password" /var/log/auth.log | tail -5 | sed 's/^/  /'
        else
            success "No failed login attempts in auth.log"
        fi
    fi

    echo -e "\n${GREEN}=== File Permissions ===${NC}"

    # Check critical file permissions
    critical_files=("/etc/passwd" "/etc/shadow" "/etc/sudoers")
    for file in "${critical_files[@]}"; do
        if [ -f "$file" ]; then
            perms=$(stat -c "%a" "$file")
            case "$file" in
                "/etc/passwd")
                    if [ "$perms" = "644" ]; then
                        success "/etc/passwd permissions: OK ($perms)"
                    else
                        warn "/etc/passwd permissions: $perms (should be 644)"
                    fi
                    ;;
                "/etc/shadow")
                    if [ "$perms" = "640" ] || [ "$perms" = "600" ]; then
                        success "/etc/shadow permissions: OK ($perms)"
                    else
                        error "/etc/shadow permissions: $perms (should be 640 or 600)"
                    fi
                    ;;
                "/etc/sudoers")
                    if [ "$perms" = "440" ]; then
                        success "/etc/sudoers permissions: OK ($perms)"
                    else
                        warn "/etc/sudoers permissions: $perms (should be 440)"
                    fi
                    ;;
            esac
        fi
    done
}

collect_full_report() {
    log "Collecting comprehensive diagnostic report..."

    report_dir="/tmp/vagrant-diagnostic-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$report_dir"

    {
        echo "=== VAGRANT DIAGNOSTIC REPORT ==="
        echo "Generated: $(date)"
        echo "Hostname: $(hostname)"
        echo "User: $(whoami)"
        echo

        system_diagnostics
        echo
        network_troubleshooting
        echo
        performance_analysis
        echo
        service_health_check
        echo
        vagrant_specific_issues
        echo
        security_audit

    } > "$report_dir/diagnostic-report.txt"

    # Collect additional files
    cp /var/log/syslog "$report_dir/" 2>/dev/null || true
    cp /var/log/auth.log "$report_dir/" 2>/dev/null || true
    cp /etc/os-release "$report_dir/" 2>/dev/null || true

    # Create archive
    cd /tmp
    tar -czf "${report_dir}.tar.gz" "$(basename "$report_dir")"

    success "Full diagnostic report created: ${report_dir}.tar.gz"
    echo "Report location: ${report_dir}.tar.gz"

    read -p "Press Enter to continue..."
}

automated_resolution() {
    log "Running automated problem resolution..."

    echo -e "\n${GREEN}=== Automated Fixes ===${NC}"

    # Fix 1: Clean disk space
    echo "Cleaning disk space..."
    apt-get autoremove -y >/dev/null 2>&1 && success "Removed unused packages" || warn "Failed to remove packages"
    apt-get autoclean >/dev/null 2>&1 && success "Cleaned package cache" || warn "Failed to clean cache"

    # Fix 2: Drop caches if memory is high
    mem_usage=$(free | awk '/^Mem:/{printf "%.0f", $3/$2*100}')
    if [ "$mem_usage" -gt 85 ]; then
        echo "Dropping system caches (memory usage: ${mem_usage}%)..."
        sync && echo 3 > /proc/sys/vm/drop_caches
        new_mem_usage=$(free | awk '/^Mem:/{printf "%.0f", $3/$2*100}')
        success "Memory usage: ${mem_usage}% -> ${new_mem_usage}%"
    fi

    # Fix 3: Restart failed services
    failed_services=$(systemctl --failed --no-pager -q)
    if [ -n "$failed_services" ]; then
        echo "Restarting failed services..."
        echo "$failed_services" | while read service; do
            if [[ "$service" != *"not-found"* ]]; then
                systemctl restart "$service" 2>/dev/null && success "Restarted $service" || warn "Failed to restart $service"
            fi
        done
    fi

    # Fix 4: Update package database
    echo "Updating package database..."
    apt-get update -qq >/dev/null 2>&1 && success "Package database updated" || warn "Failed to update package database"

    success "Automated resolution completed"
    read -p "Press Enter to continue..."
}

real_time_monitor() {
    log "Starting real-time performance monitor (Press Ctrl+C to exit)..."

    trap 'echo -e "\n${GREEN}Monitoring stopped.${NC}"; return' INT

    while true; do
        clear
        echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
        echo -e "${BLUE}║              Real-time System Monitor                  ║${NC}"
        echo -e "${BLUE}║                  $(date '+%Y-%m-%d %H:%M:%S')                     ║${NC}"
        echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"

        echo -e "\n${GREEN}CPU Usage:${NC}"
        top -bn1 | grep "Cpu(s)" | awk '{print $2, $4, $6, $10}' | sed 's/,//g'

        echo -e "\n${GREEN}Memory Usage:${NC}"
        free -h | awk '/^Mem:/{print "Total:", $2, "Used:", $3, "Free:", $7, "Usage:", int($3/$2*100)"%"}'

        echo -e "\n${GREEN}Disk Usage:${NC}"
        df -h / | awk 'NR==2{print "Root:", $3 "/" $2, "(" $5 ")"}'

        echo -e "\n${GREEN}Network:${NC}"
        echo "Active connections: $(ss -tun | wc -l)"

        echo -e "\n${GREEN}Top Processes (CPU):${NC}"
        ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -5 | tail -4

        echo -e "\n${GREEN}Top Processes (Memory):${NC}"
        ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -5 | tail -4

        echo -e "\n${BLUE}Press Ctrl+C to exit${NC}"
        sleep 3
    done
}

# Main loop
while true; do
    show_menu
    case $choice in
        1) system_diagnostics; read -p "Press Enter to continue..." ;;
        2) network_troubleshooting; read -p "Press Enter to continue..." ;;
        3) performance_analysis; read -p "Press Enter to continue..." ;;
        4) service_health_check; read -p "Press Enter to continue..." ;;
        5) vagrant_specific_issues; read -p "Press Enter to continue..." ;;
        6) security_audit; read -p "Press Enter to continue..." ;;
        7) collect_full_report ;;
        8) automated_resolution ;;
        9) real_time_monitor ;;
        0) echo "Goodbye!"; exit 0 ;;
        *) error "Invalid option" ;;
    esac
done
EOF

chmod +x /usr/local/bin/vagrant-troubleshoot
echo "Vagrant troubleshooting toolkit installed at /usr/local/bin/vagrant-troubleshoot"
```

### Common Issue Resolution Patterns

```bash
# Issue: VirtualBox Guest Additions out of sync
vagrant plugin install vagrant-vbguest
vagrant vbguest --status
vagrant vbguest --auto-reboot

# Issue: Shared folders not working
vagrant reload
# or
vagrant ssh -c "sudo mount -t vboxsf vagrant /vagrant"

# Issue: Network connectivity problems
vagrant reload --provision
# Check for conflicting host networks
VBoxManage list hostonlyifs

# Issue: High memory usage
vagrant halt
# Edit Vagrantfile to reduce memory allocation
vagrant up

# Issue: Disk space full in VM
vagrant ssh -c "sudo apt-get autoremove && sudo apt-get autoclean"
vagrant ssh -c "sudo journalctl --vacuum-time=7d"

# Issue: Performance degradation
# Enable CPU virtualization features
config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
  vb.customize ["modifyvm", :id, "--nestedpaging", "on"]
  vb.customize ["modifyvm", :id, "--largepages", "on"]
end

# Issue: SSH connection problems
vagrant ssh-config > ssh_config
ssh -F ssh_config default
# or
vagrant destroy && vagrant up

# Issue: Provisioning failures
vagrant provision --debug 2>&1 | tee provision.log
# Check for specific errors in provision.log
```

### Advanced Configuration

### Custom Plugins and Providers

```bash
# Install useful plugins
vagrant plugin install vagrant-hostmanager    # Host file management
vagrant plugin install vagrant-cachier        # Package caching
vagrant plugin install vagrant-reload         # Restart capability during provision
```

### Docker Provider Configuration

```ruby
config.vm.provider "docker" do |d|
  d.build_dir = "."
  d.build_args = ["-t", "my-app"]
  d.ports = ["3000:3000"]
  d.volumes = ["/host/path:/container/path"]
end
```

### Enterprise GitOps & CI/CD Integration

```ruby
# Vagrantfile - GitOps integration with enterprise CI/CD
require 'yaml'
require 'json'
require 'base64'

# Enterprise GitOps configuration
gitops_config = YAML.load_file('gitops/config.yml')
pipeline_secrets = JSON.parse(Base64.decode64(ENV['PIPELINE_SECRETS'] || '{}'))

Vagrant.configure("2") do |config|
  # Enterprise GitOps settings
  config.vm.box = gitops_config['enterprise']['base_box']
  config.vm.box_version = gitops_config['enterprise']['box_version']

  # GitOps synchronization
  config.vm.provision "gitops_sync", type: "shell", run: "always" do |shell|
    shell.inline = <<-SHELL
      #!/bin/bash
      echo "🔄 Synchronizing GitOps repository..."

      if [ ! -d "/opt/gitops" ]; then
        git clone #{gitops_config['repository']['url']} /opt/gitops
      else
        cd /opt/gitops && git fetch origin && git reset --hard origin/main
      fi

      cd /opt/gitops/environments/#{gitops_config['environment']}
      if [ -f "validate.sh" ]; then chmod +x validate.sh && ./validate.sh; fi
      if [ -d "k8s" ] && command -v kubectl &> /dev/null; then kubectl apply -f k8s/; fi

      echo "✅ GitOps synchronization completed"
    SHELL
  end

  # Multi-provider enterprise configuration
  gitops_config['nodes'].each do |node_name, node_config|
    config.vm.define node_name do |node|
      node.vm.hostname = "#{node_name}.#{gitops_config['domain']}"
      node.vm.network "private_network", ip: node_config['ip']

      # AWS provider for cloud-native development
      node.vm.provider :aws do |aws, override|
        aws.access_key_id = pipeline_secrets['aws_access_key_id']
        aws.secret_access_key = pipeline_secrets['aws_secret_access_key']
        aws.region = node_config['aws_region']
        aws.instance_type = node_config['aws_instance_type']
        aws.ami = node_config['aws_ami']
        aws.security_groups = node_config['aws_security_groups']

        aws.tags = {
          'Name' => "#{gitops_config['project']}-#{node_name}",
          'Environment' => gitops_config['environment'],
          'ManagedBy' => 'Vagrant-GitOps'
        }
      end

      # Service discovery registration
      node.vm.provision "service_discovery", type: "shell", run: "always" do |shell|
        shell.inline = <<-SHELL
          curl -X POST #{gitops_config['service_discovery']['endpoint']}/register \\
            -H "Content-Type: application/json" \\
            -d '{"name": "#{node_name}", "address": "#{node_config['ip']}", "port": #{node_config['port'] || 80}}'
        SHELL
      end
    end
  end
end
```

### Enterprise Security & Compliance Automation

```ruby
# security/enterprise-security.rb - Comprehensive security hardening
class VagrantSecurity
  def self.apply_cis_hardening(config, security_config)
    config.vm.provision "cis_hardening", type: "ansible" do |ansible|
      ansible.playbook = "security/cis-hardening.yml"
      ansible.extra_vars = {
        cis_level: security_config['cis_level'],
        compliance_framework: security_config['compliance_framework'],
        audit_enabled: security_config['audit_enabled']
      }
    end
  end

  def self.setup_vault_integration(config, vault_config)
    config.vm.provision "vault_setup", type: "shell" do |shell|
      shell.inline = <<-SHELL
        #!/bin/bash
        echo "🔐 Setting up HashiCorp Vault integration..."

        # Install Vault
        wget -q https://releases.hashicorp.com/vault/#{vault_config['version']}/vault_#{vault_config['version']}_linux_amd64.zip
        unzip vault_#{vault_config['version']}_linux_amd64.zip
        sudo mv vault /usr/local/bin/

        # Configure Vault client
        export VAULT_ADDR='#{vault_config['server_addr']}'
        echo 'export VAULT_ADDR="#{vault_config['server_addr']}"' >> ~/.bashrc

        # Install Vault agent for secret management
        sudo tee /etc/vault-agent.hcl > /dev/null << EOF
auto_auth {
  method "aws" {
    mount_path = "auth/aws"
    config = {
      type = "iam"
      role = "#{vault_config['aws_role']}"
    }
  }
}

template {
  source      = "/opt/vault/templates/database.tpl"
  destination = "/etc/app/database.conf"
  perms       = 0600
}
EOF

        echo "✅ Vault integration setup completed"
      SHELL
    end
  end

  def self.setup_monitoring(config, monitoring_config)
    config.vm.provision "monitoring_setup", type: "shell" do |shell|
      shell.inline = <<-SHELL
        #!/bin/bash
        echo "📊 Setting up enterprise monitoring..."

        # Install Prometheus Node Exporter
        wget -q https://github.com/prometheus/node_exporter/releases/download/v#{monitoring_config['node_exporter_version']}/node_exporter-#{monitoring_config['node_exporter_version']}.linux-amd64.tar.gz
        tar xzf node_exporter-#{monitoring_config['node_exporter_version']}.linux-amd64.tar.gz
        sudo mv node_exporter-#{monitoring_config['node_exporter_version']}.linux-amd64/node_exporter /usr/local/bin/

        # Create systemd service
        sudo tee /etc/systemd/system/node_exporter.service > /dev/null << EOF
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --web.listen-address=0.0.0.0:9100
Restart=always

[Install]
WantedBy=multi-user.target
EOF

        sudo useradd --no-create-home --shell /bin/false node_exporter
        sudo systemctl daemon-reload
        sudo systemctl enable node_exporter
        sudo systemctl start node_exporter

        echo "✅ Enterprise monitoring setup completed"
      SHELL
    end
  end
end
```

### Advanced Testing & Quality Assurance

```ruby
# testing/enterprise-testing.rb - Comprehensive testing framework
class VagrantTesting
  def self.setup_infrastructure_testing(config, testing_config)
    config.vm.provision "infrastructure_testing", type: "shell" do |shell|
      shell.inline = <<-SHELL
        #!/bin/bash
        echo "🧪 Setting up infrastructure testing..."

        # Install Testinfra for infrastructure testing
        pip3 install testinfra ansible pytest

        # Install Inspec for compliance testing
        curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec

        # Create test directory structure
        mkdir -p /vagrant/tests/{unit,integration,compliance,performance}

        # Setup automated test execution
        sudo tee /usr/local/bin/run-infrastructure-tests.sh > /dev/null << 'EOF'
#!/bin/bash
set -euo pipefail

TEST_DIR="/vagrant/tests"
REPORT_DIR="/vagrant/reports"
mkdir -p "$REPORT_DIR"

echo "Running infrastructure tests..."

# Unit tests with Testinfra
cd "$TEST_DIR"
testinfra unit/test_*.py -v --junitxml="$REPORT_DIR/testinfra-results.xml"

# Compliance tests with Inspec
inspec exec compliance/ --reporter=json:"$REPORT_DIR/inspec-results.json"

# Performance tests with Apache Bench
if [ -f "performance/load-test.sh" ]; then
  bash performance/load-test.sh > "$REPORT_DIR/performance-results.txt"
fi

echo "Infrastructure testing completed. Reports in $REPORT_DIR"
EOF

        chmod +x /usr/local/bin/run-infrastructure-tests.sh

        echo "✅ Infrastructure testing setup completed"
      SHELL
    end
  end

  def self.setup_continuous_testing(config, ci_config)
    config.vm.provision "ci_testing", type: "shell" do |shell|
      shell.inline = <<-SHELL
        #!/bin/bash
        echo "🔄 Setting up continuous testing pipeline..."

        # Install GitLab Runner for CI/CD integration
        curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
        chmod +x /usr/local/bin/gitlab-runner

        # Register GitLab Runner
        gitlab-runner register \\
          --non-interactive \\
          --url "#{ci_config['gitlab_url']}" \\
          --registration-token "#{ci_config['runner_token']}" \\
          --executor "shell" \\
          --description "Vagrant Enterprise Runner" \\
          --tag-list "#{ci_config['runner_tags']}"

        # Install GitHub Actions runner
        mkdir -p /opt/github-runner
        cd /opt/github-runner
        curl -o actions-runner-linux-x64-2.309.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.309.0/actions-runner-linux-x64-2.309.0.tar.gz
        tar xzf ./actions-runner-linux-x64-2.309.0.tar.gz

        # Configure as service
        sudo ./svc.sh install
        sudo ./svc.sh start

        echo "✅ Continuous testing pipeline setup completed"
      SHELL
    end
  end
end
```

## AI Assistant Guidelines

When helping with Vagrant:

1. **Always suggest specific box versions** for reproducibility
2. **Provide complete Vagrantfile examples** for requested configurations
3. **Include provisioning scripts** for complex environment setup
4. **Mention resource requirements** (memory, CPU) for different use cases
5. **Suggest appropriate providers** based on host operating system
6. **Include networking configuration** for multi-service environments
7. **Provide troubleshooting steps** for common setup issues
8. **Reference official documentation** for advanced configurations

### Code Generation Rules

- Generate Vagrantfiles that follow Ruby syntax and Vagrant conventions
- Include resource allocation appropriate for development use
- Provide provisioning that's idempotent and handles errors gracefully
- Include networking configuration for realistic development scenarios
- Add comments explaining configuration choices and alternatives
