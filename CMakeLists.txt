cmake_minimum_required(VERSION 3.10)


set(PROJECT_SRC_DIR src CACHE STRING "The path to glob all source files")

set(PROJECT_OUTPUT_DIR bin CACHE STRING "The path to output binaries")
set(PROJECT_OBJECT_DIR obj CACHE STRING "The path to output intermediates")

set(
    CXX_SOURCE_EXTENSION 
        cpp 
    CACHE STRING "All project source files will have this extension"
)

set(
    CXX_HEADER_EXTENSION 
        h 
    CACHE STRING "All project header files will have this extension"
)


project(cppg)
    # Look for conan file
    message("---- Looking for Conan file")
    find_file(CONAN_FILE 
        conanbuildinfo.cmake
        HINTS bin/conan)
    if(EXISTS ${CONAN_FILE})
        message("---- Conan directory found")
        include(${CMAKE_SOURCE_DIR}/bin/conan/conanbuildinfo.cmake)
        conan_basic_setup()
        message("---- Conan dependencies setup")
    else()
        message(FATAL_ERROR "---- Conan directory not found. Please run configure.[bat/sh] [Debug/Release]")
    endif()

    # Search for all cpp files inside the PROHECT_SRC_DIR
    file(GLOB_RECURSE PROJECT_SOURCES "${PROJECT_SRC_DIR}/*.${CXX_SOURCE_EXTENSION}" LIST_DIRECTORIES True)
    file(GLOB_RECURSE PROJECT_HEADERS "${PROJECT_SRC_DIR}/*.${CXX_HEADER_EXTENSION}" LIST_DIRECTORIES True)

    # Add the executable to the project
    add_executable(cppg ${PROJECT_SOURCES} ${PROJECT_HEADERS})

    target_link_libraries(cppg PUBLIC ${CONAN_LIBS})

    set_target_properties(
        cppg 
            PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/${PROJECT_OUTPUT_DIR}/${PROJECT_NAME}
    )

