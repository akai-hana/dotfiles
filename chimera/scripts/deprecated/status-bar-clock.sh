#!/bin/bash
# Seconds-accurate clock, while only updating every minute.

seconds_left=$((60 - $(date +%S)))
echo $seconds_left
sleep $seconds_left

while true; do
  current_time=$(date +'%d %b %R')
  xsetroot -name "Greetings, akai. || $current_time [GMT+1 ($(date +%Z))] ||"
  sleep 1m
done
