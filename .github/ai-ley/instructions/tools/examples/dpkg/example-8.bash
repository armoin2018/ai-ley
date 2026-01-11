# Local Repository Setup
mkdir -p /opt/local-repo
cp *.deb /opt/local-repo/
cd /opt/local-repo && dpkg-scanpackages . /dev/null | gzip -9c > Packages.gz

# Repository Integration
echo "deb [trusted=yes] file:///opt/local-repo ./" > /etc/apt/sources.list.d/local.list
apt-get update

# Package Verification and Integrity
for package in *.deb; do
    echo "Verifying $package"
    dpkg -I "$package" | grep -E "Package|Version|Architecture"
    dpkg --contents "$package" | head -5
done