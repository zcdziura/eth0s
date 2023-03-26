#!/usr/bin/env bash

mkdir -pv "$ETH0S_WORKING_DIR"/{etc,var,tools} "$ETH0S_WORKING_DIR"/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sfv usr/$i "$ETH0S_WORKING_DIR"/$i
done

case $(uname -m) in
  x86_64) mkdir -pv "$ETH0S_WORKING_DIR"/lib64 ;;
esac