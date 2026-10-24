#!/bin/bash

LAPTOP="eDP-1"
EXTERNAL="HDMI-1-0"

if xrandr --query | grep "^$EXTERNAL connected"; then
	xrandr --output "$LAPTOP" --primary --auto \
		--output "$EXTERNAL" --auto --right-of "$LAPTOP"
else
	xrandr --output "$LAPTOP" --primary --auto \
		--output "$EXTERNAL" --off
fi

feh --bg-fill ~/Pictures/Wallpapers/Anime/wallhaven-jxq6wp.png

