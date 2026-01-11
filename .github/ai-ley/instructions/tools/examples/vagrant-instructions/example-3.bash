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