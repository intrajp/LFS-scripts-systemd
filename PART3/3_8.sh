
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
PID="$$"
export LFS=/mnt/lfs
. config
. functions 
previous_command_succeeded

####6.35. ${LIBTOOL_STRING} 
##6.35.1. Installation of Libtool 
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Libtool?"
yes_or_no
${LIBTOOL_TAR}
previous_command_succeeded
cd ${LIBTOOL} 
previous_command_succeeded
./configure --prefix=/usr
previous_command_succeeded
make
previous_command_succeeded
#make check
make install
previous_command_succeeded
backto_source_dir_part3
previous_command_succeeded
rm -rf ${LIBTOOL} 
previous_command_succeeded

##
####6.36. ${GDBM_STRING}
##6.36.1. Installation of GDBM 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing GDBM?"
yes_or_no
${GDBM_TAR}
previous_command_succeeded
cd ${GDBM} 
previous_command_succeeded
./configure --prefix=/usr \
            --disable-static \
            --enable-libgdbm-compat
previous_command_succeeded
##
make
previous_command_succeeded
#make check
make install
previous_command_succeeded
#
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GDBM} 
previous_command_succeeded

#
####6.37. ${GPERF_STRING} 
##6.37.1. Installation of Gperf 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Gperf?"
yes_or_no
##
${GPERF_TAR}
previous_command_succeeded
cd ${GPERF} 
previous_command_succeeded
./configure --prefix=/usr --docdir=/usr/share/doc/${GPERF}
previous_command_succeeded
make
previous_command_succeeded
#make -j1 check
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GPERF} 
previous_command_succeeded

##
####6.38. ${EXPAT} 
##6.38.1. Installation of Expat 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Expat?"
yes_or_no
#sed -i 's|usr/bin/env |bin/|' run.sh.in
previous_command_succeeded
##
${EXPAT_TAR}
previous_command_succeeded
##
cd ${EXPAT} 
previous_command_succeeded
##
sed -i 's|usr/bin/enf |bin/|' run.sh.in
previous_command_succeeded
##
./configure --prefix=/usr --disable-static
previous_command_succeeded
make
previous_command_succeeded
#make check
make install
previous_command_succeeded
##
install -v -dm755 /usr/share/doc/${EXPAT}
previous_command_succeeded
install -v -m644 doc/*.{html,png,css} /usr/share/doc/${EXPAT}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${EXPAT} 
previous_command_succeeded

##
####6.39. ${INETUTULS_STRING} 
##6.39.1. Installation of Inetutils
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Inetutils?"
yes_or_no
${INETUTILS_TAR}
previous_command_succeeded
cd ${INETUTILS} 
previous_command_succeeded
##
./configure --prefix=/usr        \
            --localstatedir=/var \
            --disable-logger     \
            --disable-whois      \
            --disable-rcp        \
            --disable-rexec      \
            --disable-rlogin     \
            --disable-rsh        \
            --disable-servers
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
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
previous_command_succeeded
mv -v /usr/bin/ifconfig /sbin
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${INETUTILS} 
previous_command_succeeded

##
####6.40. ${PERL} 
##6.40.1. Installation of Perl
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Perl?"
yes_or_no
##
${PERL_TAR}
previous_command_succeeded
cd ${PERL} 
previous_command_succeeded
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
previous_command_succeeded
##
export BUILD_ZLIB=False
previous_command_succeeded
export BUILD_BZIP2=0
previous_command_succeeded
##
sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib                  \
                  -Dusethreads
previous_command_succeeded
##
make
previous_command_succeeded
# make -k test
make install
previous_command_succeeded
unset BUILD_ZLIB BUILD_BZIP2
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${PERL} 
previous_command_succeeded

##
####6.41. ${XML_PARSER_STRING} 
##6.41.1. Installation of XML::Parser 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing XML::Parser?"
yes_or_no
##
${XML_PARSER_TAR}
previous_command_succeeded
##
cd ${XML_PARSER}
previous_command_succeeded
##
perl Makefile.PL
previous_command_succeeded
make
previous_command_succeeded
# make test
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${XML_PARSER}
previous_command_succeeded

##
####6.42. ${INTLTOOL_STRING} 
##6.42.1. Installation of  Intltool 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Intltool?"
yes_or_no
##
${INTLTOOL_TAR}
previous_command_succeeded
##
cd ${INTLTOOL} 
previous_command_succeeded
##
sed -i 's:\\\${:\\\$\\{:' intltool-update.in
previous_command_succeeded
##
./configure --prefix=/usr
previous_command_succeeded
##
make
previous_command_succeeded
#make check
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/${INTLTOOL}/I18N-HOWTO
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${INTLTOOL} 
previous_command_succeeded
##

####6.43. ${AUTOCONF_STRING} 
##6.43.1. Installation of Autoconf
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Autoconf?"
yes_or_no
${AUTOCONF_TAR}
previous_command_succeeded
cd ${AUTOCONF} 
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
rm -rf ${AUTOCONF} 
previous_command_succeeded
##

####6.44. ${AUTOMAKE_STRING} 
##6.44.1. Installation of Automake
backto_source_dir_part3
echo "Are you ready for installing Automake?"
yes_or_no
${AUTOMAKE_TAR}
previous_command_succeeded
cd ${AUTOMAKE} 
previous_command_succeeded
##
./configure --prefix=/usr --docdir=/usr/share/doc/${AUTOMAKE}
previous_command_succeeded
##
make
previous_command_succeeded
##
#sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
#make -j4 check
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${AUTOMAKE} 
previous_command_succeeded
##

####6.45. ${XZ_STRING} 
##6.45.1. Installation of Xz
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Xz?"
yes_or_no
${XZ_TAR}
previous_command_succeeded
cd ${XZ} 
previous_command_succeeded
##
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/${XZ}
previous_command_succeeded
##
make
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
previous_command_succeeded
mv -v /usr/lib/liblzma.so.* /lib
previous_command_succeeded
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${XZ}      
previous_command_succeeded
##

####6.46. ${KMOD_STRING} 
##6.46.1. Installation of Kmod
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Kmod?"
yes_or_no
tar xvf ${KMOD}.tar.xz   
previous_command_succeeded
cd ${KMOD} 
previous_command_succeeded
##
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
previous_command_succeeded
##
make
previous_command_succeeded
##
##
make install
previous_command_succeeded

for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done
previous_command_succeeded

ln -sv kmod /bin/lsmod
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${KMOD} 
previous_command_succeeded

##
####6.47. ${GETTEXT_STRING} 
##6.47.1. Installation of Gettext
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Gettext?"
yes_or_no
${GETTEXT_TAR}
previous_command_succeeded
cd ${GETTEXT} 
previous_command_succeeded
##
sed -i '/^TESTS =/d' gettext-runtime/tests/Makefile.in &&
previous_command_succeeded
sed -i 's/test-lock..EXEEXT.//' gettext-tools/gnulib-tests/Makefile.in
previous_command_succeeded

./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/${GETTEXT}
previous_command_succeeded
##
make
previous_command_succeeded
##
#make check
##
make install
previous_command_succeeded
chmod -v 0755 /usr/lib/preloadable_libintl.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GETTEXT} 
previous_command_succeeded
##

####6.48. ${ELFUTILS_STRING} 
##6.48.1. Installation of Libelf 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Libelf?"
yes_or_no
${ELFUTILS_TAR}
previous_command_succeeded
cd ${ELFUTILS}
previous_command_succeeded
./configure --prefix=/usr
previous_command_succeeded
make
previous_command_succeeded
make -C libelf install
previous_command_succeeded
install -vm644 config/libelf.pc /usr/lib/pkgconfig
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${ELFUTILS} 
previous_command_succeeded
##

####6.49. ${LIBFFI_STRING} 
##6.49.1. Installation of Liffi
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Libffi?"
yes_or_no
${LIBFFI_TAR}
previous_command_succeeded
cd ${LIBFFI}
previous_command_succeeded
sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' \
    -i include/Makefile.in
previous_command_succeeded

sed -e '/^includedir/ s/=.*$/=@includedir@/' \
    -e 's/^Cflags: -I${includedir}/Cflags:/' \
    -i libffi.pc.in
previous_command_succeeded
./configure --prefix=/usr --disable-static
previous_command_succeeded
make
previous_command_succeeded
#make check
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${LIBFFI} 
previous_command_succeeded
##

####6.50. ${OPENSSL_STRING} 
##6.50.1. Installation of OpenSSL 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing OpenSSL?"
yes_or_no
${OPENSSL_TAR}
previous_command_succeeded
cd ${OPENSSL}
previous_command_succeeded
./configure --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic         
previous_command_succeeded
make
previous_command_succeeded
#make test 
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
previous_command_succeeded
make MANSUFFIX=ssl install
previous_command_succeeded
mv -v /usr/share/doc/openssl /usr/share/doc/${OPENSSL}
cp -vfr doc/* /usr/share/doc/${OPENSSL}
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${OPENSSL} 
previous_command_succeeded
##

####6.51. ${PYTHON_STRING} 
##6.51.1. Installation of Python 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Python 3?"
yes_or_no
${PYTHON_TAR}
previous_command_succeeded
cd ${PYTHON}
previous_command_succeeded
./configure --prefix=/usr --enable-shared --with-system-expat --with-system-ffi --with-ensurepip=yes 
previous_command_succeeded
make
previous_command_succeeded
make install
previous_command_succeeded
chmod -v 755 /usr/lib/libpython3.6m.so
previous_command_succeeded
chmod -v 755 /usr/lib/libpython3.so
previous_command_succeeded
install -v -dm755 /usr/share/doc/${PYTHON_NAME}/html
previous_command_succeeded
tar --strip-components=1 \
    --no-same-owner \
    --no-same-permissions \
    -C /usr/share/doc/${PYTHON_NAME}/html \
    -xvf ../${PYTHON_NAME}-docs-html.tar.bz2
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${PYTHON} 
previous_command_succeeded
##

####6.52. ${NINJA_STRING} 
##6.52.1. Installation of Ninja 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Ninja?"
yes_or_no
${NINJA_TAR}
previous_command_succeeded
cd ${NINJA}
previous_command_succeeded
export NINJAJOBS=4
previous_command_succeeded
patch -Np1 -i ../${NINJA}-add_NINJAJOBS_var-1.patch
previous_command_succeeded
python3 configure.py --bootstrap
previous_command_succeeded
#python3 configure.py
#./ninja ninja_test
#./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
install -vm755 ninja /usr/bin/
previous_command_succeeded
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
previous_command_succeeded
install -vDm644 misc/zsh-completion /usr/share/zsh/site-functions/_ninja
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${NINJA} 
previous_command_succeeded
##

####6.53. ${MESON_STRING} 
##6.53.1. Installation of Meson 
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Meson?"
yes_or_no
${MESON_TAR}
previous_command_succeeded
cd ${MESON}
previous_command_succeeded
##
python3 setup.py build
previous_command_succeeded
python3 setup.py install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MESON} 
previous_command_succeeded
##

## by intrajp:systemd fails unless blkid.so is not there, so install util-linux before systemd

####6.xx. ${UTIL_LINUX_STRING} 
##6.xx.1. FHS compliance notes
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
##6.xx.2. Installation of Util-linux
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
#

####6.54. ${SYSTEMD_STRING} 
##6.54.1. Installation of systemd
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing systemd?"
yes_or_no
${SYSTEMD_TAR}
previous_command_succeeded
cd ${SYSTEMD} 
previous_command_succeeded
ln -sf /tools/bin/true /usr/bin/xsltproc
previous_command_succeeded
${SYSTEMD_MAN_PAGES_TAR}
previous_command_succeeded
sed '178,222d' -i src/resolve/meson.build
previous_command_succeeded
sed -i 's/GROUPP="render", //' rules/50-udev-default.rules.in
previous_command_succeeded
mkdir -p build
previous_command_succeeded
cd build
previous_command_succeeded
##
LANG=en_US.UTF-8                          \
meson       --prefix=/usr                 \
            --sysconfdir=/etc             \
            --localstatedir=/var          \
            -Dblkid=true                  \
            -Dbuildtype=release           \
            -Ddefault-dnssec=no           \
            -Dfirstboot=false             \
            -Dinstall-tests=false         \
            -Dkill-path=/bin/kill         \
            -Dkmod-path=/bin/kmod         \
            -Dldconfig=false              \
            -Dmount-path=/bin/mount       \
            -Drootprefix=                 \
            -Drootlibdir=/lib             \
            -Dsplit-usr=true              \
            -Dsulogin-path=/sbin/sulogin  \
            -Dsysusers=false              \
            -Dmount-path=/bin/umount      \
            -Db_lto=false                 \
            ..
previous_command_succeeded
LANG=en_US.UTF-8 ninja
previous_command_succeeded
LANG=en_US.UTF-8 ninja install
previous_command_succeeded
rm -rfv /usr/lib/rpm
previous_command_succeeded
for tool in runlevel reboot shutdown poweroff halt telinit; do
    ln -sfv ../bin/systemctl /sbin/${tool}
done
previous_command_succeeded
ln -sfv ../lib/systemd/systemd /sbin/init
previous_command_succeeded
rm -f /usr/bin/xsltproc
previous_command_succeeded
systemd-machine-id-setup
previous_command_succeeded
cat > /lib/systemd/systemd-user-sessions << "EOF"
#!/bin/bash
rm -f /run/nologin
EOF
previous_command_succeeded
chmod 755 /lib/systemd/systemd-user-sessions
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${SYSTEMD} 
previous_command_succeeded

####6.55. ${PROCPS_NG}
##6.55.1. Installation of Procps-ng
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Procps-ng?"
yes_or_no
${PROCPS_NG_TAR}
previous_command_succeeded
cd ${PROCPS_NG} 
previous_command_succeeded
##
## pkgconfig path added by intrajp
PKG_CONFIG_PATH=/usr/lib64/pkgconfig                 \
./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/${PROCPS_NG} \
            --disable-static                         \
            --disable-kill                           \
            --with-systemd
previous_command_succeeded
##
make
previous_command_succeeded
##
#sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
#sed -i '/set tty/d' testsuite/pkill.test/pkill.exp
#rm testsuite/pgrep.test/pgrep.exp
#make check
##
make install
previous_command_succeeded
##
mv -v /usr/lib/libprocps.so.* /lib
previous_command_succeeded
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${PROCPS_NG} 
previous_command_succeeded
##

####6.56. ${E2FSPROGS_STRING}
##6.56.1. Installation of E2fsprogs
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing E2fsprogs?"
yes_or_no
${E2FSPROGS_TAR}
previous_command_succeeded
cd ${E2FSPROGS}   
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
LIBS=-L/tools/lib                    \
CFLAGS=-I/tools/include              \
PKG_CONFIG_PATH=/tools/lib/pkgconfig \
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck
previous_command_succeeded
##
make
previous_command_succeeded
##
#ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib
#make LD_LIBRARY_PATH=/tools/lib check
previous_command_succeeded
##
make install
previous_command_succeeded
##
make install-libs
previous_command_succeeded
##
chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
previous_command_succeeded
##
gunzip -v /usr/share/info/libext2fs.info.gz
previous_command_succeeded
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info
previous_command_succeeded
##
makeinfo -o doc/com_err.info ../lib/et/com_err.texinfo
previous_command_succeeded
install -v -m644 doc/com_err.info /usr/share/info
previous_command_succeeded
install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${E2FSPROGS}   
previous_command_succeeded
##

####6.57. ${COREUTILS_STRING} 
##6.57.1. Installation of Coreutils
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Coreutils?"
yes_or_no
${COREUTILS_TAR}
previous_command_succeeded
cd ${COREUTILS}   
previous_command_succeeded
##
sed -i '/test.lock/s/^/#/' gnulib-tests/gnulib.mk
previous_command_succeeded
## added by intrajp
sed -i "s/AC_PROG_LN_S/AC_PROG_LN_S\nAC_PROG_YACC/" configure.ac
previous_command_succeeded
##
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime
previous_command_succeeded
##
FORCE_UNSAFE_CONFIGURE=1 make
previous_command_succeeded
##
#make NON_ROOT_USERNAME=nobody check-root
##
#echo "dummy:x:1000:nobody" >> /etc/group
##
#chown -Rv nobody .
##
#su nobody -s /bin/bash \
#-c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"
##
#sed -i '/dummy/d' /etc/group
##
make install
previous_command_succeeded
##
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
previous_command_succeeded
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
previous_command_succeeded
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
previous_command_succeeded
mv -v /usr/bin/chroot /usr/sbin
previous_command_succeeded
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
previous_command_succeeded
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8
previous_command_succeeded
##
mv -v /usr/bin/{head,sleep,nice} /bin
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${COREUTILS} 
previous_command_succeeded
##

####6.58. ${CHECK_STRING} 
##6.58.1. Installation of Check 
backto_source_dir_part3
echo "Are you ready for installing Check?"
yes_or_no
${CHECK_TAR}
previous_command_succeeded
cd ${CHECK} 
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
rm -rf ${CHECK} 
previous_command_succeeded
##

####6.59. ${DIFFUTILS_STRING} 
##6.59.1. Installation of Diffutils
backto_source_dir_part3
echo "Are you ready for installing Diffutils?"
yes_or_no
tar xvf ${DIFFUTILS}.tar.xz 
previous_command_succeeded
cd ${DIFFUTILS} 
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
rm -rf ${DIFFUTILS} 
previous_command_succeeded
##

####6.60. ${GAWK_STRING} 
##6.60.1. Installation of Gawk
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Gawk?"
yes_or_no
${GAWK_TAR}
previous_command_succeeded
cd ${GAWK} 
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
##
mkdir -v /usr/share/doc/${GAWK}
previous_command_succeeded
cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/${GAWK}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GAWK} 
previous_command_succeeded
##

####6.61. ${FINDUTILS_STRING} 
##6.61.1. Installation of Findutils
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Findutils?"
yes_or_no
${FINDUTILS_TAR}
previous_command_succeeded
cd ${FINDUTILS} 
previous_command_succeeded
##
sed -i 's/test-lock..EXEEXT.//' tests/Makefile.in
previous_command_succeeded

./configure --prefix=/usr --localstatedir=/var/lib/locate
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
mv -v /usr/bin/find /bin
previous_command_succeeded
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${FINDUTILS} 
previous_command_succeeded
##

####6.62. ${GROFF} 
##6.62.1. Installation of Groff
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Groff?"
yes_or_no
${GROFF_TAR}
previous_command_succeeded
cd ${GROFF}     
previous_command_succeeded
##
##################note that PAGE is properly set !!###########################
PAGE=letter ./configure --prefix=/usr
##
make -j1
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GROFF}     
previous_command_succeeded
##

####6.63. ${GRUB_STRING} 
##6.63.1. Installation of GRUB
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing GRUB?"
yes_or_no
${GRUB_TAR}
previous_command_succeeded
cd ${GRUB}     
previous_command_succeeded
##
./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GRUB}     
previous_command_succeeded
##

####6.64. ${LESS_STRING} 
##6.64.1. Installation of Less
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Less?"
yes_or_no
${LESS_TAR}
previous_command_succeeded
cd ${LESS} 
previous_command_succeeded
##
./configure --prefix=/usr --sysconfdir=/etc
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
rm -rf ${LESS} 
previous_command_succeeded
##

####6.65. ${GZIP_STRING} 
##6.65.1. Installation of Gzip
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Gzip?"
yes_or_no
${GZIP_TAR}
previous_command_succeeded
cd ${GZIP}     
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
mv -v /usr/bin/gzip /bin
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GZIP}     
previous_command_succeeded

####6.66. ${IPROUTE2_STRING} 
##6.66.1. Installation of IPRoute2
backto_source_dir_part3
echo "Are you ready for installing IPRoute2?"
yes_or_no
${IPROUTE2_TAR}
previous_command_succeeded
cd ${IPROUTE2}     
previous_command_succeeded
##
sed -i /ARPD/d Makefile
previous_command_succeeded
rm -fv man/man8/arpd.8
previous_command_succeeded
##
sed -i 's/m_ipt.o//' tc/Makefile
previous_command_succeeded
make
previous_command_succeeded
##
make DOCDIR=/usr/share/doc/${IPROUTE2} install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${IPROUTE2}     
previous_command_succeeded
##

####6.67. ${KBD_STRING} 
##6.67.1. Installation of Kbd
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Kbd?"
yes_or_no
${KBD_TAR}
previous_command_succeeded
cd ${KBD}    
previous_command_succeeded
##
patch -Np1 -i ../${KBD}-backspace-1.patch
previous_command_succeeded
##
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
previous_command_succeeded
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
previous_command_succeeded
##
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock
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
mkdir -v       /usr/share/doc/${KBD}
previous_command_succeeded
cp -R -v docs/doc/* /usr/share/doc/${KBD}
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${KBD}     
previous_command_succeeded
##
echo "Everything's fine, I guess. Now, go to next step, typing \"source 3_9.sh | tee 3_9.sh.log\"."
