set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "")

set(LLVM_TARGETS_TO_BUILD X86;ARM;AArch64 CACHE STRING "")
set(LLVM_ENABLE_ASSERTIONS ON CACHE BOOL "")
set(LLVM_ENABLE_EXPORTED_SYMBOLS_IN_EXECUTABLES OFF CACHE BOOL "")

set(LIBCXX_ENABLE_SHARED OFF CACHE BOOL "")
set(LIBCXX_ENABLE_STATIC OFF CACHE BOOL "")