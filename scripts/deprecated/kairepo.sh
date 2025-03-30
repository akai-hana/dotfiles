#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 [repository-name]"
else
  repo_name=$1
  echo "Disabling repository $repo_name..."
  doas eselect repository disable $repo_name
  echo "Syncing..."
  doas emerge --sync
  echo "Enabling repository $repo_name again..."
  doas eselect repository enable $repo_name
  echo "Syncing again..."
  doas emerge --sync
  echo "Finished!"
fi
