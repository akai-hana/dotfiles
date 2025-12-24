#!/usr/bin/env bash

# 1. Get the window ID of the active terminal
TERMINAL_WIN=$(xdotool getactivewindow)

# 2. Unmap (hide) it from the window manager
xdotool windowunmap "$TERMINAL_WIN"  &&  sleep 0.1

# 3. Launch the GUI app (replace $@ with your command)
"$@"

# 4. When the app exits, remap (show) the terminal
xdotool windowmap "$TERMINAL_WIN"
