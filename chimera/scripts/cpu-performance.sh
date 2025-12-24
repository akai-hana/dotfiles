#!/bin/sh
sleep 2s
echo performance | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
