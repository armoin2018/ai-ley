# Prometheus metrics exporter
cat > /usr/local/bin/dpkg-exporter << 'EOF'
#!/bin/bash
echo "# HELP dpkg_packages_total Total number of installed packages"
echo "# TYPE dpkg_packages_total gauge"
echo "dpkg_packages_total $(dpkg -l | grep '^ii' | wc -l)"

echo "# HELP dpkg_packages_broken Number of broken packages"
echo "# TYPE dpkg_packages_broken gauge"
echo "dpkg_packages_broken $(dpkg --audit 2>/dev/null | grep 'Package' | wc -l)"
EOF
chmod +x /usr/local/bin/dpkg-exporter