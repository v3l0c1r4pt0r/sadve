cmake_minimum_required (VERSION 3.0)
project (simple)

set(OUTPUT_INCLUDE $ENV{OUTPUT_INCLUDE})
set(OUTPUT_SYMBOL $ENV{OUTPUT_SYMBOL})
set(OUTPUT_COMMAND $ENV{OUTPUT_COMMAND})
set(OUTPUT_TYPE $ENV{OUTPUT_TYPE})

if (NOT DEFINED OUTPUT_INCLUDE OR
    NOT DEFINED OUTPUT_SYMBOL OR
    NOT DEFINED OUTPUT_COMMAND OR
    NOT DEFINED OUTPUT_TYPE)
  message(FATAL_ERROR "At least one of OUTPUT_INCLUDE, OUTPUT_SYMBOL or OUTPUT_TYPE variable not defined. Stopping.")
endif()

configure_file(simple.c.in ${CMAKE_BINARY_DIR}/simple.c)
add_executable(simple_${OUTPUT_SYMBOL} ${CMAKE_BINARY_DIR}/simple.c)
add_custom_target(run COMMAND echo BEGIN && ${CMAKE_BINARY_DIR}/simple_${OUTPUT_SYMBOL} && echo END)
