
echo "############################################################################################"
echo "Pink Rabbit Linux 8.2"
echo 
echo "Copyright(C)2016-2018 Shintaro Fujiwara" 
echo "All rights reserved."
echo 
echo "Pink Rabbit Linux is a distribution which facilitates making your own Linux Distribution"
echo "Just run scripts and you can make your own Linux Distribution."
echo ""
echo "This version is based on Linux From Scratch: Version 8.2-systemd"
echo "which had been Created by Gerard Beekmans and Edited by Matthew Burgess and Armin K."
echo "Copyright © 1999-2018 Gerard Beekmans"
echo "# # Copyright © 1999-2018, Gerard Beekmans"
echo "This Distribution is licensed under a Creative Commons License."
echo "Computer instructions may be extracted from this Distribution under the MIT License."
echo "Linux® is a registered trademark of Linus Torvalds."
echo "############################################################################################"

. ../COMMON/config
. ../COMMON/functions

##Part I. Introduction
DEVICE=""
ANS=""
ANS2=""
SWAP=""
PID="$$"
##Part II. Preparing for the Build 
####Chapter 2 Preparing the Host System 
####2.5. Creating a File System on the Partition 
echo
echo "Are you ready for going to Chapter 2. Preparing the Host System ?"
yes_or_no
echo
echo "Are you ready for making filesystem anew?"
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

####2.6. Setting The $LFS Variable
echo
echo "Are you ready for going to 2.5. Setting The $LFS Variable?"
yes_or_no
export LFS=/mnt/lfs
##
echo $LFS
##

####2.7. Mounting the New Partition 
echo
echo "Are you ready for mounting new partition?"
yes_or_no
#export LFS=/mnt/lfs
if [ -d $LFS ]; then
  echo "$LFS exists"
  echo "Deleting $LFS and making it again"
  rm -rf $LFS
  previous_command_succeeded
fi
mkdir -pv $LFS
previous_command_succeeded
##
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
/sbin/swapon -v /dev/$SWAP
previous_command_succeeded

####Chapter 3 Packages and Patches 
####3.1. Introduction 
##
if [ -d $LFS/sources ]; then
  echo "$LFS/sources exists"
  echo "Deleting $LFS/sources and making it again"
  rm -rf $LFS/sources
  previous_command_succeeded
fi
mkdir -v $LFS/sources
previous_command_succeeded
##
chmod -v a+wt $LFS/sources
previous_command_succeeded
##
echo
echo "Are you ready for downloading files needed for LFS ?"
yes_or_no
get_needed_files
previous_command_succeeded

####Chapter 4. Final Preparations
echo
echo "Are you ready for going to Chapter 4. Final Preparations?"
yes_or_no
##4.1. Introduction
##4.2. Creating the $LFS/tools Directory
if [ -d $LFS/tools ]; then
  echo "$LFS/tools exists"
  echo "Deleting $LFS/tools and making it again"
  rm -rf $LFS/tools
  previous_command_succeeded
fi
mkdir -v $LFS/tools
previous_command_succeeded
if [ -d /tools ]; then
  echo "/tools exists"
  echo "Deleting /tools and making there soft link"
  rm -rf /tools
  previous_command_succeeded
fi
ln -sv $LFS/tools /
previous_command_succeeded
##
##4.3. Adding the LFS User 
id -u lfs >/dev/null
if [ $? -eq 0 ]; then
  echo "user lfs exists"
  userdel -r lfs
  previous_command_succeeded
fi
##
id -g lfs >/dev/null
if [ $? -eq 0 ]; then
  echo "group lfs exists"
else
  groupadd lfs
fi
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
previous_command_succeeded
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
  echo "$LFS/sources exists. This is A OK."
fi
mkdir /home/lfs/PART3
previous_command_succeeded
cp -a ../PART3/AUTOSTART ../COMMON/config ../COMMON/functions ../PART3/*.sh /home/lfs/PART3
previous_command_succeeded
cp -a ../PART3/*.sh ../COMMON/config ../COMMON/functions ../PART3/AUTOSTART $LFS
previous_command_succeeded
cp -a 2.sh 3.sh 4.sh 5.sh /home/lfs
previous_command_succeeded
cp -a ../COMMON/functions ../COMMON/config /home/lfs
previous_command_succeeded
chown lfs:lfs /home/lfs/2.sh /home/lfs/3.sh /home/lfs/4.sh /home/lfs/5.sh
previous_command_succeeded
chown lfs:lfs /home/lfs/functions
previous_command_succeeded
chown lfs:lfs /home/lfs/config
previous_command_succeeded
su - lfs

###
