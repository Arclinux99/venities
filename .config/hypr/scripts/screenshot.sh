#!/bin/bash

# Screenshot script for Hyprland
# Takes a screenshot, copies to clipboard, and saves to file

# Create screenshots directory if it doesn't exist
mkdir -p ~/Pictures/Screenshots

# Take screenshot with area selection
grim -g "$(slurp)" - | tee ~/Pictures/Screenshots/screenshot_$(date +'%Y%m%d_%H%M%S').png | wl-copy

# Notify user
notify-send "Screenshot" "Captured to clipboard and saved to ~/Pictures/Screenshots" -i camera-photo
