dnf update -y
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm -y
dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#DELL drivers repo
#curl -O https://linux.dell.com/repo/hardware/dsu/bootstrap.cgi
#bash bootstrap.cgi
dnf groupupdate core -y
dnf update -y
dnf install -y gdm gnome-shell gnome-console brave-browser nautilus onlyoffice-desktopeditors gnome-tweaks gnome-extensions-app gnome-browser-connector gnome-usage gnome-password-generator gnome-disk-utility gnome-photos totem gnome-calculator gnome-weather gnome-text-editor gtk-murrine-engine gnome-menus sassc ufw fail2ban net-tools file-roller seahorse git
#gnome-documents not found
# gnome-console https://apps.gnome.org news-flash dialect obfuscate warp metadata-cleaner
flatpak update -y
flatpak install flathub -y app.drey.Warp app.drey.Dialect com.gitlab.newsflash com.belmoussaoui.Obfuscate fr.romainvigier.MetadataCleaner

systemctl enable gdm
systemctl set-default graphical.target
dnf remove -y gnome-tour
dnf autoremove -y
# --- Setup UFW rules
ufw limit 22/tcp
ufw allow 80/tcp  
ufw allow 443/tcp  
ufw default deny incoming  
ufw default allow outgoing
ufw enable
systemctl enable ufw
# --- Harden /etc/sysctl.conf #Not recommended
#sysctl kernel.modules_disabled=1
sysctl -a
sysctl -A
sysctl mib
sysctl net.ipv4.conf.all.rp_filter
sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF

# --- Enable fail2ban
wget https://raw.githubusercontent.com/ChrisTitusTech/secure-linux/master/jail.local
cp jail.local /etc/fail2ban/jail.local
systemctl enable fail2ban
systemctl start fail2ban

echo "listening ports"
netstat -tunlp
dnf remove net-tools -y
dnf autoremove -y
