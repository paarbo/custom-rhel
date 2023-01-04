dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
dnf install -y epel-release
dnf install -y gdm gnome-shell gnome-terminal brave-browser nautilus onlyoffice-desktopeditors gnome-tweaks gnome-extensions-app gnome-browser-connector gnome-usage gnome-password-generator gnome-disk-utility gnome-photos totem gnome-calculator gnome-documents gnome-weather gnome-text-editor
systemctl enable gdm
systemctl set-default graphical.target
dnf remove/purge gnome-tour
