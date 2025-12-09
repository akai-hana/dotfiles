#!/bin/sh

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run with root privileges." >&2
  exit 1
fi

# Reset the latency timer for all PCI devices
setpci -v -s '*:*' latency_timer=20
setpci -v -s '0:0' latency_timer=0

# Set latency timer for all sound cards
setpci -v -d "*:*:04xx" latency_timer=80
