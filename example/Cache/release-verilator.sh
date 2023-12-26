#!/bin/bash

# This script is used to release the XDummyCache library.

# has verible?
if ! command -v verible-verilog-syntax &> /dev/null
then
    echo "verible could not be found"
    echo "please add verible-verilog-syntax into path first"
    echo "https://chipsalliance.github.io/verible/verilog_syntax.html"
    echo "https://github.com/chipsalliance/verible/releases/tag/v0.0-3428-gcfcbb82b"
    exit
fi

# run cache codegen
rm -rf mcv_out
# mcv -f example/Cache/Cache.v -s ./template -t ./temp -S Cache -T Cache -w cache.fst --sim verilator
mcv example/Cache/Cache.v -f example/Cache/Test.v -w cache.fst --sim verilator $@ -C '-fPIC -O3' -V '--vpi'

# build cache
cd mcv_out && make
# echo "build cache done, all you need has been generated in temp/release"
