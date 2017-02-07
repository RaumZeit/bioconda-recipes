#!/bin/bash

## Choose extra configure options depending on the operating system
## (mac or linux)
##
if [ `uname` == Darwin ] ; then
# enable c++11 support
    #echo;
    #echo "PREFIX/lib";
    #ls -l $PREFIX/lib;
    #echo "PREFIX/lib/pkgconfig";
    #ls -l $PREFIX/lib/pkgconfig/boost*;
    #cat $PREFIX/lib/pkgconfig/boost*;
    #cat $PREFIX/lib/pkgconfig/RNAlib*;
    #echo "otool"
    #otool -L $PREFIX/lib/libboost_program_options.dylib
    #echo;
    MACOSX_VERSION_MIN=10.6
    extra_config_options="CXXFLAGS=\"-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN}\" LDFLAGS=\"-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN} -L${LIBRARY_PATH}\""
#    extra_config_options="CC=clang CXX=clang++ CXXFLAGS=\"-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN}\" LDFLAGS=\"-stdlib=libc++ -mmacosx-version-min=${MACOSX_VERSION_MIN} -L${LIBRARY_PATH}\""
else ## linux
    # add -fopenmp to compilation due to viennarna setup
    extra_config_options="CXXFLAGS=-fopenmp"
fi

./configure --prefix=$PREFIX \
            --with-RNA=$PREFIX \
            --with-boost=$PREFIX \
            --disable-multithreading \
            ${extra_config_options} \
            && \
make && \
make install
