# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# Define the CPU architecture for ThreadX
set(THREADX_ARCH "linux")
set(THREADX_TOOLCHAIN "gnu")

# Use vcpkg toolchain file
set(VCPKG_CMAKE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")
if (EXISTS ${VCPKG_CMAKE})
  set(CMAKE_TOOLCHAIN_FILE ${VCPKG_CMAKE}
      CACHE STRING "TEST")
  set(VCPKG_TARGET_TRIPLET "x86-${THREADX_ARCH}"
      CACHE STRING "default vcpkg triplet")
endif ()

# Perform compiler test with the static library
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(LINUX_FLAGS "-g -pthread")

set(CMAKE_C_FLAGS   "${LINUX_FLAGS} -m32" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS "${LINUX_FLAGS} -m32 -fno-rtti -fno-exceptions" CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS "${LINUX_FLAGS} -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS "${LINUX_FLAGS} ${LD_FLAGS} -Wl,--gc-sections" CACHE INTERNAL "exe link flags")

SET(CMAKE_C_FLAGS_DEBUG "-Og -g -ggdb3" CACHE INTERNAL "c debug compiler flags")
SET(CMAKE_CXX_FLAGS_DEBUG "-Og -g -ggdb3" CACHE INTERNAL "cxx debug compiler flags")
SET(CMAKE_ASM_FLAGS_DEBUG "-g -ggdb3" CACHE INTERNAL "asm debug compiler flags")

SET(CMAKE_C_FLAGS_RELEASE "-O3" CACHE INTERNAL "c release compiler flags")
SET(CMAKE_CXX_FLAGS_RELEASE "-O3" CACHE INTERNAL "cxx release compiler flags")
SET(CMAKE_ASM_FLAGS_RELEASE "" CACHE INTERNAL "asm release compiler flags")
