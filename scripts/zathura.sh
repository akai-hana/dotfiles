#!/bin/sh

# Launch Zathura and record its PID.
zathura "$@" &
ZATHURA_PID=$!

# Immediately minimize the terminal.
awesome-client 'client.focus.minimized = true' &

# Wait for the DBus signal that indicates that Zathura's name has been released.
dbus-monitor "type='signal',interface='org.freedesktop.DBus',member='NameOwnerChanged'" | \
awk '/org.pwmt.zathura/ {
  # Skip the first two lines (old owner, new owner)
  getline; getline;
  # Only exit if the new owner is empty (i.e. string "")
  if ($0 ~ /string ""/) { exit 0 }
}'

# Now that Zathura has closed, restore the terminal.
awesome-client 'for _, c in ipairs(client.get()) do
  if c.minimized then
    c.minimized = false;
    client.focus = c;
    break
  end
end'
