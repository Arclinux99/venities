#!/bin/bash
# Audio Diagnostic Script for Arch Linux
# Checks audio system status and provides troubleshooting info

echo "=== AUDIO SYSTEM DIAGNOSTIC ==="
echo

# Check audio services status
echo "1. Audio Services Status:"
echo "-------------------------"
systemctl --user status pipewire pipewire-pulse wireplumber --no-pager -l | grep -E "(Active:|Main PID:|●)"
echo

# Check audio devices
echo "2. Available Audio Devices:"
echo "---------------------------"
aplay -l 2>/dev/null || echo "alsa-utils not installed"
echo

# Check PulseAudio sinks
echo "3. PulseAudio Sinks:"
echo "-------------------"
pactl list short sinks
echo

# Check current audio status
echo "4. Current Audio Configuration:"
echo "------------------------------"
pactl info | grep -E "(Default Sink:|Default Source:)"
echo

# Check volume and mute status
echo "5. Volume Status:"
echo "----------------"
pactl list sinks | grep -A3 -E "(State:|Mute:|Volume:)"
echo

# Check active ports
echo "6. Active Audio Ports:"
echo "---------------------"
pactl list sinks | grep -A2 "Active Port:"
echo

# Test commands
echo "7. Test Commands:"
echo "----------------"
echo "Test audio: speaker-test -t wav -c 2 -l 1"
echo "Play test file: pw-play /usr/share/sounds/alsa/Front_Left.wav"
echo "Volume control GUI: pavucontrol"
echo

echo "=== END DIAGNOSTIC ==="
