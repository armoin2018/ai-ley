# CMakeLists.txt - Modern CMake practices
cmake_minimum_required(VERSION 3.20)

project(ModernCppProject 
    VERSION 1.0.0
    DESCRIPTION "A modern C++ project following best practices"
    LANGUAGES CXX
)

# Set C++ standard and compiler requirements
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Enable modern CMake features
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

# Compiler-specific options
if(MSVC)
    add_compile_options(/W4 /WX /permissive-)
    add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
else()
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
    
    # Additional GCC/Clang warnings
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        add_compile_options(-Wduplicated-cond -Wduplicated-branches -Wlogical-op)
    endif()
    
    if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
        add_compile_options(-Wlifetime -Wthread-safety)
    endif()
endif()

# Build types and configurations
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -DDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g -DNDEBUG")

# Find required packages
find_package(Threads REQUIRED)

# Optional packages
find_package(Boost QUIET COMPONENTS system filesystem)
find_package(fmt QUIET)

# Main library target
add_library(${PROJECT_NAME}_lib
    src/user_service.cpp
    src/database_connection.cpp
    src/async_task_manager.cpp
    src/thread_safe_queue.cpp
)

# Modern target-based configuration
target_include_directories(${PROJECT_NAME}_lib
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    PRIVATE
        src
)

target_compile_features(${PROJECT_NAME}_lib
    PUBLIC cxx_std_20
)

target_link_libraries(${PROJECT_NAME}_lib
    PUBLIC
        Threads::Threads
    PRIVATE
        $<$<TARGET_EXISTS:Boost::system>:Boost::system>
        $<$<TARGET_EXISTS:fmt::fmt>:fmt::fmt>
)

# Executable
add_executable(${PROJECT_NAME}
    src/main.cpp
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE ${PROJECT_NAME}_lib
)

# Testing
option(BUILD_TESTING "Build tests" ON)
if(BUILD_TESTING)
    enable_testing()
    
    find_package(GTest REQUIRED)
    
    add_executable(${PROJECT_NAME}_tests
        tests/test_user_service.cpp
        tests/test_database_connection.cpp
        tests/test_thread_safe_queue.cpp
    )
    
    target_link_libraries(${PROJECT_NAME}_tests
        PRIVATE
            ${PROJECT_NAME}_lib
            GTest::gtest_main
            GTest::gmock
    )
    
    include(GoogleTest)
    gtest_discover_tests(${PROJECT_NAME}_tests)
endif()

# Static analysis
option(ENABLE_STATIC_ANALYSIS "Enable static analysis tools" OFF)
if(ENABLE_STATIC_ANALYSIS)
    find_program(CLANG_TIDY_EXE NAMES clang-tidy)
    if(CLANG_TIDY_EXE)
        set_target_properties(${PROJECT_NAME}_lib PROPERTIES
            CXX_CLANG_TIDY "${CLANG_TIDY_EXE};-checks=*,-fuchsia-*,-google-*,-zircon-*,-abseil-*,-llvm-*"
        )
    endif()
    
    find_program(CPPCHECK_EXE NAMES cppcheck)
    if(CPPCHECK_EXE)
        set_target_properties(${PROJECT_NAME}_lib PROPERTIES
            CXX_CPPCHECK "${CPPCHECK_EXE};--enable=warning,performance,portability"
        )
    endif()
endif()

# Installation
install(TARGETS ${PROJECT_NAME}_lib ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)