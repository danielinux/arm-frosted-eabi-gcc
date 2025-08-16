#!/bin/bash
set -x

THIS_DIR="$(pwd | sed 's/\//\\\//g')"
echo $THIS_DIR

mkdir $PWD/cmd
cd crosstool-ng
./bootstrap
./configure --prefix=$PWD/../cmd && make && make install
cd ..

cp arm-frosted-eabi.config.in .config

cd newlib/libgloss/arm-frosted
autoreconf2.69 -i -f
cd ../../..

cd elf2flt
git stash
patch -p1 < ../patches/elf2flt/elf2flt-frosted-patch.diff
cd ..

cmd/bin/ct-ng build $@
