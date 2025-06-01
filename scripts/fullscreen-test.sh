#!/bin/sh

# Fullscreen Resource Manager
# Pauses picom and live wallpaper when any window goes fullscreen
# Resumes them when exiting fullscreen

PICOM_PID=""
WALLPAPER_PID=""
FULLSCREEN_STATE=false

# Function to pause services
pause_services() {
    echo "Pausing services..."
    
    # Kill picom entirely instead of pausing (safer approach)
    if pgrep -x "picom" > /dev/null; then
        PICOM_PID=$(pgrep -x "picom")
        pkill -x "picom" &  # Background the kill command
    fi
    
    # Pause live wallpaper - Shadow (python process)
    if pgrep -x "python" > /dev/null; then
        WALLPAPER_PID=$(pgrep -x "python")
        kill -STOP "$WALLPAPER_PID" &  # Background the pause
    fi
}

# Function to resume services
resume_services() {
    echo "Resuming services..."
    
    # Resume wallpaper first (faster)
    if [ -n "$WALLPAPER_PID" ] && kill -0 "$WALLPAPER_PID" 2>/dev/null; then
        kill -CONT "$WALLPAPER_PID" &  # Background the resume
    else
        echo "Shadow wallpaper process not found - may need manual restart"
    fi
    
    # Restart picom in background with optimized flags
    if ! pgrep -x "picom" > /dev/null; then
        # Use faster backend and disable some effects for quicker startup
        picom --daemon --backend glx --no-fading-openclose --fade-in-step=1 --fade-out-step=1 &
    else
        echo "Picom already running"
    fi
}

# Function to check if any window is fullscreen
check_fullscreen() {
    # Get the active window
    local active_window=$(xdotool getactivewindow 2>/dev/null)
    
    if [ -n "$active_window" ]; then
        # Check if window is fullscreen
        local window_state=$(xprop -id "$active_window" _NET_WM_STATE 2>/dev/null | grep -o "_NET_WM_STATE_FULLSCREEN")
        
        if [ -n "$window_state" ]; then
            # Get the window's process name to check if it's ghostty
            local window_pid=$(xprop -id "$active_window" _NET_WM_PID 2>/dev/null | cut -d' ' -f3)
            if [ -n "$window_pid" ]; then
                local process_name=$(ps -p "$window_pid" -o comm= 2>/dev/null)
                if [ "$process_name" = "ghostty" ]; then
                    return 1  # Ignore ghostty fullscreen
                fi
            fi
            return 0  # Fullscreen (non-ghostty)
        fi
    fi
    return 1  # Not fullscreen
}

# Main monitoring loop
while true; do
    if check_fullscreen; then
        if [ "$FULLSCREEN_STATE" = false ]; then
            pause_services
            FULLSCREEN_STATE=true
        fi
    else
        if [ "$FULLSCREEN_STATE" = true ]; then
            resume_services
            FULLSCREEN_STATE=false
        fi
    fi
    
done
