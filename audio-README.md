# Audio Configuration for Arch Linux

This directory contains audio configuration files for Arch Linux using PipeWire.

## Files

- `audio-config.sh` - Main audio configuration script
- `pipewire.conf` - PipeWire configuration file
- `audio-setup.service` - Systemd service for auto-setup
- `audio-diagnostic.sh` - Diagnostic script for troubleshooting

## Quick Setup

1. Make scripts executable:
   ```bash
   chmod +x audio-config.sh audio-diagnostic.sh
   ```

2. Run audio configuration:
   ```bash
   ./audio-config.sh
   ```

## Installation

### Copy PipeWire config:
```bash
mkdir -p ~/.config/pipewire/pipewire.conf.d/
cp pipewire.conf ~/.config/pipewire/pipewire.conf.d/
```

### Install systemd service (optional):
```bash
mkdir -p ~/.config/systemd/user/
cp audio-setup.service ~/.config/systemd/user/
systemctl --user enable audio-setup.service
```

## Manual Configuration Commands

The following commands were used to fix the original audio issues:

```bash
# Set output port to speakers
pactl set-sink-port alsa_output.pci-0000_05_00.6.analog-stereo analog-output-speaker

# Set as default sink
pactl set-default-sink alsa_output.pci-0000_05_00.6.analog-stereo

# Set volume
pactl set-sink-volume alsa_output.pci-0000_05_00.6.analog-stereo 80%

# Activate sink
pactl suspend-sink alsa_output.pci-0000_05_00.6.analog-stereo 0

# Restart services
systemctl --user restart pipewire pipewire-pulse wireplumber
```

## Troubleshooting

Run the diagnostic script:
```bash
./audio-diagnostic.sh
```

### Common Issues:

1. **No sound**: Check if sink is suspended or muted
2. **Wrong output**: Ensure speakers port is selected (not headphones)
3. **Low volume**: Adjust volume with pactl or pavucontrol
4. **Service issues**: Restart PipeWire services

### Required Packages:
```bash
sudo pacman -S pipewire pipewire-alsa pipewire-pulse wireplumber alsa-utils
```

## Hardware Info

Audio devices detected:
- **AMD Family 17h/19h/1ah HD Audio Controller** (Card 1) - Main audio
- **NVIDIA GA107 High Definition Audio Controller** (Card 0) - HDMI audio

Default configuration uses AMD controller with analog stereo output to speakers.
