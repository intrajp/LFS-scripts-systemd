
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

. config 
. functions
previous_command_succeeded

####Chapter 5. Constructing a Temporary System
echo
echo "Are you ready for constructing a temporary system?"
echo
yes_or_no
echo
echo $LFS
echo "Can you see \"/mnt/lfs\"?"
yes_or_no

####5.4. ${BINUTILS_STRING} - Pass 1
echo
echo "Are you ready for building Cross Binutils?"
echo
yes_or_no
##
backto_source_dir
previous_command_succeeded
##
tar -xjvf ${BINUTILS}.tar.bz2
previous_command_succeeded
cd "${BINUTILS}" 
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
../configure --prefix=/tools            \
             --with-sysroot=$LFS        \
             --with-lib-path=/tools/lib \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror
##
previous_command_succeeded
make
previous_command_succeeded
##
case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac
##
make install
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf "${BINUTILS}" 
previous_command_succeeded

####5.5. ${GCC_STRING} - Pass 1
##5.5.1. Installation of Cross GCC
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install Cross GCC?"
echo
yes_or_no
##
tar -xvf ${GCC}.tar.xz 
previous_command_succeeded
cd ${GCC} 
previous_command_succeeded
##
tar -xf ../mpfr-3.1.5.tar.xz
previous_command_succeeded
mv -v mpfr-3.1.5 mpfr
previous_command_succeeded
tar -xf ../gmp-6.1.2.tar.xz
previous_command_succeeded
mv -v gmp-6.1.2 gmp
previous_command_succeeded
tar -xf ../mpc-1.0.3.tar.gz
previous_command_succeeded
mv -v mpc-1.0.3 mpc
previous_command_succeeded
##
for file in gcc/config/{linux,i386/linux{,64}}.h 
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
../configure                                       \
    --target=$LFS_TGT                              \
    --prefix=/tools                                \
    --with-glibc-version=2.11                      \
    --with-sysroot=$LFS                            \
    --with-newlib                                  \
    --without-headers                              \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --disable-nls                                  \
    --disable-shared                               \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-threads                              \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libmpx                             \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${GCC} 
previous_command_succeeded
##

####5.6. ${LINUX} API Headers
##5.6.1. Installation of Linux API Headers
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install Linux API Headers?"
echo
yes_or_no
##
tar -xvf ${LINUX}.tar.xz
previous_command_succeeded
cd ${LINUX} 
previous_command_succeeded
##
make mrproper
previous_command_succeeded
##
make INSTALL_HDR_PATH=dest headers_install
previous_command_succeeded
cp -rv dest/include/* /tools/include
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${LINUX} 
previous_command_succeeded
##

####5.7. ${GLIBC_STRING}
##5.7.1. Installation of Glibc
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install Glibc?"
echo
yes_or_no
##
tar -xvf ${GLIBC}.tar.xz
previous_command_succeeded
cd ${GLIBC} 
previous_command_succeeded
##
##
mkdir -v build
previous_command_succeeded
cd       build
previous_command_succeeded
##
../configure                             \
      --prefix=/tools                    \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --enable-kernel=3.2             \
      --with-headers=/tools/include      \
      libc_cv_forced_unwind=yes          \
      libc_cv_c_cleanup=yes
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${GLIBC} 
previous_command_succeeded
##
echo 'int main(){}' > dummy.c
$LFS_TGT-gcc dummy.c
readelf -l a.out | grep ': /tools'
##
echo "Can you see [Requesting program interpreter: /tools/lib/ld-linux.so.2] (If your system is 64-bit, it will be lib64.)"
yes_or_no
##
rm -v dummy.c a.out
previous_command_succeeded

####5.8. ${LIBSTDC_STRING} 
##5.8.1. Installation of Target Libstdc++
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install Target ${LIBSTDC_STRING}?"
echo
yes_or_no
##
##
tar -xvf ${GCC}.tar.xz
previous_command_succeeded
cd ${GCC} 
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
../libstdc++-v3/configure           \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/${GCC_VERSION}
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${GCC} 
previous_command_succeeded
##
####5.9. ${BINUTILS_STRING} - Pass 2
##5.9.1. Installation of Binutils
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install Binutils?"
echo
yes_or_no
##
tar -xjvf ${BINUTILS}.tar.bz2
previous_command_succeeded
cd ${BINUTILS} 
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../configure                   \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
make -C ld clean
previous_command_succeeded
make -C ld LIB_PATH=/usr/lib:/lib
previous_command_succeeded
cp -v ld/ld-new /tools/bin
previous_command_succeeded
##
backto_source_dir
previous_command_succeeded
rm -rf ${BINUTILS} 
previous_command_succeeded
##
####5.10. ${GCC} - Pass 2
##5.10.1. Installation of GCC
backto_source_dir
previous_command_succeeded
echo
echo "Are you ready to Install GCC?"
echo
yes_or_no
##
tar -xvf ${GCC}.tar.xz
previous_command_succeeded
cd ${GCC} 
previous_command_succeeded
##
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h
previous_command_succeeded
##
for file in gcc/config/{linux,i386/linux{,64}}.h 
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done
previous_command_succeeded
##
tar -xf ../mpfr-3.1.5.tar.xz
previous_command_succeeded
mv -v mpfr-3.1.5 mpfr
previous_command_succeeded
tar -xf ../gmp-6.1.2.tar.xz
previous_command_succeeded
mv -v gmp-6.1.2 gmp
previous_command_succeeded
tar -xf ../mpc-1.0.3.tar.gz
previous_command_succeeded
mv -v mpc-1.0.3 mpc
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
CC=$LFS_TGT-gcc                                    \
CXX=$LFS_TGT-g++                                   \
AR=$LFS_TGT-ar                                     \
RANLIB=$LFS_TGT-ranlib                             \
../configure                                       \
    --prefix=/tools                                \
    --with-local-prefix=/tools                     \
    --with-native-system-header-dir=/tools/include \
    --enable-languages=c,c++                       \
    --disable-libstdcxx-pch                        \
    --disable-multilib                             \
    --disable-bootstrap                            \
    --disable-libgomp
previous_command_succeeded
##
make
previous_command_succeeded
##
make install
previous_command_succeeded
##
ln -sv gcc /tools/bin/cc
previous_command_succeeded
###
backto_source_dir
previous_command_succeeded
rm -rf ${GCC} 
previous_command_succeeded
##
##
echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
##
echo "Can you see [Requesting program interpreter: /tools/lib/ld-linux.so.2] (If your system is 64-bit, it will be lib64."
yes_or_no
##
rm -v dummy.c a.out
previous_command_succeeded
##
echo "Everything's fine?"
echo "Now execute \"source 4.sh|tee 4.sh.log\"."
