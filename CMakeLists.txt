project(adaside)

cmake_minimum_required(VERSION 3.1)

# Configure use of Qt

find_package(Qt5 REQUIRED COMPONENTS Core)

add_definitions(${Qt5Core_DEFINITIONS})
add_definitions(-fPIC)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Configure use of LLVM/Clang

EXEC_PROGRAM("llvm-config" ARGS "--prefix" OUTPUT_VARIABLE CLANG_DIR)
set(CLANG_DIR_SOURCE "llvm-config")

if ("${CLANG_DIR}" STREQUAL "")
    message(FATAL_ERROR "Unable to detect CLANG location by checking LLVM_INSTALL_DIR, CLANG_INSTALL_DIR or running llvm-config.")
elseif (NOT IS_DIRECTORY ${CLANG_DIR})
    message(FATAL_ERROR "${CLANG_DIR} detected by ${CLANG_DIR_SOURCE} does not exist.")
endif()

set(CLANG_EXTRA_INCLUDES ${CLANG_DIR}/include)

add_subdirectory(sources/ApiExtractor)
