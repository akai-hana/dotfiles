#!/bin/bash
# STATE=1

# grab the number off line 2
state=$(sed -n '2s/[^0-9]*\([0-9]\+\).*/\1/p' "$0")

cmds=(
  "setxkbmap us"
  "setxkbmap es"
  "setxkbmap -layout gallium -variant basic"
)

# run it
eval "${cmds[state]}"

# compute next & patch line 2
next=$(( (state + 1) % ${#cmds[@]} ))
sed -i "2s/[0-9]\+/$next/" "$0"

