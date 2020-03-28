#!/bin/bash

cd ${CXX_DEV_TOOLS_PATH}/test/cxx-lint

# Test 1
cxxdt-cxx-lint samples/valid-format.*
if [ $? -ne 0 ]; then
    echo "cxxdt-cxx-lint failed to return 0 on valid cxx samples"
    exit 1
fi

# Test 2
cxxdt-cxx-lint samples/invalid-format.* &> /dev/null
if [ $? -eq 0 ]; then
    echo "cxxdt-cxx-lint failed to return not 0 on invalid cxx samples"
    exit 1
fi