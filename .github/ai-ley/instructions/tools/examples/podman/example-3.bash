# Enterprise security hardening script
cat > ~/.local/bin/podman-security-hardening.sh << 'EOF'
#!/bin/bash
set -euo pipefail

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Starting Enterprise Podman Security Hardening..."

# SELinux/AppArmor enterprise configuration
if command -v getenforce >/dev/null 2>&1; then
    log "Configuring SELinux for enterprise container security"

    # Create enterprise SELinux policy
    sudo semanage fcontext -a -t container_file_t "/home/$(whoami)/.local/share/containers(/.*)?"
    sudo restorecon -R /home/$(whoami)/.local/share/containers/

    # Enterprise container contexts
    sudo setsebool -P container_use_cephfs on
    sudo setsebool -P virt_use_nfs on
    sudo setsebool -P virt_use_samba on

elif command -v aa-status >/dev/null 2>&1; then
    log "Configuring AppArmor for enterprise container security"

    # Create enterprise AppArmor profile
    sudo tee /etc/apparmor.d/podman-enterprise << 'APPARMOR_EOF'
#include <tunables/global>

/usr/bin/podman {
  #include <abstractions/base>
  #include <abstractions/nameservice>

  capability dac_override,
  capability setuid,
  capability setgid,
  capability sys_admin,
  capability sys_chroot,
  capability net_bind_service,

  /usr/bin/podman ix,
  /usr/bin/crun ix,
  /usr/bin/runc ix,

  owner /home/*/.local/share/containers/** rwk,
  owner /run/user/*/containers/** rwk,

  /proc/*/mountinfo r,
  /sys/fs/cgroup/** rwk,

  # Enterprise network access
  network inet stream,
  network inet dgram,
  network inet6 stream,
  network inet6 dgram,
}
APPARMOR_EOF

    sudo apparmor_parser -r /etc/apparmor.d/podman-enterprise
fi

# Enterprise seccomp profile
cat > ~/.config/containers/seccomp.json << 'SECCOMP_EOF'
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": [
    "SCMP_ARCH_X86_64",
    "SCMP_ARCH_X86",
    "SCMP_ARCH_AARCH64",
    "SCMP_ARCH_ARM",
    "SCMP_ARCH_S390X",
    "SCMP_ARCH_PPC64LE"
  ],
  "syscalls": [
    {
      "name": "accept",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "accept4",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "access",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "arch_prctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "bind",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "brk",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "chdir",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "clone",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "close",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "dup3",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_create",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_create1",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_ctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "epoll_wait",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "execve",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "exit",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "exit_group",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "fcntl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "fcntl64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "futex",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getcwd",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getdents",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getdents64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getgid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getgroups",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getpid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getppid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "gettid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "getuid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "listen",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "lstat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "lstat64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mmap",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mmap2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "mprotect",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "munmap",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "nanosleep",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "open",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "openat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "pipe",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "pipe2",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "poll",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "prctl",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "read",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigaction",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigprocmask",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "rt_sigreturn",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "sched_yield",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "select",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "set_robust_list",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "set_tid_address",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "socket",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "socketpair",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "stat",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "stat64",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "unlink",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "wait4",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "waitpid",
      "action": "SCMP_ACT_ALLOW"
    },
    {
      "name": "write",
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
SECCOMP_EOF

# Enterprise capabilities configuration
cat > ~/.config/containers/capabilities.conf << 'CAPS_EOF'
# Enterprise container capabilities
# Allow minimal capabilities for security
default_capabilities = [
  "AUDIT_WRITE",
  "CHOWN",
  "DAC_OVERRIDE",
  "FOWNER",
  "FSETID",
  "KILL",
  "MKNOD",
  "NET_BIND_SERVICE",
  "NET_RAW",
  "SETFCAP",
  "SETGID",
  "SETPCAP",
  "SETUID",
  "SYS_CHROOT"
]

# Deny dangerous capabilities
drop_capabilities = [
  "SYS_ADMIN",
  "SYS_MODULE",
  "SYS_RAWIO",
  "SYS_TIME",
  "MAC_ADMIN",
  "MAC_OVERRIDE",
  "NET_ADMIN"
]
CAPS_EOF

log "Enterprise Podman security hardening completed successfully"
EOF

chmod +x ~/.local/bin/podman-security-hardening.sh
~/.local/bin/podman-security-hardening.sh