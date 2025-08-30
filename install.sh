#!/bin/bash

# Arcestia Hyprland Dotfiles Installer
# Automated installation script for Hyprland rice configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}  ARCESTIA HYPRLAND DOTFILES   ${NC}"
    echo -e "${PURPLE}================================${NC}"
    echo ""
}

# Check if running on Arch Linux
check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        print_warning "This script is designed for Arch Linux. Continue anyway? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# Handle Hyprland config backup
handle_hyprland_backup() {
    if [[ -d "$HOME/.config/hypr" ]]; then
        echo ""
        print_warning "Existing Hyprland configuration detected at ~/.config/hypr"
        echo -e "${CYAN}Do you want to backup your current Hyprland configuration?${NC}"
        echo -e "  ${YELLOW}1)${NC} Yes, create backup"
        echo -e "  ${YELLOW}2)${NC} No, skip backup (current config will be overwritten)"
        echo ""
        echo -n "Choose option (1-2): "
        read -r backup_choice
        
        case $backup_choice in
            1)
                backup_hyprland_config
                ;;
            2)
                print_status "Skipping backup, proceeding with installation..."
                ;;
            *)
                print_error "Invalid choice. Exiting."
                exit 1
                ;;
        esac
    else
        print_status "No existing Hyprland configuration found, proceeding with installation..."
    fi
}

# Backup Hyprland config
backup_hyprland_config() {
    print_status "Creating backup of Hyprland configuration..."
    
    local backup_dir="$HOME/.config/hypr-backup-$(date +%Y%m%d_%H%M%S)"
    
    if [[ -d "$HOME/.config/hypr" ]]; then
        cp -r "$HOME/.config/hypr" "$backup_dir"
        print_success "Hyprland configuration backed up to: $backup_dir"
    fi
}

# Check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=()
    local deps=("hyprland" "waybar" "rofi" "swww" "cliphist" "wl-clipboard" "matugen" "kitty" "nautilus" "pamixer")
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        print_warning "Missing dependencies: ${missing_deps[*]}"
        print_status "Install missing packages? (Y/n)"
        read -r response
        if [[ ! "$response" =~ ^[Nn]$ ]]; then
            if command -v yay &> /dev/null; then
                yay -S "${missing_deps[@]}"
            elif command -v paru &> /dev/null; then
                paru -S "${missing_deps[@]}"
            else
                sudo pacman -S "${missing_deps[@]}"
            fi
        fi
    else
        print_success "All dependencies are installed"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_status "Installing Oh My Zsh..."
    
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed"
    else
        print_status "Oh My Zsh already installed"
    fi
    
    # Install plugins
    print_status "Installing Oh My Zsh plugins..."
    
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    # zsh-autosuggestions
    if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
        print_success "zsh-autosuggestions installed"
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$plugin_dir/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
        print_success "zsh-syntax-highlighting installed"
    fi
}

# Copy configurations
copy_configs() {
    print_status "Copying configuration files..."
    
    # Copy .config directory
    cp -r .config/* "$HOME/.config/"
    print_success "Hyprland, Waybar, and other configs copied"
    
    # Copy .zshrc
    cp .zshrc "$HOME/.zshrc"
    print_success "Zsh configuration copied"
    
    # Create wallpaper directory and copy wallpapers
    mkdir -p "$HOME/Pictures/wallpapers"
    cp wallpapers/* "$HOME/Pictures/wallpapers/"
    print_success "Wallpapers copied to ~/Pictures/wallpapers"
}

# Set permissions
set_permissions() {
    print_status "Setting script permissions..."
    
    # Make all scripts executable
    find "$HOME/.config/hypr/scripts" -name "*.sh" -exec chmod +x {} \;
    print_success "Script permissions set"
}

# Start clipboard daemon
start_clipboard_daemon() {
    print_status "Starting clipboard daemon..."
    
    # Check if cliphist daemon is already running
    if ! pgrep -f "cliphist store" > /dev/null; then
        # Start cliphist daemon
        wl-paste --type text --watch cliphist store &
        wl-paste --type image --watch cliphist store &
        print_success "Clipboard daemon started"
    else
        print_status "Clipboard daemon already running"
    fi
}

# Main installation process
main() {
    print_header
    
    # Change to script directory
    cd "$(dirname "$0")"
    
    print_status "Starting installation process..."
    
    check_arch
    handle_hyprland_backup  # Handle Hyprland backup at the beginning
    check_dependencies
    install_oh_my_zsh
    copy_configs
    set_permissions
    start_clipboard_daemon
    
    print_success "Installation completed successfully!"
    echo ""
    print_status "Next steps:"
    echo -e "  1. ${CYAN}Logout and login again${NC} or ${CYAN}restart your session${NC}"
    echo -e "  2. ${CYAN}Start Hyprland${NC} if not already running"
    echo -e "  3. ${CYAN}Switch to zsh${NC}: chsh -s \$(which zsh)"
    echo ""
    print_status "Key bindings:"
    echo -e "  ${CYAN}Super + Shift + W${NC} - Wallpaper picker"
    echo -e "  ${CYAN}Super + V${NC} - Clipboard history"
    echo -e "  ${CYAN}Super + Shift + V${NC} - Clear clipboard"
    echo -e "  ${CYAN}Super + D${NC} - Application launcher"
    echo -e "  ${CYAN}Super + Return${NC} - Terminal"
    echo ""
    print_success "Enjoy your new Hyprland rice! 🌸"
}

# Run installation
main "$@"
