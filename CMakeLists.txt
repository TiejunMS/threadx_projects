# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

cmake_minimum_required(VERSION 3.13..3.22 FATAL_ERROR)
set(CMAKE_C_STANDARD 99)

# Define paths
set(BASE_DIR ${CMAKE_SOURCE_DIR})
set(LIBS_DIR ${BASE_DIR}/libs)

include(${BASE_DIR}/cmake/linux.cmake)

set(NX_USER_FILE ${CMAKE_SOURCE_DIR}/tx_user.h)

# Project
set(PROJECT AzureRTOS_Projects)
project(${PROJECT} VERSION 0.1.0 LANGUAGES C)

add_subdirectory(${LIBS_DIR}/threadx lib/threadx)
add_subdirectory(${BASE_DIR}/demo_tracex)

