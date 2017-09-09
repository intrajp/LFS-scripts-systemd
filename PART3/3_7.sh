
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

####6.21.${BZIP_STRING} 
##6.21.1. Installation of Bzip2
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Bzip2?"
yes_or_no
tar zxvf ${BZIP}.tar.gz
previous_command_succeeded
cd ${BZIP} 
previous_command_succeeded
##
patch -Np1 -i ../${BZIP}-install_docs-1.patch
previous_command_succeeded
##
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
previous_command_succeeded
##
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile
previous_command_succeeded
##
make -f Makefile-libbz2_so
previous_command_succeeded
make clean
previous_command_succeeded
##
make
previous_command_succeeded
##
make PREFIX=/usr install
previous_command_succeeded
##
cp -v bzip2-shared /bin/bzip2
previous_command_succeeded
cp -av libbz2.so* /lib
previous_command_succeeded
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
previous_command_succeeded
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
previous_command_succeeded
ln -sv bzip2 /bin/bunzip2
previous_command_succeeded
ln -sv bzip2 /bin/bzcat
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${BZIP} 
previous_command_succeeded

####6.22. ${PKG_CONFIG_STRING} 
##6.22.1. Installation of Pkg-config
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Pkg-config?"
yes_or_no
##
tar zxvf ${PKG_CONFIG}.tar.gz 
previous_command_succeeded
cd ${PKG_CONFIG} 
previous_command_succeeded
##
./configure --prefix=/usr        \
            --with-internal-glib \
            --disable-host-tool  \
            --docdir=/usr/share/doc/${PKG_CONFIG}
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
rm -rf ${PKG_CONFIG} 
previous_command_succeeded

####6.23. ${NCURSES_STRING} 
##6.23.1. Installation of Ncurses
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Ncurses?"
yes_or_no
tar zxvf ${NCURSES}.tar.gz
previous_command_succeeded
cd ${NCURSES} 
previous_command_succeeded
##
sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in
previous_command_succeeded
##
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --enable-pc-files       \
            --enable-widec
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
mv -v /usr/lib/libncursesw.so.6* /lib
previous_command_succeeded
##
ln -sfv ../../lib/$(readlink /usr/lib/libncursesw.so) /usr/lib/libncursesw.so
previous_command_succeeded
##
for lib in ncurses form panel menu ; do
    rm -vf                    /usr/lib/lib${lib}.so
    echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
    ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done
previous_command_succeeded
##
rm -vf                     /usr/lib/libcursesw.so
previous_command_succeeded
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
previous_command_succeeded
ln -sfv libncurses.so      /usr/lib/libcurses.so
previous_command_succeeded
##
mkdir -v       /usr/share/doc/${NCURSES}
previous_command_succeeded
cp -v -R doc/* /usr/share/doc/${NCURSES}
previous_command_succeeded
##
#make distclean
#./configure --prefix=/usr    \
#            --with-shared    \
#            --without-normal \
#            --without-debug  \
#            --without-cxx-binding \
#            --with-abi-version=5
#make sources libs
#cp -av lib/lib*.so.5* /usr/lib
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${NCURSES} 
previous_command_succeeded

####6.24. Attr-2.4.47
##6.24.1. Installation of Attr
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Attr?"
yes_or_no
tar zxvf ${ATTR}.src.tar.gz
previous_command_succeeded
cd ${ATTR} 
##
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
previous_command_succeeded
##
sed -i -e "/SUBDIRS/s|man[25]||g" man/Makefile
previous_command_succeeded
sed -i 's:{(:\\{(:' test/run
previous_command_succeeded
##
./configure --prefix=/usr \
            --disable-static
previous_command_succeeded
##
make
previous_command_succeeded
##
#make -j1 tests root-tests
##
make install install-dev install-lib
previous_command_succeeded
chmod -v 755 /usr/lib/libattr.so
previous_command_succeeded
##
mv -v /usr/lib/libattr.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${ATTR} 
previous_command_succeeded

####6.25. ${ACL_STRING} 
##6.25.1. Installation of Acl
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Acl?"
yes_or_no
tar zxvf ${ACL}.src.tar.gz
previous_command_succeeded
cd ${ACL} 
previous_command_succeeded
##
sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
previous_command_succeeded
##
sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
previous_command_succeeded
sed -i 's/{(/\\{(/' test/run
previous_command_succeeded
##
sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c
previous_command_succeeded
##
./configure --prefix=/usr    \
            --disable-static \
            --libexecdir=/usr/lib
previous_command_succeeded
##
make
previous_command_succeeded
##
make install install-dev install-lib
previous_command_succeeded
chmod -v 755 /usr/lib/libacl.so
previous_command_succeeded
##
mv -v /usr/lib/libacl.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${ACL} 
previous_command_succeeded
##

####6.26. ${LIBCAP_STRING} 
##6.26.1. Installation of Libcap
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Libcap?"
yes_or_no
tar xvf ${LIBCAP}.tar.xz
previous_command_succeeded
cd ${LIBCAP} 
previous_command_succeeded
##
sed -i '/install.*STALIBNAME/d' libcap/Makefile
previous_command_succeeded
##
make
previous_command_succeeded
##
make RAISE_SETFCAP=no prefix=/usr install
previous_command_succeeded
chmod -v 755 /usr/lib/libcap.so
previous_command_succeeded
##
mv -v /usr/lib/libcap.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.so
previous_command_succeeded
##
backto_source_dir_part3
rm -rf ${LIBCAP} 
previous_command_succeeded
##

####6.27. ${SED_STRING} 
##6.27.1. Installation of Sed
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Sed?"
yes_or_no
tar xvf ${SED}.tar.xz
previous_command_succeeded
cd  ${SED} 
previous_command_succeeded
##
sed -i 's/usr/tools/' build-aux/help2man
previous_command_succeeded
sed -i 's/testsuite.panic-tests.sh//' Makefile.in
previous_command_succeeded

./configure --prefix=/usr --bindir=/bin
previous_command_succeeded
##
make
previous_command_succeeded
make html
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
install -d -m755 /usr/share/doc/${SED}
previous_command_succeeded
install -m644 doc/sed.html /usr/share/doc/${SED}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${SED} 
previous_command_succeeded
##

####6.28. ${SHADOW_STRING} 
##6.28.1. Installation of Shadow
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Shadow?"
yes_or_no
tar xvf ${SHADOW}.tar.xz 
previous_command_succeeded
cd ${SHADOW} 
previous_command_succeeded
##
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
previous_command_succeeded
find man -name Makefile.in -exec sed -i 's/groups\.1 / /'   {} \;
previous_command_succeeded
find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
previous_command_succeeded
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /'   {} \;
previous_command_succeeded
##
sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
previous_command_succeeded
##
sed -i 's/1000/999/' etc/useradd
previous_command_succeeded
##
./configure --sysconfdir=/etc --with-group-name-max-length=32
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
mv -v /usr/bin/passwd /bin
previous_command_succeeded
##
pwconv
previous_command_succeeded
##
grpconv
previous_command_succeeded
##
sed -i 's/yes/no/' /etc/default/useradd
previous_command_succeeded
##
passwd root
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${SHADOW} 
previous_command_succeeded
##

####6.29. ${PSMISC_STRING} 
##6.29.1. Installation of Psmisc
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Psmisc?"
yes_or_no
tar xvf ${PSMISC}.tar.xz
previous_command_succeeded
cd ${PSMISC} 
previous_command_succeeded
##
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
mv -v /usr/bin/fuser /bin
previous_command_succeeded
mv -v /usr/bin/killall /bin
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${PSMISC} 
previous_command_succeeded
##

####6.30. ${IANA_STRING} 
##6.30.1. Installation of Iana-Etc
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Iana-Etc?"
yes_or_no
tar xjvf ${IANA}.tar.bz2    
previous_command_succeeded
cd ${IANA}    
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${IANA}    
previous_command_succeeded
##

####6.31. ${BISON_STRING}
##6.31.1. Installation of Bison
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Bison?"
yes_or_no
tar xvf ${BISON}.tar.xz      
previous_command_succeeded
cd ${BISON}      
previous_command_succeeded
##
./configure --prefix=/usr --docdir=/usr/share/doc/${BISON}
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
rm -rf ${BISON}      
previous_command_succeeded
##

####6.32. ${FLEX_STRING} 
##6.32.1. Installation of Flex
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Flex?"
yes_or_no
tar xvf ${FLEX}.tar.xz    
previous_command_succeeded
cd ${FLEX}     
previous_command_succeeded
##
./configure --prefix=/usr --docdir=/usr/share/doc/${FLEX}
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
ln -sv flex /usr/bin/lex
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${FLEX} 
previous_command_succeeded
##

####6.33. ${GREP_STRING} 
##6.33.1. Installation of Grep
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Grep?"
yes_or_no
tar xvf ${GREP}.tar.xz       
previous_command_succeeded
cd ${GREP} 
previous_command_succeeded
##
##
./configure --prefix=/usr --bindir=/bin
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
rm -rf ${GREP}       
previous_command_succeeded
##

####6.34. ${BASH_STRING}
##6.34.1. Installation of Bash 
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Bash?"
yes_or_no
tar zxvf ${BASH}.tar.gz        
previous_command_succeeded
cd ${BASH}        
previous_command_succeeded
##
patch -Np1 -i ../${BASH}-upstream_fixes-1.patch
previous_command_succeeded
##
./configure --prefix=/usr                       \
            --docdir=/usr/share/doc/${BASH} \
            --without-bash-malloc               \
            --with-installed-readline
previous_command_succeeded
##
make
previous_command_succeeded
##
chown -Rv nobody .
previous_command_succeeded
#su nobody -s /bin/bash -c "PATH=$PATH make tests"
##
make install
previous_command_succeeded
mv -vf /usr/bin/bash /bin
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${BASH}         
previous_command_succeeded
##
echo "Everything's fine, I guess. Now, go to next step, typing \"cd /;source 3_8.sh | tee 3_8.sh.log\"."
exec /bin/bash --login +h
