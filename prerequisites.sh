dnf update -y
dnf install -y unzip gdm gnome-shell gnome-terminal gnome-system-monitor nautilus gnome-software gnome-tweaks gnome-extensions-app chrome-gnome-shell gnome-disk-utility gnome-photos gnome-menus totem gnome-calculator gedit seahorse git
systemctl enable gdm
systemctl set-default graphical.target
dnf remove -y gnome-tour

dnf config-manager --set-enabled crb
dnf install -y epel-release
dnf install -y rpmfusion-free-release
dnf install -y --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
dnf groupupdate core -y
dnf update
dnf install -y okular brave-browser librewolf onlyoffice-desktopeditors gtk-murrine-engine sassc ufw fail2ban file-roller
# net-tools not found gnome-console gnome-usage gnome-password-generator gnome-text-editor gnome-weather gnome-browser-connector
# https://apps.gnome.org news-flash dialect obfuscate warp metadata-cleaner
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update -y
flatpak install flathub -y app.drey.Warp app.drey.Dialect com.gitlab.newsflash com.belmoussaoui.Obfuscate fr.romainvigier.MetadataCleaner #com.moonlight_stream.Moonlight

dnf autoremove -y
# --- Setup UFW rules
#ufw limit 22/tcp
ufw allow 80/tcp  
ufw allow 443/tcp  
ufw default deny incoming  
ufw default allow outgoing
ufw enable
systemctl enable ufw
# --- Harden /etc/sysctl.conf #Not recommended
#sysctl kernel.modules_disabled=1
#sysctl -a
#sysctl -A
#sysctl mib
#sysctl net.ipv4.conf.all.rp_filter
#sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

# --- Enable fail2ban
wget https://raw.githubusercontent.com/ChrisTitusTech/secure-linux/master/jail.local
cp jail.local /etc/fail2ban/jail.local
rm -f jail.local
systemctl enable fail2ban
systemctl start fail2ban

#echo "listening ports"
#netstat -tunlp
#dnf remove net-tools -y
dnf autoremove -y
reboot
