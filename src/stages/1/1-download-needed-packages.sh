#!/usr/bin/env bash

SOURCES_DIR="$ETH0S_WORKING_DIR"/sources

PKG_BINUTILS=https://ftp.gnu.org/gnu/binutils/binutils-2.40.tar.xz
PKG_GCC=https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz
PKG_GMP=https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz
PKG_MPFR=https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.0.tar.xz
PKG_MPC=https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz
PKG_KERNEL=https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.2.8.tar.xz
PKG_GLIBC=https://ftp.gnu.org/gnu/glibc/glibc-2.37.tar.xz

for i in "$PKG_BINUTILS" "$PKG_GCC" "$PKG_KERNEL" "$PKG_GLIBC"; do
    dir_name=$(echo "$i" | sed 's/^.*\/\([a-z]\+\)-\([0-9]\.\?\)\+\.tar\.[a-z]\+$/\1/')
    mkdir -p "$SOURCES_DIR"/"$dir_name"
    curl -L "$i" | tar -xJ -C "$SOURCES_DIR"/"$dir_name" --strip-components=1
done

for i in "$PKG_GMP" "$PKG_MPFR"; do
    dir_name=$(echo "$i" | sed 's/^.*\/\([a-z]\+\)-\([0-9]\.\?\)\+\.tar\.[a-z]\+$/\1/')
    mkdir -p "$SOURCES_DIR"/gcc/"$dir_name"
    curl -L "$i" | tar -xJ -C "$SOURCES_DIR"/gcc/"$dir_name" --strip-components=1
done

mkdir -p "$SOURCES_DIR"/gcc/mpc
curl -L "$PKG_MPC" | tar -xz -C "$SOURCES_DIR"/gcc/mpc --strip-components=1

GLIBC_PATCH=https://www.linuxfromscratch.org/patches/lfs/11.3/glibc-2.37-fhs-1.patch

curl -OL --output-dir "$SOURCES_DIR" "$GLIBC_PATCH"
