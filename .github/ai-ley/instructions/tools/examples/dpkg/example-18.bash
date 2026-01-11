# Package Management Metrics
TOTAL_PACKAGES=$(dpkg -l | grep "^ii" | wc -l)
BROKEN_PACKAGES=$(dpkg --audit 2>/dev/null | grep "Package" | wc -l)
CONFIG_FILES=$(find /etc -name "*.dpkg-*" | wc -l)
DATABASE_SIZE=$(du -sh /var/lib/dpkg/ | cut -f1)

echo "System Package Metrics:"
echo "Total Installed Packages: $TOTAL_PACKAGES"
echo "Broken Packages: $BROKEN_PACKAGES"
echo "Configuration Backups: $CONFIG_FILES"
echo "Database Size: $DATABASE_SIZE"

# Package Installation Success Rate
SUCCESS_RATE=$(grep "status installed" /var/log/dpkg.log | wc -l)
TOTAL_OPERATIONS=$(grep "install\|remove\|configure" /var/log/dpkg.log | wc -l)
echo "Installation Success Rate: $(bc -l <<< "scale=2; $SUCCESS_RATE/$TOTAL_OPERATIONS*100")%"