
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
##

####6.14. ${M4_STRING} 
##6.14.1. Installation of M4
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing M4?"
yes_or_no
##
${M4_TAR}
previous_command_succeeded
cd ${M4} 
previous_command_succeeded
##
./configure --prefix=/usr
previous_command_succeeded
make 
previous_command_succeeded
# make check
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${M4} 
previous_command_succeeded

####6.15. ${BC_STRING} 
##6.15.1. Installation of Bc 
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Bc?"
yes_or_no
##
${BC_TAR}
previous_command_succeeded
cd ${BC} 
previous_command_succeeded
##
cat > bc/fix-libmath_h << "EOF"
#! /bin/bash
sed -e '1 s/^/{"/'   \
    -e     's/$/",/' \
    -e '2,$ s/^/"/'  \
    -e   '$ d'       \
    -i libmath.h

sed -e '$ s/$/0}/' \
    -i libmath.h
EOF
previous_command_succeeded

ln -sv /tools/lib/libncursesw.so.6 /usr/lib/libncursesw.so.6

ln -sfv libncurses.so.6 /usr/lib/libncurses.so
previous_command_succeeded

sed -i -e '/flex/s/as_fn_error/: ;; # &/' configure
previous_command_succeeded

./configure --prefix=/usr \
    --with-readline \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info
previous_command_succeeded

make 
previous_command_succeeded
echo "quit" | ./bc/bc -l Test/checklib.b
make install
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${BC} 
previous_command_succeeded

####6.16. ${BINUTILS_STRING} 
##6.16.1. Installation of Binutils
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing Binutils ?"
yes_or_no
##
${BINUTILS_TAR}
previous_command_succeeded
cd ${BINUTILS} 
previous_command_succeeded
##
expect -c "spawn ls"
previous_command_succeeded
##
echo "Can you see \"spawn ls\" ?"
previous_command_succeeded
yes_or_no
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
../configure --prefix=/usr   \
             --enable-gold \
             --enable-ld=default \
             --enable-plugins \
             --enable-shared \
             --disable-werror \
             --enable-64-bit-bfd \
             --with-system-zlib
previous_command_succeeded
##
make tooldir=/usr
previous_command_succeeded
##
#make check
##
make tooldir=/usr install
##
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${BINUTILS} 
previous_command_succeeded
##

####6.17. ${GMP}
##6.17.1. Installation of GMP
##
backto_source_dir_part3
echo "Are you ready for installing GMP?"
yes_or_no
##
${GMP_TAR}
previous_command_succeeded
cd  ${GMP} 
previous_command_succeeded
##
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/${GMP}
previous_command_succeeded
##
make
previous_command_succeeded
make html
previous_command_succeeded
##
#make check 2>&1 | tee gmp-check-log
##
#awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
##
make install
previous_command_succeeded
make install-html
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${GMP} 
previous_command_succeeded

####6.18. ${MPFR_STRING} 
##6.18.1. Installation of MPFR
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing MPFR?"
yes_or_no
##
${MPFR_TAR}
previous_command_succeeded
cd ${MPFR} 
previous_command_succeeded
##
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/${MPFR}
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
make install-html
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MPFR} 
previous_command_succeeded

####6.19. ${MPC_STRING}
##6.19.1. Installation of MPC
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing MPC?"
yes_or_no
##
${MPC_TAR}
previous_command_succeeded
cd ${MPC} 
previous_command_succeeded
##
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/${MPC}
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
make install-html
previous_command_succeeded
##
backto_source_dir_part3
previous_command_succeeded
rm -rf ${MPC} 
previous_command_succeeded

####6.20. ${GCC_STRING}
##6.20.1. Installation of GCC
##
backto_source_dir_part3
previous_command_succeeded
echo "Are you ready for installing GCC?"
yes_or_no
##
${GCC_TAR}
previous_command_succeeded
cd ${GCC} 
previous_command_succeeded
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac
previous_command_succeeded
rm -f /usr/lib/gcc
previous_command_succeeded
##
mkdir -v build
previous_command_succeeded
cd build
previous_command_succeeded
##
SED=sed                               \
../configure --prefix=/usr            \
             --enable-languages=c,c++ \
             --disable-multilib       \
             --disable-bootstrap      \
             --with-system-zlib
previous_command_succeeded
##
make
previous_command_succeeded
##
ulimit -s 32768
previous_command_succeeded
##
#make -k check
##
#../contrib/test_summary
##
make install
previous_command_succeeded
##
ln -sv ../usr/bin/cpp /lib
previous_command_succeeded
##
ln -sv gcc /usr/bin/cc
previous_command_succeeded
##
install -v -dm755 /usr/lib/bfd-plugins
previous_command_succeeded
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/${GCC_VERSION}/liblto_plugin.so \
        /usr/lib/bfd-plugins/
previous_command_succeeded
##
echo "Check if compiling and linking will work as expected."
##
echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
##
echo "Can you read \"[Requesting program interpreter: /lib/ld-linux-x86-64.so.2]\"?"
##
yes_or_no
##
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
##
echo "Can you read these 3 lines?"
echo "/usr/lib/gcc/i686-pc-linux-gnu/${GCC_VERSION}/../../../crt1.o succeeded"
echo "/usr/lib/gcc/i686-pc-linux-gnu/${GCC_VERSION}/../../../crti.o succeeded"
echo "/usr/lib/gcc/i686-pc-linux-gnu/${GCC_VERSION}/../../../crtn.o succeeded"
##
yes_or_no
##
grep -B4 '^ /usr/include' dummy.log
##
echo ""
echo "Can you read these lines? "
echo ""

echo "#include <...> search starts here:"
echo " /usr/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/include"
echo " /usr/local/include"
echo " /usr/lib/gcc/x86_64-pc-linux-gnu/${GCC_VERSION}/include-fixed"
echo " /usr/include"
yes_or_no
##
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
##
echo "Can you read these lines(64-bit)?"
echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib64\")"
echo "SEARCH_DIR(\"/usr/local/lib64\")"
echo "SEARCH_DIR(\"/lib64\")"
echo "SEARCH_DIR(\"/usr/lib64\")"
echo "SEARCH_DIR(\"/usr/x86_64-pc-linux-gnu/lib\")"
echo "SEARCH_DIR(\"/usr/local/lib\")"
echo "SEARCH_DIR(\"/lib\")"
echo "SEARCH_DIR(\"/usr/lib\");"
echo ""
echo "Can you read these lines(32-bit)?"
echo "SEARCH_DIR(\"/usr/i686-pc-linux-gnu/lib32\")"
echo "SEARCH_DIR(\"/usr/local/lib32\")"
echo "SEARCH_DIR(\"/lib32\")"
echo "SEARCH_DIR(\"/usr/lib32\")"
echo "SEARCH_DIR(\"/usr/i686-pc-linux-gnu/lib\")"
echo "SEARCH_DIR(\"/usr/local/lib\")"
echo "SEARCH_DIR(\"/lib\")"
echo "SEARCH_DIR(\"/usr/lib\");"
echo ""
##
yes_or_no
##
grep "/lib.*/libc.so.6 " dummy.log
##
echo "Can you see \"attempt to open /lib/libc.so.6 succeeded\"?"
yes_or_no
##
grep found dummy.log
##
echo "Can you see \"found ld-linux-x86-64.so.2 at /lib/ld-linux-x86-64.so.2\"?"
yes_or_no
##
rm -v dummy.c a.out dummy.log
##
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
##
##
backto_source_dir_part3
rm -rf ${GCC} 
cd /
##

echo "OK,Everything is fine. Let's move next!"
echo "Execute \"source 3_7.sh|tee 3_7.sh.log\"."
#################################################

