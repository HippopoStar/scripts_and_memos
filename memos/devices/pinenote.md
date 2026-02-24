
[Pine64 Wiki - PineNote](https://wiki.pine64.org/wiki/PineNote)  
[GitHub.io - PNDeb - HandBook](https://pndeb.github.io/pinenote-tweaks/)  

## Install OS

### Debian Trixie
[GitHub - PNDeb - pinenote-debian-image - Releases](https://github.com/PNDeb/pinenote-debian-image/releases)  
```
sudo apt-get update && sudo apt-get -y install curl
sudo parted /dev/mmcblk0 print
lsblk
read -ei '6' -p 'Please specify target partition: ' TARGET_PARTITION
if [ "${TARGET_PARTITION}" -eq 5 -o "${TARGET_PARTITION}" -eq 6 ]
then
  IMAGE_NAME="debian_partition_${TARGET_PARTITION}"
  curl -C - -L -# -O "https://github.com/PNDeb/pinenote-debian-image/releases/download/v20250101_01/${IMAGE_NAME}.img.zst"
  set -o pipefail
  zstdcat "${IMAGE_NAME}.img.zst" | sudo dd of="/dev/mmcblk0p${TARGET_PARTITION}" bs=1M conv=fsync status=progress
  echo "Return value: ${?}"
fi
```

## Batch 2 Factory Image (Debian Trixie) workarounds
```
# NO_PUBKEY E0B6906147A709C6
sudo curl -L --output-dir /etc/apt/sources.list.d -O https://github.com/PNDeb/pinenote-tweaks/raw/refs/heads/main/pn_custom_repo_and_keyring/apt_sources/pnedeb.sources
sudo curl -L --output-dir /usr/share/keyrings -O https://github.com/PNDeb/pinenote-tweaks/raw/refs/heads/main/pn_custom_repo_and_keyring/keyrings/pinenote_repo_key_5.gpg
```
[diederik - pinenote-batch2-factory-install-fixes](https://git.sr.ht/~diederik/pinenote-batch2-factory-install-fixes)  
```
sudo apt-get update && sudo apt-get -y install git
git clone https://git.sr.ht/~diederik/pinenote-batch2-factory-install-fixes
pushd pinenote-batch2-factory-install-fixes

git fetch --tags
git tag -l -n1
read -ei 'v0.0.4' -p 'Please specify tag: ' PINENOTE_BATCH2_FACTORY_INSTALL_FIXES_TAG
git checkout "${PINENOTE_BATCH2_FACTORY_INSTALL_FIXES_TAG}"

sudo dpkg-reconfigure locales
sudo dpkg-reconfigure tzdata
sudo ./main

popd
```
```
sudo apt-get clean
sudo apt-get purge ?config-files # Select packages that were removed but not purged
sudo fstrim -a
```
[GitHub - PNDeb - pinenote_dbus_service - Tags](https://github.com/PNDeb/pinenote_dbus_service/tags)  
```
sudo apt-get update && sudo apt-get -y install \
  build-essential \
  curl \
  git \
  libdbus-1-dev \
  linux-libc-dev \
  pkg-config
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
cargo install cargo-deb
git clone https://github.com/PNDeb/pinenote_dbus_service.git
pushd pinenote_dbus_service

# git fetch --tags
# git tag -l -n1
# read -ei 'v0.2.3-1' -p 'Please specify tag: ' PINENOTE_DBUS_SERVICE_TAG
# git checkout "${PINENOTE_DBUS_SERVICE_TAG}"
PINENOTE_DBUS_SERVICE_TAG=v0.2.5

cargo build
cargo deb
sudo dpkg -i ./target/debian/pinenote-dbus-service_${PINENOTE_DBUS_SERVICE_TAG:1}-1_arm64.deb

popd
```
```
Gio.DBusError:
GDBus.Error:org.freedesktop.DBus.Error.UnknownMethod: Unknown method SetNoOffScreen
```
```
Gio.DBusError:
GDBus.Error:org.freedesktop.DBus.Error.Failed: D-Bus argument type mismatch at position 0: expected u8, found bool
```
[GitHub - PNDeb - pinenote-gnome-extension - Tags](https://github.com/PNDeb/pinenote-gnome-extension/tags)  
```
sudo apt-get update && sudo apt-get -y install git
git clone https://github.com/PNDeb/pinenote-gnome-extension.git
pushd pinenote-gnome-extension

# git fetch --tags
# git tag -l -n1
# read -ei 'v1.7' -p 'Please specify tag: ' PINENOTE_GNOME_EXTENSION_TAG
# git checkout "${PINENOTE_GNOME_EXTENSION_TAG}"

./install.sh
# sudo apt-get update && sudo apt-get -y install build-essential debhelper
# dpkg-buildpackage -us -uc

popd
```
