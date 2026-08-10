#!/bin/bash

 LAPTOP="eDP"
 EXTERNAL="HDMI-A-1-0"

 if xrandr --query | grep "^$EXTERNAL connected"; then
	 xrandr --output "$EXTERNAL" --primary --auto \
		 --output "$LAPTOP" --auto --right-of "$EXTERNAL"
 else
	 xrandr --output "$LAPTOP" --primary --auto \
		 --output "$EXTERNAL" --off
 fi
