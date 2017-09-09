
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

export LFS=/mnt/lfs
. config
. functions
previous_command_succeeded
PID="$$"
##
echo $LFS
echo "Can you see \"/mnt/lfs\"?"
yes_or_no
echo "Are you ready for 6.71. Stripping Again?"
yes_or_no
#chroot $LFS /tools/bin/env -i            \
#    HOME=/root TERM=$TERM PS1='\u:\w\$ ' \
#    PATH=/bin:/usr/bin:/sbin:/usr/sbin   \
#    /tools/bin/bash --login
##

/tools/bin/find /{,usr/}{bin,lib,sbin} -type f \
    -exec /tools/bin/strip --strip-debug '{}' ';'
previous_command_succeeded

/tools/bin/find /usr/lib -type f -name \*.a \
    -exec /tools/bin/strip --strip-debug {} ';'
previous_command_succeeded

/tools/bin/find /lib /usr/lib -type f \( -name \*.so* -a ! -name \*dbg \) \
    -exec /tools/bin/strip --strip-unneeded {} ';'
previous_command_succeeded

/tools/bin/find /{bin,sbin} /usr/{bin,sbin,libexec} -type f \
    -exec /tools/bin/strip --strip-all {} ';'
previous_command_succeeded

##
echo "Are you ready clean up some extra files left around from running tests?"
yes_or_no
rm -rf /tmp/*
previous_command_succeeded
##
echo "Are you ready for deleting the /tools directory altogether? Remember when you login from now," 
echo "chroot \"$LFS\" /usr/bin/env -i              \\"
echo "HOME=/root TERM=\"$TERM\" PS1='\u:\w\$ ' \\"
echo "PATH=/bin:/usr/bin:/sbin:/usr/sbin     \\"
echo "/bin/bash --login"
yes_or_no
rm -rf /tools
previous_command_succeeded
##
rm -f /usr/lib/lib{bfd,opcodes}.a
previous_command_succeeded
rm -f /usr/lib/libbz2.a
previous_command_succeeded
rm -f /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
previous_command_succeeded
rm -f /usr/lib/libltdl.a
previous_command_succeeded
rm -f /usr/lib/libfl.a
previous_command_succeeded
rm -f /usr/lib/libfl_pic.a
previous_command_succeeded
rm -f /usr/lib/libz.a
previous_command_succeeded
##
echo "But don't worry just follow instruction below.You can login chroot environment properly." 
echo "Are you ready for going forward?" 
yes_or_no
echo "Everything's fine, I guess. logout and chroot into here again. You should type \"source 3_11.sh|tee 3_11.sh.log\" from PART3 directory."
##################

