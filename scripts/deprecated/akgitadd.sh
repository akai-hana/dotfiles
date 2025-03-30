#!/bin/sh
current_directory=$(pwd)
git config --global --add safe.directory "$current_directory"
echo "safe directory added ($current_directory)"
