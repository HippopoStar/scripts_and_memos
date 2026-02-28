
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
Reboot, then:
```
sudo apt-get clean
sudo apt-get purge ?config-files # Select packages that were removed but not purged
sudo fstrim -a
```

[GitHub - PNDeb - pinenote_dbus_service](https://github.com/PNDeb/pinenote_dbus_service)  
```
# Install dependencie(s)
sudo apt-get update && sudo apt-get -y install \
  build-essential \
  curl \
  git \
  jq \
  libdbus-1-dev \
  linux-libc-dev \
  pkg-config
# Install Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
# Install crate(s)
cargo install cargo-deb
# Clone repository
git clone https://github.com/PNDeb/pinenote_dbus_service.git

# Enter repository directory
pushd pinenote_dbus_service
# Check abbreviated commit hash (83ed018 at the time of writing)
git log -n 1 --oneline
# Build project, create package and install
PINENOTE_DBUS_SERVICE_VERSION=$(
  cargo metadata --no-deps --format-version 1 \
  | jq -r '.["packages"][] | select(.["name"] == "pinenote_dbus_service")["version"]'
)
cargo build
cargo deb
sudo dpkg -i ./target/debian/pinenote-dbus-service_${PINENOTE_DBUS_SERVICE_VERSION}-1_arm64.deb

# Leave repository directory
popd
```

[GitHub - PNDeb - pinenote-gnome-extension](https://github.com/PNDeb/pinenote-gnome-extension)  
```
# Install dependencie(s)
sudo apt-get update && sudo apt-get -y install git
# Clone repository
git clone https://github.com/PNDeb/pinenote-gnome-extension.git

# Enter repository directory
pushd pinenote-gnome-extension
# Check abbreviated commit hash (f755cbb at the time of writing)
git log -n 1 --oneline
# Run install script
./install.sh
gnome-extensions enable pnhelper@m-weigand.github.com

# Leave repository directory
popd
```
Now, restart `gnome-shell` (that can be done by rebooting the device)  
