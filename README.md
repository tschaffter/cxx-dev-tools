# cxx-dev-tools

[![CircleCI](https://circleci.com/gh/tschaffter/cxx-dev-tools.svg?style=shield)](https://circleci.com/gh/tschaffter/cxx-dev-tools)

Tools for supporting the development of CXX projects

## Overview

This repo provides a growing list of tools.

- CMake linter
- CXX linter
- Git hooks

This tools aim to support best coding practices like linting files, comfiguring
a Git pre-commit hook, etc.

The main motivation for developing these tools is to address an issue that
typically affects code bases that are organized into multiple repositories. In
the example of a CMake linter:

1. each repository may host a copy of the configuration that the linter must use
2. each repository may define a different version of the linter

Both elements contribute to introduce discrepencies in the code formatting and
make the maintenance of the code base across multiple repositories more
difficult.

The solution proposed is to define both tools and configurations in
one repository. This reposiutory can then be added as a Git submodule to
multiple repositories that will then benefit from the same tools and
configurations.

## Usage

If you want to use the tool versions and configurations defined in this
repository, simply add it as a git submodule to your projects.

```bash
git submodule add -b master https://github.com/tschaffter/cxx-dev-tools.git cxx-dev-tools
```

Run the following command to add the CXX dev tools to the PATH.

```bash
cd dev-cxx-tools && . export.sh
```

If you want to customize the tool versions and configuration, then fork this
repository before adding it as a submodule to your other projects.

## Tools

### cxxdt-cmake-lint

Check if the format of the specified CXX files is compliant with the CXX style
configuration defined in this repo.

```bash
$ cxxdt-cmake-lint test/cmake-lint/samples/invalid-format.cmake
test/cmake-lint/samples/invalid-format.cmake
============================================
test/cmake-lint/samples/invalid-format.cmake:10,04: [C0305] too many newlines between statements

Summary
=======
files scanned: 1
found lint:
  Convention: 1

$ echo $?
1

$ cxxdt-cmake-lint test/cmake-lint/samples/valid-format.cmake
test/cmake-lint/samples/valid-format.cmake
==========================================

Summary
=======
files scanned: 1
found lint:

$ echo $?
0
```

The exit status returned is 0 if the format of the file is valid.

If no CMake files are specified, `cxxdt-cmake-lint` tries to read a list CMake
files from `./.cxxdt-cmake-lint` (one file/file expression per line). The
following command is used in the CI configuration of this repo to check that the
CMake module `BuildType.cmake` is correctly formatted.

```
$ cxxdt-cmake-lint
cmake/BuildType.cmake
=====================

Summary
=======
files scanned: 1
found lint:

$ echo $?
0
```




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
