
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
PID="$$"
export LFS=/mnt/lfs
. config
. functions 
previous_command_succeeded
##
####6.11. ${ZLIB_STRING} 
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Zlib ?"
yes_or_no
##
tar xvf ${ZLIB}.tar.xz
previous_command_succeeded
cd ${ZLIB} 
previous_command_succeeded
##
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
##
mv -v /usr/lib/libz.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${ZLIB} 
previous_command_succeeded

####6.12. ${FILE_STRING} 
##6.12.1. Installation of File
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing File ?"
yes_or_no
##
tar zxvf ${FILE}.tar.gz
previous_command_succeeded
cd ${FILE} 
previous_command_succeeded
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${FILE} 
previous_command_succeeded

####6.13. ${READLINE_STRING} 
##6.13.1. Installation of Readline 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Readline ?"
yes_or_no
##
tar zxvf ${READLINE}.tar.gz 
previous_command_succeeded
cd ${READLINE} 
previous_command_succeeded
##
sed -i '/MV.*old/d' Makefile.in
previous_command_succeeded
sed -i '/{OLDSUFF}/c:' support/shlib-install 
previous_command_succeeded
./configure --prefix=/usr \
  --disable-static \
  --docdir=/usr/share/doc/${READLINE}
previous_command_succeeded
make SHLIB_LIBS="-L/tools/lib -lncursesw"
previous_command_succeeded
make SHLIB_LIBS="-L/tools/lib -lncurses" install
previous_command_succeeded
mv -v /usr/lib/lib{readline,history}.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so) /usr/lib/libhistory.so
previous_command_succeeded
install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/${READLINE}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${READLINE} 
previous_command_succeeded
##

echo "OK,Everything is fine. Let's move next!"
echo "Execute \"source 3_6.sh|tee 3_6.sh.log\"."
#################################################

