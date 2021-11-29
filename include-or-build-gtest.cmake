include(${CMAKE_CURRENT_LIST_DIR}/log.cmake)

# 3.14 is required for FetchContent
cmake_minimum_required(VERSION 3.14)

find_package(PkgConfig)

set(prefix __ld_gtest)
# 1.11.0 introduced various matchers that can be used with EXPECT_THAT (e.g., ThrowsMessage)
set(required_version 1.11.0)

pkg_check_modules(${prefix} gtest>=${required_version} IMPORTED_TARGET)

if(TARGET gtest)
    __cmake_scripts_log("target gtest found, not setting up again")
else()
    if(${prefix}_FOUND)
        __cmake_scripts_log("Using system gtest")
        add_library(gtest ALIAS PkgConfig::${prefix})
    else()
        __cmake_scripts_log("googletest not found or too old on system, fetching from GitHub")

        include(FetchContent)

        FetchContent_Declare(
            ${prefix}
            GIT_REPOSITORY https://github.com/google/googletest.git
            GIT_TAG release-${required_version}
        )

        FetchContent_MakeAvailable(${prefix})
    endif()
endif()
