// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Tests folding and canonicalization of casting/conversion ops.

// RUN: iree-opt -split-input-file -pass-pipeline='vm.module(canonicalize)' %s | IreeFileCheck %s

// CHECK-LABEL: @trunc_folds
vm.module @trunc_folds {
  // CHECK-LABEL: @trunc_i8_const
  vm.func @trunc_i8_const() -> i32 {
    // CHECK: vm.const.i32 255 : i32
    %c = vm.const.i32 0xFFFFFFFF : i32
    %0 = vm.trunc.i8 %c : i32
    vm.return %0 : i32
  }

  // CHECK-LABEL: @trunc_i16_const
  vm.func @trunc_i16_const() -> i32 {
    // CHECK: vm.const.i32 65535 : i32
    %c = vm.const.i32 0xFFFFFFFF : i32
    %0 = vm.trunc.i16 %c : i32
    vm.return %0 : i32
  }
}

// -----

// CHECK-LABEL: @ext_folds
vm.module @ext_folds {
  // CHECK-LABEL: @ext_i8_i32_s_const
  vm.func @ext_i8_i32_s_const() -> i32 {
    // CHECK: vm.const.i32 -1 : i32
    %c = vm.const.i32 0x000000FF : i32
    %0 = vm.ext.i8.i32.s %c : i32
    vm.return %0 : i32
  }

  // CHECK-LABEL: @ext_i16_i32_s_const
  vm.func @ext_i16_i32_s_const() -> i32 {
    // CHECK: vm.const.i32 -1 : i32
    %c = vm.const.i32 0x0000FFFF : i32
    %0 = vm.ext.i16.i32.s %c : i32
    vm.return %0 : i32
  }
}
