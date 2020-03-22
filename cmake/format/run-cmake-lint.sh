#!/bin/bash

CMAKE_FILES="$@ \
    ${CXX_DEV_TOOLS_PATH}/cmake/BuildType.cmake"

cmake-lint \
    ${CMAKE_FILES} \
    --config-files \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.cmake-format.json \
        ${CXX_DEV_TOOLS_PATH}/cmake/format/.esp-idf-cmake-format.json