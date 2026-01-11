# Ansible Integration Example
- name: Install custom packages with dpkg
  ansible.builtin.shell: |
    dpkg -i {{ item }}
    apt-get install -f -y
  with_items: "{{ custom_packages }}"
  register: dpkg_result
  failed_when: dpkg_result.rc != 0

# Puppet Integration
package { 'custom-app':
  ensure   => installed,
  provider => dpkg,
  source   => '/opt/packages/custom-app_1.0.0_amd64.deb',
  require  => File['/opt/packages/custom-app_1.0.0_amd64.deb'],
}