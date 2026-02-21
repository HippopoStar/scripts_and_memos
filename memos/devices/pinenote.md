
[Pine64 Wiki - PineNote](https://wiki.pine64.org/wiki/PineNote)  
[diederik - pinenote-batch2-factory-install-fixes - v0.0.4](https://git.sr.ht/~diederik/pinenote-batch2-factory-install-fixes/refs/v0.0.4)  

## Install OS
```
sudo parted /dev/mmcblk0 print
zstdcat <image_name>.img.zst | sudo dd of=/dev/mmcblk0pX bs=1M conv=fsync status=progress
```

### Debian Trixie
[GitHub - PNDeb - pinenote-debian-image - Releases](https://github.com/PNDeb/pinenote-debian-image/releases)  
[GitHub.io - PNDeb - HandBook](https://pndeb.github.io/pinenote-tweaks/)  
