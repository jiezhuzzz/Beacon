#!/bin/bash
set -e
set -x

# Building SVF
(
    echo -e "## Build SVF"
    pushd $FUZZER/repo/SVF
    sed -i 's/LLVMRELEASE=\/home\/ysui\/llvm-4.0.0\/llvm-4.0.0.obj/LLVMRELEASE=\/usr\/llvm/' build.sh
    ./build.sh
    popd
)

# Building precondInfer
(
    echo -e "## Build precondInfer"
    pushd $FUZZER/precondInfer
    mkdir -p build 
    pushd build
    cmake \
        -DENABLE_KLEE_ASSERTS=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -DLLVM_CONFIG_BINARY=/usr/bin/llvm-config \
        -DSVF_ROOT_DIR=${FUZZER}/SVF \
        -DSVF_LIB_DIR=${FUZZER}/SVF/Release-build/lib \
        ..
    make -j
    mv bin/precondInfer $OUT/
    popd
    popd
)

# Building Ins
(
    echo -e "## Build Ins"
    pushd $FUZZER/Ins
    mkdir -p build 
    pushd build
    CXXFLAGS="-fno-rtti" cmake \
        -DLLVM_DIR=/usr/lib/cmake/llvm/ \
        -DCMAKE_BUILD_TYPE=Release \
        ..
    make -j
    mv bin/Ins $OUT/
    popd
    popd
)