# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

cmake_minimum_required(VERSION 3.13..3.22 FATAL_ERROR)
set(CMAKE_C_STANDARD 99)

# Project
set(PROJECT demo_tracex)
project(${PROJECT} VERSION 0.1.0 LANGUAGES C)

add_executable(${PROJECT} sample_threadx.c)

target_link_libraries(${PROJECT} PUBLIC azrtos::threadx)
