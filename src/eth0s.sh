#!/usr/bin/env bash

VALID_ARGS=$(getopt -o j:w: --long jobs:working-dir: -- "$@")

SRC_DIR=$(pwd)/src
export SRC_DIR

ETH0S_WORKING_DIR=$(pwd)/dist
export ETH0S_WORKING_DIR

NUM_CORES=$(lscpu | grep -E '^CPU\(s\):' | tr -s ' ' | cut -d ' ' -f 2)
export NUM_CORES

eval set -- "$VALID_ARGS"
while true; do
    case "$1" in
        -j | --jobs)
            shift
            NUM_CORES="$1"
            shift
            ;;
        -w | --working-dir)
            shift
            ETH0S_WORKING_DIR="$1"
            shift
            ;;
        --) shift;
            break
            ;;
    esac
done

if [ ! -w "$ETH0S_WORKING_DIR" ]
then
    >&2 echo "User does not have the correct permissions to write to the working directory: '$ETH0S_WORKING_DIR'"
    exit 1
fi

## Setting environment variables...
ORIG_PATH="$PATH"
export PATH="$ETH0S_WORKING_DIR"/tools/bin:"$PATH"

ETH0S_TGT=$(uname -m)-eth0s_tmp-linux-gnu
export ETH0S_TGT

ORIG_CONFIG_SITE="$CONFIG_SITE"
export CONFIG_SITE="$ETH0S_WORKING_DIR"/usr/share/config.site

LC_ALL=POSIX
export LC_ALL

## Now, onto the show!
# source "$SRC_DIR"/stages/stage-0.sh &&
source "$SRC_DIR"/stages/stage-1.sh

## Cleanup...
unset NUM_CORES

unset PATH
export PATH="$ORIG_PATH"

unset ETH0S_TGT

unset CONFIG_SITE
export CONFIG_SITE="$ORIG_CONFIG_SITE"

unset LC_ALL

unset ETH0S_WORKING_DIR

unset SRC_DIR
