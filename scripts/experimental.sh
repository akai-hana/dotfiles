#!/bin/bash

# Portage Repository Package Manager Script
# Usage: ./script.sh <repository> <package>

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <repository> <package>"
    echo "Example: $0 guru app-misc/hello"
    exit 1
fi

# Assign arguments to variables
REPOSITORY="$1"
PACKAGE="$2"

# Check if running as root (required for eselect and file modifications)
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root"
    exit 1
fi

# Enable the repository using eselect
echo "Enabling repository: $REPOSITORY"
eselect repository enable "$REPOSITORY"

# Check exit status manually for dash compatibility
if [ $? -ne 0 ]; then
    echo "Error: Failed to enable repository $REPOSITORY"
    exit 1
fi

# Ensure directories exist
mkdir -p /etc/portage

# Add repository mask to package.mask
MASK_FILE="/etc/portage/package.mask"
MASK_ENTRY="*/*::$REPOSITORY"

# Check if mask entry already exists
if [ -f "$MASK_FILE" ] && grep -Fxq "$MASK_ENTRY" "$MASK_FILE"; then
    echo "Mask entry already exists: $MASK_ENTRY"
else
    echo "Adding mask entry: $MASK_ENTRY"
    echo "$MASK_ENTRY" >> "$MASK_FILE"
fi

# Add package unmask to package.unmask
UNMASK_FILE="/etc/portage/package.unmask"
UNMASK_ENTRY="$PACKAGE::$REPOSITORY"

# Check if unmask entry already exists
if [ -f "$UNMASK_FILE" ] && grep -Fxq "$UNMASK_ENTRY" "$UNMASK_FILE"; then
    echo "Unmask entry already exists: $UNMASK_ENTRY"
else
    echo "Adding unmask entry: $UNMASK_ENTRY"
    echo "$UNMASK_ENTRY" >> "$UNMASK_FILE"
fi

echo "Successfully configured repository $REPOSITORY and unmasked package $PACKAGE"
echo ""
echo "Summary of changes:"
echo "- Enabled repository: $REPOSITORY"
echo "- Added to $MASK_FILE: $MASK_ENTRY"
echo "- Added to $UNMASK_FILE: $UNMASK_ENTRY"
