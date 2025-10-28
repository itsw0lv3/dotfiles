#!/usr/bin/env bash

sudo pacman -S jellyfin-server jellyfin-web jellyfin-ffmpeg
sudo systemctl enable jellyfin.service
sudo systemctl start jellyfin.service

sudo usermod -a -G your-media-group jellyfin
sudo systemctl restart jellyfin.service

# Make /run/media readable and executable by all
sudo chmod +rx /run/media

# Make your user directory under /run/media accessible
sudo chmod +rx /run/media/$USER

# Make the Backups directory and contents readable by jellyfin group
sudo chmod -R g+rX /run/media/$USER/Backups

# Add jellyfin to your user's group
sudo usermod -a -G $(id -gn) jellyfin

# Restart Jellyfin
sudo systemctl restart jellyfin.service

# Test it
sudo -u jellyfin ls /run/media/$USER/Backups/Media/Video
