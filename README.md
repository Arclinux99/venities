# VENITIES
This rice uses configs from many repos, so it's not 100% pure my creation

I use Matugen as the color scheme generator, so this dotfiles will work better with Matugen as you don't have to reconfigure every colors in the config file

As for the wallpaper, i use swww. The wallpaper picker script that i made uses swww combined with Matugen, so you need to tweak the script a bit to work with your own system if you use a different wallpaper backend

Special credit to [JaKooLit](https://github.com/JaKooLit), i used some of his scripts and waybar settings


## Quick Installation

Run the automated installation script:
```bash
./install.sh
```

## Manual Installation

### Prerequisites
Ensure you have the following packages installed:
```bash
# Arch Linux
sudo pacman -S hyprland waybar rofi swww cliphist wl-clipboard matugen pamixer oh-my-zsh-git pipewire pipewire-pulse pipewire-alsa wireplumber

# Or using AUR helper (yay/paru)
yay -S hyprland waybar rofi swww cliphist wl-clipboard matugen pamixer oh-my-zsh-git pipewire pipewire-pulse pipewire-alsa wireplumber
```

### Installation Steps
1. Clone this repository
2. Copy configurations to your home directory
3. Install Oh My Zsh plugins
4. Set up wallpaper directory
5. Setup audio system (see Audio Setup section)
6. Reload Hyprland configuration

### Audio Setup
After installation, enable audio services:
```bash
# Enable PipeWire audio services
systemctl --user enable --now pipewire
systemctl --user enable --now pipewire-pulse
systemctl --user enable --now wireplumber

# Test volume control
pamixer --get-volume
~/.config/hypr/scripts/volume.sh --get

# Run comprehensive audio test
./test_audio.sh
```

## Key Bindings

### Wallpaper Management
- **Super + Shift + W** → Open wallpaper picker

### Clipboard Manager
- **Super + V** → Show clipboard history
- **Super + Shift + V** → Clear clipboard history
- **Super + Ctrl + V** → Delete specific clipboard item

### Window Management
- **Super + Q** → Close active window
- **Super + F** → Toggle floating mode
- **Super + Shift + F** → Toggle fullscreen
- **Super + Return** → Open terminal
- **Super + E** → Open file manager
- **Super + Space** → Application launcher

### Screenshots
- **Super + Shift + S** → Area selection screenshot

### Named Workspaces
- **Super + G** → Switch to Gaming workspace
- **Super + M** → Switch to Spotify workspace
- **Super + Shift + G** → Move window to Gaming workspace
- **Super + Shift + M** → Move window to Spotify workspace

### Audio/Volume Control
- **XF86AudioRaiseVolume** → Increase volume (+2%)
- **XF86AudioLowerVolume** → Decrease volume (-2%)
- **XF86AudioMute** → Toggle mute/unmute
- **XF86AudioMicMute** → Toggle microphone mute
- **XF86AudioNext/Prev/Pause** → Media player controls

#### Waybar Volume Control
- **Volume Icon**: Hover cursor over volume icon in Waybar
  - **Left Click** → Toggle mute/unmute
  - **Right Click** → Open PavuControl audio mixer
  - **Scroll Up** → Increase volume (+5%)
  - **Scroll Down** → Decrease volume (-5%)

#### Music Player Control (MPRIS)
- **Music Icon**: Hover cursor over music/media icon in Waybar
  - **Left Click** → Previous track
  - **Middle Click** → Play/Pause
  - **Right Click** → Next track
  - **Scroll Up/Down** → Volume control

### System
- **Super + L** → Lock screen
- **Super + R** → Restart Waybar

<img width="640" height="480" alt="20250720_22h08m02s_grim" src="https://github.com/user-attachments/assets/cdfc60a8-9241-4633-bc23-8d80ebe9f862" />

<img width="640" height="480" alt="20250720_22h10m55s_grim" src="https://github.com/user-attachments/assets/66696b8b-d479-4884-b10b-1920ae8b21a2" />


