
[Pine64 — Documentation — PineBook Pro](https://pine64.org/documentation/Pinebook_Pro/)  
[Pine64 Wiki — Pinebook Pro](https://wiki.pine64.org/wiki/Pinebook_Pro)  

## Hardware

### Keyboard & Touchpad firmware

[Pine64 — Documentation — PineBook Pro — Features — Touchpad](https://pine64.org/documentation/Pinebook_Pro/Features/Touchpad/)  
[Pine64 Wiki — PineBook Pro — Touchpad](https://wiki.pine64.org/wiki/Pinebook_Pro#Touchpad_%28trackpad%29)  

### Wi-Fi

```
ip -br link show wlan0
ip address show
nmtui
```

### Privacy Switches

[Pine64 — Documentation — PineBook Pro — Keyboard — Privacy Switches](https://pine64.org/documentation/Pinebook_Pro/Keyboard/#privacy-switches)  
[Pine64 Wiki — PineBook Pro — Keyboard — Privacy Switches](https://wiki.pine64.org/wiki/Pinebook_Pro#Privacy_Switches)  
```
# Privacy switch (network): Super+F11 (3s)
# disable (3 blinks) → reboot → enable (2 blinks)
sudo tee /sys/bus/platform/drivers/dwmmc_rockchip/{un,}bind \
	<<< "$( basename /sys/devices/platform/fe310* )"
```



## Operating System

[Tow-Boot — Pinebook Pro](https://tow-boot.org/devices/pine64-pinebookPro.html)  
[GitHub — Tow-Boot — Issues — 176](https://github.com/Tow-Boot/Tow-Boot/issues/176#issuecomment-1256913300)  
[GitHub — Tow-Boot — Issues — 55](https://github.com/Tow-Boot/Tow-Boot/issues/55#issuecomment-1065190947)  

[Pine64 Wiki — Pinebook Pro — Software Releases](https://wiki.pine64.org/wiki/Pinebook_Pro_Software_Releases)  

### Manjaro ARM

[Manjaro — Products — Download — ARM — Pinebook Pro](https://manjaro.org/products/download/arm?device=Pinebook+Pro)  
→ Although there is a "Pinebook Pro" image, the "Generic" one should be used.  
```
sudo pacman-mirrors -g && sudo pacman -Syyu
sudo pacman -Sy \
	base-devel \
	flatpak \
	git \
	tmux \
	vim
python3 -m venv ~/.venv
echo 'source ~/.venv/bin/activate' | tee -a ~/.bashrc
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user install flathub org.mozilla.firefox
```

### Kali Linux

[Kali Linux — Get Kali — ARM](https://www.kali.org/get-kali/#kali-arm)  
[Kali Linux — Documentation — Kali On ARM — Pinebook Pro](https://www.kali.org/docs/arm/pinebook-pro/)  



## Software

### neofetch

```
sudo pacman -Sy neofetch
```

### Theme

Manjaro (Mate Desktop Environment)  
[AUR — qogir-icon-theme](https://aur.archlinux.org/packages/qogir-icon-theme)  
```
AUR_PACKAGE='qogir-icon-theme'
# Either:
pamac build "${AUR_PACKAGE}"
# or:
yay -S "${AUR_PACKAGE}"
```

### Rust toolchain

```
# Debian
sudo apt-get update && sudo apt-get install build-essential
# Arch Linux
sudo pacman -Sy base-devel

# https://rustup.rs/
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Redshift

[RedShift](https://wiki.archlinux.org/title/Redshift)  
```
curl -C - -L --output-dir ~/.config -O \
	https://raw.githubusercontent.com/HippopoStar/scripts_and_memos/refs/heads/main/dotfiles/redshift/redshift.conf

systemctl --user enable redshift-gtk
```

