#!/bin/bash

cmake-format \
    ./cmake/BuildType.cmake \
    --config-files \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.cmake-format.json \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.esp-idf-cmake-format.json \
    --check