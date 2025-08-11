#!/usr/env/bin bash

echo "Installing yay.."
sh yay.sh
echo "Installing base hypr"
sh simpleHypr.sh
echo "Installling AMD mesa and gaming drivers"
sh AMD.sh
echo "Installing Wine things"
sh wine.sh
echo "Gaming stuffs"
sh gaming_stuff.sh
echo "Dev tools"
sh dev.sh
