#!/bin/bash
cmake-lint CMakeLists.txt \
    ./examples/hello-world/CMakeLists.txt \
    ./examples/service/CMakeLists.txt \
    ./test/unit/CMakeLists.txt \
    ./cmake/BuildType.cmake \
    --config-files \
        cmake/.cmake-format.json \
        cmake/.esp-idf-cmake-format.json