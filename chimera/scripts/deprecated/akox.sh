#!/bin/sh
doas emerge -1 virtualbox-modules &&
doas modprobe -a vboxdrv vboxnetflt vboxnetadp
