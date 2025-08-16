#!/bin/bash
set -x

THIS_DIR="$(pwd | sed 's/\//\\\//g')"
echo $THIS_DIR

mkdir $PWD/cmd
cd crosstool-ng
autoreconf -i -f
./configure --prefix=$PWD/../cmd && make && make install
cd ..

cp arm-frosted-eabi.config.in .config

cd newlib/libgloss/arm-frosted
autoreconf2.69 -i -f
cd ../../..

cmd/bin/ct-ng build $@
