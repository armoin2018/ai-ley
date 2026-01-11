# Configure user namespaces for enterprise security
echo "$(whoami):100000:65536" | sudo tee -a /etc/subuid
echo "$(whoami):100000:65536" | sudo tee -a /etc/subgid

# Enterprise container resource limits
mkdir -p ~/.config/containers
cat > ~/.config/containers/containers.conf << 'EOF'
[containers]
# Enterprise security defaults
default_sysctls = [
  "net.ipv4.ping_group_range=0 0",
]
default_capabilities = [
  "CHOWN", "DAC_OVERRIDE", "FOWNER", "FSETID", "KILL", "NET_BIND_SERVICE",
  "NET_RAW", "SETFCAP", "SETGID", "SETPCAP", "SETUID", "SYS_CHROOT"
]
default_ulimits = [
  "nofile=65536:65536",
  "nproc=4096:4096"
]

# Enterprise runtime configuration
runtime = "crun"
conmon_path = ["/usr/bin/conmon"]
events_logger = "journald"
log_driver = "journald"

# Enterprise networking defaults
dns_servers = ["8.8.8.8", "1.1.1.1"]
dns_searches = ["enterprise.local"]
dns_options = ["use-vc"]

# Enterprise image security
pull_policy = "always"
EOF

# Enterprise registry configuration
cat > ~/.config/containers/registries.conf << 'EOF'
[registries.search]
registries = ["registry.redhat.io", "quay.io", "docker.io"]

[registries.insecure]
registries = []

[registries.block]
registries = []

# Enterprise registry mirrors
[[registry]]
prefix = "docker.io"
location = "registry-mirror.enterprise.local:5000"

[[registry.mirror]]
location = "registry.redhat.io"
pull-from-mirror = "digest-only"

# Enterprise image signing policy
[registries]
default = [{"type": "insecureAcceptAnything"}]

[transports]
docker-daemon = {"": [{"type": "insecureAcceptAnything"}]}
EOF

# Enable enterprise systemd services
systemctl --user enable podman.socket
systemctl --user start podman.socket
loginctl enable-linger $(whoami)

echo "Enterprise Podman rootless configuration completed successfully"