#!/bin/sh

# Get the active terminal window ID
TERMINAL_WIN_ID=$(xdotool getactivewindow)
echo "Terminal Window ID: $TERMINAL_WIN_ID"  # Debugging

# Minimize the terminal
echo "Minimizing terminal..."
xdotool windowminimize "$TERMINAL_WIN_ID"
echo "Terminal should now be minimized."

# Run Zathura and wait for it to exit
echo "Launching Zathura..."
zathura "$@"
echo "Zathura closed."

# Restore the terminal
echo "Attempting to restore terminal..."
awesome-client "for _, c in ipairs(client.get()) do if c.window == $TERMINAL_WIN_ID then c.minimized = false; client.focus = c; c:raise(); break end end"
echo "Restore command sent."
