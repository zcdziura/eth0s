#!/usr/bin/env bash

LINUX_DIR="$ETH0S_WORKING_DIR"/sources/linux
cd "$LINUX_DIR"

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include "$ETH0S_WORKING_DIR"/usr
