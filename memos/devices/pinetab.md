
[Pine64 Wiki - PineTab](https://wiki.pine64.org/wiki/PineTab)  
[GitHub - DanctNIX - Pine64-Arch - releases - 20220729](https://github.com/dreemurrs-embedded/Pine64-Arch/releases/tag/20220729)  

## Turn on
[Pine64 Wiki - PineTab - Tips and tricks #Reset](https://wiki.pine64.org/wiki/PineTab#Reset)  

## Tow-Boot
[Tow-Boot - Devices - pine64-pinetabA64](https://tow-boot.org/devices/pine64-pinetabA64.html)  

## Install OS
```
xzcat <image_name>.img.xz | sudo dd of=/dev/sdX bs=1M conv=fsync status=progress
```

### ArchLinux ARM by DanctNIX

**Install git**  
```
sudo pacman -Sy base-devel git
```
**Install KOReader**  
```
git clone https://github.com/eNV25/pkgs.git
sudo pacman -Sy gcc glibc
makepkg -siD pkgs/koreader-bin
```

### Mobian Sunxi

**Install KOReader**  
```
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --user flathub rocks.koreader.KOReader
```
