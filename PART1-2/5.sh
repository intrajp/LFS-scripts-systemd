
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

. functions

PID="$$"
####5.37. Changing Ownership
export LFS=/mnt/lfs
previous_command_succeeded
echo "Now chage ownership of /mnt/lfs/tools to root." 
yes_or_no
chown -R root:root $LFS/tools
previous_command_succeeded
echo "Backup /mnt/lfs directory altogether (including source files and current build state) for the future use. Remember the \"Version-8.1-systemd\"."
echo "This makes a file \"/home/lfs/mnt_lfs_Version-8.1-systemd.tar.gz\"."
yes_or_no
pushd /home/lfs
  tar -zcf mnt_lfs_Version-8.1-systemd.tar.gz /mnt/lfs
popd
previous_command_succeeded

echo "OK, type \"cd PART3;./AUTOSTART.sh\". "
