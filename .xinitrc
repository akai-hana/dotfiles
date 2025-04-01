. ~/.xprofile
xrdb -merge ~/.xresources

exec dbus-launch --sh-syntax --exit-with-session awesome
#exec dbus-launch --sh-syntax --exit-with-session nichtwm
