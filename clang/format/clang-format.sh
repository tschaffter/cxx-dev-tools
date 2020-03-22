#!/bin/bash

# Style configuration file can not be directly specified to clang-format.
# Using .clang-format is not convenient as we don't expect this file to be
# present from where clang-format is executed.
# Here we define a reusable proxy to avoid maintaining duplicated configuration.
STYLE="{ \
    BasedOnStyle: Google, \
    IndentWidth: 4, \
    AccessModifierOffset: -2 \
    }"

clang-format -style="${STYLE}" $@