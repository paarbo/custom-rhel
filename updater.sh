#requires root perms
dnf update -y
dnf autoremove -y
flatpak upgrade -y
#goes to the desired user, to avoid any file owner issues
su - $1
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
git clone https://github.com/vinceliuice/Fluent-icon-theme.git
sh ./Fluent-gtk-theme/install.sh -l --tweaks round noborder square
sh ./Fluent-icon-theme/install.sh -r
