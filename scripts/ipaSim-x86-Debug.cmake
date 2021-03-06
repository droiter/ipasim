list (APPEND CMAKE_MODULE_PATH "${SOURCE_DIR}/scripts")
include (CommonVariables)

file (MAKE_DIRECTORY "${DEBUG_IPASIM_CMAKE_DIR}")
execute_process (
    COMMAND "${CMAKE_COMMAND}" -G Ninja
        -DSUPERBUILD=Off
        "-DCMAKE_C_COMPILER=${CLANG_EXE}"
        -DCMAKE_C_COMPILER_ID=Clang
        "-DCMAKE_CXX_COMPILER=${CLANG_EXE}"
        -DCMAKE_CXX_COMPILER_ID=Clang
        "-DCMAKE_LINKER=${LLD_LINK_EXE}"
        "-DCMAKE_AR=${LLVM_BIN_DIR}/llvm-ar.exe"
        -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY
        "-DSOURCE_DIR=${SOURCE_DIR}"
        "-DBINARY_DIR=${BINARY_DIR}"
        -DCMAKE_EXPORT_COMPILE_COMMANDS=On
        -DCMAKE_BUILD_TYPE=Debug
        # Build 32 bit binaries with debugging symbols that Visual Studio
        # understands. See also
        # https://gitlab.kitware.com/cmake/cmake/issues/16259#note_158150.
        "-DCMAKE_C_FLAGS=-m32 -gcodeview"
        "-DCMAKE_CXX_FLAGS=-m32 -gcodeview"
        "${SOURCE_DIR}"
    WORKING_DIRECTORY "${DEBUG_IPASIM_CMAKE_DIR}")
