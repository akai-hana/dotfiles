#!/bin/sh

REPO_NAME="$1"

doas eselect repository enable "$REPO_NAME"
doas emerge --sync "$REPO_NAME"
