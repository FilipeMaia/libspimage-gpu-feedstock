#!/bin/bash

mkdir build
cd build

if [[ ${HOST} =~ .*darwin.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
    CMAKE_PLATFORM_FLAGS+=("")
fi

cmake .. -DUSE_CUDA=OFF \
	    -DCMAKE_BUILD_TYPE=Release \
	    -DCMAKE_PREFIX_PATH=${PREFIX} \
	    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
	    ${CMAKE_PLATFORM_FLAGS[@]} 
make install
