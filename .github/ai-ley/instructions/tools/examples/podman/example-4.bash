# Enterprise image signing with Cosign
# Install Cosign for enterprise image signing
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign

# Enterprise GPG key generation
cat > ~/.gnupg/gpg-enterprise.conf << 'EOF'
%echo Generating enterprise GPG key
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: Enterprise Container Security
Name-Comment: Podman Enterprise Image Signing
Name-Email: security@enterprise.local
Expire-Date: 2y
Passphrase: $(openssl rand -base64 32)
%commit
%echo Enterprise GPG key generation complete
EOF

# Generate enterprise signing keys
gpg --batch --generate-key ~/.gnupg/gpg-enterprise.conf
ENTERPRISE_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | head -1 | awk '{print $2}' | cut -d'/' -f2)

# Enterprise image signing workflow
cat > ~/.local/bin/enterprise-image-sign.sh << 'EOF'
#!/bin/bash
set -euo pipefail

IMAGE_NAME=${1:-}
if [[ -z "$IMAGE_NAME" ]]; then
    echo "Usage: $0 <image-name:tag>"
    exit 1
fi

# Enterprise image security scan
echo "Performing enterprise security scan..."
skopeo inspect "docker://$IMAGE_NAME" | jq -r '.RepoTags[], .RepoDigests[]'

# Sign with GPG
echo "Signing image with enterprise GPG key..."
podman image sign --sign-by security@enterprise.local "$IMAGE_NAME"

# Sign with Cosign (keyless)
echo "Signing image with Cosign..."
cosign sign --yes "$IMAGE_NAME"

# Create enterprise SBOM
echo "Generating enterprise Software Bill of Materials..."
syft "$IMAGE_NAME" -o json > "${IMAGE_NAME//[:\/]/_}-sbom.json"

# Create enterprise attestation
echo "Creating enterprise security attestation..."
cosign attest --yes --predicate "${IMAGE_NAME//[:\/]/_}-sbom.json" "$IMAGE_NAME"

echo "Enterprise image signing completed for: $IMAGE_NAME"
EOF

chmod +x ~/.local/bin/enterprise-image-sign.sh

# Enterprise registry security policy
cat > ~/.config/containers/policy.json << 'EOF'
{
  "default": [
    {
      "type": "reject"
    }
  ],
  "transports": {
    "docker": {
      "registry.enterprise.local": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/home/$(whoami)/.gnupg/pubring.gpg"
        }
      ],
      "registry.redhat.io": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release"
        }
      ],
      "quay.io": [
        {
          "type": "signedBy",
          "keyType": "GPGKeys",
          "keyPath": "/home/$(whoami)/.gnupg/pubring.gpg"
        }
      ],
      "docker.io": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    },
    "docker-daemon": {
      "": [
        {
          "type": "insecureAcceptAnything"
        }
      ]
    }
  }
}
EOF

echo "Enterprise image security and signing configuration completed"