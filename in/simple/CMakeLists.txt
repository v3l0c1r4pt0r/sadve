# Copyright (C) 2018 Kamil Lorenc
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.
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
