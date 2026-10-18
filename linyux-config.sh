#!/bin/bash

# Linyux OS — вспомогательный скрипт конфигурации live-build.
# Дублирует требования auto/config явными флагами lb config.
#   ./linyux-config.sh

set -e

HOST_ARCH="$(dpkg --print-architecture)"

QEMU_OPTS=()
if [ "${HOST_ARCH}" = "amd64" ]; then
    # Foreign bootstrap i386 на amd64-хосте через qemu-user-static.
    QEMU_OPTS=(--bootstrap-qemu-arch i386 --bootstrap-qemu-static /usr/bin/qemu-i386-static)
fi

lb config noauto \
    --architecture i386 \
    "${QEMU_OPTS[@]}" \
    --binary-images iso-hybrid \
    --distribution bookworm \
    --parent-distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --debian-installer live \
    --debian-installer-distribution bookworm \
    --bootloaders syslinux \
    --linux-flavours 686-pae \
    --mode debian \
    --system live \
    --locale en_US.UTF-8 \
    --hostname linyux \
    --chroot-squashfs-compression-type zstd \
    --binary-filesystem ext4 \
    --security true \
    --updates true \
    "${@}"

echo "[linyux] lb config выполнен: i386, iso-hybrid, debian-installer live, minimal bootstrap."
