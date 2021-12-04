#!/usr/bin/env bash

set -eux

rtl433=https://github.com/merbanan/rtl_433/archive/master.tar.gz
rtl_433_tests=https://github.com/merbanan/rtl_433_tests/archive/master.tar.gz

nix-build -I rtl433=$rtl433 -I rtl_433_tests=$rtl_433_tests -A rtl_433.tests.binary

