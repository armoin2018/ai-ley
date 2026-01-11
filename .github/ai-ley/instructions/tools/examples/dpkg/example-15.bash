# Package Database Performance
time dpkg -l | wc -l                    # Database query performance
du -sh /var/lib/dpkg/                   # Database storage usage
lsof /var/lib/dpkg/lock-frontend        # Check for locking issues

# Installation Performance Tracking
#!/bin/bash
track_installation() {
    local package="$1"
    local start_time=$(date +%s)
    
    dpkg -i "$package"
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    echo "Package $(basename $package) installed in ${duration}s" >> /var/log/package-performance.log
}