#!/bin/bash

mkdir build
cd build

if [[ ${HOST} =~ .*darwin.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
    CMAKE_PLATFORM_FLAGS+=("")
fi

# CUDA_HOME is defined by nvcc metapackage
CMAKE_FLAGS=" -DCUDA_TOOLKIT_ROOT_DIR=${CUDA_HOME}"
# From: https://github.com/floydhub/dl-docker/issues/59
CMAKE_FLAGS+=" -DCMAKE_LIBRARY_PATH=${CUDA_HOME}/lib64/stubs"

cmake .. -DUSE_CUDA=ON \      
         ${CMAKE_FLAGS} \
	 -DCMAKE_BUILD_TYPE=Release \
	 -DCMAKE_PREFIX_PATH=${PREFIX} \
	 -DCMAKE_INSTALL_PREFIX=${PREFIX} \
	 ${CMAKE_PLATFORM_FLAGS[@]} 
make install
