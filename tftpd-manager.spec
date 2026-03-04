Name:           tftpd-manager
Version:        %{_version}
Release:        1
Summary:        Interactive TFTP Management Utility
License:        MIT
BuildArch:      noarch

Requires:       %{server_dep}, mc, bash, coreutils, systemd, grep
Requires:       /usr/bin/pgrep, /usr/bin/pkill

%description
Interactive shell script for managing tftpd with direct execution mode.
Standardizes behavior across different distributions.

%install
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/share/applications
mkdir -p %{buildroot}/etc
install -m 755 %{_sourcedir}/usr/local/bin/tftpd-manager %{buildroot}/usr/local/bin/
install -m 644 %{_sourcedir}/usr/share/applications/tftpd-manager.desktop %{buildroot}/usr/share/applications/
touch %{buildroot}/etc/tftpd-manager.conf

%post
if [ ! -s /etc/tftpd-manager.conf ]; then
    echo 'TFTP_DIR="/var/lib/tftpboot"' > /etc/tftpd-manager.conf
fi

systemctl stop tftp.socket tftp.service tftpd tftpd-hpa >/dev/null 2>&1 || :
systemctl disable tftp.socket tftp.service tftpd tftpd-hpa >/dev/null 2>&1 || :

%postun
if [ $1 -eq 0 ]; then
    rm -f /etc/tftpd-manager.conf /etc/tftpd-manager.conf.rpmsave
    
    echo "Restoring system TFTP services to autostart..."
    systemctl enable tftp.socket tftp.service tftpd >/dev/null 2>&1 || :
fi

%files
/usr/local/bin/tftpd-manager
/usr/share/applications/tftpd-manager.desktop
%config(noreplace) /etc/tftpd-manager.conf