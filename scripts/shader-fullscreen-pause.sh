#!/bin/sh
# Fully event-driven fullscreen shader wallpaper/picom manager script
# (by akai - converted to pure event-driven approach)
# This script saves on computer resources by stopping the
# shader wallpaper and picom from running when full-screening onto a program.
# Zero polling - purely event-driven using X11 events.

# Same assumptions as original:
# + Ghostty as the terminal program  
# + Zen as the browser
# + Vesktop as the Discord client
# + Transparent terminal
# + Shadow (shader wallpaper program) being installed specifically under "~/git/shadow"

PICOM_PID=""
WALLPAPER_PID=""
FULLSCREEN_STATE=false

# Function to pause services
pause_services() {
    echo "Pausing services..."
    
    # Kill picom entirely instead of pausing (safer approach)
    if pgrep -x "picom" > /dev/null; then
        PICOM_PID=$(pgrep -x "picom")
        pkill -x "picom" &
    fi
    
    # Pause live wallpaper - Shadow (python process)
    if pgrep -x "python" > /dev/null; then
        WALLPAPER_PID=$(pgrep -x "python")
        kill -STOP "$WALLPAPER_PID" &
    fi
}

# Function to resume services
resume_services() {
    echo "Resuming services..."
    
    # Resume wallpaper first (faster)
    if [ -n "$WALLPAPER_PID" ] && kill -0 "$WALLPAPER_PID" 2>/dev/null; then
        kill -CONT "$WALLPAPER_PID" &
    else
        echo "Shadow wallpaper process not found - may need manual restart"
    fi
    
    # Restart picom in background with optimized flags
    if ! pgrep -x "picom" > /dev/null; then
        picom --daemon --backend glx --no-fading-openclose --fade-in-step=1 --fade-out-step=1 &
    else
        echo "Picom already running"
    fi
}

# Function to check if specific window is fullscreen
is_window_fullscreen() {
    local window_id="$1"
    [ -n "$window_id" ] || return 1
    
    # Check if window has fullscreen state
    local window_state=$(xprop -id "$window_id" _NET_WM_STATE 2>/dev/null | grep -o "_NET_WM_STATE_FULLSCREEN")
    
    if [ -n "$window_state" ]; then
        # Get the window's process name to check if it's ghostty
        local window_pid=$(xprop -id "$window_id" _NET_WM_PID 2>/dev/null | cut -d' ' -f3)
        if [ -n "$window_pid" ]; then
            local process_name=$(ps -p "$window_pid" -o comm= 2>/dev/null)
            if [ "$process_name" = "ghostty" ]; then
                return 1  # Ignore ghostty fullscreen
            fi
        fi
        return 0  # Fullscreen (non-ghostty)
    fi
    return 1  # Not fullscreen
}

# Function to handle state changes
handle_state_change() {
    local new_fullscreen_state=false
    
    # Get currently active window
    local active_window=$(xdotool getactivewindow 2>/dev/null)
    
    if [ -n "$active_window" ] && is_window_fullscreen "$active_window"; then
        new_fullscreen_state=true
    fi
    
    # Only act if state actually changed
    if [ "$new_fullscreen_state" != "$FULLSCREEN_STATE" ]; then
        if [ "$new_fullscreen_state" = true ]; then
            pause_services
            FULLSCREEN_STATE=true
        else
            resume_services
            FULLSCREEN_STATE=false
        fi
    fi
}

# Cleanup function for proper shutdown
cleanup() {
    echo "Shutting down fullscreen manager..."
    if [ "$FULLSCREEN_STATE" = true ]; then
        resume_services
    fi
    # Kill all background jobs
    jobs -p | xargs -r kill 2>/dev/null
    exit 0
}

# Set up signal handlers for clean shutdown
trap cleanup INT TERM EXIT

# Check dependencies
for cmd in xdotool xprop xev; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: $cmd is required but not installed"
        exit 1
    fi
done

# Check initial state
handle_state_change

echo "Fully event-driven fullscreen manager started. Listening for window events..."

# Pure event-driven approach using xev to monitor X11 events
# This monitors PropertyNotify events for window state changes
xev -root -event property | while IFS= read -r line; do
    case "$line" in
        *"PropertyNotify event"*)
            # A property changed on the root window or a child window
            handle_state_change
            ;;
        *"_NET_ACTIVE_WINDOW"*)
            # Active window changed
            handle_state_change
            ;;
        *"_NET_WM_STATE"*)
            # Window state changed (including fullscreen)
            handle_state_change
            ;;
    esac
done
