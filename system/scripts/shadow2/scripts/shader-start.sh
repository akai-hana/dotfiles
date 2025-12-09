#!/bin/sh

cd ~/git/shadow || exit 1

# Random selection using sort with random key
shader=$(find ~/git/shader-wallpaper/shadow -name "*.frag" | sort -R | head -n 1)

# Run the shadow command in the background
DRI_PRIME=1 poetry run shadow "$shader" -m root -f 20 -q 1 &
