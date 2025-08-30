# VENITIES
This rice uses configs from many repos, so it's not 100% pure my creation

I use Matugen as the color scheme generator, so this dotfiles will work better with Matugen as you don't have to reconfigure every colors in the config file

As for the wallpaper, i use swww. The wallpaper picker script that i made uses swww combined with Matugen, so you need to tweak the script a bit to work with your own system if you use a different wallpaper backend

Special credit to [JaKooLit](https://github.com/JaKooLit), i used some of his scripts and waybar settings

## Features
- **Hyprland** window manager with custom configurations
- **Waybar** status bar with multiple layouts and styles
- **Rofi** application launcher and menu system
- **Swww** wallpaper daemon with automatic color scheme generation
- **Cliphist** clipboard manager with rofi integration
- **Matugen** automatic color scheme generation from wallpapers
- **Oh My Zsh** with auto-suggestions and syntax highlighting

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
sudo pacman -S hyprland waybar rofi swww cliphist wl-clipboard matugen oh-my-zsh-git

# Or using AUR helper (yay/paru)
yay -S hyprland waybar rofi swww cliphist wl-clipboard matugen oh-my-zsh-git
```

### Installation Steps
1. Clone this repository
2. Copy configurations to your home directory
3. Install Oh My Zsh plugins
4. Set up wallpaper directory
5. Reload Hyprland configuration

## Key Bindings

### Wallpaper Management
- **Super + Shift + W** → Open wallpaper picker

### Clipboard Manager
- **Super + V** → Show clipboard history
- **Super + Shift + V** → Clear clipboard history
- **Super + Ctrl + V** → Delete specific clipboard item

### Window Management
- **Super + Q** → Close active window
- **Super + Space** → Toggle floating mode
- **Super + Shift + F** → Toggle fullscreen
- **Super + Return** → Open terminal
- **Super + E** → Open file manager
- **Super + D** → Application launcher

### Screenshots
- **Super + Shift + S** → Area selection screenshot

### System
- **Super + L** → Lock screen
- **Super + R** → Restart Waybar

<img width="640" height="480" alt="20250720_22h08m02s_grim" src="https://github.com/user-attachments/assets/cdfc60a8-9241-4633-bc23-8d80ebe9f862" />

<img width="640" height="480" alt="20250720_22h10m55s_grim" src="https://github.com/user-attachments/assets/66696b8b-d479-4884-b10b-1920ae8b21a2" />


