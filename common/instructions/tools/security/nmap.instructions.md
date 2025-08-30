`
---
applyTo: "nmap, network-scanner, security-scanning, port-scanning, vulnerability-assessment"
---

# Nmap Network Security Scanner Instructions

## Overview
- **Domain**: Network Discovery and Security Auditing Tool for Infrastructure Assessment
- **Purpose**: Perform network reconnaissance, port scanning, service detection, and vulnerability assessment
- **Applicable To**: Security auditing, network mapping, penetration testing, infrastructure monitoring
- **Integration Level**: Security workflows, DevSecOps pipelines, and network monitoring systems

## Core Principles

### Fundamental Concepts
1. **Network Discovery**: Identify live hosts and network topology
2. **Port Scanning**: Detect open ports and running services
3. **Service Detection**: Fingerprint applications and service versions
4. **OS Detection**: Identify operating systems and device types
5. **Vulnerability Assessment**: Detect known security vulnerabilities
6. **Scriptable Engine**: Extensible NSE (Nmap Scripting Engine) for custom scanning

### Key Benefits
- Comprehensive network reconnaissance and mapping
- Fast and efficient scanning algorithms
- Extensive service and OS fingerprinting database
- Powerful scripting engine for custom vulnerability checks
- Cross-platform compatibility with consistent results
- Industry-standard tool for security assessments

### Common Misconceptions
- **Myth**: Nmap is only for malicious activities
  **Reality**: Nmap is a legitimate security tool used by professionals for authorized network assessment
- **Myth**: Nmap scans are always detectable
  **Reality**: Nmap offers stealth scanning techniques to minimize detection

## Implementation Framework

### Getting Started
#### Prerequisites
- Administrative privileges for certain scan types
- Network access to target systems
- Understanding of TCP/IP networking concepts
- Authorization to scan target networks (critical for legal compliance)

#### Initial Setup
```bash
# Install Nmap (Ubuntu/Debian)
sudo apt-get update
sudo apt-get install nmap

# Install Nmap (CentOS/RHEL)
sudo yum install nmap
# or for newer versions
sudo dnf install nmap

# Install Nmap (macOS with Homebrew)
brew install nmap

# Install Nmap (Windows)
# Download from https://nmap.org/download.html

# Verify installation
nmap --version

# Update Nmap databases
sudo nmap --script-updatedb

# Check installed NSE scripts
nmap --script-help all | head -20
```

### Core Methodologies
#### Network Infrastructure Assessment
- **Purpose**: Systematically map and assess network infrastructure security posture
- **When to Use**: Security audits, penetration testing, network documentation
- **Implementation Steps**:
  1. Define scope and obtain proper authorization
  2. Perform host discovery and network mapping
  3. Conduct comprehensive port scanning
  4. Execute service detection and OS fingerprinting
  5. Run vulnerability assessment scripts
  6. Document findings and generate reports
- **Success Metrics**: Complete network visibility with identified security issues and comprehensive documentation

#### DevSecOps Integration Strategy
- **Purpose**: Integrate network security scanning into CI/CD pipelines
- **When to Use**: Continuous security monitoring, infrastructure deployment validation
- **Implementation Steps**:
  1. Define automated scanning policies and schedules
  2. Integrate Nmap scans into deployment workflows
  3. Implement result parsing and alerting systems
  4. Create security dashboards and reporting
  5. Establish remediation workflows for findings
- **Success Metrics**: Automated security scanning with integrated alerting and reduced time-to-detection

### Process Integration
#### Enterprise Security Scanning Framework
```bash
#!/bin/bash
# Comprehensive enterprise network security scanning framework

set -euo pipefail

# Configuration
SCAN_CONFIG_DIR="/etc/nmap/scans"
RESULTS_DIR="/var/log/nmap-scans"
REPORT_DIR="/opt/security-reports"
LOG_FILE="/var/log/nmap-enterprise.log"
NOTIFICATION_EMAIL="security-team@company.com"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Network discovery and mapping
network_discovery() {
    local network_range="$1"
    local scan_name="${2:-discovery}"
    
    log "Starting network discovery for $network_range"
    
    local output_file="$RESULTS_DIR/${scan_name}_discovery_$(date +%Y%m%d_%H%M%S)"
    
    # Host discovery scan
    nmap -sn "$network_range" \
        --privileged \
        --reason \
        -oA "$output_file" \
        -v
    
    # Parse and format results
    local live_hosts=$(grep "Host is up" "$output_file.nmap" | wc -l)
    log "Network discovery completed: $live_hosts live hosts found"
    
    # Generate host list for further scanning
    grep "Nmap scan report" "$output_file.nmap" | \
        awk '{print $5}' > "$output_file.hosts"
    
    echo "$output_file.hosts"
}

# Comprehensive port scanning
comprehensive_scan() {
    local target="$1"
    local scan_type="${2:-comprehensive}"
    local scan_name="${3:-portscan}"
    
    log "Starting comprehensive scan of $target"
    
    local output_file="$RESULTS_DIR/${scan_name}_comprehensive_$(date +%Y%m%d_%H%M%S)"
    
    # Comprehensive TCP scan with service detection
    nmap -sS -sV -O \
        --version-intensity 9 \
        --osscan-guess \
        -p 1-65535 \
        --min-rate 1000 \
        --max-retries 3 \
        --host-timeout 30m \
        --script=default,vuln \
        --reason \
        -oA "$output_file" \
        "$target" \
        -v
    
    # UDP scan for critical services
    nmap -sU \
        --top-ports 1000 \
        --version-intensity 0 \
        --host-timeout 15m \
        -oA "${output_file}_udp" \
        "$target" \
        -v
    
    log "Comprehensive scan completed for $target"
    echo "$output_file"
}

# Vulnerability assessment
vulnerability_scan() {
    local target="$1"
    local scan_name="${2:-vuln}"
    
    log "Starting vulnerability assessment for $target"
    
    local output_file="$RESULTS_DIR/${scan_name}_vulnerability_$(date +%Y%m%d_%H%M%S)"
    
    # Vulnerability scanning with NSE scripts
    nmap -sV \
        --script="vuln,exploit,dos,brute,auth,discovery" \
        --script-args="unsafe=1" \
        --version-intensity 9 \
        -p- \
        --max-rate 500 \
        --host-timeout 60m \
        -oA "$output_file" \
        "$target" \
        -v
    
    # Parse vulnerabilities
    grep -E "(VULNERABLE|CVE-|EXPLOIT)" "$output_file.nmap" > "$output_file.vulnerabilities" || true
    
    local vuln_count=$(wc -l < "$output_file.vulnerabilities" 2>/dev/null || echo "0")
    log "Vulnerability assessment completed: $vuln_count potential vulnerabilities found"
    
    echo "$output_file"
}

# Stealth scanning for sensitive environments
stealth_scan() {
    local target="$1"
    local scan_name="${2:-stealth}"
    
    log "Starting stealth scan for $target"
    
    local output_file="$RESULTS_DIR/${scan_name}_stealth_$(date +%Y%m%d_%H%M%S)"
    
    # Fragmented SYN scan with timing controls
    nmap -sS -f -T2 \
        --source-port 53 \
        --data-length 25 \
        --randomize-hosts \
        --spoof-mac 0 \
        -D RND:10 \
        --top-ports 1000 \
        -oA "$output_file" \
        "$target" \
        -v
    
    log "Stealth scan completed for $target"
    echo "$output_file"
}

# Custom NSE script execution
custom_script_scan() {
    local target="$1"
    local script_category="$2"
    local scan_name="${3:-custom}"
    
    log "Starting custom NSE script scan ($script_category) for $target"
    
    local output_file="$RESULTS_DIR/${scan_name}_nse_$(date +%Y%m%d_%H%M%S)"
    
    # Execute specific NSE script categories
    nmap -sV \
        --script="$script_category" \
        --script-args="http.useragent='Mozilla/5.0 (compatible; Security Scanner)'" \
        -p 80,443,8080,8443,21,22,23,25,53,110,143,993,995 \
        -oA "$output_file" \
        "$target" \
        -v
    
    log "Custom NSE script scan completed for $target"
    echo "$output_file"
}

# Report generation and analysis
generate_report() {
    local scan_results=("$@")
    local report_file="$REPORT_DIR/security_scan_report_$(date +%Y%m%d_%H%M%S).html"
    
    log "Generating comprehensive security report"
    
    # Create HTML report
    cat > "$report_file" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Network Security Scan Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .header { background-color: #f0f0f0; padding: 10px; border-radius: 5px; }
        .section { margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }
        .critical { background-color: #ffebee; border-color: #f44336; }
        .warning { background-color: #fff3e0; border-color: #ff9800; }
        .info { background-color: #e3f2fd; border-color: #2196f3; }
        .vulnerability { margin: 10px 0; padding: 10px; background-color: #fff; border-left: 4px solid #f44336; }
        pre { background-color: #f5f5f5; padding: 10px; border-radius: 3px; overflow-x: auto; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>
EOF
    
    # Add report header
    cat >> "$report_file" << EOF
    <div class="header">
        <h1>Network Security Scan Report</h1>
        <p><strong>Generated:</strong> $(date)</p>
        <p><strong>Scan Duration:</strong> $(date)</p>
        <p><strong>Scanner:</strong> Nmap $(nmap --version | head -1 | awk '{print $3}')</p>
    </div>
EOF
    
    # Process each scan result
    for result_file in "${scan_results[@]}"; do
        if [[ -f "$result_file.nmap" ]]; then
            # Extract key information
            local target=$(grep "Nmap scan report" "$result_file.nmap" | head -1 | awk '{print $5}')
            local open_ports=$(grep "^[0-9]" "$result_file.nmap" | grep "open" | wc -l)
            local services=$(grep "^[0-9]" "$result_file.nmap" | grep "open")
            
            cat >> "$report_file" << EOF
    <div class="section info">
        <h2>Scan Results: $target</h2>
        <p><strong>Open Ports:</strong> $open_ports</p>
        <h3>Services Detected:</h3>
        <pre>$services</pre>
    </div>
EOF
            
            # Add vulnerability information if available
            if [[ -f "$result_file.vulnerabilities" && -s "$result_file.vulnerabilities" ]]; then
                cat >> "$report_file" << EOF
    <div class="section critical">
        <h3>Vulnerabilities Found:</h3>
        <pre>$(cat "$result_file.vulnerabilities")</pre>
    </div>
EOF
            fi
        fi
    done
    
    # Close HTML
    echo "</body></html>" >> "$report_file"
    
    log "Report generated: $report_file"
    
    # Send notification
    if command -v mail &> /dev/null; then
        echo "Security scan completed. Report available at: $report_file" | \
            mail -s "Security Scan Report - $(date +%Y-%m-%d)" "$NOTIFICATION_EMAIL"
    fi
    
    echo "$report_file"
}

# Main scanning orchestrator
main_scan() {
    local scan_config="$1"
    
    if [[ ! -f "$scan_config" ]]; then
        log "ERROR: Scan configuration file not found: $scan_config"
        exit 1
    fi
    
    log "Starting enterprise security scan using configuration: $scan_config"
    
    # Create necessary directories
    mkdir -p "$RESULTS_DIR" "$REPORT_DIR"
    
    local scan_results=()
    
    # Read scan configuration
    while IFS=',' read -r target scan_type scan_name; do
        # Skip comments and empty lines
        [[ "$target" =~ ^#.*$ ]] || [[ -z "$target" ]] && continue
        
        log "Processing target: $target (type: $scan_type)"
        
        case "$scan_type" in
            "discovery")
                result=$(network_discovery "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            "comprehensive")
                result=$(comprehensive_scan "$target" "$scan_type" "$scan_name")
                scan_results+=("$result")
                ;;
            "vulnerability")
                result=$(vulnerability_scan "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            "stealth")
                result=$(stealth_scan "$target" "$scan_name")
                scan_results+=("$result")
                ;;
            *)
                log "WARNING: Unknown scan type: $scan_type"
                ;;
        esac
        
        # Rate limiting between targets
        sleep 5
        
    done < "$scan_config"
    
    # Generate comprehensive report
    if [[ ${#scan_results[@]} -gt 0 ]]; then
        report_file=$(generate_report "${scan_results[@]}")
        log "Enterprise security scan completed. Report: $report_file"
    else
        log "No scan results to process"
    fi
}

# Command dispatcher
case "${1:-help}" in
    "discovery")
        network_discovery "$2" "${3:-discovery}"
        ;;
    "scan")
        comprehensive_scan "$2" "${3:-comprehensive}" "${4:-scan}"
        ;;
    "vuln")
        vulnerability_scan "$2" "${3:-vuln}"
        ;;
    "stealth")
        stealth_scan "$2" "${3:-stealth}"
        ;;
    "nse")
        custom_script_scan "$2" "$3" "${4:-nse}"
        ;;
    "enterprise")
        main_scan "$2"
        ;;
    "help"|*)
        echo "Enterprise Nmap Security Scanning Framework"
        echo "Usage: $0 {discovery|scan|vuln|stealth|nse|enterprise} <target> [options]"
        echo ""
        echo "Commands:"
        echo "  discovery <network>              - Network discovery scan"
        echo "  scan <target> [type] [name]      - Comprehensive port scan"
        echo "  vuln <target> [name]             - Vulnerability assessment"
        echo "  stealth <target> [name]          - Stealth scanning"
        echo "  nse <target> <scripts> [name]    - Custom NSE script execution"
        echo "  enterprise <config-file>         - Full enterprise scan"
        echo ""
        echo "Example config file format:"
        echo "# target,scan_type,scan_name"
        echo "192.168.1.0/24,discovery,internal_network"
        echo "10.0.0.100,comprehensive,web_server"
        echo "database.company.com,vulnerability,db_server"
        ;;
esac
```

### DevSecOps Pipeline Integration
```yaml
# GitLab CI/CD Pipeline with Nmap Security Scanning
stages:
  - build
  - test
  - security-scan
  - deploy

variables:
  NMAP_IMAGE: "instrumentisto/nmap:latest"
  SECURITY_RESULTS_DIR: "security-results"

# Infrastructure Security Scan
infrastructure_security_scan:
  stage: security-scan
  image: ${NMAP_IMAGE}
  before_script:
    - mkdir -p ${SECURITY_RESULTS_DIR}
    - apk add --no-cache jq curl
  script:
    # Network discovery
    - |
      nmap -sn ${TARGET_NETWORK} \
        -oX ${SECURITY_RESULTS_DIR}/discovery.xml \
        -v
    
    # Service detection on discovered hosts
    - |
      nmap -sV --top-ports 1000 \
        --script=default,vuln \
        -iL <(grep -oP 'addr="\K[^"]+' ${SECURITY_RESULTS_DIR}/discovery.xml) \
        -oX ${SECURITY_RESULTS_DIR}/services.xml \
        -v
    
    # Generate JSON report for processing
    - |
      python3 << 'EOF'
      import xml.etree.ElementTree as ET
      import json
      import sys
      
      def parse_nmap_xml(xml_file):
          tree = ET.parse(xml_file)
          root = tree.getroot()
          
          results = {
              'hosts': [],
              'vulnerabilities': [],
              'open_ports': []
          }
          
          for host in root.findall('.//host'):
              if host.find('.//status').get('state') == 'up':
                  address = host.find('.//address').get('addr')
                  host_info = {'ip': address, 'ports': []}
                  
                  for port in host.findall('.//port'):
                      if port.find('.//state').get('state') == 'open':
                          port_info = {
                              'number': port.get('portid'),
                              'protocol': port.get('protocol'),
                              'service': port.find('.//service').get('name', 'unknown') if port.find('.//service') is not None else 'unknown'
                          }
                          host_info['ports'].append(port_info)
                          results['open_ports'].append(f"{address}:{port_info['number']}")
                  
                  results['hosts'].append(host_info)
          
          return results
      
      # Parse results
      if len(sys.argv) > 1:
          results = parse_nmap_xml(sys.argv[1])
          with open('${SECURITY_RESULTS_DIR}/scan_results.json', 'w') as f:
              json.dump(results, f, indent=2)
      EOF
      python3 parse_nmap.py ${SECURITY_RESULTS_DIR}/services.xml
    
    # Check for critical vulnerabilities
    - |
      CRITICAL_PORTS=$(jq -r '.open_ports[] | select(. | contains(":22") or contains(":23") or contains(":21") or contains(":3389"))' ${SECURITY_RESULTS_DIR}/scan_results.json | wc -l)
      echo "Critical service ports found: $CRITICAL_PORTS"
      
      if [ "$CRITICAL_PORTS" -gt 0 ]; then
        echo "WARNING: Critical services detected that may need security review"
        jq '.open_ports[] | select(. | contains(":22") or contains(":23") or contains(":21") or contains(":3389"))' ${SECURITY_RESULTS_DIR}/scan_results.json
      fi
  
  artifacts:
    reports:
      junit: ${SECURITY_RESULTS_DIR}/junit-report.xml
    paths:
      - ${SECURITY_RESULTS_DIR}/
    expire_in: 7 days
  
  only:
    variables:
      - $ENABLE_SECURITY_SCAN == "true"

# Vulnerability Assessment
vulnerability_assessment:
  stage: security-scan
  image: ${NMAP_IMAGE}
  script:
    - mkdir -p ${SECURITY_RESULTS_DIR}
    
    # Deep vulnerability scan
    - |
      nmap -sV \
        --script="vuln,exploit" \
        --script-args="unsafe=1" \
        --top-ports 1000 \
        -oX ${SECURITY_RESULTS_DIR}/vulnerability_scan.xml \
        ${TARGET_HOSTS} \
        -v
    
    # Parse vulnerabilities and create report
    - |
      grep -E "(CVE-|VULNERABLE)" ${SECURITY_RESULTS_DIR}/vulnerability_scan.xml || true > ${SECURITY_RESULTS_DIR}/vulnerabilities.txt
      
      VULN_COUNT=$(wc -l < ${SECURITY_RESULTS_DIR}/vulnerabilities.txt)
      echo "Vulnerabilities found: $VULN_COUNT"
      
      if [ "$VULN_COUNT" -gt 0 ]; then
        echo "CRITICAL: Vulnerabilities detected!"
        cat ${SECURITY_RESULTS_DIR}/vulnerabilities.txt
        exit 1
      fi
  
  artifacts:
    paths:
      - ${SECURITY_RESULTS_DIR}/
    expire_in: 30 days
  
  allow_failure: false
  only:
    variables:
      - $ENABLE_VULNERABILITY_SCAN == "true"
```

## Best Practices

### Advanced Nmap Scanning Techniques
```bash
#!/bin/bash
# Advanced Nmap scanning techniques and optimization

# Host discovery optimization
optimize_host_discovery() {
    local network="$1"
    
    echo "Optimizing host discovery for $network"
    
    # Fast ping sweep
    nmap -sn --min-rate 5000 --max-retries 1 "$network"
    
    # ARP scan for local networks
    if [[ "$network" =~ ^192\.168\.|^10\.|^172\.(1[6-9]|2[0-9]|3[01])\. ]]; then
        nmap -PR -sn "$network"
    fi
    
    # TCP SYN ping for firewalled networks
    nmap -PS22,80,443 -sn "$network"
    
    # UDP ping for specific services
    nmap -PU53,161,137 -sn "$network"
}

# Port scanning optimization
optimize_port_scanning() {
    local target="$1"
    local scan_type="${2:-fast}"
    
    echo "Optimizing port scanning for $target"
    
    case "$scan_type" in
        "fast")
            # Top 1000 ports with timing optimization
            nmap -sS --top-ports 1000 --min-rate 1000 -T4 "$target"
            ;;
        "comprehensive")
            # All ports with rate limiting
            nmap -sS -p- --min-rate 500 --max-rate 1000 -T3 "$target"
            ;;
        "stealth")
            # Slow stealth scan
            nmap -sS -T1 --max-rate 10 -f "$target"
            ;;
        "intense")
            # Maximum intensity scan
            nmap -sS -sV -O --version-intensity 9 -A -T5 "$target"
            ;;
    esac
}

# Service detection enhancement
enhance_service_detection() {
    local target="$1"
    
    echo "Enhanced service detection for $target"
    
    # Comprehensive service detection
    nmap -sV \
        --version-intensity 9 \
        --version-all \
        --allports \
        -sS \
        "$target"
    
    # NSE scripts for service enumeration
    nmap --script="banner,http-title,http-headers,smtp-commands,pop3-capabilities" \
        -sV "$target"
    
    # SSL/TLS analysis
    nmap --script="ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-poodle" \
        -p 443,993,995,8443 "$target"
}

# OS detection optimization
optimize_os_detection() {
    local target="$1"
    
    echo "OS detection optimization for $target"
    
    # Standard OS detection
    nmap -O --osscan-guess --osscan-limit "$target"
    
    # Enhanced OS detection with script support
    nmap -O \
        --script="smb-os-discovery,http-server-header,ssh-hostkey" \
        --osscan-guess \
        "$target"
    
    # Aggressive OS detection
    nmap -A --osscan-guess "$target"
}

# Firewall evasion techniques
firewall_evasion() {
    local target="$1"
    
    echo "Applying firewall evasion techniques for $target"
    
    # Fragment packets
    nmap -sS -f -f "$target"
    
    # Use decoys
    nmap -sS -D RND:10 "$target"
    
    # Source port manipulation
    nmap -sS --source-port 53 "$target"
    
    # Timing manipulation
    nmap -sS -T1 "$target"
    
    # Protocol manipulation
    nmap -sF "$target"  # FIN scan
    nmap -sN "$target"  # Null scan
    nmap -sX "$target"  # Xmas scan
}

# NSE script management
manage_nse_scripts() {
    local action="$1"
    local script_name="${2:-}"
    
    case "$action" in
        "list")
            nmap --script-help all | grep -E "^[a-z]" | head -20
            ;;
        "categories")
            nmap --script-help all | grep "Categories:" | sort -u
            ;;
        "update")
            nmap --script-updatedb
            ;;
        "info")
            if [[ -n "$script_name" ]]; then
                nmap --script-help "$script_name"
            else
                echo "Please provide script name"
            fi
            ;;
        "test")
            if [[ -n "$script_name" ]]; then
                nmap --script "$script_name" --script-trace scanme.nmap.org
            else
                echo "Please provide script name"
            fi
            ;;
    esac
}

# Performance tuning
performance_tuning() {
    local target="$1"
    local performance_mode="${2:-balanced}"
    
    echo "Applying performance tuning ($performance_mode) for $target"
    
    case "$performance_mode" in
        "fast")
            nmap -sS \
                --min-rate 5000 \
                --max-retries 1 \
                --host-timeout 5m \
                -T5 \
                "$target"
            ;;
        "balanced")
            nmap -sS \
                --min-rate 1000 \
                --max-retries 2 \
                --host-timeout 15m \
                -T4 \
                "$target"
            ;;
        "thorough")
            nmap -sS \
                --min-rate 100 \
                --max-retries 5 \
                --host-timeout 30m \
                -T2 \
                "$target"
            ;;
        "stealth")
            nmap -sS \
                --min-rate 10 \
                --max-retries 1 \
                --host-timeout 60m \
                -T1 \
                "$target"
            ;;
    esac
}
```

## Common Patterns and Examples

### Pattern 1: Web Application Security Assessment
**Scenario**: Comprehensive security assessment of web applications and services
**Implementation**:
```bash
#!/bin/bash
# Web application security assessment with Nmap

web_app_security_scan() {
    local target="$1"
    local report_prefix="${2:-webapp}"
    
    echo "Starting web application security assessment for $target"
    
    # HTTP service detection
    nmap -sV -p 80,443,8080,8081,8443,8000,8888,9000 \
        --script="http-enum,http-headers,http-methods,http-robots.txt" \
        -oA "${report_prefix}_http_enum" \
        "$target"
    
    # SSL/TLS security assessment
    nmap -sV -p 443,8443 \
        --script="ssl-cert,ssl-enum-ciphers,ssl-heartbleed,ssl-poodle,ssl-ccs-injection" \
        -oA "${report_prefix}_ssl_assessment" \
        "$target"
    
    # Web vulnerability scanning
    nmap -sV -p 80,443,8080,8443 \
        --script="http-vuln*" \
        --script-args="http.useragent='Security Scanner'" \
        -oA "${report_prefix}_web_vulns" \
        "$target"
    
    # Directory and file discovery
    nmap -sV -p 80,443,8080,8443 \
        --script="http-enum,http-brute" \
        --script-args="http-enum.basepath=/,http-enum.displayall" \
        -oA "${report_prefix}_directory_enum" \
        "$target"
    
    # Web application fingerprinting
    nmap -sV -p 80,443,8080,8443 \
        --script="http-waf-detect,http-waf-fingerprint" \
        -oA "${report_prefix}_waf_detection" \
        "$target"
    
    echo "Web application security assessment completed"
}

# Database security assessment
database_security_scan() {
    local target="$1"
    local report_prefix="${2:-database}"
    
    echo "Starting database security assessment for $target"
    
    # Database service detection
    nmap -sV -p 1433,3306,5432,1521,27017,6379,11211 \
        --script="banner" \
        -oA "${report_prefix}_db_detection" \
        "$target"
    
    # MySQL security scan
    nmap -sV -p 3306 \
        --script="mysql-info,mysql-enum,mysql-empty-password" \
        -oA "${report_prefix}_mysql_scan" \
        "$target"
    
    # PostgreSQL security scan
    nmap -sV -p 5432 \
        --script="pgsql-brute" \
        -oA "${report_prefix}_postgresql_scan" \
        "$target"
    
    # MSSQL security scan
    nmap -sV -p 1433 \
        --script="ms-sql-info,ms-sql-config,ms-sql-empty-password" \
        -oA "${report_prefix}_mssql_scan" \
        "$target"
    
    # MongoDB security scan
    nmap -sV -p 27017 \
        --script="mongodb-info,mongodb-databases" \
        -oA "${report_prefix}_mongodb_scan" \
        "$target"
    
    echo "Database security assessment completed"
}

# Network infrastructure assessment
network_infrastructure_scan() {
    local network="$1"
    local report_prefix="${2:-infrastructure}"
    
    echo "Starting network infrastructure assessment for $network"
    
    # Network device discovery
    nmap -sS -O \
        --script="snmp-info,snmp-sysdescr" \
        -p 22,23,80,161,443,8080 \
        -oA "${report_prefix}_infrastructure" \
        "$network"
    
    # Router and switch detection
    nmap -sU -p 161 \
        --script="snmp-info,snmp-interfaces,snmp-netstat" \
        -oA "${report_prefix}_snmp_scan" \
        "$network"
    
    # Network service enumeration
    nmap -sV \
        --script="banner,ssh-hostkey,ssl-cert" \
        -p 21,22,23,25,53,80,110,143,443,993,995 \
        -oA "${report_prefix}_services" \
        "$network"
    
    echo "Network infrastructure assessment completed"
}
```
**Expected Outcomes**: Comprehensive security assessment with detailed vulnerability reports and remediation guidance

### Pattern 2: Automated Security Monitoring
**Scenario**: Continuous security monitoring and alerting system
**Implementation**:
```bash
#!/bin/bash
# Automated security monitoring with Nmap

# Configuration
MONITOR_CONFIG="/etc/nmap/monitor.conf"
BASELINE_DIR="/var/lib/nmap/baselines"
ALERT_LOG="/var/log/nmap-monitor.log"
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

# Create security baseline
create_baseline() {
    local target="$1"
    local baseline_name="${2:-default}"
    
    echo "Creating security baseline for $target"
    
    mkdir -p "$BASELINE_DIR"
    
    # Create comprehensive baseline scan
    nmap -sS -sV -O \
        --top-ports 1000 \
        --script="default" \
        -oX "$BASELINE_DIR/${baseline_name}_baseline.xml" \
        "$target"
    
    # Extract key metrics
    python3 << 'EOF'
import xml.etree.ElementTree as ET
import json
import sys

def extract_baseline_metrics(xml_file, output_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    baseline = {
        'scan_date': root.get('startstr'),
        'hosts': {},
        'total_open_ports': 0,
        'services': []
    }
    
    for host in root.findall('.//host'):
        if host.find('.//status').get('state') == 'up':
            address = host.find('.//address').get('addr')
            host_data = {
                'os': '',
                'open_ports': [],
                'services': []
            }
            
            # Extract OS info
            osclass = host.find('.//osclass')
            if osclass is not None:
                host_data['os'] = f"{osclass.get('vendor', '')} {osclass.get('osfamily', '')}"
            
            # Extract ports and services
            for port in host.findall('.//port'):
                if port.find('.//state').get('state') == 'open':
                    port_num = port.get('portid')
                    service = port.find('.//service')
                    service_name = service.get('name', 'unknown') if service is not None else 'unknown'
                    
                    host_data['open_ports'].append(port_num)
                    host_data['services'].append(f"{port_num}/{service_name}")
                    baseline['total_open_ports'] += 1
            
            baseline['hosts'][address] = host_data
            baseline['services'].extend(host_data['services'])
    
    with open(output_file, 'w') as f:
        json.dump(baseline, f, indent=2)

if len(sys.argv) > 2:
    extract_baseline_metrics(sys.argv[1], sys.argv[2])
EOF
    
    python3 extract_baseline.py "$BASELINE_DIR/${baseline_name}_baseline.xml" "$BASELINE_DIR/${baseline_name}_baseline.json"
    
    echo "Baseline created: $BASELINE_DIR/${baseline_name}_baseline.json"
}

# Monitor changes from baseline
monitor_changes() {
    local target="$1"
    local baseline_name="${2:-default}"
    
    echo "Monitoring changes for $target against baseline $baseline_name"
    
    # Current scan
    local current_scan="/tmp/nmap_current_$(date +%s).xml"
    nmap -sS -sV \
        --top-ports 1000 \
        --script="default" \
        -oX "$current_scan" \
        "$target"
    
    # Compare with baseline
    python3 << 'EOF'
import xml.etree.ElementTree as ET
import json
import sys
from datetime import datetime

def compare_with_baseline(current_xml, baseline_json, alert_log):
    # Load baseline
    with open(baseline_json, 'r') as f:
        baseline = json.load(f)
    
    # Parse current scan
    tree = ET.parse(current_xml)
    root = tree.getroot()
    
    current_data = {}
    alerts = []
    
    for host in root.findall('.//host'):
        if host.find('.//status').get('state') == 'up':
            address = host.find('.//address').get('addr')
            current_ports = []
            current_services = []
            
            for port in host.findall('.//port'):
                if port.find('.//state').get('state') == 'open':
                    port_num = port.get('portid')
                    service = port.find('.//service')
                    service_name = service.get('name', 'unknown') if service is not None else 'unknown'
                    
                    current_ports.append(port_num)
                    current_services.append(f"{port_num}/{service_name}")
            
            current_data[address] = {
                'open_ports': current_ports,
                'services': current_services
            }
            
            # Compare with baseline
            if address in baseline['hosts']:
                baseline_ports = set(baseline['hosts'][address]['open_ports'])
                current_ports_set = set(current_ports)
                
                # New ports detected
                new_ports = current_ports_set - baseline_ports
                if new_ports:
                    alerts.append({
                        'type': 'NEW_PORTS',
                        'host': address,
                        'ports': list(new_ports),
                        'severity': 'HIGH'
                    })
                
                # Closed ports detected
                closed_ports = baseline_ports - current_ports_set
                if closed_ports:
                    alerts.append({
                        'type': 'CLOSED_PORTS',
                        'host': address,
                        'ports': list(closed_ports),
                        'severity': 'MEDIUM'
                    })
            else:
                # New host detected
                alerts.append({
                    'type': 'NEW_HOST',
                    'host': address,
                    'ports': current_ports,
                    'severity': 'HIGH'
                })
    
    # Log alerts
    if alerts:
        timestamp = datetime.now().isoformat()
        with open(alert_log, 'a') as f:
            for alert in alerts:
                f.write(f"{timestamp} - {json.dumps(alert)}\n")
        
        print(f"ALERTS DETECTED: {len(alerts)} security changes found")
        for alert in alerts:
            print(f"  {alert['severity']}: {alert['type']} on {alert['host']}")
        
        return alerts
    else:
        print("No security changes detected")
        return []

if len(sys.argv) > 3:
    alerts = compare_with_baseline(sys.argv[1], sys.argv[2], sys.argv[3])
    sys.exit(1 if alerts else 0)
EOF
    
    python3 compare_scan.py "$current_scan" "$BASELINE_DIR/${baseline_name}_baseline.json" "$ALERT_LOG"
    local exit_code=$?
    
    # Send alerts if changes detected
    if [[ $exit_code -eq 1 && -n "$SLACK_WEBHOOK" ]]; then
        send_slack_alert "$target" "$baseline_name"
    fi
    
    # Cleanup
    rm -f "$current_scan"
}

# Send Slack notification
send_slack_alert() {
    local target="$1"
    local baseline_name="$2"
    
    local latest_alerts=$(tail -5 "$ALERT_LOG")
    local message="🚨 Security changes detected on $target (baseline: $baseline_name)\n\nRecent alerts:\n$latest_alerts"
    
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$message\"}" \
        "$SLACK_WEBHOOK"
}

# Continuous monitoring daemon
monitor_daemon() {
    echo "Starting continuous security monitoring daemon"
    
    while true; do
        if [[ -f "$MONITOR_CONFIG" ]]; then
            while IFS=',' read -r target baseline_name interval; do
                [[ "$target" =~ ^#.*$ ]] || [[ -z "$target" ]] && continue
                
                echo "Monitoring $target with baseline $baseline_name"
                monitor_changes "$target" "$baseline_name"
                
            done < "$MONITOR_CONFIG"
        fi
        
        # Wait for next monitoring cycle (default 1 hour)
        sleep "${MONITOR_INTERVAL:-3600}"
    done
}
```
**Expected Outcomes**: Automated security monitoring with baseline comparison and real-time alerting

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Scanning Without Authorization
- **Description**: Performing network scans without proper authorization
- **Why It's Problematic**: Can violate laws and organizational policies
- **Better Approach**: Always obtain written authorization before scanning any network

#### Anti-Pattern 2: Ignoring Rate Limiting
- **Description**: Running aggressive scans without considering network impact
- **Why It's Problematic**: Can disrupt network services and trigger security systems
- **Better Approach**: Use appropriate timing options and rate limiting based on target environment

## Tools and Resources

### Essential Nmap Command Reference
```bash
# Host discovery
nmap -sn 192.168.1.0/24                # Ping sweep
nmap -sL 192.168.1.0/24                # List scan (no packets sent)
nmap -PS22,80,443 192.168.1.1          # TCP SYN ping
nmap -PA22,80,443 192.168.1.1          # TCP ACK ping
nmap -PU53,161,137 192.168.1.1         # UDP ping

# Port scanning
nmap -sS target                        # TCP SYN scan (stealth)
nmap -sT target                        # TCP connect scan
nmap -sU target                        # UDP scan
nmap -sF target                        # TCP FIN scan
nmap -sN target                        # TCP null scan
nmap -sX target                        # TCP Xmas scan

# Service detection
nmap -sV target                        # Version detection
nmap -sV --version-intensity 9 target  # Aggressive version detection
nmap -A target                         # Aggressive scan (OS + version + scripts)

# OS detection
nmap -O target                         # OS detection
nmap -O --osscan-guess target          # OS detection with guessing

# NSE scripts
nmap --script=default target           # Default NSE scripts
nmap --script=vuln target              # Vulnerability scripts
nmap --script=safe target              # Safe scripts only
nmap --script="http-*" target          # HTTP-related scripts

# Output formats
nmap -oN output.txt target             # Normal output
nmap -oX output.xml target             # XML output
nmap -oG output.gnmap target           # Grepable output
nmap -oA output_prefix target          # All formats

# Timing and performance
nmap -T0 target                        # Paranoid (slowest)
nmap -T1 target                        # Sneaky
nmap -T2 target                        # Polite
nmap -T3 target                        # Normal (default)
nmap -T4 target                        # Aggressive
nmap -T5 target                        # Insane (fastest)

# Advanced options
nmap --min-rate 1000 target            # Minimum packet rate
nmap --max-rate 5000 target            # Maximum packet rate
nmap --max-retries 2 target            # Retry attempts
nmap --host-timeout 30m target         # Host timeout
```

### NSE Script Categories and Examples
```bash
# Script categories
auth        # Authentication related scripts
broadcast   # Network broadcast discovery
brute       # Brute force attacks
default     # Default scripts (safe and useful)
discovery   # Host and service discovery
dos         # Denial of service attacks
exploit     # Exploitation scripts
external    # Scripts requiring external resources
fuzzer      # Fuzzing scripts
intrusive   # Intrusive scripts
malware     # Malware detection
safe        # Safe scripts
version     # Version detection enhancement
vuln        # Vulnerability detection

# Popular NSE scripts
--script=http-enum                     # HTTP directory enumeration
--script=http-title                    # HTTP title grabbing
--script=ssl-cert                      # SSL certificate information
--script=ssh-hostkey                   # SSH host key information
--script=smb-enum-shares               # SMB share enumeration
--script=dns-brute                     # DNS subdomain brute force
--script=snmp-sysdescr                 # SNMP system description
--script=mysql-info                    # MySQL server information
--script=ftp-anon                      # Anonymous FTP access
--script=smtp-commands                 # SMTP command enumeration
```

### Integration Tools and Frameworks
- **Nmap XML to HTML**: Convert XML output to web reports
- **Nmap Automator**: Automated scanning framework
- **Nessus Integration**: Import Nmap results into Nessus
- **Metasploit Integration**: Use Nmap results for exploitation
- **OWASP ZAP**: Web application security with Nmap integration
- **Burp Suite**: Professional web security testing
- **OpenVAS**: Open source vulnerability scanner
- **Nuclei**: Fast vulnerability scanner with templates

## Quality and Compliance

### Quality Standards
- Consistent scanning methodology with documented procedures
- Proper authorization and scope definition for all scans
- Regular validation of scan results and false positive filtering
- Comprehensive documentation of findings and remediation steps
- Integration with security workflows and incident response procedures

### Security Standards
- Compliance with organizational security policies
- Proper handling of sensitive scan data and results
- Secure storage and transmission of scan outputs
- Regular updates of Nmap and NSE script databases
- Access controls for scanning tools and results

### Performance Standards
- Optimized scanning parameters for target environments
- Rate limiting to prevent network disruption
- Efficient result processing and storage
- Monitoring of scan performance and resource usage

## AI Assistant Guidelines

When helping with Nmap network security scanning:

1. **Authorization Emphasis**: Always stress the importance of proper authorization before scanning
2. **Legal Compliance**: Ensure all scanning activities comply with applicable laws and policies
3. **Scope Management**: Help define appropriate scan scopes and methodologies
4. **Results Interpretation**: Assist in analyzing and interpreting scan results accurately
5. **Security Integration**: Support integration with broader security programs and workflows
6. **Performance Optimization**: Optimize scanning parameters for efficiency and stealth
7. **Documentation Standards**: Ensure comprehensive documentation of procedures and findings
8. **Continuous Improvement**: Support regular updates and enhancement of scanning capabilities

### Decision Making Framework
When helping teams with Nmap:

1. **Authorization Verification**: Confirm proper authorization exists for all scanning activities
2. **Risk Assessment**: Evaluate potential risks and impacts of scanning activities
3. **Methodology Selection**: Choose appropriate scanning techniques for target environments
4. **Result Analysis**: Analyze findings for security implications and prioritization
5. **Integration Planning**: Plan integration with existing security tools and processes

### Code Generation Rules
- Generate Nmap commands with appropriate safety parameters and authorization checks
- Include comprehensive error handling and logging for all scanning operations
- Use proper output formats and result parsing for integration with other tools
- Implement rate limiting and performance optimization based on target environments
- Generate documentation templates for scan procedures and findings
- Include security controls for scan data handling and access
- Provide clear guidance on legal and ethical scanning practices
- Include integration patterns for DevSecOps and security automation workflows

### Quality Enforcement
- ✅ Require authorization documentation before providing scanning guidance
- ✅ Enforce appropriate scan timing and rate limiting parameters
- ✅ Block generation of commands for potentially illegal or unauthorized scanning
- ✅ Require proper documentation and justification for aggressive scanning techniques
- ✅ Enforce secure handling of scan results and sensitive data
- ✅ Promote integration with established security workflows and procedures
- ✅ Require regular updates of scanning tools and vulnerability databases
- ✅ Enforce compliance with organizational security policies and legal requirements