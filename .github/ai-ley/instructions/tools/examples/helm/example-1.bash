# Install Helm (macOS)
brew install helm

# Install Helm (Linux)
curl https://get.helm.sh/helm-v3.13.2-linux-amd64.tar.gz | tar xz
sudo mv linux-amd64/helm /usr/local/bin/

# Verify installation
helm version

# Add popular chart repositories
helm repo add stable https://charts.helm.sh/stable
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# List available repositories
helm repo list