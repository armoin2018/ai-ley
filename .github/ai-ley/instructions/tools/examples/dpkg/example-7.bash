# Package List Export/Import
dpkg --get-selections > /backup/package-selections.txt
debconf-get-selections > /backup/debconf-selections.txt

# On target system
dpkg --clear-selections
dpkg --set-selections < /backup/package-selections.txt
apt-get dselect-upgrade

# Differential Package Analysis
comm -23 <(dpkg -l | grep "^ii" | awk '{print $2}' | sort) \
         <(cat baseline-packages.txt | sort) > additional-packages.txt