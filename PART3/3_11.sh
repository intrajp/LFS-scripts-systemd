
echo "############################################################################################"
echo "Pink Rabbit Linux 8.2"
echo 
echo "Copyright(C)2016-2018 Shintaro Fujiwara" 
echo "All rights reserved."
echo 
echo "Pink Rabbit Linux is a distribution which facilitates making your own Linux Distribution"
echo "Just run scripts and you can make your own Linux Distribution."
echo ""
echo "This version is based on Linux From Scratch: Version 8.1-systemd"
echo "which had been Created by Gerard Beekmans and Edited by Matthew Burgess and Armin K."
echo "Copyright © 1999-2018 Gerard Beekmans"
echo "# # Copyright © 1999-2018, Gerard Beekmans"
echo "This Distribution is licensed under a Creative Commons License."
echo "Computer instructions may be extracted from this Distribution under the MIT License."
echo "Linux® is a registered trademark of Linus Torvalds."
echo "############################################################################################"

export LFS=/mnt/lfs
. config
. functions 
previous_command_succeeded

PID="$$"
##
echo "Is this chroot environment?"
yes_or_no
echo "Are you ready setting network?"
yes_or_no
##
cat > /etc/systemd/network/10-dhcp-eth0.network << "EOF"
[Match]
Name=eth0

[Network]
DHCP=yes
EOF
previous_command_succeeded

cat > /etc/systemd/network/10-dhcp-eth1.network << "EOF"
[Match]
Name=eth1

[Network]
DHCP=yes
EOF
previous_command_succeeded

cat > /etc/systemd/network/10-dhcp-eth2.network << "EOF"
[Match]
Name=eth2

[Network]
DHCP=yes
EOF
previous_command_succeeded

##
cat > /etc/resolv.conf << "EOF"
# Begin /etc/resolv.conf

#domain mydomain.org
nameserver 192.168.0.1
#nameserver <IP address of your secondary nameserver>

# End /etc/resolv.conf
EOF
previous_command_succeeded

##
#ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf
#previous_command_succeeded
##
echo "Pink Rabbit Linux" > /etc/hostname
previous_command_succeeded
##
cat > /etc/hosts << "EOF"
# Begin /etc/hosts (network card version)

127.0.0.1 localhost
::1       localhost
#192.168.0.202 HOSTNAME.example.org [alias1] [alias2] ...

# End /etc/hosts (network card version)
EOF
previous_command_succeeded
##
############### 7.4 #####################
udevadm info -a -p /sys/class/video4linux/video0
previous_command_succeeded
##
############### 7.5 #####################
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF
previous_command_succeeded
##
############### 7.6 #####################
##timedatectl set-local-rtc 1
##
##timedatectl set-time YYYY-MM-DD HH:MM:SS
##
##timedatectl set-timezone TIMEZONE
##
##timedatectl list-timezones
##
##systemctl disable systemd-timesyncd
##
############### 7.7 #####################
#cat > /etc/vconsole.conf << "EOF"
###KEYMAP=de-latin1
###FONT=Lat2-Terminus16
#EOF
#previous_command_succeeded
##
##localectl set-keymap MAP
##
############### 7.8 #####################
cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc
# Modified by Chris Lynn <roryo@roryo.dynup.net>

# Allow the command prompt to wrap to the next line
set horizontal-scroll-mode Off

# Enable 8bit input
set meta-flag On
set input-meta On

# Turns off 8th bit stripping
set convert-meta Off

# Keep the 8th bit for display
set output-meta On

# none, visible or audible
set bell-style none

# All of the following map the escape sequence of the value
# contained in the 1st argument to the readline specific functions
"\eOd": backward-word
"\eOc": forward-word

# for linux console
"\e[1~": beginning-of-line
"\e[4~": end-of-line
"\e[5~": beginning-of-history
"\e[6~": end-of-history
"\e[3~": delete-char
"\e[2~": quoted-insert

# for xterm
"\eOH": beginning-of-line
"\eOF": end-of-line

# for Konsole
"\e[H": beginning-of-line
"\e[F": end-of-line

# End /etc/inputrc
EOF
previous_command_succeeded
##
############### 7.9 #####################
mkdir -pv /etc/systemd/system/getty@tty1.service.d
previous_command_succeeded

cat > /etc/systemd/system/getty@tty1.service.d/noclear.conf << EOF
[Service]
TTYVTDisallocate=no
EOF
previous_command_succeeded
##
ln -sfv /dev/null /etc/systemd/system/tmp.mount
previous_command_succeeded
##
mkdir -pv /etc/systemd/system/foobar.service.d
previous_command_succeeded

cat > /etc/systemd/system/foobar.service.d/foobar.conf << EOF
[Service]
Restart=always
RestartSec=30
EOF
previous_command_succeeded
##
cat > /etc/fstab << "EOF"
# Begin /etc/fstab

# file system  mount-point  type     options             dump  fsck
#                                                              order

/dev/<xxx>     /            <fff>    defaults            1     1
/dev/<yyy>     swap         swap     pri=1               0     0

# End /etc/fstab
EOF
previous_command_succeeded
##
echo "Edit /etc/fstab as you need."
##
cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF
previous_command_succeeded
##
echo "OK, END this script."
echo "You will go Chapter8 by your own risk."
echo "You have to make kernel and install grub."
yes_or_no
echo "Good luck!."

