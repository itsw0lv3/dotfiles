#!/bin/bash

# Waybar Config Switcher
# Usage: ./switch-config.sh [full-bar|split-bar] [theme]

WAYBAR_DIR="$HOME/.config/waybar"  # Adjust path as needed
CONFIGS_DIR="$WAYBAR_DIR/configs"
THEMES_DIR="$WAYBAR_DIR/themes"
STYLE_FILE="$WAYBAR_DIR/style.css"

# Function to show usage
show_usage() {
    echo "Usage: $0 <config> [theme]"
    echo ""
    echo "Available configs:"
    ls "$CONFIGS_DIR" 2>/dev/null | sed 's/\.css$//' | sed 's/^/  - /'
    echo ""
    echo "Available themes:"
    ls "$THEMES_DIR" 2>/dev/null | sed 's/\.css$//' | sed 's/^/  - /'
    echo ""
    echo "Examples:"
    echo "  $0 full-bar simple-dark"
    echo "  $0 split-bar gruvbox"
    echo "  $0 full-bar  # Uses current theme"
}

# Check if config argument is provided
if [ $# -lt 1 ]; then
    echo "Error: Config name required"
    show_usage
    exit 1
fi

CONFIG="$1"
THEME="$2"
CONFIG_FILE="$CONFIGS_DIR/$CONFIG.css"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Config file '$CONFIG_FILE' not found"
    show_usage
    exit 1
fi

# If theme is provided, check if it exists
if [ -n "$THEME" ]; then
    THEME_FILE="$THEMES_DIR/$THEME.css"
    if [ ! -f "$THEME_FILE" ]; then
        echo "Error: Theme file '$THEME_FILE' not found"
        show_usage
        exit 1
    fi
fi

# Backup current style.css
# if [ -f "$STYLE_FILE" ]; then
#     cp "$STYLE_FILE" "$STYLE_FILE.backup"
#     echo "Backed up current style.css to style.css.backup"
# fi

# Copy the selected config
cp "$CONFIG_FILE" "$STYLE_FILE"
echo "Applied config: $CONFIG"

# If theme is specified, update the import line
if [ -n "$THEME" ]; then
    sed -i "s|@import url(\"themes/.*\.css\")|@import url(\"themes/$THEME.css\")|g" "$STYLE_FILE"
    echo "Applied theme: $THEME"
fi

# Restart waybar if it's running
if pgrep waybar > /dev/null; then
    echo "Restarting waybar..."
    pkill waybar
    sleep 0.5
    waybar &
    echo "Waybar restarted"
fi

echo "Configuration applied successfully!"
