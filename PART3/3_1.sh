
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
echo "# # Copyright © 1999-2017, Gerard Beekmans"
echo "This Distribution is licensed under a Creative Commons License."
echo "Computer instructions may be extracted from this Distribution under the MIT License."
echo "Linux® is a registered trademark of Linus Torvalds."
echo "############################################################################################"
PID="$$"
export LFS=/mnt/lfs

function yes_or_no(){
while true
  ANS=""
  echo -n "[yes|no]"
  read ANS
    do
      if [ "$ANS" = "yes" ];then
        #break 
        return 
      elif [ "$ANS" = "no" ];then  
        `kill -KILL $PID`
        exit 1
      else
        echo -n "[yes|no]"
        read ANS
      fi
   done
}

function previous_command_succeeded(){
  if [ $? -eq 0 ]; then
    echo "command succeeded"
  else
    echo "command failed"
    exit 1
  fi
}
previous_command_succeeded
######Chapter 6. Installing Basic System Software
####6.2. Preparing Virtual Kernel File Systems
export LFS=/mnt/lfs
previous_command_succeeded
echo $LFS
echo "Can you see \"/mnt/lfs\"? If you type yes, I move forward."
yes_or_no
##
mkdir -pv $LFS/{dev,proc,sys,run}
##
##6.2.1. Creating Initial Device Nodes
echo "Are you ready for creating initial device nodes?"
yes_or_no
mknod -m 600 $LFS/dev/console c 5 1
previous_command_succeeded
mknod -m 666 $LFS/dev/null c 1 3
previous_command_succeeded
##
##6.2.2. Mounting and Populating /dev
echo "Are you ready for mounting and populating \"/dev\"?"
yes_or_no
mount -v --bind /dev $LFS/dev
previous_command_succeeded
##6.2.3. Mounting Virtual Kernel File Systems
echo "Are you ready for mounting virtual kernel file systems?"
yes_or_no
mount -vt devpts devpts $LFS/dev/pts -o gid=5,mode=620
previous_command_succeeded
mount -vt proc proc $LFS/proc
previous_command_succeeded
mount -vt sysfs sysfs $LFS/sys
previous_command_succeeded
mount -vt tmpfs tmpfs $LFS/run
previous_command_succeeded
##
if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
  previous_command_succeeded
fi
##
##6.4. Entering the Chroot Environment
echo "Are you ready for entering the chroot environment?"
echo "After you chroot into $LFS ,you execute \"source 3_2.sh|tee 3_2.sh.log\"."
yes_or_no
chroot "$LFS" /tools/bin/env -i \
HOME=/root \
TERM="$TERM" \
PS1='\u:\w\$ ' \
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
/tools/bin/bash --login +h
##

