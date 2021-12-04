#!/usr/bin/env bash

set -eux

nix-build -E "with import <nixpkgs> {}; callPackage ./package.nix {}" -I rtl433=https://github.com/merbanan/rtl_433/archive/master.tar.gz -I rtl_433_tests=https://github.com/merbanan/rtl_433_tests/archive/master.tar.gz

