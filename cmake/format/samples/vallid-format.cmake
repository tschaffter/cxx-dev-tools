# Set a default build type if none was specified
set(DEFAULT_BUILD_TYPE "Release")
if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
    set(DEFAULT_BUILD_TYPE "Debug")
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${DEFAULT_BUILD_TYPE}' as none
            was specified.")

    set(CMAKE_BUILD_TYPE
        ${DEFAULT_BUILD_TYPE}
        CACHE STRING "Choose the type of build." FORCE)
endif()
