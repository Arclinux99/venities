#!/bin/bash
# Audio Configuration Script for Arch Linux
# Based on PipeWire/ALSA setup

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}[INFO]${NC} Setting up audio configuration..."

# Enable and start audio services
echo -e "${YELLOW}[STEP 1]${NC} Starting audio services..."
systemctl --user enable --now pipewire pipewire-pulse wireplumber

# Wait for services to start
sleep 2

# Set correct audio output port to speakers
echo -e "${YELLOW}[STEP 2]${NC} Configuring audio output port..."
pactl set-sink-port alsa_output.pci-0000_05_00.6.analog-stereo analog-output-speaker

# Set default sink
echo -e "${YELLOW}[STEP 3]${NC} Setting default audio sink..."
pactl set-default-sink alsa_output.pci-0000_05_00.6.analog-stereo

# Set volume to 80%
echo -e "${YELLOW}[STEP 4]${NC} Setting volume to 80%..."
pactl set-sink-volume alsa_output.pci-0000_05_00.6.analog-stereo 80%

# Ensure sink is not suspended
echo -e "${YELLOW}[STEP 5]${NC} Activating audio sink..."
pactl suspend-sink alsa_output.pci-0000_05_00.6.analog-stereo 0

# Test audio
echo -e "${YELLOW}[STEP 6]${NC} Testing audio output..."
if command -v speaker-test >/dev/null 2>&1; then
    echo "Running audio test (2 seconds)..."
    timeout 2s speaker-test -t wav -c 2 >/dev/null 2>&1
    echo -e "${GREEN}[SUCCESS]${NC} Audio test completed!"
else
    echo -e "${RED}[WARNING]${NC} speaker-test not available, install alsa-utils for testing"
fi

echo -e "${GREEN}[COMPLETE]${NC} Audio configuration applied successfully!"
echo -e "${GREEN}[INFO]${NC} Your audio should now work with Spotify, Firefox, and other applications."
