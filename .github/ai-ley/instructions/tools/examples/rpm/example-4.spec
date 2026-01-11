# myapp.spec - Example RPM specification file

Name:           myapp
Version:        1.0.0
Release:        1%{?dist}
Summary:        My Application - A sample application

License:        MIT
URL:            https://github.com/example/myapp
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc
BuildRequires:  make
BuildRequires:  pkgconfig
BuildRequires:  systemd-rpm-macros

Requires:       systemd
Requires:       logrotate
Requires(pre):  shadow-utils
Requires(post): systemd
Requires(preun): systemd
Requires(postun): systemd

%description
My Application is a sample application that demonstrates
proper RPM packaging techniques including systemd integration,
user management, and configuration file handling.

%prep
%setup -q

%build
# Configure build environment
make %{?_smp_mflags} \
    PREFIX=%{_prefix} \
    BINDIR=%{_bindir} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

%install
# Remove any existing build root
rm -rf $RPM_BUILD_ROOT

# Install application files
make install \
    DESTDIR=$RPM_BUILD_ROOT \
    PREFIX=%{_prefix} \
    BINDIR=%{_bindir} \
    SYSCONFDIR=%{_sysconfdir} \
    LOCALSTATEDIR=%{_localstatedir}

# Install systemd service file
install -D -m 644 packaging/myapp.service \
    $RPM_BUILD_ROOT%{_unitdir}/myapp.service

# Install configuration file
install -D -m 644 packaging/myapp.conf \
    $RPM_BUILD_ROOT%{_sysconfdir}/myapp/myapp.conf

# Install logrotate configuration
install -D -m 644 packaging/myapp.logrotate \
    $RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d/myapp

# Create directories
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/myapp
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/myapp
mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/myapp

%pre
# Create user account
getent group myapp >/dev/null || groupadd -r myapp
getent passwd myapp >/dev/null || \
    useradd -r -g myapp -d %{_localstatedir}/lib/myapp \
    -s /sbin/nologin -c "My Application User" myapp
exit 0

%post
# Enable and start systemd service
%systemd_post myapp.service

# Set proper permissions
chown -R myapp:myapp %{_localstatedir}/log/myapp
chown -R myapp:myapp %{_localstatedir}/lib/myapp
chown -R myapp:myapp %{_localstatedir}/run/myapp

%preun
# Stop systemd service before uninstall
%systemd_preun myapp.service

%postun
# Cleanup after uninstall
%systemd_postun_with_restart myapp.service

# Remove user account on complete removal
if [ $1 -eq 0 ]; then
    userdel myapp >/dev/null 2>&1 || :
    groupdel myapp >/dev/null 2>&1 || :
fi

%files
%doc README.md CHANGELOG.md
%license LICENSE

# Binaries
%{_bindir}/myapp

# Configuration files
%config(noreplace) %{_sysconfdir}/myapp/myapp.conf
%config %{_sysconfdir}/logrotate.d/myapp

# Systemd service
%{_unitdir}/myapp.service

# Directories with proper ownership
%dir %attr(755, myapp, myapp) %{_localstatedir}/log/myapp
%dir %attr(755, myapp, myapp) %{_localstatedir}/lib/myapp
%dir %attr(755, myapp, myapp) %{_localstatedir}/run/myapp

%changelog
* Fri Aug 16 2025 Your Name <your.email@example.com> - 1.0.0-1
- Initial package release
- Added systemd integration
- Implemented proper user management
- Added logrotate configuration