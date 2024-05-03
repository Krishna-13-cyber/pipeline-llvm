; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-NOFP --check-prefix=CHECK-NOFP-SD
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon,+fullfp16 | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-FP --check-prefix=CHECK-FP-SD
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon -global-isel -global-isel-abort=2 2>&1 | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-NOFP --check-prefix=CHECK-NOFP-GI
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon,+fullfp16 -global-isel -global-isel-abort=2 2>&1 | FileCheck %s --check-prefix=CHECK --check-prefix=CHECK-FP --check-prefix=CHECK-FP-GI

; CHECK-NOFP-GI:       warning: Instruction selection used fallback path for test_v11f16
; CHECK-NOFP-GI-NEXT:  warning: Instruction selection used fallback path for test_v11f16_ninf
; CHECK-NOFP-GI-NEXT:  warning: Instruction selection used fallback path for test_v3f32
; CHECK-NOFP-GI-NEXT:  warning: Instruction selection used fallback path for test_v3f32_ninf
; CHECK-NOFP-GI-NEXT:  warning: Instruction selection used fallback path for test_v2f128
;
; CHECK-FP-GI:       warning: Instruction selection used fallback path for test_v11f16
; CHECK-FP-GI-NEXT:  warning: Instruction selection used fallback path for test_v11f16_ninf
; CHECK-FP-GI-NEXT:  warning: Instruction selection used fallback path for test_v3f32
; CHECK-FP-GI-NEXT:  warning: Instruction selection used fallback path for test_v3f32_ninf
; CHECK-FP-GI-NEXT:  warning: Instruction selection used fallback path for test_v2f128

declare half @llvm.vector.reduce.fmin.v1f16(<1 x half> %a)
declare float @llvm.vector.reduce.fmin.v1f32(<1 x float> %a)
declare double @llvm.vector.reduce.fmin.v1f64(<1 x double> %a)
declare fp128 @llvm.vector.reduce.fmin.v1f128(<1 x fp128> %a)

declare half @llvm.vector.reduce.fmin.v4f16(<4 x half> %a)
declare half @llvm.vector.reduce.fmin.v8f16(<8 x half> %a)
declare half @llvm.vector.reduce.fmin.v16f16(<16 x half> %a)
declare float @llvm.vector.reduce.fmin.v2f32(<2 x float> %a)
declare float @llvm.vector.reduce.fmin.v4f32(<4 x float> %a)
declare float @llvm.vector.reduce.fmin.v8f32(<8 x float> %a)
declare float @llvm.vector.reduce.fmin.v16f32(<16 x float> %a)
declare double @llvm.vector.reduce.fmin.v2f64(<2 x double> %a)
declare double @llvm.vector.reduce.fmin.v4f64(<4 x double> %a)

declare half @llvm.vector.reduce.fmin.v11f16(<11 x half> %a)
declare float @llvm.vector.reduce.fmin.v3f32(<3 x float> %a)
declare fp128 @llvm.vector.reduce.fmin.v2f128(<2 x fp128> %a)

define half @test_v1f16(<1 x half> %a) nounwind {
; CHECK-LABEL: test_v1f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = call nnan half @llvm.vector.reduce.fmin.v1f16(<1 x half> %a)
  ret half %b
}

define float @test_v1f32(<1 x float> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v1f32:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NOFP-SD-NEXT:    // kill: def $s0 killed $s0 killed $q0
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-SD-LABEL: test_v1f32:
; CHECK-FP-SD:       // %bb.0:
; CHECK-FP-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-FP-SD-NEXT:    // kill: def $s0 killed $s0 killed $q0
; CHECK-FP-SD-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v1f32:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    // kill: def $s0 killed $s0 killed $d0
; CHECK-NOFP-GI-NEXT:    ret
;
; CHECK-FP-GI-LABEL: test_v1f32:
; CHECK-FP-GI:       // %bb.0:
; CHECK-FP-GI-NEXT:    // kill: def $s0 killed $s0 killed $d0
; CHECK-FP-GI-NEXT:    ret
  %b = call nnan float @llvm.vector.reduce.fmin.v1f32(<1 x float> %a)
  ret float %b
}

define double @test_v1f64(<1 x double> %a) nounwind {
; CHECK-LABEL: test_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = call nnan double @llvm.vector.reduce.fmin.v1f64(<1 x double> %a)
  ret double %b
}

define fp128 @test_v1f128(<1 x fp128> %a) nounwind {
; CHECK-LABEL: test_v1f128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = call nnan fp128 @llvm.vector.reduce.fmin.v1f128(<1 x fp128> %a)
  ret fp128 %b
}

define half @test_v4f16(<4 x half> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v4f16:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NOFP-SD-NEXT:    mov h1, v0.h[1]
; CHECK-NOFP-SD-NEXT:    fcvt s2, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s2, s1
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[2]
; CHECK-NOFP-SD-NEXT:    mov h0, v0.h[3]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s0, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s0, s1, s0
; CHECK-NOFP-SD-NEXT:    fcvt h0, s0
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-LABEL: test_v4f16:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    fminnmv h0, v0.4h
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v4f16:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NOFP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-GI-NEXT:    fcvt h0, s0
; CHECK-NOFP-GI-NEXT:    ret
  %b = call nnan half @llvm.vector.reduce.fmin.v4f16(<4 x half> %a)
  ret half %b
}

define half @test_v4f16_ninf(<4 x half> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v4f16_ninf:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NOFP-SD-NEXT:    mov h1, v0.h[1]
; CHECK-NOFP-SD-NEXT:    fcvt s2, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s2, s1
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[2]
; CHECK-NOFP-SD-NEXT:    mov h0, v0.h[3]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s0, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s0, s1, s0
; CHECK-NOFP-SD-NEXT:    fcvt h0, s0
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-LABEL: test_v4f16_ninf:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    fminnmv h0, v0.4h
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v4f16_ninf:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-NOFP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-GI-NEXT:    fcvt h0, s0
; CHECK-NOFP-GI-NEXT:    ret
  %b = call nnan ninf half @llvm.vector.reduce.fmin.v4f16(<4 x half> %a)
  ret half %b
}

define half @test_v8f16(<8 x half> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v8f16:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    mov h1, v0.h[1]
; CHECK-NOFP-SD-NEXT:    fcvt s2, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s2, s1
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[2]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[3]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[4]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[5]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    mov h2, v0.h[6]
; CHECK-NOFP-SD-NEXT:    mov h0, v0.h[7]
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s0, h0
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s1, s1, s2
; CHECK-NOFP-SD-NEXT:    fcvt h1, s1
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s0, s1, s0
; CHECK-NOFP-SD-NEXT:    fcvt h0, s0
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-LABEL: test_v8f16:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    fminnmv h0, v0.8h
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v8f16:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    fcvtl v1.4s, v0.4h
; CHECK-NOFP-GI-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-NOFP-GI-NEXT:    fminnm v0.4s, v1.4s, v0.4s
; CHECK-NOFP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-GI-NEXT:    fcvt h0, s0
; CHECK-NOFP-GI-NEXT:    ret
  %b = call nnan half @llvm.vector.reduce.fmin.v8f16(<8 x half> %a)
  ret half %b
}

define half @test_v16f16(<16 x half> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v16f16:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    mov h2, v1.h[1]
; CHECK-NOFP-SD-NEXT:    mov h3, v0.h[1]
; CHECK-NOFP-SD-NEXT:    fcvt s4, h1
; CHECK-NOFP-SD-NEXT:    fcvt s5, h0
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcmp s3, s2
; CHECK-NOFP-SD-NEXT:    fcsel s2, s3, s2, lt
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    mov h4, v1.h[2]
; CHECK-NOFP-SD-NEXT:    mov h5, v0.h[2]
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcvt s4, h4
; CHECK-NOFP-SD-NEXT:    fcvt s5, h5
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fminnm s2, s3, s2
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    mov h4, v1.h[3]
; CHECK-NOFP-SD-NEXT:    mov h5, v0.h[3]
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt s4, h4
; CHECK-NOFP-SD-NEXT:    fcvt s5, h5
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fminnm s2, s2, s3
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    mov h4, v1.h[4]
; CHECK-NOFP-SD-NEXT:    mov h5, v0.h[4]
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt s4, h4
; CHECK-NOFP-SD-NEXT:    fcvt s5, h5
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fminnm s2, s2, s3
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    mov h4, v1.h[5]
; CHECK-NOFP-SD-NEXT:    mov h5, v0.h[5]
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt s4, h4
; CHECK-NOFP-SD-NEXT:    fcvt s5, h5
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fminnm s2, s2, s3
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    mov h4, v1.h[6]
; CHECK-NOFP-SD-NEXT:    mov h5, v0.h[6]
; CHECK-NOFP-SD-NEXT:    mov h1, v1.h[7]
; CHECK-NOFP-SD-NEXT:    mov h0, v0.h[7]
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt s4, h4
; CHECK-NOFP-SD-NEXT:    fcvt s5, h5
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fcvt s0, h0
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcmp s5, s4
; CHECK-NOFP-SD-NEXT:    fminnm s2, s2, s3
; CHECK-NOFP-SD-NEXT:    fcsel s3, s5, s4, lt
; CHECK-NOFP-SD-NEXT:    fcmp s0, s1
; CHECK-NOFP-SD-NEXT:    fcvt h3, s3
; CHECK-NOFP-SD-NEXT:    fcsel s0, s0, s1, lt
; CHECK-NOFP-SD-NEXT:    fcvt h2, s2
; CHECK-NOFP-SD-NEXT:    fcvt h0, s0
; CHECK-NOFP-SD-NEXT:    fcvt s3, h3
; CHECK-NOFP-SD-NEXT:    fcvt s2, h2
; CHECK-NOFP-SD-NEXT:    fcvt s0, h0
; CHECK-NOFP-SD-NEXT:    fminnm s2, s2, s3
; CHECK-NOFP-SD-NEXT:    fcvt h1, s2
; CHECK-NOFP-SD-NEXT:    fcvt s1, h1
; CHECK-NOFP-SD-NEXT:    fminnm s0, s1, s0
; CHECK-NOFP-SD-NEXT:    fcvt h0, s0
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-LABEL: test_v16f16:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    fminnm v0.8h, v0.8h, v1.8h
; CHECK-FP-NEXT:    fminnmv h0, v0.8h
; CHECK-FP-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v16f16:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-NOFP-GI-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-NOFP-GI-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-NOFP-GI-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-NOFP-GI-NEXT:    fminnm v0.4s, v2.4s, v0.4s
; CHECK-NOFP-GI-NEXT:    fminnm v1.4s, v3.4s, v1.4s
; CHECK-NOFP-GI-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-NOFP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-GI-NEXT:    fcvt h0, s0
; CHECK-NOFP-GI-NEXT:    ret
  %b = call nnan half @llvm.vector.reduce.fmin.v16f16(<16 x half> %a)
  ret half %b
}

define float @test_v2f32_ninf(<2 x float> %a) nounwind {
; CHECK-LABEL: test_v2f32_ninf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnmp s0, v0.2s
; CHECK-NEXT:    ret
  %b = call float @llvm.vector.reduce.fmin.v2f32(<2 x float> %a)
  ret float %b
}

define float @test_v4f32_ninf(<4 x float> %a) nounwind {
; CHECK-LABEL: test_v4f32_ninf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnmv s0, v0.4s
; CHECK-NEXT:    ret
  %b = call nnan ninf float @llvm.vector.reduce.fmin.v4f32(<4 x float> %a)
  ret float %b
}

define float @test_v8f32(<8 x float> %a) nounwind {
; CHECK-LABEL: test_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    fminnmv s0, v0.4s
; CHECK-NEXT:    ret
  %b = call nnan float @llvm.vector.reduce.fmin.v8f32(<8 x float> %a)
  ret float %b
}

define float @test_v16f32(<16 x float> %a) nounwind {
; CHECK-NOFP-SD-LABEL: test_v16f32:
; CHECK-NOFP-SD:       // %bb.0:
; CHECK-NOFP-SD-NEXT:    fminnm v1.4s, v1.4s, v3.4s
; CHECK-NOFP-SD-NEXT:    fminnm v0.4s, v0.4s, v2.4s
; CHECK-NOFP-SD-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-NOFP-SD-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-SD-NEXT:    ret
;
; CHECK-FP-SD-LABEL: test_v16f32:
; CHECK-FP-SD:       // %bb.0:
; CHECK-FP-SD-NEXT:    fminnm v1.4s, v1.4s, v3.4s
; CHECK-FP-SD-NEXT:    fminnm v0.4s, v0.4s, v2.4s
; CHECK-FP-SD-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-FP-SD-NEXT:    fminnmv s0, v0.4s
; CHECK-FP-SD-NEXT:    ret
;
; CHECK-NOFP-GI-LABEL: test_v16f32:
; CHECK-NOFP-GI:       // %bb.0:
; CHECK-NOFP-GI-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-NOFP-GI-NEXT:    fminnm v1.4s, v2.4s, v3.4s
; CHECK-NOFP-GI-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-NOFP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-NOFP-GI-NEXT:    ret
;
; CHECK-FP-GI-LABEL: test_v16f32:
; CHECK-FP-GI:       // %bb.0:
; CHECK-FP-GI-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-FP-GI-NEXT:    fminnm v1.4s, v2.4s, v3.4s
; CHECK-FP-GI-NEXT:    fminnm v0.4s, v0.4s, v1.4s
; CHECK-FP-GI-NEXT:    fminnmv s0, v0.4s
; CHECK-FP-GI-NEXT:    ret
  %b = call nnan float @llvm.vector.reduce.fmin.v16f32(<16 x float> %a)
  ret float %b
}

define double @test_v2f64(<2 x double> %a) nounwind {
; CHECK-LABEL: test_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnmp d0, v0.2d
; CHECK-NEXT:    ret
  %b = call double @llvm.vector.reduce.fmin.v2f64(<2 x double> %a)
  ret double %b
}

define double @test_v4f64(<4 x double> %a) nounwind {
; CHECK-LABEL: test_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fminnm v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    fminnmp d0, v0.2d
; CHECK-NEXT:    ret
  %b = call double @llvm.vector.reduce.fmin.v4f64(<4 x double> %a)
  ret double %b
}

define half @test_v11f16(<11 x half> %a) nounwind {
; CHECK-NOFP-LABEL: test_v11f16:
; CHECK-NOFP:       // %bb.0:
; CHECK-NOFP-NEXT:    ldr h16, [sp, #8]
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    ldr h17, [sp]
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt s2, h2
; CHECK-NOFP-NEXT:    adrp x8, .LCPI14_0
; CHECK-NOFP-NEXT:    fcvt s16, h16
; CHECK-NOFP-NEXT:    fcvt s17, h17
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s4, h4
; CHECK-NOFP-NEXT:    fcmp s1, s16
; CHECK-NOFP-NEXT:    fcsel s1, s1, s16, lt
; CHECK-NOFP-NEXT:    fcmp s0, s17
; CHECK-NOFP-NEXT:    ldr h16, [sp, #16]
; CHECK-NOFP-NEXT:    fcvt s16, h16
; CHECK-NOFP-NEXT:    fcsel s0, s0, s17, lt
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s2, s16
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fcsel s1, s2, s16, lt
; CHECK-NOFP-NEXT:    ldr h2, [x8, :lo12:.LCPI14_0]
; CHECK-NOFP-NEXT:    mov w8, #2139095040 // =0x7f800000
; CHECK-NOFP-NEXT:    fcvt s2, h2
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s3, s2
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fmov s1, w8
; CHECK-NOFP-NEXT:    fcsel s3, s3, s1, lt
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h5
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h6
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h7
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcsel s1, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    ret
;
; CHECK-FP-LABEL: test_v11f16:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    // kill: def $h0 killed $h0 def $q0
; CHECK-FP-NEXT:    // kill: def $h1 killed $h1 def $q1
; CHECK-FP-NEXT:    // kill: def $h2 killed $h2 def $q2
; CHECK-FP-NEXT:    // kill: def $h3 killed $h3 def $q3
; CHECK-FP-NEXT:    // kill: def $h4 killed $h4 def $q4
; CHECK-FP-NEXT:    // kill: def $h5 killed $h5 def $q5
; CHECK-FP-NEXT:    mov x8, sp
; CHECK-FP-NEXT:    // kill: def $h6 killed $h6 def $q6
; CHECK-FP-NEXT:    // kill: def $h7 killed $h7 def $q7
; CHECK-FP-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-FP-NEXT:    movi v1.8h, #124, lsl #8
; CHECK-FP-NEXT:    mov v0.h[2], v2.h[0]
; CHECK-FP-NEXT:    ld1 { v1.h }[0], [x8]
; CHECK-FP-NEXT:    add x8, sp, #8
; CHECK-FP-NEXT:    ld1 { v1.h }[1], [x8]
; CHECK-FP-NEXT:    add x8, sp, #16
; CHECK-FP-NEXT:    mov v0.h[3], v3.h[0]
; CHECK-FP-NEXT:    ld1 { v1.h }[2], [x8]
; CHECK-FP-NEXT:    mov v0.h[4], v4.h[0]
; CHECK-FP-NEXT:    mov v0.h[5], v5.h[0]
; CHECK-FP-NEXT:    mov v0.h[6], v6.h[0]
; CHECK-FP-NEXT:    mov v0.h[7], v7.h[0]
; CHECK-FP-NEXT:    fminnm v0.8h, v0.8h, v1.8h
; CHECK-FP-NEXT:    fminnmv h0, v0.8h
; CHECK-FP-NEXT:    ret
  %b = call nnan half @llvm.vector.reduce.fmin.v11f16(<11 x half> %a)
  ret half %b
}

define half @test_v11f16_ninf(<11 x half> %a) nounwind {
; CHECK-NOFP-LABEL: test_v11f16_ninf:
; CHECK-NOFP:       // %bb.0:
; CHECK-NOFP-NEXT:    ldr h16, [sp, #8]
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    ldr h17, [sp]
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt s2, h2
; CHECK-NOFP-NEXT:    adrp x8, .LCPI15_0
; CHECK-NOFP-NEXT:    fcvt s16, h16
; CHECK-NOFP-NEXT:    fcvt s17, h17
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s4, h4
; CHECK-NOFP-NEXT:    fcmp s1, s16
; CHECK-NOFP-NEXT:    fcsel s1, s1, s16, lt
; CHECK-NOFP-NEXT:    fcmp s0, s17
; CHECK-NOFP-NEXT:    ldr h16, [sp, #16]
; CHECK-NOFP-NEXT:    fcvt s16, h16
; CHECK-NOFP-NEXT:    fcsel s0, s0, s17, lt
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s2, s16
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fcsel s1, s2, s16, lt
; CHECK-NOFP-NEXT:    ldr h2, [x8, :lo12:.LCPI15_0]
; CHECK-NOFP-NEXT:    mov w8, #57344 // =0xe000
; CHECK-NOFP-NEXT:    fcvt s2, h2
; CHECK-NOFP-NEXT:    movk w8, #18303, lsl #16
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s3, s2
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fmov s1, w8
; CHECK-NOFP-NEXT:    fcsel s3, s3, s1, lt
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h5
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h6
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcsel s3, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s4, h7
; CHECK-NOFP-NEXT:    fcvt h3, s3
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcmp s4, s2
; CHECK-NOFP-NEXT:    fcvt s3, h3
; CHECK-NOFP-NEXT:    fcsel s1, s4, s1, lt
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fcvt h1, s1
; CHECK-NOFP-NEXT:    fminnm s0, s0, s3
; CHECK-NOFP-NEXT:    fcvt s1, h1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    fcvt s0, h0
; CHECK-NOFP-NEXT:    fminnm s0, s0, s1
; CHECK-NOFP-NEXT:    fcvt h0, s0
; CHECK-NOFP-NEXT:    ret
;
; CHECK-FP-LABEL: test_v11f16_ninf:
; CHECK-FP:       // %bb.0:
; CHECK-FP-NEXT:    // kill: def $h0 killed $h0 def $q0
; CHECK-FP-NEXT:    // kill: def $h1 killed $h1 def $q1
; CHECK-FP-NEXT:    // kill: def $h2 killed $h2 def $q2
; CHECK-FP-NEXT:    // kill: def $h3 killed $h3 def $q3
; CHECK-FP-NEXT:    // kill: def $h4 killed $h4 def $q4
; CHECK-FP-NEXT:    // kill: def $h5 killed $h5 def $q5
; CHECK-FP-NEXT:    mov x8, sp
; CHECK-FP-NEXT:    // kill: def $h6 killed $h6 def $q6
; CHECK-FP-NEXT:    // kill: def $h7 killed $h7 def $q7
; CHECK-FP-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-FP-NEXT:    mvni v1.8h, #132, lsl #8
; CHECK-FP-NEXT:    ld1 { v1.h }[0], [x8]
; CHECK-FP-NEXT:    add x8, sp, #8
; CHECK-FP-NEXT:    mov v0.h[2], v2.h[0]
; CHECK-FP-NEXT:    ld1 { v1.h }[1], [x8]
; CHECK-FP-NEXT:    add x8, sp, #16
; CHECK-FP-NEXT:    mov v0.h[3], v3.h[0]
; CHECK-FP-NEXT:    ld1 { v1.h }[2], [x8]
; CHECK-FP-NEXT:    mov v0.h[4], v4.h[0]
; CHECK-FP-NEXT:    mov v0.h[5], v5.h[0]
; CHECK-FP-NEXT:    mov v0.h[6], v6.h[0]
; CHECK-FP-NEXT:    mov v0.h[7], v7.h[0]
; CHECK-FP-NEXT:    fminnm v0.8h, v0.8h, v1.8h
; CHECK-FP-NEXT:    fminnmv h0, v0.8h
; CHECK-FP-NEXT:    ret
  %b = call nnan ninf half @llvm.vector.reduce.fmin.v11f16(<11 x half> %a)
  ret half %b
}

define float @test_v3f32(<3 x float> %a) nounwind {
; CHECK-LABEL: test_v3f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #2139095040 // =0x7f800000
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mov v0.s[3], v1.s[0]
; CHECK-NEXT:    fminnmv s0, v0.4s
; CHECK-NEXT:    ret
  %b = call nnan float @llvm.vector.reduce.fmin.v3f32(<3 x float> %a)
  ret float %b
}

define float @test_v3f32_ninf(<3 x float> %a) nounwind {
; CHECK-LABEL: test_v3f32_ninf:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #2139095039 // =0x7f7fffff
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    mov v0.s[3], v1.s[0]
; CHECK-NEXT:    fminnmv s0, v0.4s
; CHECK-NEXT:    ret
  %b = call nnan ninf float @llvm.vector.reduce.fmin.v3f32(<3 x float> %a)
  ret float %b
}

define fp128 @test_v2f128(<2 x fp128> %a) nounwind {
; CHECK-LABEL: test_v2f128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    b fminl
  %b = call nnan fp128 @llvm.vector.reduce.fmin.v2f128(<2 x fp128> %a)
  ret fp128 %b
}