# cxx-dev-tools

Tools to support the development and CI of CXX projects.

## Overview

This repository provides tools and configurations that are meant to be unique
across many GitHub repositories.

One of the tools provided by this repo is `cmake-format`, which is a CMake
linter and format validator for CMake files. Developers use this tool to
garantee that the content of all the CMake files in their project are formatted
in the same way. In the case of modular projects composed of multiple GitHub
repos, individual repos would typically import `cmake-format` independently of
each other with the risk that repos may use different version of `cmake-format`.
Moreover, `cmake-format` can take as input a confiration file that would be
typicallly copied to each repo, thus potentially leading to format discrepencies
across repositories.

To solve the above issues, this repo provides a wrapper that enables
`cmake-format` to be run from multiple repos while still using a single
configuration file.

## How to use this repository

If you want to use the default configurations of the tools, simply add this repo
as a git submodule to all your CXX projects that should have the same CXX and/or
CMake formating.

```bash
git submodule add -b master https://github.com/tschaffter/cxx-dev-tools.git dev-cxx-tools
```

Then, add the CXX dev tools to your PATH.

```bash
cd dev-cxx-tools/
. export.sh
```

You can now run `run-cmake-format.sh CMAKE_FILES` to easily format `CMAKE_FILES`
(e.g. `CMakeLists.txt`, `cmake/MyTool.cmake`, etc.) using the configuration file
located in `cmake/format/.cmake-format.json`.

In case you want to define your own CXX style, for example, fork this repo and
modify the CXX format configuration, then add your fork as a submodule to your
projects.

## Continuous Integration

Add cxx-dev-tools to your CI configuration if you want to test that the files
committed comply with the unique formating defined here (or your own format if
you have fork and modify this repo, see above). See `.circleci/config.yml` for
an example on how to check that the format of your CXX and CMake files pass.

## Tools

### Linters and format validators

TODO: List the wrappers instead

- [cmake-format](https://github.com/cheshirekow/cmake_format.git):
Linter and format validator for CMake files (CMakeLists.txt, .cmake, etc.)
- [clang-format](https://github.com/llvm-mirror/clang/tree/master/tools/clang-format):
Linter and format validator for CXX files (.hpp, .cpp, .h, .cpp, etc.)

### CMake tools

- [BuildType.cmake](cmake/BuildType.cmake): Set a default build type if none
was specified.

### GitHub tools

- [pre-commit hook](git/.githooks/pre-commit): This example git pre hook checks
that your `.circleci/config.yml` is valid, otherwise `git commit` will fail.

## Configurations

This repo includes the following configuration files.

- [cmake/format/.cmake-format.json](cmake/format/.cmake-format.json):
Default configuration file for `cmake-format`.
- [cmake/format/.esp-idf-cmake-format.json](cmake/format/.esp-idf-cmake-format.json):
Configuration file for `cmake-format` for ESP-IDF projects.
