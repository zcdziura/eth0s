#!/usr/bin/env bash

STAGE_1_DIR="$SRC_DIR"/stages/1

source "$SRC_DIR"/stages/1/1-download-needed-packages.sh &&
source "$STAGE_1_DIR"/2-build-cross-toolchain-binutils.sh &&
source "$STAGE_1_DIR"/3-build-cross-toolchain-gcc.sh &&
source "$STAGE_1_DIR"/4-build-cross-toolchain-linux-headers.sh &&
source "$STAGE_1_DIR"/5-build-cross-toolchain-glibc.sh
