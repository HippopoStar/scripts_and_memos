===== ===== ===== ===== =====  
===== I3WM  
===== ===== ===== ===== =====  

```
sudo apt-get update && sudo apt-get -y install breeze-cursor-theme feh compton
```
Background picture: `~/<Pictures|Images>/background.<png|jpg>`  
Screensaver picture: `~/<Pictures|Images>/screensaver.<png|jpg>`  

[i3wm - Docs - User's Guide - 5.2. Statusline command](https://i3wm.org/docs/userguide.html#status_command)  
[i3wm - Docs - i3status - 10. External scripts/programs with i3status](https://i3wm.org/docs/i3status.html#_external_scripts_programs_with_i3status)  

Login screen cursor theme (gdm3):  
[Debian Manpages - (8) gdm3](https://manpages.debian.org/bookworm/gdm3/gdm3.8.en.html)  
[Debian Manpages - update-alternatives](https://manpages.debian.org/bookworm/dpkg/update-alternatives.1.en.html)  
[Debian Manpages - machinectl](https://manpages.debian.org/bookworm/systemd-container/machinectl.1.en.html)  
```
cat /etc/gdm3/greeter.dconf-defaults
sudo mkdir -p /etc/dconf/db/gdm.d
sudo cat <<_EOF > /etc/dconf/db/gdm.d/10-cursor-settings
[org/gnome/desktop/interface]
cursor-theme='Breeze_Snow'
cursor-size=36
_EOF
sudo dconf update
```
```
update-alternatives --display x-cursor-theme
update-alternatives --config x-cursor-theme

sudo apt-get update && sudo apt-get install systemd-container
sudo machinectl shell gdm@ /bin/bash -c \
  'gsettings set org.gnome.desktop.interface cursor-theme Breeze_Snow'
sudo machinectl shell gdm@ /bin/bash -c \
  'gsettings set org.gnome.desktop.interface cursor-size 36'
```

