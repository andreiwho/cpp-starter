#!/bin/bash
export CONAN_USER_HOME=$(pwd)/bin/conan/$1
CC=clang CXX=clang++ conan install . -pr ./profiles/default_linux -s build_type=$1 -if ./bin/conan --build missing -s compiler.libcxx=libstdc++11