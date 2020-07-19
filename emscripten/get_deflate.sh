#!/bin/bash

#version of Deflate to use
DEFLATE_VERSION="1.6"

# download and unzip Deflate
#if [ ! -e "v${DEFLATE_VERSION}.tar.gz" ]
#then
#    curl -s https://api.github.com/repos/ebiggers/libdeflate/releases/latest \
#        | grep "*.tar.gz" \
#        | cut -d : -f 2,3 \
#        | tr -d \" \
#        | wget -qi -
#fi

#configure the library
if [ ! -e "libdeflate-${DEFLATE_VERSION}/Makefile" ]
then
	tar xzf "libdeflate-${DEFLATE_VERSION}.tar.gz"
fi

pushd "libdeflate-${DEFLATE_VERSION}"
BASEDIR=$(dirname $(pwd))
emmake make
LIBDIR=${BASEDIR}/libs INCDIR=${BASEDIR}/include BINDIR=${BASEDIR}/bin emmake make install
popd
