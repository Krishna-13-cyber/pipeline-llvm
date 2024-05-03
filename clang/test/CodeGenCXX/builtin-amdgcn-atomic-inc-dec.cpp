// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: amdgpu-registered-target
// RUN: %clang_cc1 %s -x hip -fcuda-is-device -emit-llvm -O0 -o - \
// RUN:   -triple=amdgcn-amd-amdhsa | FileCheck %s

// CHECK-LABEL: @_Z29test_non_volatile_parameter32Pj(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[PTR_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[RES:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    [[PTR_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[PTR_ADDR]] to ptr
// CHECK-NEXT:    [[RES_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[RES]] to ptr
// CHECK-NEXT:    store ptr [[PTR:%.*]], ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[TMP1]], align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw uinc_wrap ptr [[TMP0]], i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr [[RES_ASCAST]], align 4
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[TMP5]], align 4
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr [[TMP4]], i32 [[TMP6]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP7]], ptr [[RES_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_non_volatile_parameter32(__UINT32_TYPE__ *ptr) {
  __UINT32_TYPE__ res;
  res = __builtin_amdgcn_atomic_inc32(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");

  res = __builtin_amdgcn_atomic_dec32(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z29test_non_volatile_parameter64Py(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[PTR_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[RES:%.*]] = alloca i64, align 8, addrspace(5)
// CHECK-NEXT:    [[PTR_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[PTR_ADDR]] to ptr
// CHECK-NEXT:    [[RES_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[RES]] to ptr
// CHECK-NEXT:    store ptr [[PTR:%.*]], ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr [[TMP1]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw uinc_wrap ptr [[TMP0]], i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr [[RES_ASCAST]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load i64, ptr [[TMP5]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr [[TMP4]], i64 [[TMP6]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP7]], ptr [[RES_ASCAST]], align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_non_volatile_parameter64(__UINT64_TYPE__ *ptr) {
  __UINT64_TYPE__ res;
  res = __builtin_amdgcn_atomic_inc64(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");

  res = __builtin_amdgcn_atomic_dec64(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z25test_volatile_parameter32PVj(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[PTR_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[RES:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    [[PTR_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[PTR_ADDR]] to ptr
// CHECK-NEXT:    [[RES_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[RES]] to ptr
// CHECK-NEXT:    store ptr [[PTR:%.*]], ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load volatile i32, ptr [[TMP1]], align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw volatile uinc_wrap ptr [[TMP0]], i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr [[RES_ASCAST]], align 4
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load volatile i32, ptr [[TMP5]], align 4
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw volatile udec_wrap ptr [[TMP4]], i32 [[TMP6]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP7]], ptr [[RES_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_volatile_parameter32(volatile __UINT32_TYPE__ *ptr) {
  __UINT32_TYPE__ res;
  res = __builtin_amdgcn_atomic_inc32(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");

  res = __builtin_amdgcn_atomic_dec32(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z25test_volatile_parameter64PVy(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[PTR_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-NEXT:    [[RES:%.*]] = alloca i64, align 8, addrspace(5)
// CHECK-NEXT:    [[PTR_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[PTR_ADDR]] to ptr
// CHECK-NEXT:    [[RES_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[RES]] to ptr
// CHECK-NEXT:    store ptr [[PTR:%.*]], ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load volatile i64, ptr [[TMP1]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw volatile uinc_wrap ptr [[TMP0]], i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr [[RES_ASCAST]], align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = load ptr, ptr [[PTR_ADDR_ASCAST]], align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load volatile i64, ptr [[TMP5]], align 8
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw volatile udec_wrap ptr [[TMP4]], i64 [[TMP6]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP7]], ptr [[RES_ASCAST]], align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_volatile_parameter64(volatile __UINT64_TYPE__ *ptr) {
  __UINT64_TYPE__ res;
  res = __builtin_amdgcn_atomic_inc64(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");

  res = __builtin_amdgcn_atomic_dec64(ptr, *ptr, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z13test_shared32v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), i32 [[TMP0]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared32vE3val to ptr), align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_shared32() {
  __attribute__((shared)) __UINT32_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc32(&val, val, __ATOMIC_SEQ_CST, "workgroup");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z13test_shared64v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), i64 [[TMP0]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ13test_shared64vE3val to ptr), align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_shared64() {
  __attribute__((shared)) __UINT64_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc64(&val, val, __ATOMIC_SEQ_CST, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_SEQ_CST, "workgroup");
}

__attribute__((device)) __UINT32_TYPE__ global_val32;
// CHECK-LABEL: @_Z13test_global32v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), i32 [[TMP0]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP1]], ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr addrspacecast (ptr addrspace(1) @global_val32 to ptr), align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_global32() {
  global_val32 = __builtin_amdgcn_atomic_inc32(&global_val32, global_val32, __ATOMIC_SEQ_CST, "workgroup");

  global_val32 = __builtin_amdgcn_atomic_dec32(&global_val32, global_val32, __ATOMIC_SEQ_CST, "workgroup");
}

__attribute__((device)) __UINT64_TYPE__ global_val64;
// CHECK-LABEL: @_Z13test_global64v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), i64 [[TMP0]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP1]], ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr addrspacecast (ptr addrspace(1) @global_val64 to ptr), align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_global64() {
  global_val64 = __builtin_amdgcn_atomic_inc64(&global_val64, global_val64, __ATOMIC_SEQ_CST, "workgroup");

  global_val64 = __builtin_amdgcn_atomic_dec64(&global_val64, global_val64, __ATOMIC_SEQ_CST, "workgroup");
}

__attribute__((constant)) __UINT32_TYPE__ cval32;
// CHECK-LABEL: @_Z15test_constant32v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[LOCAL_VAL:%.*]] = alloca i32, align 4, addrspace(5)
// CHECK-NEXT:    [[LOCAL_VAL_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[LOCAL_VAL]] to ptr
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspacecast (ptr addrspace(4) @cval32 to ptr), align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(4) @cval32 to ptr), i32 [[TMP0]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP1]], ptr [[LOCAL_VAL_ASCAST]], align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspacecast (ptr addrspace(4) @cval32 to ptr), align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(4) @cval32 to ptr), i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr [[LOCAL_VAL_ASCAST]], align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_constant32() {
  __UINT32_TYPE__ local_val;

  local_val = __builtin_amdgcn_atomic_inc32(&cval32, cval32, __ATOMIC_SEQ_CST, "workgroup");

  local_val = __builtin_amdgcn_atomic_dec32(&cval32, cval32, __ATOMIC_SEQ_CST, "workgroup");
}

__attribute__((constant)) __UINT64_TYPE__ cval64;
// CHECK-LABEL: @_Z15test_constant64v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[LOCAL_VAL:%.*]] = alloca i64, align 8, addrspace(5)
// CHECK-NEXT:    [[LOCAL_VAL_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[LOCAL_VAL]] to ptr
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr addrspacecast (ptr addrspace(4) @cval64 to ptr), align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(4) @cval64 to ptr), i64 [[TMP0]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP1]], ptr [[LOCAL_VAL_ASCAST]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr addrspacecast (ptr addrspace(4) @cval64 to ptr), align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(4) @cval64 to ptr), i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr [[LOCAL_VAL_ASCAST]], align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_constant64() {
  __UINT64_TYPE__ local_val;

  local_val = __builtin_amdgcn_atomic_inc64(&cval64, cval64, __ATOMIC_SEQ_CST, "workgroup");

  local_val = __builtin_amdgcn_atomic_dec64(&cval64, cval64, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z12test_order32v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP0]] syncscope("workgroup") monotonic, align 4
// CHECK-NEXT:    store i32 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP2]] syncscope("workgroup") acquire, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP5:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP4]] syncscope("workgroup") acquire, align 4
// CHECK-NEXT:    store i32 [[TMP5]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP6]] syncscope("workgroup") release, align 4
// CHECK-NEXT:    store i32 [[TMP7]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP9:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP8]] syncscope("workgroup") acq_rel, align 4
// CHECK-NEXT:    store i32 [[TMP9]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP11:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), i32 [[TMP10]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP11]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order32vE3val to ptr), align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_order32() {
  __attribute__((shared)) __UINT32_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc32(&val, val, __ATOMIC_RELAXED, "workgroup");

  val = __builtin_amdgcn_atomic_inc32(&val, val, __ATOMIC_CONSUME, "workgroup");

  val = __builtin_amdgcn_atomic_inc32(&val, val, __ATOMIC_ACQUIRE, "workgroup");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_RELEASE, "workgroup");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_ACQ_REL, "workgroup");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z12test_order64v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP0]] syncscope("workgroup") monotonic, align 8
// CHECK-NEXT:    store i64 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP2]] syncscope("workgroup") acquire, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP5:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP4]] syncscope("workgroup") acquire, align 8
// CHECK-NEXT:    store i64 [[TMP5]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP6]] syncscope("workgroup") release, align 8
// CHECK-NEXT:    store i64 [[TMP7]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP8:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP9:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP8]] syncscope("workgroup") acq_rel, align 8
// CHECK-NEXT:    store i64 [[TMP9]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP10:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP11:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), i64 [[TMP10]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP11]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_order64vE3val to ptr), align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_order64() {
  __attribute__((shared)) __UINT64_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc64(&val, val, __ATOMIC_RELAXED, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_CONSUME, "workgroup");

  val = __builtin_amdgcn_atomic_inc64(&val, val, __ATOMIC_ACQUIRE, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_RELEASE, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_ACQ_REL, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_SEQ_CST, "workgroup");
}

// CHECK-LABEL: @_Z12test_scope32v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), i32 [[TMP0]] seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), i32 [[TMP2]] syncscope("workgroup") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP5:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), i32 [[TMP4]] syncscope("agent") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP5]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), i32 [[TMP6]] syncscope("wavefront") seq_cst, align 4
// CHECK-NEXT:    store i32 [[TMP7]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope32vE3val to ptr), align 4
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_scope32() {
  __attribute__((shared)) __UINT32_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc32(&val, val, __ATOMIC_SEQ_CST, "");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_SEQ_CST, "workgroup");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_SEQ_CST, "agent");

  val = __builtin_amdgcn_atomic_dec32(&val, val, __ATOMIC_SEQ_CST, "wavefront");
}

// CHECK-LABEL: @_Z12test_scope64v(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw uinc_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), i64 [[TMP0]] seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP1]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP2:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP3:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), i64 [[TMP2]] syncscope("workgroup") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP3]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP4:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP5:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), i64 [[TMP4]] syncscope("agent") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP5]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP6:%.*]] = load i64, ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    [[TMP7:%.*]] = atomicrmw udec_wrap ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), i64 [[TMP6]] syncscope("wavefront") seq_cst, align 8
// CHECK-NEXT:    store i64 [[TMP7]], ptr addrspacecast (ptr addrspace(3) @_ZZ12test_scope64vE3val to ptr), align 8
// CHECK-NEXT:    ret void
//
__attribute__((device)) void test_scope64() {
  __attribute__((shared)) __UINT64_TYPE__ val;

  val = __builtin_amdgcn_atomic_inc64(&val, val, __ATOMIC_SEQ_CST, "");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_SEQ_CST, "workgroup");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_SEQ_CST, "agent");

  val = __builtin_amdgcn_atomic_dec64(&val, val, __ATOMIC_SEQ_CST, "wavefront");
}