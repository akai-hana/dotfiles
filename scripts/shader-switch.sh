#!/bin/sh

killall python
(cd ~/git/shadow && DRI_PRIME=1 poetry run shadow "$(find ~/shader-wallpaper/shadow -name "*.frag" | shuf -n 1)" -m root -f 20 -q 1) &
