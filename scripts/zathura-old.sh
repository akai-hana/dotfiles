#!/bin/sh

zathura "$@" &
awesome-client 'client.focus.minimized = true' &

ZATHURA_PID=$!

wait $ZATHURA_PID

#dbus-monitor "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged'" |
#    awk '/zathura/ { exit }'

awesome-client 'for _, c in ipairs(client.get()) do if c.minimized then c.minimized = false; client.focus = c; break end end'
