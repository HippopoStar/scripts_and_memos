
## neofetch
```
sudo pacman -Syu neofetch
```

## Theme
Manjaro (Mate Desktop Environment)  
[AUR - qogir-icon-theme](https://aur.archlinux.org/packages/qogir-icon-theme)  
```
AUR_PACKAGE='qogir-icon-theme'
# Either:
pamac build "${AUR_PACKAGE}"
# or:
yay -S "${AUR_PACKAGE}"
```

## Keyboard & Touchpad firmware
[Pine64 - Documentation - PineBook Pro - Features - Touchpad](https://pine64.org/documentation/Pinebook_Pro/Features/Touchpad/)  
[Pine64 Wiki - PineBook Pro - Touchpad](https://wiki.pine64.org/wiki/Pinebook_Pro#Touchpad_%28trackpad%29)  

## Wi-Fi
```
ip address show
nmtui
```

## Privacy Switches
[Pine64 - Documentation - PineBook Pro - Keyboard - Privacy Switches](https://pine64.org/documentation/Pinebook_Pro/Keyboard/#privacy-switches)  
[Pine64 Wiki - PineBook Pro - Keyboard - Privacy Switches](https://wiki.pine64.org/wiki/Pinebook_Pro#Privacy_Switches)  
```
# Privacy switch (network): Super+F11 (3s)
# disable (3 blinks) → reboot → enable (2 blinks)
sudo tee /sys/bus/platform/drivers/dwmmc_rockchip/{un,}bind \
  <<< "$( basename /sys/devices/platform/fe310* )"
```

## Rust toolchain
```
# Debian
sudo apt-get update && sudo apt-get install build-essential
# Arch Linux
sudo pacman -Syu base-devel

# https://rustup.rs/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Redshift
[RedShift](https://wiki.archlinux.org/title/Redshift)  
```
curl -C - -L --output-dir ~/.config -O \
  https://raw.githubusercontent.com/HippopoStar/scripts_and_memos/refs/heads/main/dotfiles/redshift/redshift.conf

systemctl --user enable redshift-gtk
```

