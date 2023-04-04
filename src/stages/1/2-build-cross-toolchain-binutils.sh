#!/usr/bin/env bash

BINUTILS_DIR="$ETH0S_WORKING_DIR"/sources/binutils
cd $BINUTILS_DIR
mkdir -pv "$BINUTILS_DIR"/build && cd "$BINUTILS_DIR"/build

"$BINUTILS_DIR"/configure \
    --prefix="$ETH0S_WORKING_DIR"/tools \
    --with-sysroot="$ETH0S_WORKING_DIR" \
    --target="$ETH0S_TGT"  \
    --disable-nls       \
    --enable-gprofng=no \
    --disable-werror

make -j"$NUM_CORES"
make install
