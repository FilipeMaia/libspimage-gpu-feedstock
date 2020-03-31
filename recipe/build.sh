#!/bin/bash

mkdir build
cd build

if [[ ${HOST} =~ .*darwin.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
else
    CMAKE_PLATFORM_FLAGS+=("")
fi

cmake -DUSE_CUDA=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_PREFIX_PATH=${PREFIX} \
      -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCUDA_TOOLKIT_ROOT_DIR=${CUDA_HOME} \
      ${CMAKE_PLATFORM_FLAGS[@]} \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DCUDA_NVCC_FLAGS="-Xcompiler -std=c++11" \
      ..

make install
