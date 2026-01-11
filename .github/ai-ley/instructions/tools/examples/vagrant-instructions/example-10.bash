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