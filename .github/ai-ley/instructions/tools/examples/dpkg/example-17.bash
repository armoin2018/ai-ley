# Package Database Recovery
cp -a /var/lib/dpkg /var/lib/dpkg.backup
dpkg --clear-selections
dpkg --set-selections < /backup/package-selections.txt
apt-get dselect-upgrade

# Force Package Removal
dpkg --remove --force-remove-reinstreq package-name
dpkg --purge --force-remove-essential package-name
dpkg --force-all -i package.deb         # Nuclear option - use with extreme caution

# Alternative Database Reconstruction
cd /var/lib/dpkg
rm status
touch status
dpkg --configure -a
apt-get install --reinstall $(dpkg -l | grep "^ii" | awk '{print $2}')