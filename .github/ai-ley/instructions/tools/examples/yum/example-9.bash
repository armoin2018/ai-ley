# Security updates
yum --security check-update           # Check for security updates
yum --security update                 # Install security updates only
yum updateinfo list security          # List security advisories
yum updateinfo info CVE-2021-1234     # Show specific CVE information

# System maintenance
package-cleanup --problems            # Find dependency problems
package-cleanup --orphans             # Find orphaned packages
package-cleanup --oldkernels          # Remove old kernel packages
yum-complete-transaction              # Complete interrupted transactions
rpm --rebuilddb                       # Rebuild RPM database