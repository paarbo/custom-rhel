#requires sudo perms
sudo dnf update -y
sudo dnf autoremove -y
sudo flatpak upgrade -y
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
git clone https://github.com/vinceliuice/Fluent-icon-theme.git
sh ./Fluent-gtk-theme/install.sh -l --tweaks round noborder square
sh ./Fluent-icon-theme/install.sh -r
