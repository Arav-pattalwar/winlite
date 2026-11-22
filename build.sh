#!/usr/bin/env bash
# WinLite ISO builder. Run on Debian/Ubuntu (or WSL2 Debian) as root:
#   sudo ./build.sh            -> 64-bit ISO
#   sudo ARCH=i386 ./build.sh  -> 32-bit ISO (for very old CPUs without x86-64)
set -euo pipefail
ARCH="${ARCH:-amd64}"
cd "$(dirname "$0")"

apt-get update
apt-get install -y live-build debootstrap squashfs-tools xorriso curl git debian-archive-keyring

lb clean --purge || true
lb config \
  --distribution bookworm \
  --architectures "$ARCH" \
  --linux-flavours "$([ "$ARCH" = i386 ] && echo 686 || echo amd64)" \
  --binary-images iso-hybrid \
  --bootappend-live "boot=live components quiet splash zswap.enabled=1 zswap.compressor=lz4" \
  --iso-application "WinLite" --iso-volume "WinLite" \
  --archive-areas "main contrib non-free non-free-firmware" \
  --apt-recommends false \
  --security true

lb build
echo "Done. ISO: $(ls -1 *.iso)"
