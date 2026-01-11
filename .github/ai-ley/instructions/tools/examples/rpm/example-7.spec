# system-config.spec - System configuration package

Name:           company-system-config
Version:        1.0
Release:        1%{?dist}
Summary:        Company standard system configuration

License:        Proprietary
Group:          System Environment/Base
BuildArch:      noarch
Source0:        %{name}-%{version}.tar.gz

Requires:       bash
Requires:       systemd
Requires:       firewalld
Requires:       rsyslog

%description
Standard system configuration package for company servers.
Includes security settings, monitoring configuration, and
standardized system defaults.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT

# Create directory structure
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/company
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/systemd/system
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/rsyslog.d
mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/firewalld/services
mkdir -p $RPM_BUILD_ROOT%{_bindir}

# Install configuration files
install -m 644 configs/company.conf $RPM_BUILD_ROOT%{_sysconfdir}/company/
install -m 644 configs/rsyslog-company.conf $RPM_BUILD_ROOT%{_sysconfdir}/rsyslog.d/
install -m 644 configs/company-app.xml $RPM_BUILD_ROOT%{_sysconfdir}/firewalld/services/

# Install scripts
install -m 755 scripts/company-setup.sh $RPM_BUILD_ROOT%{_bindir}/
install -m 755 scripts/company-monitor.sh $RPM_BUILD_ROOT%{_bindir}/

%post
# Configure firewall
firewall-cmd --permanent --add-service=company-app >/dev/null 2>&1 || :
firewall-cmd --reload >/dev/null 2>&1 || :

# Configure rsyslog
systemctl restart rsyslog >/dev/null 2>&1 || :

# Run initial setup
%{_bindir}/company-setup.sh

%preun
if [ $1 -eq 0 ]; then
    # Remove firewall service
    firewall-cmd --permanent --remove-service=company-app >/dev/null 2>&1 || :
    firewall-cmd --reload >/dev/null 2>&1 || :
fi

%files
%config(noreplace) %{_sysconfdir}/company/company.conf
%config %{_sysconfdir}/rsyslog.d/rsyslog-company.conf
%{_sysconfdir}/firewalld/services/company-app.xml
%{_bindir}/company-setup.sh
%{_bindir}/company-monitor.sh

%changelog
* Fri Aug 16 2025 System Admin <admin@company.com> - 1.0-1
- Initial system configuration package
- Added firewall rules for company applications
- Configured centralized logging
- Added monitoring scripts