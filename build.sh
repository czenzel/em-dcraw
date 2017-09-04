#!/bin/bash
#
# dcraw Builder for Emscripten
# Copyright 2017 Christopher Zenzel.
# All Rights Reserved.
#
# Builder to be licensed
#

mkdir -p build

cd libjpeg
emconfigure ./configure --prefix=`pwd`/../build
emmake make
emmake make install
cd ..

cd build/lib
emcc -o libjpeg.js libjpeg.dylib

cd ../bin
emcc -o dcraw ../../src/dcraw.c -DNO_JASPER -DNO_LCMS -I../include -L../lib -ljpeg

cp dcraw dcraw.bc
emcc -o dcraw.js -s ALLOW_MEMORY_GROWTH=1 -O3 dcraw.bc

cd ../..

cp build/bin/dcraw.js js/
cp build/lib/libjpeg.js js/
cp build/bin/dcraw.js.mem js/
