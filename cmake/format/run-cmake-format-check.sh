#!/bin/bash

CMAKE_FILES="$@"

cmake-format \
    ${CMAKE_FILES} \
    --config-files \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.cmake-format.json \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.esp-idf-cmake-format.json \
    --check