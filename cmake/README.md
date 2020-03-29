# Developing with CMake

## Tools

- cxxdt-cmake-lint
- cxxdt-cmake-format

These tools use the following configurations:

- config/.cmake-format.json - Default configuration generated using `cmake-format`.
- config/.esp-idf-cmake-format.json - Configuration for linting ESP-IDF CMake
files.

See the project [README.md](../README.md) for more detailed information on how
to use these tools.

## CMake modules

- BuildType.cmake - Set a default build type if none was specified.