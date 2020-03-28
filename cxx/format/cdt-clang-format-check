#!/bin/bash

CXX_FILES=$@

# Returns 0 to stdout if no difference, otherwise 1.
# clang-format.sh will be in the PATH after sourcing export.sh
diff -u <(cat ${CXX_FILES}) <(clang-format.sh ${CXX_FILES})