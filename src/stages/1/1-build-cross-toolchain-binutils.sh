#!/usr/bin/env bash

cd "$ETH0S_UPSTREAM_DIR"/binutils || exit
mkdir -v build && cd build || exit

../configure --prefix="$ETH0S_WORKING_DIR"/tools \
             --with-sysroot="$ETH0S_WORKING_DIR" \
             --target="$ETH0S_TGT"  \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

make -j"$NUM_CORES"
make install