# Package Installation Monitoring
strace -e trace=file dpkg -i package.deb 2>&1 | grep -E "(open|stat)"
inotifywait -m -r -e create,modify,delete /var/lib/dpkg/

# Debug Package Issues
dpkg --debug=77777 -i package.deb       # Maximum debug output
DEBCONF_DEBUG=developer dpkg-reconfigure package-name
dpkg -D1 --configure package-name       # Debug configuration

# System State Analysis
dpkg --verify | grep -v "^??"           # Show file modifications
dpkg -l | awk '/^.[^i]/ {print $2}'     # Non-installed packages
find /var/lib/dpkg/info -name "*.list" -size 0  # Empty file lists