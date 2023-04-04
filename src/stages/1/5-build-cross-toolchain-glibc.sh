#!/usr/bin/env bash

GLIBC_DIR="$ETH0S_WORKING_DIR"/sources/glibc
cd "$GLIBC_DIR"

case $(uname -m) in
    i?86)
		ln -sfv ld-linux.so.2 "$ETH0S_WORKING_DIR"/lib/ld-lsb.so.3
    ;;
    x86_64)
		ln -sfv ../lib/ld-linux-x86-64.so.2 "$ETH0S_WORKING_DIR"/lib64
        ln -sfv ../lib/ld-linux-x86-64.so.2 "$ETH0S_WORKING_DIR"/lib64/ld-lsb-x86-64.so.3
    ;;
esac

patch -Np1 -i ../glibc-2.37-fhs-1.patch

mkdir -pv "$GLIBC_DIR"/build && cd "$GLIBC_DIR"/build

echo "rootsbindir=/usr/sbin" > configparms

"$GLIBC_DIR"/configure \
	--prefix=/usr \
	--host="$ETH0S_TGT" \
	--build="$(../scripts/config.guess)" \
	--enable-kernel=3.2 \
	--with-headers="$ETH0S_WORKING_DIR"/usr/include \
	libc_cv_slibdir=/usr/lib

make -j"$NUM_CORES"
make DESTDIR="$ETH0S_WORKING_DIR" install

sed '/RTLDLIST=/s@/usr@@g' -i "$ETH0S_WORKING_DIR"/usr/bin/ldd

"$ETH0S_WORKING_DIR"/tools/libexec/gcc/"$ETH0S_TGT"/12.2.0/install-tools/mkheaders
