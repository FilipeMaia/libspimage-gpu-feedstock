#!/bin/bash

mkdir build
cd build

if [[ ${HOST} =~ .*darwin.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
    CMAKE_PLATFORM_FLAGS+=("")
fi

# CUDA_HOME is defined by nvcc metapackage
# From: https://github.com/floydhub/dl-docker/issues/59
cmake    -DUSE_CUDA=ON \      
	 -DCMAKE_BUILD_TYPE=Release \
	 -DCMAKE_PREFIX_PATH=${PREFIX} \
	 -DCMAKE_INSTALL_PREFIX=${PREFIX} \
	 ${CMAKE_PLATFORM_FLAGS[@]} \
	 ${SRC_DIR}
make install
