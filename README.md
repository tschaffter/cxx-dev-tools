# cxx-dev-tools

Tools to support the development and CI of CXX projects.

## Overview

This repository provides tools and configurations that are meant to be unique
across many GitHub repositories.

For example, `cmake-format` is a CMake linter and format validator for CMake
files. Developers use this tool to garantee that the content of all the CMake
files in their project are formatted in the same way. In the case of modular
projects composed of multiple GitHub repos, individual repos would typically
import `cmake-format` independently of each other with the risk that repos
may use different version of `cmake-format`. Moreover, `cmake-format` can take
as input a confiration file that would be typicallly copied to each repo,
thus potentially leading to format discrepencies across repositories.

To solve the above issues, this repo provides a wrapper that enables
`cmake-format` to be run from multiple repos while still using a single
configuration file.

## Tools

This repo includes the following tools:

### Linters and format validators

- [cmake-format](https://github.com/cheshirekow/cmake_format.git): Linter and
format validator for CMake files (CMakeLists.txt, .cmake, etc.)
- [clang-format](https://github.com/llvm-mirror/clang/tree/master/tools/clang-format): Linter and format validator for CXX files (.hpp, .cpp, .h, .cpp, etc.)

### CMake toolls

- [BuildType.cmake](cmake/BuildType.cmake): Set a default build type if none
was specified.

## Configurations

- [cmake/format/.cmake-format.json](cmake/format/.cmake-format.json):
Default configuration file for `cmake-format`.
- [cmake/format/.esp-idf-cmake-format.json](cmake/format/.esp-idf-cmake-format.json):
Configuration file for `cmake-format` for ESP-IDF projects.