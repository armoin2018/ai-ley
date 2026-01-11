# Install Ansible Core (latest stable)
pip3 install ansible-core>=2.15
pip3 install ansible>=8.0

# Install enterprise collections
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.posix
ansible-galaxy collection install cloud.common
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install amazon.aws
ansible-galaxy collection install azure.azcollection
ansible-galaxy collection install google.cloud

# Install enterprise dependencies
pip3 install requests jinja2 cryptography
pip3 install pymongo psycopg2-binary mysql-connector-python
pip3 install kubernetes openshift boto3 azure-cli

# Configure Ansible environment
export ANSIBLE_CONFIG="/opt/ansible/ansible.cfg"
export ANSIBLE_INVENTORY="/opt/ansible/inventory"
export ANSIBLE_ROLES_PATH="/opt/ansible/roles"
export ANSIBLE_COLLECTIONS_PATH="/opt/ansible/collections"