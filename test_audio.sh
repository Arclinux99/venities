#!/bin/bash
# Test script untuk verifikasi konfigurasi audio dan waybar

echo "🔊 Testing Audio Configuration..."
echo "================================"

# Test 1: Check PipeWire services
echo "1. Checking PipeWire services..."
systemctl --user is-active pipewire &>/dev/null && echo "✅ PipeWire: Active" || echo "❌ PipeWire: Inactive"
systemctl --user is-active pipewire-pulse &>/dev/null && echo "✅ PipeWire-Pulse: Active" || echo "❌ PipeWire-Pulse: Inactive" 
systemctl --user is-active wireplumber &>/dev/null && echo "✅ Wireplumber: Active" || echo "❌ Wireplumber: Inactive"

# Test 2: Check pamixer
echo -e "\n2. Testing pamixer..."
if command -v pamixer &> /dev/null; then
    VOLUME=$(pamixer --get-volume 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "✅ Pamixer: Working (Volume: ${VOLUME}%)"
    else
        echo "❌ Pamixer: Connection Error"
    fi
else
    echo "❌ Pamixer: Not installed"
fi

# Test 3: Check volume script
echo -e "\n3. Testing volume script..."
SCRIPT_PATH="$HOME/.config/hypr/scripts/volume.sh"
if [ -f "$SCRIPT_PATH" ] && [ -x "$SCRIPT_PATH" ]; then
    SCRIPT_OUTPUT=$("$SCRIPT_PATH" --get 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "✅ Volume script: Working (${SCRIPT_OUTPUT})"
    else
        echo "❌ Volume script: Error executing"
    fi
else
    echo "❌ Volume script: Not found or not executable"
fi

# Test 4: Check Waybar config
echo -e "\n4. Checking Waybar configuration..."
CONFIG_PATH="$HOME/.config/waybar/config"
if [ -f "$CONFIG_PATH" ]; then
    if grep -q "pulseaudio" "$CONFIG_PATH"; then
        echo "✅ Waybar config: Contains pulseaudio module"
    else
        echo "❌ Waybar config: Missing pulseaudio module"
    fi
else
    echo "❌ Waybar config: Not found"
fi

# Test 5: Check audio devices
echo -e "\n5. Checking audio devices..."
if [ -f "/proc/asound/cards" ]; then
    AUDIO_CARDS=$(cat /proc/asound/cards | wc -l)
    echo "✅ Audio cards detected: $((AUDIO_CARDS / 2))"
else
    echo "❌ No audio cards detected"
fi

echo -e "\n🎵 Volume Control Test Complete!"
echo "================================"
echo "If all tests show ✅, your audio configuration is working properly."
echo "You can now use:"
echo "- Keyboard media keys for volume control"
echo "- Waybar volume icon (hover cursor + scroll/click)"
echo "- Script: ~/.config/hypr/scripts/volume.sh [--inc|--dec|--toggle]"
