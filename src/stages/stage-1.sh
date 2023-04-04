#!/usr/bin/env bash

# source "$SRC_DIR"/stages/1/1-download-needed-packages.sh &&
source "$SRC_DIR"/stages/1/2-build-cross-toolchain-binutils.sh &&
source "$SRC_DIR"/stages/1/3-build-cross-toolchain-gcc.sh
