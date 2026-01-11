# Enterprise Linux (RHEL 8/9, CentOS Stream, Rocky Linux, AlmaLinux)
sudo dnf install -y podman buildah skopeo crun runc
sudo dnf install -y podman-compose podman-plugins netavark aardvark-dns
sudo dnf install -y containers-common containers-common-extra

# Ubuntu/Debian Enterprise
sudo apt update
sudo apt install -y podman buildah skopeo runc crun
sudo apt install -y podman-compose netavark aardvark-dns
sudo apt install -y containernetworking-plugins containers-common

# Enterprise macOS (Development/Testing)
brew install podman buildah skopeo
podman machine init --cpus 4 --memory 8192 --disk-size 100
podman machine start

# Enterprise Windows (WSL2 + Development)
winget install RedHat.Podman
# Or via Chocolatey
choco install podman-desktop podman-cli

# Verify enterprise installation
podman --version
buildah --version
skopeo --version

# Install enterprise extensions
sudo dnf install -y podman-docker    # Docker CLI compatibility
sudo dnf install -y cockpit-podman   # Web management interface