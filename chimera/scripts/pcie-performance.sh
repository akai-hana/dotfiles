#!/bin/sh
for i in /sys/bus/pci/devices/*/power/control; do
    echo on | doas tee "$i" > /dev/null
done
