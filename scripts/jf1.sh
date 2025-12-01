#!/bin/bash

# Give jellyfin execute permission on parent directories (to traverse)
sudo setfacl -m u:jellyfin:x /run/media
sudo setfacl -m u:jellyfin:x /run/media/$USER

# Give jellyfin read+execute on your media folder
sudo setfacl -R -m u:jellyfin:rx /run/media/$USER/Backups/Media
sudo setfacl -R -d -m u:jellyfin:rx /run/media/$USER/Backups/Media

# Add jellyfin to your group (this might still be needed)
sudo usermod -a -G $(id -gn) jellyfin

# Restart Jellyfin
sudo systemctl start jellyfin.service

# Test it
sudo -u jellyfin ls /run/media/$USER/Backups/Media/Video
