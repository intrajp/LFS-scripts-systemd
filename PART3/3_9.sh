
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
PID="$$"
export LFS=/mnt/lfs
. config
. functions 
previous_command_succeeded
##

####6.68. ${LIBPIPELINE_STRING} 
##6.68.1. Installation of Libpipeline
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Libpipeline?"
yes_or_no
${LIBPIPELINE_TAR}
previous_command_succeeded
cd ${LIBPIPELINE}  
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
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${LIBPIPELINE}  
previous_command_succeeded
##

####6.69. ${MAKE_STRING} 
##6.69.1. Installation of Make
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Make?"
yes_or_no
${MAKE_TAR}
previous_command_succeeded
cd ${MAKE} 
previous_command_succeeded
##
sed -i '211,217 d; 219,229 d; 232 d' glob/glob.c
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
##
#make PERL5LIB=$PWD/tests/ check
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MAKE} 
previous_command_succeeded
##

####6.70. ${PATCH_STRING} 
##6.70.1. Installation of Patch
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Patch?"
yes_or_no
${PATCH_TAR}
previous_command_succeeded
cd ${PATCH} 
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
backto_source_dir_part3
previous_command_succeeded
rm -rf ${PATCH} 
previous_command_succeeded
##

####6.71. ${DBUS_STRING} 
##6.71.1. Installation of D-Bus
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing D-Bus?"
yes_or_no
${DBUS_TAR}
previous_command_succeeded
cd ${DBUS} 
previous_command_succeeded
##
 ./configure --prefix=/usr                       \
              --sysconfdir=/etc                   \
              --localstatedir=/var                \
              --disable-static                    \
              --disable-doxygen-docs              \
              --disable-xml-docs                  \
              --docdir=/usr/share/doc/${DBUS} \
              --with-console-auth-dir=/run/console
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
mv -v /usr/lib/libdbus-1.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so
previous_command_succeeded
##
ln -sfv /etc/machine-id /var/lib/dbus
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${DBUS} 
previous_command_succeeded
##

####6.72. ${UTIL_LINUX_STRING} 
##6.72.1. FHS compliance notes
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Util-linux?"
yes_or_no
${UTIL_LINUX_TAR}
previous_command_succeeded
cd ${UTIL_LINUX} 
previous_command_succeeded
##
mkdir -pv /var/lib/hwclock
previous_command_succeeded
## added option r by intrajp
rm -vfr /usr/include/{blkid,libmount,uuid}
previous_command_succeeded
##
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime     \
            --docdir=/usr/share/doc/${UTIL_LINUX} \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python
previous_command_succeeded
##
make
previous_command_succeeded
##
##chown -Rv nobody .
##su nobody -s /bin/bash -c "PATH=$PATH make -k check"
make install
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${UTIL_LINUX} 
previous_command_succeeded
##

####6.73. ${MAN_DB_STRING} 
##6.73.1. Installation of Man-DB
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Man-DB?"
yes_or_no
${MAN_DB_TAR}
previous_command_succeeded
cd ${MAN_DB} 
previous_command_succeeded
##
./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/${MAN_DB} \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --enable-cache-owner=bin                    \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap
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
sed -i "s:man root:root root:g" /usr/lib/tmpfiles.d/man-db.conf
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MAN} 
previous_command_succeeded
##

####6.74. ${TAR_STRING} 
##6.74.1. Installation of Tar
backto_source_dir_part3
echo "Are you ready for installing Tar?"
yes_or_no
${TAR_TAR}
previous_command_succeeded
cd ${TAR}   
previous_command_succeeded
##
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
previous_command_succeeded
##
make
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
make -C doc install-html docdir=/usr/share/doc/${TAR}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${TAR}   
previous_command_succeeded
##

####6.75. ${TEXINFO_STRING} 
##6.75.1. Installation of Texinfo
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Texinfo?"
yes_or_no
previous_command_succeeded
${TEXINFO_TAR}
previous_command_succeeded
cd ${TEXINFO} 
previous_command_succeeded
##
./configure --prefix=/usr --disable-static
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
make TEXMF=/usr/share/texmf install-tex
previous_command_succeeded
##
pushd /usr/share/info
rm -v dir
for f in *
  do install-info $f dir 2>/dev/null
done
popd
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${TEXINFO}    
previous_command_succeeded
##

####6.76. ${VIM_STRING} 
##6.76.1. Installation of Vim
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Vim?"
yes_or_no
${VIM_TAR}
previous_command_succeeded
###check that the directory name is vim80
cd ${VIM_VERSION}    
previous_command_succeeded
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
previous_command_succeeded
##
sed -i '/call/{s/split/xsplit/;s/303/492/}' src/testdir/test_recover.vim
previous_command_succeeded
##
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
##
#make -j1 test &> vim-test.log
##
make install
previous_command_succeeded
##
ln -sv vim /usr/bin/vi
previous_command_succeeded
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
previous_command_succeeded
##
ln -sv ../vim/${VIM_VERSION}/doc /usr/share/doc/${VIM}
previous_command_succeeded
##
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" ENsure defaults are set before customizing settings, not after 
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=r
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF
previous_command_succeeded
##
touch ~/.vimrc
previous_command_succeeded
##
#vim -c ':options'
#previous_command_succeeded
##

##
backto_source_dir_part3
previous_command_succeeded
###check that the directory name is vim74
rm -rf ${VIM_VERSION}    
previous_command_succeeded

save_lib="ld-2.27.so libc-2.27.so libpthread-2.27.so libthread_db-1.0.so"

cd /lib
previous_command_succeeded

for LIB in $save_lib; do
  objcopy --only-keep-debug $LIB $LIB.dbg
  strip --strip-unneeded $LIB
  objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done
previous_command_succeeded

save_usrlib="libquadmath.so.0.0.0 libstdc++.so.6.0.24
  libmpx.so.2.0.1 libmpxwrappers.so.2.0.1 libitm.so.1.0.0
  libcilkrts.so.5.0.0 libatomic.so.1.2.0"

cd /usr/lib
previous_command_succeeded

for LIB in $save_usrlib; do
  objcopy --only-keep-debug $LIB $LIB.dbg
  strip --strip-unneeded $LIB
  objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done
previous_command_succeeded

unset LIB save_lib save_usrlib

##
echo "Everything's fine, I guess. logout and chroot into here again. You should type \"source 3_10.sh|tee 3_10.sh.log\" from /mnt/lfs/PART3 directory."
echo "first, logout and reenter with"
echo "chroot $LFS /tools/bin/env -i            \
    HOME=/root TERM=$TERM PS1='\u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin   \
    /tools/bin/bash --login
"
yes_or_no
########
