#!/bin/bash
export DOTNET_ROOT=/home/akai/dotnet/

~/git/OpenTabletDriver/bin/OpenTabletDriver.Daemon &
daemon_pid=$!

~/git/OpenTabletDriver/bin/OpenTabletDriver.UX.Gtk &
gtk_pid=$!

/usr/bin/osu-lazer &
osu_pid=$!

wait $osu_pid
kill $daemon_pid $gtk_pid
return 0