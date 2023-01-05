dnf update -y
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
dnf install -y gdm gnome-shell gnome-terminal brave-browser nautilus onlyoffice-desktopeditors gnome-tweaks gnome-extensions-app gnome-browser-connector gnome-usage gnome-password-generator gnome-disk-utility gnome-photos totem gnome-calculator gnome-weather gnome-text-editor gtk-murrine-engine sassc ufw fail2ban
#gnome-documents not found
systemctl enable gdm
systemctl set-default graphical.target
dnf remove gnome-tour
dnf autoremove
# --- Setup UFW rules
ufw allow 80/tcp  
ufw allow 443/tcp  
ufw default deny incoming  
ufw default allow outgoing
ufw enable

# --- Harden /etc/sysctl.conf
sysctl kernel.modules_disabled=1
sysctl -a
sysctl -A
#sysctl mib
sysctl net.ipv4.conf.all.rp_filter
sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

# --- Enable fail2ban
wget https://raw.githubusercontent.com/ChrisTitusTech/secure-linux/master/jail.local
cp jail.local /etc/fail2ban/
systemctl enable fail2ban
systemctl start fail2ban

#echo "listening ports"
#netstat -tunlp
