#!/bin/bash

CXX_FILES=$@

# clang-format.sh will be in the PATH after sourcing export.sh
clang-format.sh -i ${CXX_FILES}