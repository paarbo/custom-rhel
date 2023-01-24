#requires root perms
dnf update -y
dnf autoremove -y
flatpak upgrade -y
#returns to the current user, to avoid any file owner issues
exit
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
git clone https://github.com/vinceliuice/Fluent-icon-theme.git
sh ./Fluent-gtk-theme/install.sh -l --tweaks round noborder square
sh ./Fluent-icon-theme/install.sh
