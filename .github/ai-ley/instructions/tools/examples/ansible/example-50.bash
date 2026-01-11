# Deploy infrastructure with monitoring
ansible-playbook -i inventory/production infrastructure-with-monitoring.yml

# Run comprehensive security audit
ansible-playbook -i inventory/production security-compliance-audit.yml

# Execute blue-green deployment
ansible-playbook -i inventory/production blue-green-deployment.yml

# Scale infrastructure automatically
ansible-playbook -i inventory/production auto-scaling.yml