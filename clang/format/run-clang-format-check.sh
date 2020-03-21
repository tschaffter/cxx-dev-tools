#!/bin/bash
# Returns 0 to stdout if no difference, otherwise 1
diff -u <(cat include/eventemitter/*) <(clang-format include/eventemitter/*)