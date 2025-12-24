#!/usr/bin/env sh

doas rc-service iwd start
doas iwctl adapter phy0 set-property Powered on
doas iwctl device wlan0 set-property Powered on
doas iwctl station wlan0 scan
sleep 5s
doas iwctl station wlan0 connect "Uzbekistan"
