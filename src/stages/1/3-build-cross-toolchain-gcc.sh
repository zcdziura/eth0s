#!/usr/bin/env bash

GCC_DIR="$ETH0S_WORKING_DIR"/sources/gcc
cd "$GCC_DIR"

case $(uname -m) in
	x86_64)
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
	;;
esac

mkdir -pv "$GCC_DIR"/build && cd "$GCC_DIR"/build

"$GCC_DIR"/configure \
	--target="$ETH0S_TGT" \
	--prefix="$ETH0S_WORKING_DIR"/tools \
	--with-glibc-version=2.37 \
	--with-sysroot="$ETH0S_WORKING_DIR" \
	--with-newlib \
	--without-headers \
	--enable-default-pie \
	--enable-default-ssp \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-threads \
	--disable-libatomic \
	--disable-libgomp \
	--disable-libquadmath \
	--disable-libssp \
	--disable-libvtv \
	--disable-libstdcxx \
	--enable-languages=c,c++

make -j"$NUM_CORES"
make install
