set CONAN_USER_HOME=%cd%\bin\conan\%1
conan install . -s build_type=%1 -if ./bin/conan --build * --build=missing