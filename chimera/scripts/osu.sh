#!/bin/bash


# Launch osu-lazer and capture PID of the wrapper process
flatpak run sh.ppy.osu &
OSU_PID=$!

# Launch otd-daemon
flatpak run net.opentabletdriver.OpenTabletDriver &

# Wait for processes to initialize
sleep 3s

# Set real-time priority for OpenTabletDriver
doas chrt -f -p 99 $(ps -e | grep OpenTabletDrive | awk '{print $1}')

# Wait for osu-lazer to exit (event-driven - uses no CPU while waiting)
wait $OSU_PID

# Cleanup: kill OTD processes when osu-lazer exits
$DISTROBOX pkill -x otd-daemon
$DISTROBOX pkill -x otd-gui
