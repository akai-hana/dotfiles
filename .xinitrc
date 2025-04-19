# . ~/.xprofile
xrdb -merge ~/.xresources

#exec dwm
exec dbus-launch --exit-with-session dwm
#exec dbus-launch --sh-syntax --exit-with-session leftwm
#exec dbus-launch --sh-syntax --exit-with-session icewm
#exec dbus-launch --sh-syntax --exit-with-session awesome
#exec dbus-launch --sh-syntax --exit-with-session nichtwm
