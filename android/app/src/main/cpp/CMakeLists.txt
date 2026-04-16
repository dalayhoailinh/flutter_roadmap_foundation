# android/app/src/main/cpp/CMakeLists.txt
# Tells the Android NDK (C compiler toolchain) how to build our C code
# into a shared library (.so file) that can be loaded at runtime.

cmake_minimum_required(VERSION 3.18.1)
project("native_math")

# add_library declares what we're building:
#   mathplugin = the library name  →  Android will produce "libmathplugin.so"
#   SHARED     = dynamically linked (.so), loaded at app startup
#   native_math.c = our source file
add_library(
    mathplugin
    SHARED
    native_math.c
)