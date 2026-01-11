# Enable verbose output
vagrant up --debug
vagrant provision --debug

# Check VM status
vagrant status
vagrant global-status

# SSH debugging
vagrant ssh-config