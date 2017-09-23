project(adaside)

cmake_minimum_required(VERSION 3.1)

# Configure use of Qt

find_package(Qt5 REQUIRED COMPONENTS Core)

add_definitions(${Qt5Core_DEFINITIONS})
add_definitions(-fPIC)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_FLAGS "-g")

# Configure use of LLVM/Clang

EXEC_PROGRAM("llvm-config" ARGS "--prefix" OUTPUT_VARIABLE CLANG_DIR)
set(CLANG_DIR_SOURCE "llvm-config")

if ("${CLANG_DIR}" STREQUAL "")
    message(FATAL_ERROR "Unable to detect CLANG location by checking LLVM_INSTALL_DIR, CLANG_INSTALL_DIR or running llvm-config.")
elseif (NOT IS_DIRECTORY ${CLANG_DIR})
    message(FATAL_ERROR "${CLANG_DIR} detected by ${CLANG_DIR_SOURCE} does not exist.")
endif()

set(CLANG_EXTRA_INCLUDES ${CLANG_DIR}/include)

find_library(CLANG_LIBRARY clang HINTS ${CLANG_DIR}/lib)
if (NOT EXISTS ${CLANG_LIBRARY})
    message(FATAL_ERROR "Unable to find Clang library ${CLANG_LIB_NAME} in ${CLANG_DIR}.")
endif()

message(STATUS "CLANG: ${CLANG_DIR}, ${CLANG_LIBRARY} detected by ${CLANG_DIR_SOURCE}")

# Find highest version clang builtin includes folder to pass along to shiboken.
set(CLANG_BUILTIN_INCLUDES_DIR_PREFIX ${CLANG_DIR}/lib/clang)
file(GLOB CLANG_BUILTIN_INCLUDES_DIR_VERSIONS "${CLANG_BUILTIN_INCLUDES_DIR_PREFIX}/*")

# Sort in alphabetical order the list of version folders.
list(SORT CLANG_BUILTIN_INCLUDES_DIR_VERSIONS)

# Reverse it so the first element is the highest version.
list(REVERSE CLANG_BUILTIN_INCLUDES_DIR_VERSIONS)

message(STATUS "Found the following CLANG builtins includes directories: ${CLANG_BUILTIN_INCLUDES_DIR_VERSIONS}")
if(CLANG_BUILTIN_INCLUDES_DIR_VERSIONS)
    # Get highest version.
    list(GET CLANG_BUILTIN_INCLUDES_DIR_VERSIONS 0 CLANG_BUILTIN_INCLUDES_DIR_HIGHEST_VERSION)
    if (CLANG_BUILTIN_INCLUDES_DIR_HIGHEST_VERSION)
        # Set the final variable to the full include path to pass along to shiboken.
        set(CLANG_BUILTIN_INCLUDES_DIR "${CLANG_BUILTIN_INCLUDES_DIR_HIGHEST_VERSION}/include")
    endif()
endif()
message(STATUS "CLANG builtins includes directory chosen: ${CLANG_BUILTIN_INCLUDES_DIR}")

add_subdirectory(sources/ApiExtractor)

# Configure GNAT project files

string(REPLACE ";" "\", \"-I" QT_INCLUDE_SWITCHES "${Qt5Core_INCLUDE_DIRS}")
string(CONCAT QT_INCLUDE_SWITCHES "\"-I" ${QT_INCLUDE_SWITCHES} "\"")

get_target_property(Qt5Core_IMPORTED_LOCATION Qt5::Core IMPORTED_LOCATION_RELEASE)

set(CXX_COMPILER_SWITCHES ${QT_INCLUDE_SWITCHES})
configure_file(gnat/config.gpr.in gnat/config.gpr @ONLY)
configure_file(sources/generator/ada_side-config.ads.in sources/generator/ada_side-config.ads @ONLY)

# Prepare project files search paths switches

list(APPEND GPRBUILD_GRP_FLAGS "-aP${PROJECT_BINARY_DIR}/gnat")
list(APPEND GPRBUILD_GRP_FLAGS "-aP${PROJECT_SOURCE_DIR}/gnat")

# Run GPRbuild to build binding library

add_custom_target(binding ALL COMMAND "gprbuild" ${GPRBUILD_GRP_FLAGS} "-p" "-Papi_extractor")
add_dependencies(binding apiextractor)
add_custom_target(adaside ALL COMMAND "gprbuild" ${GPRBUILD_GRP_FLAGS} "-p" "-Pada_side")
add_dependencies(adaside binding)
