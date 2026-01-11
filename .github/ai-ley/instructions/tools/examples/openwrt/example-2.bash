#!/bin/bash
# openwrt-security-hardening.sh - Advanced security hardening for OpenWrt

set -euo pipefail

# Configuration variables
MANAGEMENT_VLAN="100"
IOT_VLAN="10"
GUEST_VLAN="20"
ADMIN_IP="192.168.1.100"
SYSLOG_SERVER="192.168.1.10"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a /tmp/hardening.log
}

configure_advanced_firewall() {
    log_message "Configuring advanced firewall rules"

    # Enable SYN flood protection
    uci set firewall.@defaults[0].syn_flood='1'
    uci set firewall.@defaults[0].tcp_syncookies='1'
    uci set firewall.@defaults[0].tcp_window_scaling='1'

    # Configure advanced zones
    uci add firewall zone
    uci set firewall.@zone[-1].name='management'
    uci set firewall.@zone[-1].network='management'
    uci set firewall.@zone[-1].input='ACCEPT'
    uci set firewall.@zone[-1].output='ACCEPT'
    uci set firewall.@zone[-1].forward='REJECT'

    # Management network access rules
    uci add firewall rule
    uci set firewall.@rule[-1].name='Allow-Management-SSH'
    uci set firewall.@rule[-1].src='management'
    uci set firewall.@rule[-1].dest_port='22'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].target='ACCEPT'

    uci add firewall rule
    uci set firewall.@rule[-1].name='Allow-Management-HTTPS'
    uci set firewall.@rule[-1].src='management'
    uci set firewall.@rule[-1].dest_port='443'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].target='ACCEPT'

    # Block inter-VLAN communication
    uci add firewall rule
    uci set firewall.@rule[-1].name='Block-IoT-to-LAN'
    uci set firewall.@rule[-1].src='iot'
    uci set firewall.@rule[-1].dest='lan'
    uci set firewall.@rule[-1].target='REJECT'

    uci add firewall rule
    uci set firewall.@rule[-1].name='Block-Guest-to-LAN'
    uci set firewall.@rule[-1].src='guest'
    uci set firewall.@rule[-1].dest='lan'
    uci set firewall.@rule[-1].target='REJECT'

    # DDoS protection rules
    uci add firewall rule
    uci set firewall.@rule[-1].name='DDoS-Protection'
    uci set firewall.@rule[-1].src='wan'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].extra='--tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE'
    uci set firewall.@rule[-1].target='DROP'

    uci commit firewall
    /etc/init.d/firewall restart
    log_message "Advanced firewall configuration completed"
}

setup_network_segmentation() {
    log_message "Setting up network segmentation"

    # Create VLANs
    uci set network.@switch[0].ports='0t 1 2 3 4 6t'
    uci set network.@switch_vlan[0].vlan='1'
    uci set network.@switch_vlan[0].ports='1 2 3 6t'

    # Management VLAN
    uci add network switch_vlan
    uci set network.@switch_vlan[-1].device='switch0'
    uci set network.@switch_vlan[-1].vlan="${MANAGEMENT_VLAN}"
    uci set network.@switch_vlan[-1].ports="0t 6t"

    uci add network interface
    uci set network.@interface[-1].name='management'
    uci set network.@interface[-1].proto='static'
    uci set network.@interface[-1].ifname="eth0.${MANAGEMENT_VLAN}"
    uci set network.@interface[-1].ipaddr='192.168.100.1'
    uci set network.@interface[-1].netmask='255.255.255.0'

    # IoT VLAN
    uci add network switch_vlan
    uci set network.@switch_vlan[-1].device='switch0'
    uci set network.@switch_vlan[-1].vlan="${IOT_VLAN}"
    uci set network.@switch_vlan[-1].ports="4 6t"

    uci add network interface
    uci set network.@interface[-1].name='iot'
    uci set network.@interface[-1].proto='static'
    uci set network.@interface[-1].ifname="eth0.${IOT_VLAN}"
    uci set network.@interface[-1].ipaddr='192.168.10.1'
    uci set network.@interface[-1].netmask='255.255.255.0'

    uci commit network
    /etc/init.d/network restart
    log_message "Network segmentation configured"
}

configure_wifi_security() {
    log_message "Configuring advanced WiFi security"

    # Disable WPS on all radios
    uci set wireless.default_radio0.wps_pushbutton='0'
    uci set wireless.default_radio1.wps_pushbutton='0'

    # Enable WPA3 with fallback to WPA2
    uci set wireless.default_radio0.encryption='sae-mixed'
    uci set wireless.default_radio0.ieee80211w='2'  # PMF required
    uci set wireless.default_radio0.wpa_disable_eapol_key_retries='1'

    # Configure enterprise WiFi with RADIUS
    uci add wireless wifi-iface
    uci set wireless.@wifi-iface[-1].device='radio1'
    uci set wireless.@wifi-iface[-1].network='lan'
    uci set wireless.@wifi-iface[-1].mode='ap'
    uci set wireless.@wifi-iface[-1].ssid='Enterprise-WiFi'
    uci set wireless.@wifi-iface[-1].encryption='wpa2'
    uci set wireless.@wifi-iface[-1].server='192.168.1.10'
    uci set wireless.@wifi-iface[-1].port='1812'
    uci set wireless.@wifi-iface[-1].key='radius-secret'
    uci set wireless.@wifi-iface[-1].ieee80211w='1'

    # Guest network with captive portal
    uci add wireless wifi-iface
    uci set wireless.@wifi-iface[-1].device='radio0'
    uci set wireless.@wifi-iface[-1].network='guest'
    uci set wireless.@wifi-iface[-1].mode='ap'
    uci set wireless.@wifi-iface[-1].ssid='Guest-Network'
    uci set wireless.@wifi-iface[-1].encryption='psk2'
    uci set wireless.@wifi-iface[-1].key='guest-password'
    uci set wireless.@wifi-iface[-1].isolate='1'
    uci set wireless.@wifi-iface[-1].maxassoc='10'

    uci commit wireless
    wifi reload
    log_message "WiFi security configuration completed"
}

setup_intrusion_detection() {
    log_message "Setting up intrusion detection"

    # Install and configure suricata
    opkg update
    opkg install suricata

    # Basic suricata configuration
    cat > /etc/suricata/suricata.yaml << 'EOF'
vars:
  address-groups:
    HOME_NET: "[192.168.0.0/16,10.0.0.0/8,172.16.0.0/12]"
    EXTERNAL_NET: "!$HOME_NET"

default-log-dir: /var/log/suricata/

outputs:
  - fast:
      enabled: yes
      filename: fast.log
      append: yes

  - eve-log:
      enabled: yes
      filetype: regular
      filename: eve.json
      types:
        - alert
        - http
        - dns
        - tls
        - ssh
        - smtp

af-packet:
  - interface: br-lan
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes

  - interface: eth0.2
    cluster-id: 98
    cluster-type: cluster_flow
    defrag: yes

rule-files:
  - suricata.rules
  - emerging-threats.rules

classification-file: /etc/suricata/classification.config
reference-config-file: /etc/suricata/reference.config
EOF

    # Enable suricata service
    /etc/init.d/suricata enable
    /etc/init.d/suricata start

    log_message "Intrusion detection system configured"
}

configure_logging_and_monitoring() {
    log_message "Configuring comprehensive logging and monitoring"

    # Configure remote syslog
    uci set system.@system[0].log_ip="${SYSLOG_SERVER}"
    uci set system.@system[0].log_port='514'
    uci set system.@system[0].log_proto='udp'
    uci set system.@system[0].log_remote='1'
    uci set system.@system[0].log_size='1024'

    # Install and configure collectd
    opkg install collectd collectd-mod-cpu collectd-mod-memory collectd-mod-load \
                collectd-mod-interface collectd-mod-wireless collectd-mod-processes \
                collectd-mod-df collectd-mod-network

    cat > /etc/collectd.conf << EOF
Hostname "$(uci get system.@system[0].hostname)"
FQDNLookup false
BaseDir "/var/lib/collectd"
PluginDir "/usr/lib/collectd"

Interval 60
Timeout 2
ReadThreads 5
WriteThreads 1

LoadPlugin cpu
LoadPlugin memory
LoadPlugin load
LoadPlugin interface
LoadPlugin wireless
LoadPlugin processes
LoadPlugin df
LoadPlugin network

<Plugin "cpu">
    ReportByCpu true
    ValuesPercentage true
</Plugin>

<Plugin "memory">
    ValuesAbsolute true
    ValuesPercentage false
</Plugin>

<Plugin "interface">
    Interface "br-lan"
    Interface "eth0"
    Interface "wlan0"
    Interface "wlan1"
</Plugin>

<Plugin "df">
    Device "/dev/root"
    MountPoint "/"
</Plugin>

<Plugin "network">
    Server "${SYSLOG_SERVER}" "25826"
</Plugin>
EOF

    /etc/init.d/collectd enable
    /etc/init.d/collectd start

    uci commit system
    /etc/init.d/system reload

    log_message "Logging and monitoring configured"
}

setup_automated_backup() {
    log_message "Setting up automated configuration backup"

    # Create backup script
    cat > /usr/bin/openwrt-backup.sh << 'EOF'
#!/bin/bash

BACKUP_DIR="/tmp/backups"
BACKUP_SERVER="backup@192.168.1.10"
HOSTNAME=$(uci get system.@system[0].hostname)
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "${BACKUP_DIR}"

# Create configuration backup
sysupgrade -b "${BACKUP_DIR}/${HOSTNAME}_${DATE}.tar.gz"

# Upload to backup server
scp "${BACKUP_DIR}/${HOSTNAME}_${DATE}.tar.gz" "${BACKUP_SERVER}:/backups/"

# Keep only last 5 local backups
ls -t "${BACKUP_DIR}"/*.tar.gz | tail -n +6 | xargs rm -f

logger "Configuration backup completed: ${HOSTNAME}_${DATE}.tar.gz"
EOF

    chmod +x /usr/bin/openwrt-backup.sh

    # Add cron job for daily backups
    echo "0 2 * * * /usr/bin/openwrt-backup.sh" >> /etc/crontabs/root
    /etc/init.d/cron restart

    log_message "Automated backup configured"
}

apply_security_hardening() {
    log_message "Applying additional security hardening"

    # Disable unused services
    /etc/init.d/uhttpd stop
    /etc/init.d/uhttpd disable

    # Configure secure SSH
    uci set dropbear.@dropbear[0].PasswordAuth='off'
    uci set dropbear.@dropbear[0].RootPasswordAuth='off'
    uci set dropbear.@dropbear[0].Port='22'
    uci set dropbear.@dropbear[0].Interface='management'
    uci commit dropbear
    /etc/init.d/dropbear restart

    # Set strong root password policy
    # (This would be done during initial setup)

    # Disable WAN management access
    uci add firewall rule
    uci set firewall.@rule[-1].name='Block-WAN-SSH'
    uci set firewall.@rule[-1].src='wan'
    uci set firewall.@rule[-1].dest_port='22'
    uci set firewall.@rule[-1].proto='tcp'
    uci set firewall.@rule[-1].target='REJECT'

    # Enable fail2ban-like protection
    opkg install luci-app-banip
    uci set banip.global.ban_enabled='1'
    uci set banip.global.ban_logcount='3'
    uci set banip.global.ban_logterm='ssh'
    uci commit banip
    /etc/init.d/banip enable
    /etc/init.d/banip start

    uci commit firewall
    /etc/init.d/firewall restart

    log_message "Security hardening applied"
}

main() {
    log_message "Starting OpenWrt enterprise security hardening"

    configure_advanced_firewall
    setup_network_segmentation
    configure_wifi_security
    setup_intrusion_detection
    configure_logging_and_monitoring
    setup_automated_backup
    apply_security_hardening

    log_message "OpenWrt enterprise security hardening completed"
    log_message "Please reboot the system to ensure all changes take effect"
}

main "$@"