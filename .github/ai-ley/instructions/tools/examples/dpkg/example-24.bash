# Multi-architecture package management
dpkg --add-architecture i386
dpkg --print-architecture                # Show native architecture
dpkg --print-foreign-architectures       # Show foreign architectures

# Package repository management
reprepro -b /opt/repo includedeb stable package.deb
aptly repo add myrepo package.deb
aptly snapshot create myrepo-snapshot from repo myrepo
aptly publish snapshot myrepo-snapshot