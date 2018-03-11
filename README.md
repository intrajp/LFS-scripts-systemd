Pink Rabbit Linux 8.2
 
Copyright(C)2016-2018 Shintaro Fujiwara
All rights reserved.
 
Pink Rabbit Linux is a distribution which facilitates making your own Linux Distribution
Just run scripts and you can make your own Linux Distribution.

This version is based on Linux From Scratch: Version 8.2-systemd
which had been Created by Gerard Beekmans and Edited by Matthew Burgess and Armin K.

Copyright © 1999-2018, Gerard Beekman
This Distribution is licensed under a Creative Commons License.
Computer instructions may be extracted from this Distribution under the MIT License.
Linux® is a registered trademark of Linus Torvalds

Execute ./AUTOSTART in each directory

Order is,

Preface
INTRODUCTION
PART1-2
PART3

HINTS:

When logging in LFS system from host system, try this.

```
mount -v --bind /dev /mnt/lfs/dev
mount -v --bind /proc /mnt/lfs/proc
mount -v --bind /sys /mnt/lfs/sys
chroot "$LFS" /usr/bin/env -i          \
    HOME=/root TERM="$TERM"            \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    /bin/bash --login
```
When not working well installing grub on /dev/sdX, try this.
```
# dd if=/dev/zero of=/dev/sdX seek=1 count=2047
grub-install /dev/sdX
```
