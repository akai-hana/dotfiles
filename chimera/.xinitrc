#!/bin/sh
xrdb -merge ~/.xresources
. ~/.xprofile &

exec dbus-launch hana
#exec dbus-launch dwm
#exec dbus-launch --exit-with-session i3
#exec dbus-launch --exit-with-session awesome
#exec dbus-launch --exit-with-session bspwm
#exec dbus-launch --sh-syntax --exit-with-session leftwm
#exec dbus-launch --sh-syntax --exit-with-session icewm
#exec dbus-launch --sh-syntax --exit-with-session awesome
#exec dbus-launch --sh-syntax --exit-with-session nichtwm
