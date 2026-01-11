# RPM development tools
rpmbuild -ba package.spec           # Build binary and source RPM
rpmbuild -bb package.spec           # Build binary RPM only
rpmbuild -bs package.spec           # Build source RPM only
rpmdev-setuptree                    # Setup build directory structure
rpmdev-newspec                      # Create new SPEC file template
spectool -g -R package.spec         # Download sources
rpmlint package.spec                # Check SPEC file quality
rpmlint package.rpm                 # Check RPM package quality

# Package analysis
rpm -qip package.rpm                # Query package information
rpm -qlp package.rpm                # List package files
rpm -qRp package.rpm                # List package dependencies
rpm -q --scripts package-name       # Show package scripts
rpm -q --changelog package-name     # Show package changelog
rpm --verify package-name           # Verify package files