
echo "############################################################################################"
echo "Pink Rabbit Linux 8.1"
echo 
echo "Copyright(C)2016-2017 Shintaro Fujiwara" 
echo "All rights reserved."
echo 
echo "Pink Rabbit Linux is a distribution which facilitates making your own Linux Distribution"
echo "Just run scripts and you can make your own Linux Distribution."
echo ""
echo "This version is based on Linux From Scratch: Version 8.1-systemd"
echo "which had been Created by Gerard Beekmans and Edited by Matthew Burgess and Armin K."
echo "Copyright © 1999-2017 Gerard Beekmans"
echo "# # Copyright © 1999-2017, Gerard Beekmans"
echo "This Distribution is licensed under a Creative Commons License."
echo "Computer instructions may be extracted from this Distribution under the MIT License."
echo "Linux® is a registered trademark of Linus Torvalds."
echo "############################################################################################"

. ../COMMON/functions

##Part I. Introduction
DEVICE=""
ANS=""
ANS2=""
SWAP=""
PID="$$"
####Chapter 2. Preparing a New Partition
echo
echo "Are you ready for going to Chapter 2. Preparing a New Partition ?"
yes_or_no
echo
echo "Are you ready to make filesystem anew?"
yes_or_no
mkfs_for_lfs
previous_command_succeeded
if [ $DEVICE != "" ];then
  umount -l /dev/$DEVICE
  mke2fs -v -t ext4 /dev/$DEVICE
fi
ls -la /dev/$DEVICE
mkswap_for_lfs
previous_command_succeeded
if [ $SWAP != "" ];then
  swapoff /dev/$SWAP
  mkswap /dev/$SWAP
fi
previous_command_succeeded
ls -la /dev/$SWAP
previous_command_succeeded
####2.4. Mounting the New Partition
echo
echo "Are you ready to mounting new partition?"
yes_or_no
export LFS=/mnt/lfs
##
mkdir -pv $LFS
previous_command_succeeded
mount -v -t ext4 /dev/$DEVICE $LFS
previous_command_succeeded
##
###Don't have to do this!!So, comment out.
## If using multiple partitinos ...
#####
echo
echo "Are you ready for swapon?"
yes_or_no
#/sbin/swapoff /dev/$SWAP
#previous_command_succeeded
/sbin/swapon -v /dev/$SWAP
previous_command_succeeded
##
####2.5. Setting The $LFS Variable
echo
echo "Are you ready to go to 2.5. Setting The $LFS Variable?"
yes_or_no
export LFS=/mnt/lfs
##
echo $LFS
##
if [ -d $LFS/sources ]; then
  echo "$LFS/sources exists"
else
  mkdir -v $LFS/sources
fi
previous_command_succeeded
##
chmod -v a+wt $LFS/sources
previous_command_succeeded
##
echo
echo "Are you ready to download files needed for LFS ?"
yes_or_no
get_needed_files
previous_command_succeeded
####Chapter 4. Final Preparations
echo
echo "Are you ready to go to Chapter 4. Final Preparations?"
yes_or_no
##4.1. Introduction
##4.2. Creating the $LFS/tools Directory
if [ -d $LFS/sources ]; then
  echo "$LFS/sources exists"
else
  mkdir -v $LFS/tools
fi
if [ -e $LFS/sources ]; then
  echo "$LFS/sources exists"
else
  ln -sv $LFS/tools /
fi
previous_command_succeeded
##
id -g lfs >/dev/null
if [ $? -eq 0 ]; then
  echo "group lfs exists"
else
  groupadd lfs
fi

id -u lfs >/dev/null
if [ $? -eq 0 ]; then
  echo "user lfs exists"
else
  useradd -s /bin/bash -g lfs -m -k /dev/null lfs
fi
##
passwd lfs
##
chown -v lfs $LFS/tools
previous_command_succeeded
##
chown -v lfs $LFS/sources
previous_command_succeeded
##
echo
echo "OK, this script will end."
echo "Please execute \"source 2.sh|tee 2.sh.log\"."
yes_or_no

###############these should be here############### 
if [ -d $LFS/sources ]; then
  echo "$LFS/sources exists"
else
  mkdir /home/lfs/PART3
fi
previous_command_succeeded
cp ../PART3/AUTOSTART.sh ../PART3/3_1.sh /home/lfs/PART3
previous_command_succeeded
cp ../PART3/*.sh $LFS
previous_command_succeeded
cp 2.sh 3.sh 4.sh 5.sh /home/lfs
previous_command_succeeded
cp ../COMMON/functions ../COMMON/config /home/lfs
previous_command_succeeded
chown lfs:lfs /home/lfs/2.sh /home/lfs/3.sh /home/lfs/4.sh /home/lfs/5.sh
previous_command_succeeded
chown lfs:lfs /home/lfs/functions
previous_command_succeeded
chown lfs:lfs /home/lfs/config
previous_command_succeeded
su - lfs

###
