#!/bin/dash

modprobe zfs
zpool import -R /mnt/gentoo/ rpool
mount /dev/nvme1n1p1 /mnt/gentoo/boot/efi

mount --rbind /dev  /mnt/gentoo/dev
mount --rbind /proc /mnt/gentoo/proc
mount --rbind /sys  /mnt/gentoo/sys
mount --rbind /run  /mnt/gentoo/run

mount --make-rslave /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/proc
mount --make-rslave /mnt/gentoo/run

mount -t devpts devpts /mnt/gentoo/dev/pts

mount --bind /etc/resolv.conf /mnt/gentoo/etc/resolv.conf

chroot /mnt/gentoo /bin/bash --login

export TERM=xterm
source /etc/profile
export PS1="(chroot gentoo) $PS1"

