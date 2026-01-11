#!/bin/bash
# Advanced RPM management and analysis script

# Package verification and integrity checking
verify_system_packages() {
    echo "Performing comprehensive package verification"
    
    # Verify all installed packages
    echo "Verifying all packages (this may take a while)..."
    rpm -Va > /tmp/rpm-verify.log 2>&1
    
    # Analyze verification results
    if [ -s /tmp/rpm-verify.log ]; then
        echo "Package verification issues found:"
        cat /tmp/rpm-verify.log
        
        # Categorize issues
        echo -e "\nConfiguration files modified:"
        grep '^..5' /tmp/rpm-verify.log || echo "None"
        
        echo -e "\nMissing files:"
        grep '^missing' /tmp/rpm-verify.log || echo "None"
        
        echo -e "\nSize changes:"
        grep '^S' /tmp/rpm-verify.log || echo "None"
    else
        echo "All packages verified successfully"
    fi
}

# Package dependency analysis
analyze_dependencies() {
    local package="$1"
    
    echo "Analyzing dependencies for: $package"
    
    # Show package dependencies
    echo "Package requires:"
    rpm -qR "$package" | sort
    
    echo -e "\nWhat provides this package's dependencies:"
    rpm -qR "$package" | while read dep; do
        echo "Dependency: $dep"
        rpm -q --whatprovides "$dep" 2>/dev/null || echo "  Not found"
    done
    
    echo -e "\nPackages that depend on $package:"
    rpm -q --whatrequires "$package" 2>/dev/null || echo "None"
    
    # Show package conflicts
    echo -e "\nPackage conflicts:"
    rpm -q --conflicts "$package" 2>/dev/null || echo "None"
}

# Package file ownership analysis
analyze_file_ownership() {
    local file_path="$1"
    
    echo "Analyzing file ownership for: $file_path"
    
    # Check if file exists
    if [ ! -e "$file_path" ]; then
        echo "File does not exist: $file_path"
        return 1
    fi
    
    # Find owning package
    owning_package=$(rpm -qf "$file_path" 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        echo "File owned by package: $owning_package"
        
        # Show package information
        echo -e "\nPackage details:"
        rpm -qi "$owning_package"
        
        # Show file details within package
        echo -e "\nFile details in package:"
        rpm -ql "$owning_package" | grep "$(basename "$file_path")"
    else
        echo "File not owned by any RPM package"
        
        # Check if it's a configuration file
        echo "File system information:"
        ls -la "$file_path"
        file "$file_path"
    fi
}

# Package comparison and differences
compare_packages() {
    local package1="$1"
    local package2="$2"
    
    echo "Comparing packages: $package1 vs $package2"
    
    # Get file lists
    rpm -ql "$package1" | sort > /tmp/pkg1_files.list
    rpm -ql "$package2" | sort > /tmp/pkg2_files.list
    
    # Compare file lists
    echo "Files only in $package1:"
    comm -23 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    echo -e "\nFiles only in $package2:"
    comm -13 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    echo -e "\nCommon files:"
    comm -12 /tmp/pkg1_files.list /tmp/pkg2_files.list
    
    # Compare dependencies
    echo -e "\nDependency comparison:"
    echo "Dependencies only in $package1:"
    comm -23 <(rpm -qR "$package1" | sort) <(rpm -qR "$package2" | sort)
    
    echo -e "\nDependencies only in $package2:"
    comm -13 <(rpm -qR "$package1" | sort) <(rpm -qR "$package2" | sort)
    
    # Cleanup
    rm -f /tmp/pkg1_files.list /tmp/pkg2_files.list
}

# Security and vulnerability analysis
security_analysis() {
    echo "Performing security analysis"
    
    # Check for packages with security updates
    echo "Checking for security updates..."
    yum --security check-update 2>/dev/null || echo "No security updates or yum not available"
    
    # Verify package signatures
    echo -e "\nVerifying package signatures for critical packages..."
    critical_packages=("kernel" "glibc" "openssl" "openssh" "sudo")
    
    for pkg in "${critical_packages[@]}"; do
        if rpm -q "$pkg" >/dev/null 2>&1; then
            echo "Verifying $pkg signature..."
            rpm -qi "$pkg" | grep "Signature"
        fi
    done
    
    # Check for packages without signatures
    echo -e "\nPackages without signatures:"
    rpm -qa --qf "%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}: %{SIGPGP:pgpsig}\n" | \
        grep "none" | head -10
}

# Package history and rollback preparation
package_history() {
    echo "Package installation history"
    
    # Show recent package operations
    echo "Recent RPM transactions:"
    rpm -qa --last | head -20
    
    # Show package installation dates
    echo -e "\nPackage installation timeline:"
    rpm -qa --qf "%{NAME}-%{VERSION}-%{RELEASE}: %{INSTALLTIME:date}\n" | \
        sort -k2 | tail -20
    
    # Identify recently modified packages
    echo -e "\nPackages modified in last 7 days:"
    find /var/lib/rpm -name "*.rpm" -mtime -7 2>/dev/null || \
        echo "No recent package database modifications found"
}

# Main function dispatcher
main() {
    case "${1:-help}" in
        "verify")
            verify_system_packages
            ;;
        "deps")
            if [ -z "${2:-}" ]; then
                echo "Usage: $0 deps <package-name>"
                exit 1
            fi
            analyze_dependencies "$2"
            ;;
        "file")
            if [ -z "${2:-}" ]; then
                echo "Usage: $0 file <file-path>"
                exit 1
            fi
            analyze_file_ownership "$2"
            ;;
        "compare")
            if [ -z "${2:-}" ] || [ -z "${3:-}" ]; then
                echo "Usage: $0 compare <package1> <package2>"
                exit 1
            fi
            compare_packages "$2" "$3"
            ;;
        "security")
            security_analysis
            ;;
        "history")
            package_history
            ;;
        "help"|*)
            echo "Usage: $0 {verify|deps|file|compare|security|history}"
            echo ""
            echo "Commands:"
            echo "  verify          - Verify all installed packages"
            echo "  deps <pkg>      - Analyze package dependencies"
            echo "  file <path>     - Analyze file ownership"
            echo "  compare <p1> <p2> - Compare two packages"
            echo "  security        - Perform security analysis"
            echo "  history         - Show package history"
            ;;
    esac
}

main "$@"