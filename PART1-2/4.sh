
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

####5.11. ${TCL_STRING} 
##5.11.1. Installation of Tcl
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Tcl?"
echo
yes_or_no
##
tar -zxvf tcl-core8.6.7-src.tar.gz
previous_command_succeeded
cd ${TCL} 
previous_command_succeeded
##
cd unix
previous_command_succeeded
./configure --prefix=/tools
previous_command_succeeded
##
make
previous_command_succeeded
##
#TZ=UTC make test
##
make install
previous_command_succeeded
##
chmod -v u+w /tools/lib/libtcl8.6.so
previous_command_succeeded
##
make install-private-headers
##

if [ -e "/tools/bin/tclsh" ]; then
  rm -f /tools/bin/tclsh
else
  ln -sv tclsh8.6 /tools/bin/tclsh
fi
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${TCL} 
previous_command_succeeded

####5.12. ${EXPECT_STRING} 
##5.12.1. Installation of Expect
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Expect?"
echo
yes_or_no
##
tar -zxvf ${EXPECT}.tar.gz
previous_command_succeeded
cd ${EXPECT} 
previous_command_succeeded
##
cp -v configure{,.orig}
previous_command_succeeded
sed 's:/usr/local/bin:/bin:' configure.orig > configure
previous_command_succeeded
##
./configure --prefix=/tools \
--with-tcl=/tools/lib \
--with-tclinclude=/tools/include
previous_command_succeeded
##
make
previous_command_succeeded
##
#make test
##
make SCRIPTS="" install
previous_command_succeeded
backto_source_dir
previous_command_succeeded
rm -rf ${EXPECT} 
previous_command_succeeded

####5.13. ${DEJAGNU}
##5.13.1. Installation of DejaGNU
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install DejaGNU?"
echo
yes_or_no
##
tar -zxvf ${DEJAGNU}.tar.gz
previous_command_succeeded
cd ${DEJAGNU} 
previous_command_succeeded
##
./configure --prefix=/tools
previous_command_succeeded
##
make install
previous_command_succeeded
##
#make check
##
backto_source_dir
previous_command_succeeded
rm -rf ${DEJAGNU} 
previous_command_succeeded

####5.14. ${CECH_STRING}
##5.14.1. Installation of Check
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Check?"
echo 
yes_or_no
##
tar -zxvf ${CHECK}.tar.gz
previous_command_succeeded
cd ${CHECK} 
previous_command_succeeded
##
PKG_CONFIG= ./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${CHECK} 
previous_command_succeeded

####5.15. ${NCURSES}
##5.15.1. Installation of Ncurses
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Ncurses?"
echo 
yes_or_no
##
tar -zxvf ${NCURSES}.tar.gz
previous_command_succeeded
cd ${NCURSES} 
previous_command_succeeded
##
sed -i s/mawk// configure
previous_command_succeeded
##
./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${NCURSES} 
previous_command_succeeded

####5.16. ${BASH} 
##5.16.1. Installation of Bash
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Bash?"
echo 
yes_or_no
##
tar -zxvf ${BASH}.tar.gz
previous_command_succeeded
cd ${BASH} 
previous_command_succeeded
##
./configure --prefix=/tools --without-bash-malloc
previous_command_succeeded
##
make
previous_command_succeeded
##
#make tests
##
make install
previous_command_succeeded
##
ln -sv bash /tools/bin/sh
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${BASH} 
previous_command_succeeded

####5.17. ${BISON_STRING} 
##5.17.1. Installation of Bison
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Bison ?"
echo 
yes_or_no
##
tar -xvf ${BISON}.tar.xz
previous_command_succeeded
cd ${BISON} 
previous_command_succeeded
##
./configure --prefix=/tools
previous_command_succeeded
make
previous_command_succeeded
##
#make check
make install
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${BISON} 
previous_command_succeeded

####5.18. ${BZIP2_STRING}
##5.18.1. Installation of Bzip2
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Bzip2?"
echo 
yes_or_no
##
tar -zxvf ${BZIP2}.tar.gz
previous_command_succeeded
cd ${BZIP2} 
previous_command_succeeded
##
make
previous_command_succeeded
##
make PREFIX=/tools install
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${BZIP2} 
previous_command_succeeded

####5.19. ${COREUTILES_STRING}
##5.19.1. Installation of Coreutils
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Coreutils?"
echo 
yes_or_no
##
tar -xvf ${COREUTILS}.tar.xz
previous_command_succeeded
cd ${COREUTILS} 
previous_command_succeeded
##
./configure --prefix=/tools --enable-install-program=hostname
previous_command_succeeded
##
make
previous_command_succeeded
##
#make RUN_EXPENSIVE_TESTS=yes check
##
make install
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${COREUTILS} 
previous_command_succeeded

####5.20. ${DIFFUTILS} 
##5.20.1. Installation of Diffutils
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Diffutils?"
echo 
yes_or_no
##
tar -xvf ${DIFFUTILS}.tar.xz
previous_command_succeeded
cd ${DIFFUTILS} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${DIFFUTILS} 
previous_command_succeeded

####5.21. ${FILE_STRING} 
##5.21.1. Installation of File
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install File?"
echo 
yes_or_no
##
tar -zxvf ${FILE}.tar.gz
previous_command_succeeded
cd ${FILE} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${FILE} 
previous_command_succeeded

####5.22. ${FINDUTILS} 
##5.22.1. Installation of Findutils
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Findutils?"
echo 
yes_or_no
##
tar -zxvf ${FINDUTILS}.tar.gz
previous_command_succeeded
cd ${FINDUTILS} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${FINDUTILS} 
previous_command_succeeded

####5.23. ${GAWK_STRING}
##5.23.1. Installation of Gawk
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Gawk?"
echo 
yes_or_no
##
tar -xvf ${GAWK}.tar.xz
previous_command_succeeded
cd ${GAWK} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${GAWK} 
previous_command_succeeded

####5.24. ${GETTEXT_STRING}
##5.24.1. Installation of Gettext
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Gettext?"
echo 
yes_or_no
##
tar -xvf ${GETTEXT}.tar.xz
previous_command_succeeded
cd ${GETTEXT} 
previous_command_succeeded
##
cd gettext-tools
previous_command_succeeded
EMACS="no" ./configure --prefix=/tools --disable-shared
##
make -C gnulib-lib
previous_command_succeeded
make -C intl pluralx.c
previous_command_succeeded
make -C src msgfmt
previous_command_succeeded
make -C src msgmerge
previous_command_succeeded
make -C src xgettext
previous_command_succeeded
##
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${GETTEXT} 
previous_command_succeeded

####5.25. ${GREP_STRING} 
##5.25.1. Installation of Grep
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Grep?"
echo 
yes_or_no
##
tar -xvf ${GREP}.tar.xz
previous_command_succeeded
cd ${GREP}
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${GREP} 
previous_command_succeeded

####5.26. ${GZIP_STRING}
##5.26.1. Installation of Gzip
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Gzip?"
echo 
yes_or_no
##
tar -xvf ${GZIP}.tar.xz
previous_command_succeeded
cd ${GZIP} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${GZIP} 
previous_command_succeeded

####5.27. ${M4_STRING} 
##5.27.1. Installation of M4
backto_source_dir
echo
echo "Are you ready to install M4?"
echo 
yes_or_no
##
tar -xvf ${M4}.tar.xz
previous_command_succeeded
cd ${M4} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${M4} 
previous_command_succeeded

####5.28. ${MAKE_STRING} 
##5.28.1. Installation of Make
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Make?"
echo 
yes_or_no
##
tar -xjvf ${MAKE}.tar.bz2
previous_command_succeeded
cd ${MAKE} 
previous_command_succeeded
##
./configure --prefix=/tools --without-guile
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
backto_source_dir
previous_command_succeeded
rm -rf ${MAKE} 
previous_command_succeeded

####5.29. ${PATCH_STRING} 
##5.29.1. Installation of Patch
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Patch?"
echo 
yes_or_no
##
tar -xvf ${PATCH}.tar.xz
previous_command_succeeded
cd ${PATCH} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${PATCH} 
previous_command_succeeded

####5.30. ${PERL_STRING} 
##5.30.1. Installation of Perl
backto_source_dir
echo
echo "Are you ready to install Perl?"
echo 
yes_or_no
##
tar -xvf ${PERL}.tar.xz
previous_command_succeeded
cd ${PERL} 
previous_command_succeeded
##
sed -e '9751 a#ifndef PERL_IN_XSUB_RE' \
    -e '9808 a#endif' \
    -i regexec.c
previous_command_succeeded
sh Configure -des -Dprefix=/tools -Dlibs=-lm
previous_command_succeeded
##
make
previous_command_succeeded
##
cp -v perl cpan/podlators/scripts/pod2man /tools/bin
previous_command_succeeded
mkdir -pv /tools/lib/perl5/${PERL_VERSION}
previous_command_succeeded
cp -Rv lib/* /tools/lib/perl5/${PERL_VERSION}
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${PERL} 
previous_command_succeeded

####5.31. ${SED_STRING} 
##5.31.1. Installation of Sed
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Sed?"
echo 
yes_or_no
##
tar -xvf ${SED}.tar.xz
previous_command_succeeded
cd ${SED} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${SED} 
previous_command_succeeded

####5.32. ${TAR_STRING} 
##5.32.1. Installation of Tar
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Tar?"
echo 
yes_or_no
##
tar -xvf ${TAR}.tar.xz
previous_command_succeeded
cd ${TAR} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${TAR} 
previous_command_succeeded

####5.33. ${TEXINFO_STRING} 
##5.33.1. Installation of Texinfo
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Texinfo?"
echo 
yes_or_no
##
tar -xvf ${TEXINFO}.tar.xz
previous_command_succeeded
cd ${TEXINFO} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${TEXINFO} 
previous_command_succeeded

####5.34. ${UTIL_LINUX_STRING}
##5.341. Installation of Util-linux
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Util-linux?"
echo 
yes_or_no
##
tar -xvf ${UTIL_LINUX}.tar.xz
previous_command_succeeded
cd ${UTIL_LINUX} 
previous_command_succeeded
##
./configure --prefix=/tools \
--without-python \
--disable-makeinstall-chown \
--without-systemdsystemunitdir \
--without-ncurses \
PKG_CONFIG=""
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
##
backto_source_dir
previous_command_succeeded
rm -rf ${UTIL_LINUX} 
previous_command_succeeded

####5.35. ${XZ_STRING} 
##5.35.1. Installation of Xz
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to install Xz?"
echo 
yes_or_no
##
tar -xvf ${XZ}.tar.xz
previous_command_succeeded
cd ${XZ} 
previous_command_succeeded
##
./configure --prefix=/tools
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
backto_source_dir
previous_command_succeeded
rm -rf ${XZ} 
previous_command_succeeded

####5.36. Stripping
echo
echo "Are you ready for Stipping?"
echo 
yes_or_no
strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
##
rm -rf /tools/{,share}/{info,man,doc}
previous_command_succeeded
##
echo "Done."
echo "Now be root (exit and cd to /home/lfs )and execute \"source 5.sh|tee 5.sh.log\"."
