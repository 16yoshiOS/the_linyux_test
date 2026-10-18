#!/bin/bash

# Linyux OS — вспомогательный скрипт конфигурации live-build.
#
# Позволяет задать жёсткие требования параметрами lb config напрямую,
# если auto/config по какой-то причине не используется:
#
#   ./linyux-config.sh
#
# Требования (см. также README.md):
#   1. Архитектура i686 (32-bit)
#   2. Установка на жёсткий диск (debian-installer live)
#   3. Минимальный старт (debootstrap variant=minimal)
#   4. Локализация en_US.UTF-8 + ru_RU.UTF-8 + tt_RU.UTF-8, шрифты dejavu/liberation
#   5. Чистый GNOME
#   6. firefox-esr
#   7. htop, cava, xorg, fastfetch, gnome-system-monitor

set -e

lb config noauto \
    --architectures i386 \
    --architecture i386 \
    --bootstrap-qemu-architecture i386 \
    --binary-images iso-hybrid \
    --modes live \
    --distribution bookworm \
    --parent-distribution bookworm \
    --archive-areas "main contrib non-free non-free-firmware" \
    --bootstrap-variant minimal \
    --debian-installer live \
    --debian-installer-distribution bookworm \
    --debian-installer-gui false \
    --bootloaders "isolinux syslinux-extlinux" \
    --linux-flavours 686-pae \
    --locale en_US.UTF-8 \
    --hostname linyux \
    --binary-filesystem ext4 \
    --compression zstd \
    "${@}"

echo "[linyux] lb config выполнен: i386, iso-hybrid, debian-installer live, minimal bootstrap."
