#!/bin/bash

cd ${CXX_DEV_TOOLS_PATH}/test/cmake-format

# Test 1
run-cmake-format-check.sh samples/valid-format.cmake
if [ $? -ne 0 ]; then
    echo "cmake-format-check.sh failed to return 0 on valid cmake sample"
    exit 1
fi

# Test 2
run-cmake-format-check.sh samples/invalid-format.cmake
if [ $? -eq 0 ]; then
    echo "cmake-format-check.sh failed to return not 0 on invalid cmake sample"
    exit 1
fi