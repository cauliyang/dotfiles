return {

    -- NOTE: cmake template <06-03-23, Yangyang Li>
    s(
        { trig = "cmake", dscr = "cmake" },
        fmta(
            [[
            cmake_minimum_required(
              VERSION 3.8
              # CXX_STANDARD 17
            )

            set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

            project(
              <>
              # LANGUAGES C CXX
            )

            add_executable(
              ${PROJECT_NAME}
              main.cpp
            )

            set_target_properties(
              ${PROJECT_NAME}
              PROPERTIES
              CXX_STANDARD 17
              CXX_STANDARD_REQUIRED ON
            )
        ]],
            {
                i(1, "project name"),
            }
        )
    ),

    -- NOTE: make template <06-03-23, Yangyang Li>
    s(
        { trig = "makefile", dscr = "cpp" },
        fmta(
            [[
            .PHONY: main configure-debug build test clean format

            main: configure-debug build

            release: clean configure-release build

            configure-debug:
                cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug

            configure-release:
                cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release

            build:
                cmake --build build

            test: configure-debug build
                ctest --test-dir build/test --output-on-failure

            clean:
                cmake --build build --target clean

            format:

            lint:
                <>
        ]],
            {
                i(1, "project name"),
            }
        )
    ),
    s(
        { trig = "clang-tidy", dscr = "clang-tidy" },
        fmta([[Checks: "<>"]], {
            i(
                1,
                "clang-diagnostic-*,clang-analyzer-*,cppcoreguidelines-*,modernize-*,-modernize-use-trailing-return-type,bugprone-*,concurrency-*,hicpp-*,performance-*"
            ),
        })
    ),
}
