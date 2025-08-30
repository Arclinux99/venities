#!/bin/bash

# Clipboard Manager Script for Hyprland
# Uses cliphist and rofi for clipboard history management

case "${1:-show}" in
    "show"|"list")
        # Show clipboard history with rofi
        cliphist list | rofi -dmenu -p "📋 Clipboard" \
            -theme-str 'window {width: 800px; height: 600px;}' \
            -theme-str 'listview {lines: 20;}' \
            -theme-str 'element-text {horizontal-align: 0;}' | \
        cliphist decode | wl-copy
        ;;
    
    "clear"|"clean")
        # Clear clipboard history
        cliphist wipe
        # Also clear current clipboard
        echo -n "" | wl-copy
        notify-send "Clipboard" "History cleared" -i edit-clear
        ;;
        
    "delete")
        # Delete selected item from history
        cliphist list | rofi -dmenu -p "🗑️ Delete from Clipboard" \
            -theme-str 'window {width: 800px; height: 600px;}' \
            -theme-str 'listview {lines: 20;}' | \
        cliphist delete
        ;;
        
    *)
        echo "Usage: $0 [show|clear|delete]"
        echo "  show   - Show clipboard history (default)"
        echo "  clear  - Clear clipboard history"
        echo "  delete - Delete selected item from history"
        exit 1
        ;;
esac
