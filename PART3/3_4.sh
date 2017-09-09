
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
####6.7. ${LINUX_STRING} API Headers
##6.7.1. Installation of Linux API Headers
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Linux API Headers?" 
yes_or_no
tar xvf ${LINUX}.tar.xz
previous_command_succeeded
cd ${LINUX} 
previous_command_succeeded
##
make mrproper
previous_command_succeeded
##
make INSTALL_HDR_PATH=dest headers_install
previous_command_succeeded
find dest/include \( -name .install -o -name ..install.cmd \) -delete
previous_command_succeeded
cp -rv dest/include/* /usr/include
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${LINUX} 
previous_command_succeeded

####6.8. ${MAN_PAGES_STRING} 
##6.8.1. Installation of Man-pages
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Man-pages?"
yes_or_no
tar xvf ${MAN_PAGES}.tar.xz
previous_command_succeeded
cd ${MAN_PAGES} 
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MAN_PAGES} 
previous_command_succeeded

####6.9. ${GLIBC_STRING} 
##6.9.1. Installation of Glibc
backto_source_dir_part3
echo "Are you ready for installing Glibc?"
yes_or_no
##
previous_command_succeeded
tar xvf ${GLIBC}.tar.xz
previous_command_succeeded
cd ${GLIBC} 
previous_command_succeeded
##
patch -Np1 -i ../${GLIBC}-fhs-1.patch
previous_command_succeeded
##
ln -sfv /tools/lib/gcc /usr/lib
previous_command_succeeded
##
case $(uname -m) in
  i?86)  GCC_INCDIR=/usr/lib/gcc/$(uname -m)-pc-linux-gnu/7.2.0/include
        ln -sfv ld-linux.so.2 /lib/ld-lsb.so.3
  ;;
  x86_64)  GCC_INCDIR=/usr/lib/gcc/x86_64-pc-linux-gnu/7.2.0/include
          ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64
          ln -sfv ../lib/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3
  ;;
esac
previous_command_succeeded
rm -f /usr/include/limits.h
previous_command_succeeded
##
mkdir -v build 
previous_command_succeeded
cd build
previous_command_succeeded
##
CC="gcc -isystem $GCC_INCDIR -isystem /usr/include" \
../configure --prefix=/usr          \
             --disable-werror      \
             --enable-kernel=3.2 \
             --enable-stack-protector=strong \
             libc_cv_slibdir=/lib
unset GCC_INCDIR
##
make
previous_command_succeeded
##
##
#make check
touch /etc/ld.so.conf
previous_command_succeeded
##
sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile
previous_command_succeeded
make install
previous_command_succeeded
##
cp -v ../nscd/nscd.conf /etc/nscd.conf
previous_command_succeeded
mkdir -pv /var/cache/nscd
previous_command_succeeded
##
install -v -Dm644 ../nscd/nscd.tmpfiles /usr/lib/tmpfiles.d/nscd.conf
previous_command_succeeded
install -v -Dm644 ../nscd/nscd.service /lib/systemd/system/nscd.service
previous_command_succeeded
##
mkdir -pv /usr/lib/locale
previous_command_succeeded
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
previous_command_succeeded
localedef -i de_DE -f ISO-8859-1 de_DE
previous_command_succeeded
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
previous_command_succeeded
localedef -i de_DE -f UTF-8 de_DE.UTF-8
previous_command_succeeded
localedef -i en_GB -f UTF-8 en_GB.UTF-8
previous_command_succeeded
localedef -i en_HK -f ISO-8859-1 en_HK
previous_command_succeeded
localedef -i en_PH -f ISO-8859-1 en_PH
previous_command_succeeded
localedef -i en_US -f ISO-8859-1 en_US
previous_command_succeeded
localedef -i en_US -f UTF-8 en_US.UTF-8
previous_command_succeeded
previous_command_succeeded
localedef -i es_MX -f ISO-8859-1 es_MX
previous_command_succeeded
localedef -i fa_IR -f UTF-8 fa_IR
previous_command_succeeded
localedef -i fr_FR -f ISO-8859-1 fr_FR
previous_command_succeeded
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
previous_command_succeeded
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
previous_command_succeeded
localedef -i it_IT -f ISO-8859-1 it_IT
previous_command_succeeded
localedef -i it_IT -f UTF-8 it_IT.UTF-8
previous_command_succeeded
localedef -i ja_JP -f EUC-JP ja_JP
previous_command_succeeded
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
previous_command_succeeded
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
previous_command_succeeded
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
previous_command_succeeded
localedef -i zh_CN -f GB18030 zh_CN.GB18030
previous_command_succeeded
##
make localedata/install-locales
previous_command_succeeded
##

##6.9.2. Configuring Glibc
cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns myhostname
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF
previous_command_succeeded
##
tar xf ../../tzdata2017b.tar.gz
previous_command_succeeded

ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}
previous_command_succeeded

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done
previous_command_succeeded

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
previous_command_succeeded
zic -d $ZONEINFO -p America/New_York
previous_command_succeeded
unset ZONEINFO
##
tzselect
##
echo "Enter you timezone"
read TIMEZONE
echo "Are you sure your time zone is \"$TIMEZONE\" ?"
yes_or_no
##
ln -sfv /usr/share/zoneinfo/$TIMEZONE /etc/localtime
previous_command_succeeded
##
##6.9.3. Configuring the Dynamic Loader
cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF
previous_command_succeeded
##
cat >> /etc/ld.so.conf << "EOF"
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF
previous_command_succeeded
mkdir -pv /etc/ld.so.conf.d
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GLIBC} 
previous_command_succeeded

##6.10. Adjusting the Toolchain
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready adjustion the toolchain?"
yes_or_no
##
mv -v /tools/bin/{ld,ld-old}
previous_command_succeeded
mv -v /tools/$(gcc -dumpmachine)/bin/{ld,ld-old}
previous_command_succeeded
mv -v /tools/bin/{ld-new,ld}
previous_command_succeeded
ln -sv /tools/bin/ld /tools/$(gcc -dumpmachine)/bin/ld
previous_command_succeeded
##
gcc -dumpspecs | sed -e 's@/tools@@g' \
-e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
-e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' > \
`dirname $(gcc --print-libgcc-file-name)`/specs
previous_command_succeeded
##
##sanity check
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
##
echo "Can you see \"[Requesting program interpreter: /lib/ld-linux.so.2]\"(it would be ...64, or depends on your machine's architecture)?"
yes_or_no
##
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
##
echo "Can you see 3 \"succeeded\" lines?"
yes_or_no
##
grep -B1 '^ /usr/include' dummy.log
##
echo "Can you see these lines?"
echo "#include <...> search starts here:" 
echo " /usr/include"
yes_or_no
##
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
##
echo "Can you see these lines(it would be \".../lib64)?"
echo "SEARCH_DIR(\"/usr/lib\")"
echo "SEARCH_DIR(\"/lib\");"
yes_or_no
##
grep "/lib.*/libc.so.6 " dummy.log
##
echo "Can you see \"attempt to open /lib/libc.so.6 succeeded\"(it would be ...64)?"
yes_or_no
##
grep found dummy.log
##
echo "Can you see \"found ld-linux.so.2 at /lib/ld-linux.so.2\"(it would be ...64)?"
yes_or_no
rm -v dummy.c a.out dummy.log
##
echo "OK,Everything is fine. Let's move next!"
echo "Execute \"source 3_5.sh|tee 3_5.sh.log\"."
#################################################
##
