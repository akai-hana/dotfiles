#!/bin/sh
# Regenerate Ghostty config from pywal colors

WAL_DIR="$HOME/.cache/wal"
GHOSTTY_CONF="$HOME/.config/ghostty/config"
WAL_COLORS="$WAL_DIR/colors"

# Extract colors
readarray -t COLORS < "$WAL_COLORS"

# Overwrite Ghostty color section
{
    echo "font-family = \"Fira Code Retina\""
    echo "shell-integration = fish"
    echo ""
    echo "window-decoration = \"none\""
    echo "window-padding-x = 0"
    echo "confirm-close-surface = false"
    echo ""
    echo "background-opacity = 0.6"
    echo "background-blur-radius = 20"
    echo ""
    echo "background   = ${COLORS[0]}"
    echo "foreground   = ${COLORS[15]}"
    echo "cursor-color = ${COLORS[8]}"
    echo ""
    echo "selection-foreground = ${COLORS[15]}"
    echo "selection-background = ${COLORS[1]}"
    echo ""
    for i in {0..15}; do
        echo "palette = $i=${COLORS[$i]}"
    done
} > "$GHOSTTY_CONF"

