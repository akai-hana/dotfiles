#!/bin/sh

# Kill existing wallpaper processes
pkill xwinwrap
pkill mpv

# Get screen resolution
RESOLUTION=$(xrandr | grep '*' | awk '{print $1}' | head -1)
WIDTH=$(echo $RESOLUTION | cut -d'x' -f1)
HEIGHT=$(echo $RESOLUTION | cut -d'x' -f2)

# Create a simple color source for mpv to apply shaders to
# We'll use lavfi (libavfilter) to generate a test pattern
xwinwrap -ov -g ${WIDTH}x${HEIGHT}+0+0 -- mpv \
    --no-audio \
    --no-osc \
    --no-osd-bar \
    --loop-file \
    --player-operation-mode=pseudo-gui \
    --input-media-keys=no \
    --video-sync=display-resample \
    --interpolation \
    --tscale=oversample \
    --glsl-shader="$HOME/shaders/o.glsl" \
    "lavfi://color=color=black:size=${WIDTH}x${HEIGHT}:rate=60" &
