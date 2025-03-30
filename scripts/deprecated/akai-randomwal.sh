#!/bin/bash
wal -i "$(find ~/wallpapers -type f | shuf -n 1)" &
pywalfox update &
~/git/Youwal/youwal &

