#!/usr/bin/env bash

sudo pacman -S jellyfin-server jellyfin-web jellyfin-ffmpeg
# sudo systemctl enable jellyfin.service
# sudo systemctl start jellyfin.service

# Test it
sudo -u jellyfin ls /run/media/$USER/Backups/Media/Video

# Open for jellyfin
sudo firewall-cmd --permanent --add-port=8096/tcp

# HTTPS port (if you set up SSL)
sudo firewall-cmd --permanent --add-port=8096/tcp

# Service discovery (for auto-detection by apps)
sudo firewall-cmd --permanent --add-port=7359/udp

# DLNA (for casting to TVs/devices)
sudo firewall-cmd --permanent --add-port=1900/udp

# Reload
sudo firewall-cmd --reload
