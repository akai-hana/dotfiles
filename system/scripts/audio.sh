#!/bin/sh
sleep 3s
pipewire &
sleep 1s
pipewire-pulse &
sleep 1s
wireplumber &
