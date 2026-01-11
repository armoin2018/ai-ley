# enterprise-rhaa-setup.sh - Red Hat Ansible Automation Platform
#!/bin/bash

# Download installer
curl -O https://releases.ansible.com/ansible-automation-platform/setup/ansible-automation-platform-setup-2.4-1.tar.gz
tar -xzf ansible-automation-platform-setup-2.4-1.tar.gz
cd ansible-automation-platform-setup-2.4-1

# Configure inventory for enterprise deployment
cat > inventory << 'RHAA_INVENTORY'
[automationcontroller]
controller1.example.com
controller2.example.com
controller3.example.com

[automationhub]
hub1.example.com
hub2.example.com

[database]
database.example.com

[all:vars]
admin_password='your-admin-password'
pg_host='database.example.com'
pg_port='5432'
pg_database='awx'
pg_username='awx'
pg_password='your-db-password'
pg_sslmode='prefer'

registry_url='registry.redhat.io'
registry_username='your-registry-username'
registry_password='your-registry-password'

# SSL Configuration
web_server_ssl_cert='/path/to/cert.crt'
web_server_ssl_key='/path/to/cert.key'

# Enterprise features
enable_insights_collection=true
enable_automation_analytics=true
enable_ldap_authentication=true
RHAA_INVENTORY

# Run installer
./setup.sh

echo "Red Hat Ansible Automation Platform installed"
echo "Controller: https://controller1.example.com"
echo "Hub: https://hub1.example.com"