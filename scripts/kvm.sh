#!/usr/bin/env bash

sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables libguestfs

# AMD virtio:
sudo pacman -S vulkan-virtio

echo "Add these to: /etc/libvirtd.conf"
echo 'unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"'

sudo usermod -a -G libvirt $(whoami)
newgrp libvirt

sudo systemctl enable libvirtd
