# Copyright 2021 The IREE Authors
#
# Licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

# iree_runtime_runtime -> iree::hal::drivers dependency requires threading
# TODO(#4298): Separate HAL driver registration from threading.
if(NOT ${IREE_ENABLE_THREADING})
  return()
endif()

set(_NAME "iree_samples_dynamic_shapes")
add_executable(${_NAME} "")
target_sources(${_NAME}
  PRIVATE
    main.c
)

set_target_properties(${_NAME} PROPERTIES OUTPUT_NAME "dynamic-shapes")

target_link_libraries(${_NAME}
  iree_runtime_runtime
)
