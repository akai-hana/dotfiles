#!/bin/sh

# Launch ffplay in the background
ffplay -f v4l2 -input_format mjpeg -framerate 30 -video_size 1920x1080 \
    -probesize 32 -analyzeduration 0 -avioflags direct -rtbufsize 128M \
    -fflags nobuffer -flags low_delay -framedrop -tune zerolatency \
    -vf "hflip" -an /dev/video0 &
PID=$!

# Wait for the ffplay window to appear
sleep 1

# Get the window ID of the ffplay instance
WIN_ID=$(xwininfo -name "ffplay" | awk '/Window id:/{print $4}')

# If not found, try again for a few seconds
for i in $(seq 1 10); do
    [ -n "$WIN_ID" ] && break
    sleep 0.2
    WIN_ID=$(xwininfo -name "ffplay" 2>/dev/null | awk '/Window id:/{print $4}')
done

if [ -z "$WIN_ID" ]; then
    echo "❌ Could not find ffplay window."
    exit 1
fi

# Calculate aspect ratio (from your video_size)
W=1920
H=1080

# Set aspect ratio hint (min_aspect = max_aspect = 1920/1080)
xprop -id "$WIN_ID" -f WM_NORMAL_HINTS 32i \
    -set WM_NORMAL_HINTS "0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $W, $H, $W, $H, 0, 0, 0"

echo "✅ Locked window $WIN_ID to aspect ratio ${W}:${H}"

wait $PID

