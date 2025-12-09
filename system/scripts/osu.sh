#!/bin/sh

osu-lazer &
otd-daemon &
sleep 1s
doas chrt -f -p 99 $(ps -e | grep OpenTabletDrive | awk '{print $1}')
