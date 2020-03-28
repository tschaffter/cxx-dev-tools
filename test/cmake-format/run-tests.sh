#!/bin/bash

cd ${CXX_DEV_TOOLS_PATH}/test/cmake-format

# Test 1
cxxdt-cmake-lint samples/valid-format.cmake
if [ $? -ne 0 ]; then
    echo "cxxdt-cmake-lint failed to return 0 on valid cmake sample"
    exit 1
fi

# Test 2
cxxdt-cmake-lint samples/invalid-format.cmake
if [ $? -eq 0 ]; then
    echo "cxxdt-cmake-lint failed to return not 0 on invalid cmake sample"
    exit 1
fi