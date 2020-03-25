#!/bin/bash

cd ${CXX_DEV_TOOLS_PATH}/test/clang-format

# Test 1
run-clang-format-check.sh samples/valid-format.*
if [ $? -ne 0 ]; then
    echo "clang-format-check.sh failed to return 0 on valid cxx samples"
    exit 1
fi

# Test 2
run-clang-format-check.sh samples/invalid-format.* &> /dev/null
if [ $? -eq 0 ]; then
    echo "clang-format-check.sh failed to return not 0 on invalid cxx samples"
    exit 1
fi