dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
dnf install epel-release
dnf install -y gdm gnome-shell gnome-terminal brave-browser nautilus onlyoffice-desktopeditors gnome-tweaks gnome-extensions-app
systemctl enable gdm
systemctl set-default graphical.target
