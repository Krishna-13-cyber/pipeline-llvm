; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=atomic-expand %s | FileCheck %s

; Test that system scoped atomicrmw or 0 is transformed to add 0.

; Transform to add
define i32 @test_atomicrmw_or_0_global_system(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 seq_cst, align 4, !foo.md [[META0:![0-9]+]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 0 seq_cst, !foo.md !0
  ret i32 %res
}

; Transform to add
define i32 @test_atomicrmw_or_0_global_one_as(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_global_one_as(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 syncscope("one-as") seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 0 syncscope("one-as") seq_cst
  ret i32 %res
}

; Transform to add
define i32 @test_atomicrmw_or_0_flat_system(ptr %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_flat_system(
; CHECK-SAME: ptr [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr [[PTR]], i32 0 seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr %ptr, i32 0 seq_cst
  ret i32 %res
}

; Transform to add
define i32 @test_atomicrmw_or_0_as999_system(ptr addrspace(999) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_as999_system(
; CHECK-SAME: ptr addrspace(999) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(999) [[PTR]], i32 0 seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(999) %ptr, i32 0 seq_cst
  ret i32 %res
}

; Leave as-is, only system scope should be changed.
define i32 @test_atomicrmw_or_0_global_agent(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_global_agent(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw or ptr addrspace(1) [[PTR]], i32 0 syncscope("agent") seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 0 syncscope("agent") seq_cst
  ret i32 %res
}

; Leave as-is, LDS atomics aren't relevant.
define i32 @test_atomicrmw_or_0_local(ptr addrspace(3) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_local(
; CHECK-SAME: ptr addrspace(3) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw or ptr addrspace(3) [[PTR]], i32 0 seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(3) %ptr, i32 0 seq_cst
  ret i32 %res
}

; Leave non-0 values alone.
define i32 @test_atomicrmw_or_1_global_system(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_1_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw or ptr addrspace(1) [[PTR]], i32 1 seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 1 seq_cst
  ret i32 %res
}

define i32 @test_atomicrmw_or_var_global_system(ptr addrspace(1) %ptr, i32 %val) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_var_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]], i32 [[VAL:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw or ptr addrspace(1) [[PTR]], i32 [[VAL]] seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 %val seq_cst
  ret i32 %res
}

; Leave as-is
define i32 @test_atomicrmw_add_0_global_system(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_add_0_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 seq_cst, align 4
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw add ptr addrspace(1) %ptr, i32 0 seq_cst
  ret i32 %res
}

; Transform to add
define i32 @test_atomicrmw_sub_0_global_system(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_sub_0_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 seq_cst, align 4, !foo.md [[META0]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw sub ptr addrspace(1) %ptr, i32 0 seq_cst, !foo.md !0
  ret i32 %res
}

; Transform to add
define i32 @test_atomicrmw_xor_0_global_system(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_xor_0_global_system(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 seq_cst, align 4, !foo.md [[META0]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw xor ptr addrspace(1) %ptr, i32 0 seq_cst, !foo.md !0
  ret i32 %res
}


define i32 @test_atomicrmw_or_0_global_system__metadata(ptr addrspace(1) %ptr) {
; CHECK-LABEL: define i32 @test_atomicrmw_or_0_global_system__metadata(
; CHECK-SAME: ptr addrspace(1) [[PTR:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add ptr addrspace(1) [[PTR]], i32 0 seq_cst, align 4, !amdgpu.no.fine.grained.memory [[META0]], !amdgpu.no.remote.memory.access [[META0]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = atomicrmw or ptr addrspace(1) %ptr, i32 0 seq_cst, !amdgpu.no.fine.grained.memory !0, !amdgpu.no.remote.memory.access !0
  ret i32 %res
}

!0 = !{}
;.
; CHECK: [[META0]] = !{}
;.