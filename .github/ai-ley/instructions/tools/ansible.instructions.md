---
name: 'ansible.instructions'
description: 'Development guidelines and best practices for Ansible.Instructions'
keywords: [api, cloud, (auditd), (host, accounting, benchmark, ansible.instructions, authentication, authorization, automation]
---



---
agentMode: general
applyTo: general
author: AI-LEY
description: Comprehensive enterprise Ansible automation platform with advanced playbook orchestration, infrastructure-as-code provisioning, configuration management, compliance automation, security hardening frameworks, AWX/Tower integration, comprehensive monitoring and observability, multi-cloud orchestration, GitOps workflows, zero-downtime deployments, and production-scale automation patterns for enterprise infrastructure management.See [example-1](./examples/ansible/example-1.txt)bash
# enterprise-security-framework.sh - Comprehensive security automation
#!/bin/bash
set -euo pipefail

COMPLIANCE_FRAMEWORK="${COMPLIANCE_FRAMEWORK:-CIS}"
SECURITY_PROFILE="${SECURITY_PROFILE:-enterprise}"
AUDIT_ENABLED="${AUDIT_ENABLED:-true}"
VULNERABILITY_SCANNING="${VULNERABILITY_SCANNING:-true}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SECURITY-FRAMEWORK] $*"
}

# Create comprehensive security playbook
create_security_playbook() {
    log "Creating enterprise security hardening playbook..."
    
    mkdir -p playbooks/security/{cis,sox,pci,hipaa,nist}
    
    cat > playbooks/security/enterprise_hardening.yml << 'SECURITY_PLAYBOOK_EOF'
---

- name: Enterprise Security Hardening Framework
  hosts: all
  become: true
  gather_facts: true
  vars_files: - vars/security/{{ compliance_framework | lower }}\_baseline.yml - vault/security/security_secrets.yml

  pre_tasks: - name: Create security audit log
  file:
  path: /var/log/ansible-security.log
  state: touch
  mode: '0600'
  owner: root
  group: root

            lineinfile:
          path: /var/log/ansible-security.log
          line: "[{{ ansible_date_time.iso8601 }}] Security hardening started - Framework: {{ compliance_framework }}"

  roles: - { role: security.baseline, tags: ['baseline', 'cis-1'] } - { role: security.filesystem, tags: ['filesystem', 'cis-1.1'] } - { role: security.bootloader, tags: ['bootloader', 'cis-1.4'] } - { role: security.processes, tags: ['processes', 'cis-1.5'] } - { role: security.mandatory_access, tags: ['selinux', 'cis-1.6'] } - { role: security.updates, tags: ['updates', 'cis-1.8'] } - { role: security.services, tags: ['services', 'cis-2'] } - { role: security.network, tags: ['network', 'cis-3'] } - { role: security.logging, tags: ['logging', 'cis-4'] } - { role: security.access_control, tags: ['access', 'cis-5'] } - { role: security.maintenance, tags: ['maintenance', 'cis-6'] }

  post_tasks: - name: Run security compliance scan
  include_tasks: tasks/security/compliance_scan.yml
  when: compliance_scanning_enabled | default(true)

            template:
          src: security_report.j2
          dest: "/tmp/security_report_{{ ansible_hostname }}_{{ ansible_date_time.date }}.json"
        vars:
          scan_timestamp: "{{ ansible_date_time.iso8601 }}"
          compliance_framework: "{{ compliance_framework }}"
          security_profile: "{{ security_profile }}"

            uri:
          url: "{{ security_reporting_endpoint }}/api/v1/reports"
          method: POST
          headers:
            Authorization: "Bearer {{ security_api_token }}"
            Content-Type: "application/json"
          body_format: json
          body: "{{ lookup('file', '/tmp/security_report_' + ansible_hostname + '_' + ansible_date_time.date + '.json') | from_json }}"
          status_code: [200, 201]
        when: security_reporting_endpoint is defined

  SECURITY_PLAYBOOK_EOF

      log "✓ Enterprise security playbook created"

  }

# Create CIS benchmark compliance role

create_cis_compliance_role() {
log "Creating CIS benchmark compliance role..."

    mkdir -p roles/security.cis_compliance/{tasks,handlers,templates,files,vars,defaults,meta}

    cat > roles/security.cis_compliance/tasks/main.yml << 'CIS_TASKS_EOF'

---

# CIS Benchmark Implementation

- name: Include OS-specific CIS tasks
  include_tasks: "{{ ansible_os_family | lower }}.yml"
  tags: ['cis-os-specific']

- name: CIS 1.1 - Filesystem Configuration
  include_tasks: filesystem/main.yml
  tags: ['cis-1.1', 'filesystem']

- name: CIS 1.2 - Configure Software Updates
  include_tasks: updates/main.yml  
  tags: ['cis-1.2', 'updates']

- name: CIS 1.3 - Filesystem Integrity Checking
  include_tasks: integrity/main.yml
  tags: ['cis-1.3', 'integrity']

- name: CIS 1.4 - Secure Boot Settings
  include_tasks: boot/main.yml
  tags: ['cis-1.4', 'boot']

- name: CIS 1.5 - Additional Process Hardening
  include_tasks: processes/main.yml
  tags: ['cis-1.5', 'processes']

- name: CIS 1.6 - Mandatory Access Controls
  include_tasks: mac/main.yml
  tags: ['cis-1.6', 'mac']

- name: CIS 2 - Services
  include_tasks: services/main.yml
  tags: ['cis-2', 'services']

- name: CIS 3 - Network Configuration
  include_tasks: network/main.yml
  tags: ['cis-3', 'network']

- name: CIS 4 - Logging and Auditing
  include_tasks: logging/main.yml
  tags: ['cis-4', 'logging']

- name: CIS 5 - Access, Authentication and Authorization
  include_tasks: access/main.yml
  tags: ['cis-5', 'access']

- name: CIS 6 - System Maintenance
  include_tasks: maintenance/main.yml
  tags: ['cis-6', 'maintenance']
  CIS_TASKS_EOF

      # Create CIS network hardening tasks
      mkdir -p roles/security.cis_compliance/tasks/network
      cat > roles/security.cis_compliance/tasks/network/main.yml << 'CIS_NETWORK_EOF'

---

# CIS 3.1 - Network Parameters (Host Only)

- name: Disable IP forwarding
  sysctl:
  name: net.ipv4.ip_forward
  value: '0'
  state: present
  sysctl_set: true
  reload: true
  tags: ['cis-3.1.1']

- name: Disable packet redirect sending
  sysctl:
  name: "{{ item }}"
  value: '0'
  state: present
  sysctl_set: true
  reload: true
  loop:
    tags: ['cis-3.1.2']

# CIS 3.2 - Network Parameters (Host and Router)

- name: Disable source routed packet acceptance
  sysctl:
  name: "{{ item }}"
  value: '0'
  state: present
  sysctl_set: true
  reload: true
  loop:

    tags: ['cis-3.2.1']

- name: Disable ICMP redirects acceptance
  sysctl:
  name: "{{ item }}"
  value: '0'
  state: present
  sysctl_set: true
  reload: true
  loop:
    tags: ['cis-3.2.2']

# CIS 3.3 - IPv6

- name: Disable IPv6 if not required
  sysctl:
  name: "{{ item }}"
  value: '1'
  state: present
  sysctl_set: true
  reload: true
  loop:
    when: disable_ipv6 | default(true)
    tags: ['cis-3.3']

# CIS 3.4 - TCP Wrappers

- name: Install TCP Wrappers
  package:
  name: "{{ tcp_wrappers_packages }}"
  state: present
  vars:
  tcp_wrappers_packages: - tcpd - tcp_wrappers
  tags: ['cis-3.4']

# CIS 3.5 - Firewall Configuration

- name: Configure firewall rules
  include_tasks: firewall.yml
  tags: ['cis-3.5', 'firewall']
  CIS_NETWORK_EOF

      # Create CIS logging and auditing tasks
      mkdir -p roles/security.cis_compliance/tasks/logging
      cat > roles/security.cis_compliance/tasks/logging/main.yml << 'CIS_LOGGING_EOF'

---

# CIS 4.1 - Configure System Accounting (auditd)

- name: Install auditd
  package:
  name: audit
  state: present
  tags: ['cis-4.1.1']

- name: Enable auditd service
  systemd:
  name: auditd
  enabled: true
  state: started
  tags: ['cis-4.1.2']

- name: Configure audit rules
  template:
  src: audit.rules.j2
  dest: /etc/audit/rules.d/audit.rules
  backup: true
  notify: restart auditd
  tags: ['cis-4.1.3']

- name: Configure auditd.conf
  lineinfile:
  path: /etc/audit/auditd.conf
  regexp: "{{ item.regexp }}"
  line: "{{ item.line }}"
  backup: true
  loop:
    notify: restart auditd
    tags: ['cis-4.1.4']

# CIS 4.2 - Configure Logging

- name: Install rsyslog
  package:
  name: rsyslog
  state: present
  tags: ['cis-4.2.1']

- name: Configure rsyslog
  template:
  src: rsyslog.conf.j2
  dest: /etc/rsyslog.conf
  backup: true
  notify: restart rsyslog
  tags: ['cis-4.2.2']

- name: Configure log file permissions
  file:
  path: "{{ item }}"
  mode: '0640'
  owner: root

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
