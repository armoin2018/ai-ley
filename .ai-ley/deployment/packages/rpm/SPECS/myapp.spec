Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        My Application - A sample application package

Group:          Applications/System
License:        MIT
URL:            https://github.com/myorg/myapp
Source0:        %{name}-%{version}.tar.gz
Source1:        %{name}.service
Source2:        %{name}.conf

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch:      x86_64

# Build dependencies
BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  pkgconfig
BuildRequires:  systemd-devel

# Runtime dependencies
Requires:       systemd
Requires:       openssl >= 1.0.2
Requires:       curl
Requires(pre):  shadow-utils
Requires(post): systemd
Requires(preun): systemd
Requires(postun): systemd

# Conflicts and obsoletes
Conflicts:      oldapp < 2.0.0
Obsoletes:      deprecated-app

%description
My Application is a comprehensive solution for managing application workloads
in enterprise environments. It provides automated deployment, monitoring,
and management capabilities with high availability and security features.

Features:
- Automated deployment and configuration
- Real-time monitoring and alerting
- High availability and fault tolerance
- Security-first design with encryption
- RESTful API for integration
- Web-based management interface

%prep
%setup -q

%build
# Configure build environment
export CFLAGS="%{optflags}"
export CXXFLAGS="%{optflags}"

# Build application
make %{?_smp_mflags} \
    PREFIX=%{_prefix} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

%install
rm -rf %{buildroot}

# Install application files
make install DESTDIR=%{buildroot} \
    PREFIX=%{_prefix} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

# Install systemd service file
install -D -m 644 %{SOURCE1} %{buildroot}%{_unitdir}/%{name}.service

# Install configuration file
install -D -m 640 %{SOURCE2} %{buildroot}%{_sysconfdir}/%{name}/%{name}.conf

# Create data directories
mkdir -p %{buildroot}%{_localstatedir}/lib/%{name}
mkdir -p %{buildroot}%{_localstatedir}/log/%{name}
mkdir -p %{buildroot}%{_localstatedir}/run/%{name}

# Create documentation directory
mkdir -p %{buildroot}%{_docdir}/%{name}
install -m 644 README.md %{buildroot}%{_docdir}/%{name}/
install -m 644 CHANGELOG.md %{buildroot}%{_docdir}/%{name}/
install -m 644 LICENSE %{buildroot}%{_docdir}/%{name}/

%clean
rm -rf %{buildroot}

%pre
# Create system user and group
getent group %{name} >/dev/null || groupadd -r %{name}
getent passwd %{name} >/dev/null || \
    useradd -r -g %{name} -d %{_localstatedir}/lib/%{name} \
    -s /sbin/nologin -c "MyApp System User" %{name}

%post
# Set file permissions
chown -R %{name}:%{name} %{_localstatedir}/lib/%{name}
chown -R %{name}:%{name} %{_localstatedir}/log/%{name}
chown -R %{name}:%{name} %{_localstatedir}/run/%{name}
chown root:%{name} %{_sysconfdir}/%{name}/%{name}.conf
chmod 640 %{_sysconfdir}/%{name}/%{name}.conf

# Register and start systemd service
%systemd_post %{name}.service

# Create initial configuration if not exists
if [ ! -f %{_sysconfdir}/%{name}/%{name}.conf.bak ]; then
    cp %{_sysconfdir}/%{name}/%{name}.conf %{_sysconfdir}/%{name}/%{name}.conf.bak
fi

# Run post-installation setup
if [ -x %{_bindir}/%{name}-setup ]; then
    %{_bindir}/%{name}-setup --post-install
fi

%preun
# Stop and disable systemd service
%systemd_preun %{name}.service

# Run pre-removal cleanup
if [ -x %{_bindir}/%{name}-setup ]; then
    %{_bindir}/%{name}-setup --pre-remove
fi

%postun
# Clean up systemd service
%systemd_postun_with_restart %{name}.service

# Remove user and group on complete removal
if [ $1 -eq 0 ]; then
    userdel %{name} >/dev/null 2>&1 || :
    groupdel %{name} >/dev/null 2>&1 || :
    
    # Clean up data directories
    rm -rf %{_localstatedir}/lib/%{name}
    rm -rf %{_localstatedir}/log/%{name}
    rm -rf %{_localstatedir}/run/%{name}
fi

%files
%defattr(-,root,root,-)

# Documentation
%doc %{_docdir}/%{name}/README.md
%doc %{_docdir}/%{name}/CHANGELOG.md
%license %{_docdir}/%{name}/LICENSE

# Binaries
%{_bindir}/%{name}
%{_bindir}/%{name}-cli
%{_bindir}/%{name}-setup

# Libraries
%{_libdir}/%{name}/

# Configuration
%dir %{_sysconfdir}/%{name}
%config(noreplace) %{_sysconfdir}/%{name}/%{name}.conf

# Systemd service
%{_unitdir}/%{name}.service

# Data directories
%dir %attr(755,%{name},%{name}) %{_localstatedir}/lib/%{name}
%dir %attr(755,%{name},%{name}) %{_localstatedir}/log/%{name}
%dir %attr(755,%{name},%{name}) %{_localstatedir}/run/%{name}

# Man pages
%{_mandir}/man1/%{name}.1*
%{_mandir}/man5/%{name}.conf.5*

%changelog
* Fri Aug 16 2025 Development Team <dev@myorg.com> - 1.0.0-1
- Initial RPM package release
- Added systemd service integration
- Implemented configuration management
- Added comprehensive documentation
- Security hardening and user isolation
- Automated testing and validation

* Thu Aug 15 2025 Development Team <dev@myorg.com> - 0.9.0-1
- Release candidate version
- Bug fixes and performance improvements
- Enhanced security features
- Updated documentation

* Wed Aug 14 2025 Development Team <dev@myorg.com> - 0.8.0-1
- Beta release for testing
- Core functionality implementation
- Basic configuration management
- Initial systemd integration
