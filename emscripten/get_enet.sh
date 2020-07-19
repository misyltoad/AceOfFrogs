#!/bin/bash

shopt -s expand_aliases

#version of ENet to use
ENET_VERSION="1.3.7"

# download and unzip ENet
if [ ! -e "enet-${ENET_VERSION}.tar.gz" ]
then
  curl -O "http://enet.bespin.org/download/enet-${ENET_VERSION}.tar.gz"
fi

#configure the library
if [ ! -e "enet-${ENET_VERSION}/config.status" ]
then
	tar xzf "enet-${ENET_VERSION}.tar.gz"
	pushd "enet-${ENET_VERSION}"
	BASEDIR=$(dirname $(pwd))
	emconfigure ./configure CFLAGS="-s ASYNCIFY=1" --libdir=${BASEDIR}/libs --includedir=${BASEDIR}/include \
        ac_cv_func_gethostbyaddr_r=no \
        ac_cv_func_gethostbyname_r=no
	popd
fi

pushd "enet-${ENET_VERSION}"
emmake make
emmake make install
popd
