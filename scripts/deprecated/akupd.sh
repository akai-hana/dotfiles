#!/bin/sh
doas mirrorselect -s 5 &&
doas emerge --sync &&
doas emerge -uDNq --autounmask-backtrack=y --backtrack=99 --autounmask-write --keep-going @world &&
doas emerge --depclean --with-bdeps=y &&
doas emerge --clean
