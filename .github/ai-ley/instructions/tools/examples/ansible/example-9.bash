# enterprise-ansible-setup.sh - Complete enterprise platform installation
#!/bin/bash
set -euo pipefail

ANSIBLE_VERSION="${ANSIBLE_VERSION:-8.5.0}"
PYTHON_VERSION="${PYTHON_VERSION:-3.11}"
AWX_VERSION="${AWX_VERSION:-23.3.1}"
INSTALL_AWX="${INSTALL_AWX:-true}"
ENTERPRISE_MODE="${ENTERPRISE_MODE:-true}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ANSIBLE-SETUP] $*"
}

# Install system dependencies
install_system_dependencies() {
    log "Installing system dependencies..."

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Ubuntu/Debian
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y \
                python${PYTHON_VERSION} \
                python${PYTHON_VERSION}-pip \
                python${PYTHON_VERSION}-venv \
                python${PYTHON_VERSION}-dev \
                build-essential \
                libffi-dev \
                libssl-dev \
                sshpass \
                git \
                curl \
                wget \
                jq \
                rsync \
                unzip

        # RHEL/CentOS/Fedora
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y \
                python${PYTHON_VERSION} \
                python${PYTHON_VERSION}-pip \
                python${PYTHON_VERSION}-devel \
                gcc \
                openssl-devel \
                libffi-devel \
                sshpass \
                git \
                curl \
                wget \
                jq \
                rsync \
                unzip
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS with Homebrew
        if command -v brew &> /dev/null; then
            brew install \
                python@${PYTHON_VERSION} \
                git \
                curl \
                wget \
                jq \
                rsync \
                sshpass
        fi
    fi

    log "✓ System dependencies installed"
}

# Setup Python virtual environment
setup_python_environment() {
    log "Setting up Python virtual environment..."

    # Create enterprise ansible directory
    sudo mkdir -p /opt/ansible-enterprise
    sudo chown -R $(whoami):$(whoami) /opt/ansible-enterprise

    # Create virtual environment
    python${PYTHON_VERSION} -m venv /opt/ansible-enterprise/venv
    source /opt/ansible-enterprise/venv/bin/activate

    # Upgrade pip and setuptools
    pip install --upgrade pip setuptools wheel

    # Install Ansible and core dependencies
    pip install \
        ansible-core>=${ANSIBLE_VERSION%.*} \
        ansible>=${ANSIBLE_VERSION} \
        ansible-lint>=6.20.0 \
        yamllint>=1.32.0 \
        molecule[docker]>=6.0.0 \
        pytest-ansible>=4.1.0 \
        jmespath>=1.0.1 \
        netaddr>=0.8.0 \
        dnspython>=2.4.0 \
        requests>=2.31.0 \
        cryptography>=41.0.0 \
        paramiko>=3.3.0 \
        jinja2>=3.1.0 \
        pyyaml>=6.0 \
        six>=1.16.0

    # Install cloud provider libraries
    pip install \
        boto3>=1.28.0 \
        botocore>=1.31.0 \
        azure-cli>=2.50.0 \
        google-cloud>=0.34.0 \
        kubernetes>=27.2.0 \
        openshift>=0.13.0

    # Install monitoring and security libraries
    pip install \
        prometheus-client>=0.17.0 \
        elasticsearch>=8.9.0 \
        pymongo>=4.5.0 \
        psycopg2-binary>=2.9.0 \
        mysql-connector-python>=8.1.0 \
        redis>=4.6.0

    log "✓ Python environment configured"
}

# Install Ansible collections
install_ansible_collections() {
    log "Installing enterprise Ansible collections..."

    source /opt/ansible-enterprise/venv/bin/activate

    # Core collections
    ansible-galaxy collection install \
        community.general \
        community.crypto \
        community.docker \
        community.grafana \
        community.mysql \
        community.postgresql \
        community.mongodb \
        community.redis \
        community.rabbitmq \
        community.zabbix \
        ansible.posix \
        ansible.utils \
        ansible.windows \
        cloud.common \
        kubernetes.core \
        containers.podman

    # Cloud provider collections
    ansible-galaxy collection install \
        amazon.aws \
        azure.azcollection \
        google.cloud \
        openstack.cloud \
        vmware.vmware_rest \
        ovirt.ovirt \
        hetzner.hcloud

    # Network collections
    ansible-galaxy collection install \
        cisco.ios \
        cisco.nxos \
        cisco.asa \
        arista.eos \
        juniper.junos \
        vyos.vyos \
        fortinet.fortios \
        paloaltonetworks.panos

    # Security and monitoring collections
    ansible-galaxy collection install \
        community.hashi_vault \
        community.grafana \
        community.general \
        community.crypto \
        elastic.elasticsearch \
        prometheus.prometheus

    log "✓ Ansible collections installed"
}

# Configure enterprise Ansible environment
configure_ansible() {
    log "Configuring enterprise Ansible environment..."

    # Create directory structure
    mkdir -p /opt/ansible-enterprise/{config,inventory,playbooks,roles,collections,plugins,logs,keys,vault}

    # Create enterprise ansible.cfg
    cat > /opt/ansible-enterprise/config/ansible.cfg << 'ANSIBLE_CFG_EOF'
[defaults]
# Core configuration
inventory = /opt/ansible-enterprise/inventory
roles_path = /opt/ansible-enterprise/roles:/usr/share/ansible/roles
collections_path = /opt/ansible-enterprise/collections
library = /opt/ansible-enterprise/plugins/modules
module_utils = /opt/ansible-enterprise/plugins/module_utils
action_plugins = /opt/ansible-enterprise/plugins/action
lookup_plugins = /opt/ansible-enterprise/plugins/lookup
filter_plugins = /opt/ansible-enterprise/plugins/filter
vars_plugins = /opt/ansible-enterprise/plugins/vars
callback_plugins = /opt/ansible-enterprise/plugins/callback
connection_plugins = /opt/ansible-enterprise/plugins/connection
inventory_plugins = /opt/ansible-enterprise/plugins/inventory

# Vault configuration
vault_password_file = /opt/ansible-enterprise/vault/.vault_pass
vault_encrypt_identity_list = ['vault_id_1', 'vault_id_2']
vault_identity_list = vault_id_1@/opt/ansible-enterprise/vault/vault_id_1, vault_id_2@/opt/ansible-enterprise/vault/vault_id_2

# SSH configuration
private_key_file = /opt/ansible-enterprise/keys/ansible_rsa
remote_user = ansible
host_key_checking = False
ssh_args = -o ControlMaster=auto -o ControlPersist=300s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

# Performance optimization
forks = 100
serial = 50%
gathering = smart
fact_caching = jsonfile
fact_caching_connection = /opt/ansible-enterprise/cache/facts
fact_caching_timeout = 86400
gather_timeout = 30
timeout = 30
poll_interval = 0.1
internal_poll_interval = 0.1
pipelining = True
strategy = linear

# Output configuration
stdout_callback = yaml
callback_whitelist = profile_tasks, timer, yaml
display_skipped_hosts = False
display_ok_hosts = False
display_args_to_stdout = False
system_warnings = False
deprecation_warnings = False
command_warnings = False

# Logging
log_path = /opt/ansible-enterprise/logs/ansible.log
syslog_facility = LOG_LOCAL0

# Security
become = True
become_method = sudo
become_user = root
become_ask_pass = False

[inventory]
enable_plugins = host_list, script, auto, yaml, ini, toml, constructed
cache = True
cache_plugin = jsonfile
cache_timeout = 3600
cache_connection = /opt/ansible-enterprise/cache/inventory

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=300s -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -o ServerAliveCountMax=60
control_path_dir = /tmp/.ansible-cp
control_path = %(directory)s/%%h-%%p-%%r
pipelining = True
transfer_method = smart
retries = 3

[persistent_connection]
connect_timeout = 60
connect_retries = 5
connect_interval = 2

[paramiko_connection]
record_host_keys = False
proxy_command =

[colors]
highlight = white
verbose = blue
warn = bright purple
error = red
debug = dark gray
deprecate = purple
skip = cyan
unreachable = red
ok = green
changed = yellow
diff_add = green
diff_remove = red
diff_lines = cyan
ANSIBLE_CFG_EOF

    # Create directory structure with proper permissions
    chmod 700 /opt/ansible-enterprise/vault
    chmod 700 /opt/ansible-enterprise/keys
    chmod 755 /opt/ansible-enterprise/logs

    # Create environment setup script
    cat > /opt/ansible-enterprise/setup-env.sh << 'ENV_SETUP_EOF'
#!/bin/bash
export ANSIBLE_CONFIG="/opt/ansible-enterprise/config/ansible.cfg"
export ANSIBLE_INVENTORY="/opt/ansible-enterprise/inventory"
export ANSIBLE_ROLES_PATH="/opt/ansible-enterprise/roles"
export ANSIBLE_COLLECTIONS_PATH="/opt/ansible-enterprise/collections"
export ANSIBLE_LOG_PATH="/opt/ansible-enterprise/logs/ansible.log"
export ANSIBLE_VAULT_PASSWORD_FILE="/opt/ansible-enterprise/vault/.vault_pass"
export PATH="/opt/ansible-enterprise/venv/bin:$PATH"

# Activate virtual environment
source /opt/ansible-enterprise/venv/bin/activate

echo "Enterprise Ansible environment activated"
echo "Ansible version: $(ansible --version | head -n1)"
echo "Python version: $(python --version)"
echo "Collections path: $ANSIBLE_COLLECTIONS_PATH"
ENV_SETUP_EOF

    chmod +x /opt/ansible-enterprise/setup-env.sh

    log "✓ Enterprise Ansible configuration created"
}

# Install and configure AWX
install_awx() {
    if [[ "$INSTALL_AWX" != "true" ]]; then
        log "Skipping AWX installation"
        return
    fi

    log "Installing AWX automation platform..."

    # Install Docker and Docker Compose
    if ! command -v docker &> /dev/null; then
        curl -fsSL https://get.docker.com | sh
        sudo systemctl enable --now docker
        sudo usermod -aG docker $(whoami)
    fi

    if ! command -v docker-compose &> /dev/null; then
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi

    # Clone AWX
    git clone -b ${AWX_VERSION} https://github.com/ansible/awx.git /opt/awx
    cd /opt/awx

    # Configure AWX
    cat > /opt/awx/tools/docker-compose/inventory << AWX_INVENTORY_EOF
localhost ansible_connection=local ansible_python_interpreter="/usr/bin/env python3"

[all:vars]
dockerhub_base=ansible

# AWX Configuration
awx_task_hostname=awx
awx_web_hostname=awxweb
postgres_data_dir="/opt/awx/pgdocker"
host_port=80
host_port_ssl=443
docker_compose_dir="/opt/awx/tools/docker-compose"
pg_username=awx
pg_password=awxpass
pg_database=awx
pg_port=5432
admin_user=admin
admin_password=password
create_preload_data=True
secret_key=awxsecret
project_data_dir="/opt/awx/projects"
AWX_INVENTORY_EOF

    # Install AWX
    cd /opt/awx/tools/docker-compose
    ansible-playbook -i inventory install.yml

    log "✓ AWX installed and configured"
    log "   Access AWX at: http://localhost (admin/password)"
}

# Create sample enterprise content
create_sample_content() {
    log "Creating sample enterprise content..."

    # Create sample inventory
    mkdir -p /opt/ansible-enterprise/inventory/{group_vars,host_vars}

    cat > /opt/ansible-enterprise/inventory/hosts.yml << 'INVENTORY_EOF'
all:
  children:
    production:
      children:
        web_servers:
          hosts:
            web[01:03].prod.example.com:
        database_servers:
          hosts:
            db[01:02].prod.example.com:
        load_balancers:
          hosts:
            lb[01:02].prod.example.com:
    staging:
      children:
        web_servers:
          hosts:
            web01.staging.example.com:
        database_servers:
          hosts:
            db01.staging.example.com:
    development:
      children:
        web_servers:
          hosts:
            web01.dev.example.com:
        database_servers:
          hosts:
            db01.dev.example.com:
INVENTORY_EOF

    # Create sample group variables
    cat > /opt/ansible-enterprise/inventory/group_vars/all.yml << 'ALL_VARS_EOF'
# Global enterprise variables
enterprise:
  organization: "ACME Corporation"
  domain: "example.com"
  timezone: "UTC"
  ntp_servers:
    - "pool.ntp.org"
    - "time.google.com"

# Security settings
security:
  hardening_enabled: true
  compliance_framework: "CIS"
  audit_logging: true
  vulnerability_scanning: true
  patch_management: true

# Monitoring settings
monitoring:
  enabled: true
  prometheus_server: "prometheus.example.com"
  grafana_server: "grafana.example.com"
  alertmanager_server: "alertmanager.example.com"
  log_aggregation_server: "elk.example.com"
ALL_VARS_EOF

    # Create sample role
    mkdir -p /opt/ansible-enterprise/roles/common/{tasks,handlers,templates,files,vars,defaults,meta}

    cat > /opt/ansible-enterprise/roles/common/tasks/main.yml << 'ROLE_TASKS_EOF'
---
- name: Update package cache
  package:
    update_cache: yes
  tags: ['packages']

- name: Install common packages
  package:
    name: "{{ common_packages }}"
    state: present
  tags: ['packages']

- name: Configure NTP
  template:
    src: ntp.conf.j2
    dest: /etc/ntp.conf
    backup: true
  notify: restart ntp
  tags: ['ntp']

- name: Start and enable services
  service:
    name: "{{ item }}"
    state: started
    enabled: true
  loop: "{{ common_services }}"
  tags: ['services']
ROLE_TASKS_EOF

    cat > /opt/ansible-enterprise/roles/common/defaults/main.yml << 'ROLE_DEFAULTS_EOF'
---
common_packages:
  - curl
  - wget
  - vim
  - htop
  - git
  - rsync

common_services:
  - ntp
  - ssh
ROLE_DEFAULTS_EOF

    # Create sample playbook
    cat > /opt/ansible-enterprise/playbooks/site.yml << 'SITE_PLAYBOOK_EOF'
---
- name: Enterprise Infrastructure Configuration
  hosts: all
  become: true
  gather_facts: true

  roles:
    - common
    - security
    - monitoring

  post_tasks:
    - name: Verify configuration
      debug:
        msg: "Configuration completed for {{ inventory_hostname }}"
SITE_PLAYBOOK_EOF

    log "✓ Sample enterprise content created"
}

# Main installation function
main() {
    log "Starting enterprise Ansible platform installation..."
    log "Ansible Version: ${ANSIBLE_VERSION}"
    log "Python Version: ${PYTHON_VERSION}"
    log "Enterprise Mode: ${ENTERPRISE_MODE}"

    install_system_dependencies
    setup_python_environment
    install_ansible_collections
    configure_ansible

    if [[ "$INSTALL_AWX" == "true" ]]; then
        install_awx
    fi

    create_sample_content

    log "Enterprise Ansible platform installation completed!"
    log ""
    log "Next steps:"
    log "1. Source the environment: source /opt/ansible-enterprise/setup-env.sh"
    log "2. Configure vault passwords: echo 'your-vault-password' > /opt/ansible-enterprise/vault/.vault_pass"
    log "3. Add SSH keys: cp your-key /opt/ansible-enterprise/keys/ansible_rsa"
    log "4. Update inventory: edit /opt/ansible-enterprise/inventory/hosts.yml"
    log "5. Test connection: ansible all -m ping"
    log ""
    if [[ "$INSTALL_AWX" == "true" ]]; then
        log "AWX is available at: http://localhost (admin/password)"
    fi
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
EOF

chmod +x enterprise-ansible-setup.sh