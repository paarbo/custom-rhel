dnf install dnf-plugins-core
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y gdm gnome-shell gnome-terminal brave-browser nautilus onlyoffice gnome-tweaks gnome-extensions-app nano nautilus
systemctl enable gdm
systemctl set-default graphical.target
