#!/bin/sh

# visual novel shit
read -p "wanna reboot? " reboot

case $reboot in
  [yY]|[yY][eE][sS])
    echo "kk"
    ;;
  *)
    echo "got it."
    ;;
esac

# actual script
doas eselect kernel set 1

doas make -j18 
doas make prepare modules -j18 
doas make modules_install -j18 
doas make install -j18
doas genkernel --install initramfs

# end with reboot... or not.
case $reboot in
  [yY]|[yY][eE][sS])
    echo "rebooting..."
    doas reboot
    ;;
  *)
    echo rember to reboot, you alzheimer-fish.""
    ;;
esac
