; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,VLA,RV32VLA
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,VLA,RV64VLA

; RUN: llc -mtriple=riscv32 -mattr=+m,+v -early-live-intervals -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,VLA,RV32VLA
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -early-live-intervals -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,VLA,RV64VLA

; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+v -riscv-v-vector-bits-max=128 -verify-machineinstrs | FileCheck -check-prefixes=CHECK,VLS,RV32VLS %s
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,v -riscv-v-vector-bits-max=128 -verify-machineinstrs | FileCheck -check-prefixes=CHECK,VLS,RV64VLS %s

define <vscale x 8 x i32> @insert_nxv8i32_v2i32_0(<vscale x 8 x i32> %vec, ptr %svp) {
; VLA-LABEL: insert_nxv8i32_v2i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v12, (a0)
; VLA-NEXT:    vsetivli zero, 2, e32, m4, tu, ma
; VLA-NEXT:    vmv.v.v v8, v12
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v2i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v12, (a0)
; VLS-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; VLS-NEXT:    vmv.v.v v8, v12
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v2i32.nxv8i32(<vscale x 8 x i32> %vec, <2 x i32> %sv, i64 0)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_v2i32_2(<vscale x 8 x i32> %vec, ptr %svp) {
; VLA-LABEL: insert_nxv8i32_v2i32_2:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v12, (a0)
; VLA-NEXT:    vsetivli zero, 4, e32, m4, tu, ma
; VLA-NEXT:    vslideup.vi v8, v12, 2
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v2i32_2:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v12, (a0)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v8, v12, 2
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v2i32.nxv8i32(<vscale x 8 x i32> %vec, <2 x i32> %sv, i64 2)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_v2i32_6(<vscale x 8 x i32> %vec, ptr %svp) {
; VLA-LABEL: insert_nxv8i32_v2i32_6:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v12, (a0)
; VLA-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; VLA-NEXT:    vslideup.vi v8, v12, 6
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v2i32_6:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v12, (a0)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v9, v12, 2
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v2i32.nxv8i32(<vscale x 8 x i32> %vec, <2 x i32> %sv, i64 6)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_v8i32_0(<vscale x 8 x i32> %vec, ptr %svp) {
; VLA-LABEL: insert_nxv8i32_v8i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vle32.v v12, (a0)
; VLA-NEXT:    vsetivli zero, 8, e32, m4, tu, ma
; VLA-NEXT:    vmv.v.v v8, v12
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v8i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vl2re32.v v8, (a0)
; VLS-NEXT:    ret
  %sv = load <8 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v8i32.nxv8i32(<vscale x 8 x i32> %vec, <8 x i32> %sv, i64 0)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_v8i32_8(<vscale x 8 x i32> %vec, ptr %svp) {
; VLA-LABEL: insert_nxv8i32_v8i32_8:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vle32.v v12, (a0)
; VLA-NEXT:    vsetivli zero, 16, e32, m4, tu, ma
; VLA-NEXT:    vslideup.vi v8, v12, 8
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v8i32_8:
; VLS:       # %bb.0:
; VLS-NEXT:    vl2re32.v v10, (a0)
; VLS-NEXT:    ret
  %sv = load <8 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v8i32.nxv8i32(<vscale x 8 x i32> %vec, <8 x i32> %sv, i64 8)
  ret <vscale x 8 x i32> %v
}

define <vscale x 8 x i32> @insert_nxv8i32_undef_v2i32_0(ptr %svp) {
; CHECK-LABEL: insert_nxv8i32_undef_v2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <vscale x 8 x i32> @llvm.vector.insert.v2i32.nxv8i32(<vscale x 8 x i32> undef, <2 x i32> %sv, i64 0)
  ret <vscale x 8 x i32> %v
}

define <vscale x 2 x i32> @insert_nxv8i32_v4i32_0(<vscale x 2 x i32> %vec, <4 x i32> %subvec) {
; VLA-LABEL: insert_nxv8i32_v4i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; VLA-NEXT:    vmv.v.v v8, v9
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv8i32_v4i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vmv1r.v v8, v9
; VLS-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.vector.insert.nxv2i32.v4i32(<vscale x 2 x i32> %vec, <4 x i32> %subvec, i64 0)
  ret <vscale x 2 x i32> %v
}


define <4 x i32> @insert_v4i32_v4i32_0(<4 x i32> %vec, <4 x i32> %subvec) {
; CHECK-LABEL: insert_v4i32_v4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vector.insert.v4i32.v4i32(<4 x i32> %vec, <4 x i32> %subvec, i64 0)
  ret <4 x i32> %v
}

define void @insert_v4i32_v2i32_0(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v4i32_v2i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLA-NEXT:    vle32.v v9, (a0)
; VLA-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; VLA-NEXT:    vmv.v.v v9, v8
; VLA-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLA-NEXT:    vse32.v v9, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v4i32_v2i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vl1re32.v v9, (a0)
; VLS-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; VLS-NEXT:    vmv.v.v v9, v8
; VLS-NEXT:    vs1r.v v9, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %vec = load <4 x i32>, ptr %vp
  %v = call <4 x i32> @llvm.vector.insert.v2i32.v4i32(<4 x i32> %vec, <2 x i32> %sv, i64 0)
  store <4 x i32> %v, ptr %vp
  ret void
}

define void @insert_v4i32_v2i32_2(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v4i32_v2i32_2:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLA-NEXT:    vle32.v v9, (a0)
; VLA-NEXT:    vslideup.vi v9, v8, 2
; VLA-NEXT:    vse32.v v9, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v4i32_v2i32_2:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vl1re32.v v9, (a0)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v9, v8, 2
; VLS-NEXT:    vs1r.v v9, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %vec = load <4 x i32>, ptr %vp
  %v = call <4 x i32> @llvm.vector.insert.v2i32.v4i32(<4 x i32> %vec, <2 x i32> %sv, i64 2)
  store <4 x i32> %v, ptr %vp
  ret void
}

define void @insert_v4i32_undef_v2i32_0(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v4i32_undef_v2i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLA-NEXT:    vse32.v v8, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v4i32_undef_v2i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vs1r.v v8, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <4 x i32> @llvm.vector.insert.v2i32.v4i32(<4 x i32> undef, <2 x i32> %sv, i64 0)
  store <4 x i32> %v, ptr %vp
  ret void
}

; This tests the code path in RISCVISelDAGToDAG::Select where we select an
; insert_subvector with a fixed vector and fixed subvector type. The phi here is
; used to prevent the fixed insert_subvector from being combined away into a
; scalable insert_subvector.
define <4 x i32> @insert_v4i32_undef_v2i32_0_phi(<2 x i32> %subvec, i1 %cond) {
; CHECK-LABEL: insert_v4i32_undef_v2i32_0_phi:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    bnez a0, .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:  .LBB11_2: # %bar
; CHECK-NEXT:    ret
entry:
  br i1 %cond, label %foo, label %bar
foo:
  %v = call <4 x i32> @llvm.vector.insert.v2i32.v4i32(<4 x i32> undef, <2 x i32> %subvec, i64 0)
  br label %bar
bar:
  %w = phi <4 x i32> [%v, %foo], [zeroinitializer, %entry]
  ret <4 x i32> %w
}


define void @insert_v8i32_v2i32_0(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v8i32_v2i32_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vle32.v v10, (a0)
; VLA-NEXT:    vsetivli zero, 2, e32, m2, tu, ma
; VLA-NEXT:    vmv.v.v v10, v8
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vse32.v v10, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v8i32_v2i32_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vl2re32.v v10, (a0)
; VLS-NEXT:    vsetivli zero, 2, e32, m1, tu, ma
; VLS-NEXT:    vmv.v.v v10, v8
; VLS-NEXT:    vs2r.v v10, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %vec = load <8 x i32>, ptr %vp
  %v = call <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32> %vec, <2 x i32> %sv, i64 0)
  store <8 x i32> %v, ptr %vp
  ret void
}

define void @insert_v8i32_v2i32_2(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v8i32_v2i32_2:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vle32.v v10, (a0)
; VLA-NEXT:    vsetivli zero, 4, e32, m2, tu, ma
; VLA-NEXT:    vslideup.vi v10, v8, 2
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vse32.v v10, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v8i32_v2i32_2:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vl2re32.v v10, (a0)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v10, v8, 2
; VLS-NEXT:    vs2r.v v10, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %vec = load <8 x i32>, ptr %vp
  %v = call <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32> %vec, <2 x i32> %sv, i64 2)
  store <8 x i32> %v, ptr %vp
  ret void
}

define void @insert_v8i32_v2i32_6(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v8i32_v2i32_6:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vle32.v v10, (a0)
; VLA-NEXT:    vslideup.vi v10, v8, 6
; VLA-NEXT:    vse32.v v10, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v8i32_v2i32_6:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vl2re32.v v10, (a0)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v11, v8, 2
; VLS-NEXT:    vs2r.v v10, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %vec = load <8 x i32>, ptr %vp
  %v = call <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32> %vec, <2 x i32> %sv, i64 6)
  store <8 x i32> %v, ptr %vp
  ret void
}

define void @insert_v8i32_undef_v2i32_6(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v8i32_undef_v2i32_6:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLA-NEXT:    vle32.v v8, (a1)
; VLA-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; VLA-NEXT:    vslideup.vi v10, v8, 6
; VLA-NEXT:    vse32.v v10, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v8i32_undef_v2i32_6:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; VLS-NEXT:    vle32.v v8, (a1)
; VLS-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; VLS-NEXT:    vslideup.vi v9, v8, 2
; VLS-NEXT:    vs2r.v v8, (a0)
; VLS-NEXT:    ret
  %sv = load <2 x i32>, ptr %svp
  %v = call <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32> undef, <2 x i32> %sv, i64 6)
  store <8 x i32> %v, ptr %vp
  ret void
}

define void @insert_v4i16_v2i16_0(ptr %vp, ptr %svp) {
; CHECK-LABEL: insert_v4i16_v2i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <4 x i16>, ptr %vp
  %sv = load <2 x i16>, ptr %svp
  %c = call <4 x i16> @llvm.vector.insert.v2i16.v4i16(<4 x i16> %v, <2 x i16> %sv, i64 0)
  store <4 x i16> %c, ptr %vp
  ret void
}

define void @insert_v4i16_v2i16_2(ptr %vp, ptr %svp) {
; CHECK-LABEL: insert_v4i16_v2i16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 2
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <4 x i16>, ptr %vp
  %sv = load <2 x i16>, ptr %svp
  %c = call <4 x i16> @llvm.vector.insert.v2i16.v4i16(<4 x i16> %v, <2 x i16> %sv, i64 2)
  store <4 x i16> %c, ptr %vp
  ret void
}

define void @insert_v32i1_v8i1_0(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v32i1_v8i1_0:
; VLA:       # %bb.0:
; VLA-NEXT:    li a2, 32
; VLA-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; VLA-NEXT:    vlm.v v8, (a0)
; VLA-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; VLA-NEXT:    vlm.v v9, (a1)
; VLA-NEXT:    vsetivli zero, 1, e8, mf4, tu, ma
; VLA-NEXT:    vmv.v.v v8, v9
; VLA-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; VLA-NEXT:    vsm.v v8, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v32i1_v8i1_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetvli a2, zero, e8, m2, ta, ma
; VLS-NEXT:    vlm.v v8, (a0)
; VLS-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; VLS-NEXT:    vlm.v v9, (a1)
; VLS-NEXT:    vsetivli zero, 1, e8, mf4, tu, ma
; VLS-NEXT:    vmv.v.v v8, v9
; VLS-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; VLS-NEXT:    vsm.v v8, (a0)
; VLS-NEXT:    ret
  %v = load <32 x i1>, ptr %vp
  %sv = load <8 x i1>, ptr %svp
  %c = call <32 x i1> @llvm.vector.insert.v8i1.v32i1(<32 x i1> %v, <8 x i1> %sv, i64 0)
  store <32 x i1> %c, ptr %vp
  ret void
}

define void @insert_v32i1_v8i1_16(ptr %vp, ptr %svp) {
; VLA-LABEL: insert_v32i1_v8i1_16:
; VLA:       # %bb.0:
; VLA-NEXT:    li a2, 32
; VLA-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; VLA-NEXT:    vlm.v v8, (a0)
; VLA-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; VLA-NEXT:    vlm.v v9, (a1)
; VLA-NEXT:    vsetivli zero, 3, e8, mf4, tu, ma
; VLA-NEXT:    vslideup.vi v8, v9, 2
; VLA-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; VLA-NEXT:    vsm.v v8, (a0)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v32i1_v8i1_16:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetvli a2, zero, e8, m2, ta, ma
; VLS-NEXT:    vlm.v v8, (a0)
; VLS-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; VLS-NEXT:    vlm.v v9, (a1)
; VLS-NEXT:    vsetivli zero, 3, e8, mf4, tu, ma
; VLS-NEXT:    vslideup.vi v8, v9, 2
; VLS-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; VLS-NEXT:    vsm.v v8, (a0)
; VLS-NEXT:    ret
  %v = load <32 x i1>, ptr %vp
  %sv = load <8 x i1>, ptr %svp
  %c = call <32 x i1> @llvm.vector.insert.v8i1.v32i1(<32 x i1> %v, <8 x i1> %sv, i64 16)
  store <32 x i1> %c, ptr %vp
  ret void
}

define void @insert_v8i1_v4i1_0(ptr %vp, ptr %svp) {
; CHECK-LABEL: insert_v8i1_v4i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vlm.v v8, (a1)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v8, v10, 1, v0
; CHECK-NEXT:    vsetivli zero, 4, e8, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v9, v8
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmsne.vi v8, v9, 0
; CHECK-NEXT:    vsm.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <8 x i1>, ptr %vp
  %sv = load <4 x i1>, ptr %svp
  %c = call <8 x i1> @llvm.vector.insert.v4i1.v8i1(<8 x i1> %v, <4 x i1> %sv, i64 0)
  store <8 x i1> %c, ptr %vp
  ret void
}

define void @insert_v8i1_v4i1_4(ptr %vp, ptr %svp) {
; CHECK-LABEL: insert_v8i1_v4i1_4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vlm.v v0, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vlm.v v8, (a1)
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.i v9, 0
; CHECK-NEXT:    vmerge.vim v9, v9, 1, v0
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.i v10, 0
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vmerge.vim v8, v10, 1, v0
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vslideup.vi v9, v8, 4
; CHECK-NEXT:    vmsne.vi v8, v9, 0
; CHECK-NEXT:    vsm.v v8, (a0)
; CHECK-NEXT:    ret
  %v = load <8 x i1>, ptr %vp
  %sv = load <4 x i1>, ptr %svp
  %c = call <8 x i1> @llvm.vector.insert.v4i1.v8i1(<8 x i1> %v, <4 x i1> %sv, i64 4)
  store <8 x i1> %c, ptr %vp
  ret void
}

define <vscale x 2 x i16> @insert_nxv2i16_v2i16_0(<vscale x 2 x i16> %v, ptr %svp) {
; CHECK-LABEL: insert_nxv2i16_v2i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 2, e16, mf2, tu, ma
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %sv = load <2 x i16>, ptr %svp
  %c = call <vscale x 2 x i16> @llvm.vector.insert.v2i16.nxv2i16(<vscale x 2 x i16> %v, <2 x i16> %sv, i64 0)
  ret <vscale x 2 x i16> %c
}

define <vscale x 2 x i16> @insert_nxv2i16_v2i16_2(<vscale x 2 x i16> %v, ptr %svp) {
; CHECK-LABEL: insert_nxv2i16_v2i16_2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v9, (a0)
; CHECK-NEXT:    vsetivli zero, 6, e16, mf2, tu, ma
; CHECK-NEXT:    vslideup.vi v8, v9, 4
; CHECK-NEXT:    ret
  %sv = load <2 x i16>, ptr %svp
  %c = call <vscale x 2 x i16> @llvm.vector.insert.v2i16.nxv2i16(<vscale x 2 x i16> %v, <2 x i16> %sv, i64 4)
  ret <vscale x 2 x i16> %c
}

define <vscale x 2 x i1> @insert_nxv2i1_v4i1_0(<vscale x 2 x i1> %v, ptr %svp) {
; VLA-LABEL: insert_nxv2i1_v4i1_0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; VLA-NEXT:    vlm.v v8, (a0)
; VLA-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; VLA-NEXT:    vmv.v.i v9, 0
; VLA-NEXT:    vmerge.vim v9, v9, 1, v0
; VLA-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; VLA-NEXT:    vmv.v.i v10, 0
; VLA-NEXT:    vmv1r.v v0, v8
; VLA-NEXT:    vmerge.vim v8, v10, 1, v0
; VLA-NEXT:    vsetvli zero, zero, e8, mf4, tu, ma
; VLA-NEXT:    vmv.v.v v9, v8
; VLA-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; VLA-NEXT:    vmsne.vi v0, v9, 0
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_nxv2i1_v4i1_0:
; VLS:       # %bb.0:
; VLS-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; VLS-NEXT:    vlm.v v8, (a0)
; VLS-NEXT:    vmv.v.i v9, 0
; VLS-NEXT:    vmerge.vim v10, v9, 1, v0
; VLS-NEXT:    vmv1r.v v0, v8
; VLS-NEXT:    vmerge.vim v8, v9, 1, v0
; VLS-NEXT:    vsetvli zero, zero, e8, mf4, tu, ma
; VLS-NEXT:    vmv.v.v v10, v8
; VLS-NEXT:    vsetvli zero, zero, e8, mf4, ta, ma
; VLS-NEXT:    vmsne.vi v0, v10, 0
; VLS-NEXT:    ret
  %sv = load <4 x i1>, ptr %svp
  %c = call <vscale x 2 x i1> @llvm.vector.insert.v4i1.nxv2i1(<vscale x 2 x i1> %v, <4 x i1> %sv, i64 0)
  ret <vscale x 2 x i1> %c
}

define <vscale x 8 x i1> @insert_nxv8i1_v4i1_0(<vscale x 8 x i1> %v, ptr %svp) {
; CHECK-LABEL: insert_nxv8i1_v4i1_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vlm.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, tu, ma
; CHECK-NEXT:    vmv.v.v v0, v8
; CHECK-NEXT:    ret
  %sv = load <8 x i1>, ptr %svp
  %c = call <vscale x 8 x i1> @llvm.vector.insert.v8i1.nxv8i1(<vscale x 8 x i1> %v, <8 x i1> %sv, i64 0)
  ret <vscale x 8 x i1> %c
}

define <vscale x 8 x i1> @insert_nxv8i1_v8i1_16(<vscale x 8 x i1> %v, ptr %svp) {
; CHECK-LABEL: insert_nxv8i1_v8i1_16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vlm.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 3, e8, mf8, tu, ma
; CHECK-NEXT:    vslideup.vi v0, v8, 2
; CHECK-NEXT:    ret
  %sv = load <8 x i1>, ptr %svp
  %c = call <vscale x 8 x i1> @llvm.vector.insert.v8i1.nxv8i1(<vscale x 8 x i1> %v, <8 x i1> %sv, i64 16)
  ret <vscale x 8 x i1> %c
}

declare <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64>, <2 x i64>, i64)

define void @insert_v2i64_nxv16i64(ptr %psv0, ptr %psv1, ptr %out) {
; VLA-LABEL: insert_v2i64_nxv16i64:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; VLA-NEXT:    vle64.v v8, (a0)
; VLA-NEXT:    vle64.v v16, (a1)
; VLA-NEXT:    vsetivli zero, 6, e64, m8, tu, ma
; VLA-NEXT:    vslideup.vi v8, v16, 4
; VLA-NEXT:    vs8r.v v8, (a2)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v2i64_nxv16i64:
; VLS:       # %bb.0:
; VLS-NEXT:    vl1re64.v v8, (a0)
; VLS-NEXT:    vl1re64.v v10, (a1)
; VLS-NEXT:    vs8r.v v8, (a2)
; VLS-NEXT:    ret
  %sv0 = load <2 x i64>, ptr %psv0
  %sv1 = load <2 x i64>, ptr %psv1
  %v0 = call <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv0, i64 0)
  %v = call <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> %v0, <2 x i64> %sv1, i64 4)
  store <vscale x 16 x i64> %v, ptr %out
  ret void
}

define void @insert_v2i64_nxv16i64_lo0(ptr %psv, ptr %out) {
; VLA-LABEL: insert_v2i64_nxv16i64_lo0:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; VLA-NEXT:    vle64.v v8, (a0)
; VLA-NEXT:    vs8r.v v8, (a1)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v2i64_nxv16i64_lo0:
; VLS:       # %bb.0:
; VLS-NEXT:    vl1re64.v v8, (a0)
; VLS-NEXT:    vs8r.v v8, (a1)
; VLS-NEXT:    ret
  %sv = load <2 x i64>, ptr %psv
  %v = call <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv, i64 0)
  store <vscale x 16 x i64> %v, ptr %out
  ret void
}

define void @insert_v2i64_nxv16i64_lo2(ptr %psv, ptr %out) {
; VLA-LABEL: insert_v2i64_nxv16i64_lo2:
; VLA:       # %bb.0:
; VLA-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; VLA-NEXT:    vle64.v v8, (a0)
; VLA-NEXT:    vsetivli zero, 4, e64, m8, ta, ma
; VLA-NEXT:    vslideup.vi v16, v8, 2
; VLA-NEXT:    vs8r.v v16, (a1)
; VLA-NEXT:    ret
;
; VLS-LABEL: insert_v2i64_nxv16i64_lo2:
; VLS:       # %bb.0:
; VLS-NEXT:    vl1re64.v v9, (a0)
; VLS-NEXT:    vs8r.v v8, (a1)
; VLS-NEXT:    ret
  %sv = load <2 x i64>, ptr %psv
  %v = call <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv, i64 2)
  store <vscale x 16 x i64> %v, ptr %out
  ret void
}

; Check we don't mistakenly optimize this: we don't know whether this is
; inserted into the low or high split vector.
define void @insert_v2i64_nxv16i64_hi(ptr %psv, ptr %out) {
; RV32-LABEL: insert_v2i64_nxv16i64_hi:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -80
; RV32-NEXT:    .cfi_def_cfa_offset 80
; RV32-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 80
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    csrr a2, vlenb
; RV32-NEXT:    slli a2, a2, 4
; RV32-NEXT:    sub sp, sp, a2
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-NEXT:    vle64.v v8, (a0)
; RV32-NEXT:    addi a0, sp, 128
; RV32-NEXT:    vse64.v v8, (a0)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 3
; RV32-NEXT:    addi a2, sp, 64
; RV32-NEXT:    add a3, a2, a0
; RV32-NEXT:    vl8re64.v v8, (a3)
; RV32-NEXT:    vl8re64.v v16, (a2)
; RV32-NEXT:    add a0, a1, a0
; RV32-NEXT:    vs8r.v v8, (a0)
; RV32-NEXT:    vs8r.v v16, (a1)
; RV32-NEXT:    addi sp, s0, -80
; RV32-NEXT:    .cfi_def_cfa sp, 80
; RV32-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 80
; RV32-NEXT:    ret
; RV64-LABEL: insert_v2i64_nxv16i64_hi:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -80
; RV64-NEXT:    .cfi_def_cfa_offset 80
; RV64-NEXT:    sd ra, 72(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 64(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 80
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    csrr a2, vlenb
; RV64-NEXT:    slli a2, a2, 4
; RV64-NEXT:    sub sp, sp, a2
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vle64.v v8, (a0)
; RV64-NEXT:    addi a0, sp, 128
; RV64-NEXT:    vse64.v v8, (a0)
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 3
; RV64-NEXT:    addi a2, sp, 64
; RV64-NEXT:    add a3, a2, a0
; RV64-NEXT:    vl8re64.v v8, (a3)
; RV64-NEXT:    vl8re64.v v16, (a2)
; RV64-NEXT:    add a0, a1, a0
; RV64-NEXT:    vs8r.v v8, (a0)
; RV64-NEXT:    vs8r.v v16, (a1)
; RV64-NEXT:    addi sp, s0, -80
; RV64-NEXT:    .cfi_def_cfa sp, 80
; RV64-NEXT:    ld ra, 72(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 64(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 80
; RV64-NEXT:    ret
; RV32VLA-LABEL: insert_v2i64_nxv16i64_hi:
; RV32VLA:       # %bb.0:
; RV32VLA-NEXT:    addi sp, sp, -80
; RV32VLA-NEXT:    .cfi_def_cfa_offset 80
; RV32VLA-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; RV32VLA-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; RV32VLA-NEXT:    .cfi_offset ra, -4
; RV32VLA-NEXT:    .cfi_offset s0, -8
; RV32VLA-NEXT:    addi s0, sp, 80
; RV32VLA-NEXT:    .cfi_def_cfa s0, 0
; RV32VLA-NEXT:    csrr a2, vlenb
; RV32VLA-NEXT:    slli a2, a2, 4
; RV32VLA-NEXT:    sub sp, sp, a2
; RV32VLA-NEXT:    andi sp, sp, -64
; RV32VLA-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32VLA-NEXT:    vle64.v v8, (a0)
; RV32VLA-NEXT:    addi a0, sp, 128
; RV32VLA-NEXT:    vse64.v v8, (a0)
; RV32VLA-NEXT:    csrr a0, vlenb
; RV32VLA-NEXT:    slli a0, a0, 3
; RV32VLA-NEXT:    addi a2, sp, 64
; RV32VLA-NEXT:    add a3, a2, a0
; RV32VLA-NEXT:    vl8re64.v v8, (a3)
; RV32VLA-NEXT:    vl8re64.v v16, (a2)
; RV32VLA-NEXT:    add a0, a1, a0
; RV32VLA-NEXT:    vs8r.v v8, (a0)
; RV32VLA-NEXT:    vs8r.v v16, (a1)
; RV32VLA-NEXT:    addi sp, s0, -80
; RV32VLA-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; RV32VLA-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; RV32VLA-NEXT:    addi sp, sp, 80
; RV32VLA-NEXT:    ret
;
; RV64VLA-LABEL: insert_v2i64_nxv16i64_hi:
; RV64VLA:       # %bb.0:
; RV64VLA-NEXT:    addi sp, sp, -80
; RV64VLA-NEXT:    .cfi_def_cfa_offset 80
; RV64VLA-NEXT:    sd ra, 72(sp) # 8-byte Folded Spill
; RV64VLA-NEXT:    sd s0, 64(sp) # 8-byte Folded Spill
; RV64VLA-NEXT:    .cfi_offset ra, -8
; RV64VLA-NEXT:    .cfi_offset s0, -16
; RV64VLA-NEXT:    addi s0, sp, 80
; RV64VLA-NEXT:    .cfi_def_cfa s0, 0
; RV64VLA-NEXT:    csrr a2, vlenb
; RV64VLA-NEXT:    slli a2, a2, 4
; RV64VLA-NEXT:    sub sp, sp, a2
; RV64VLA-NEXT:    andi sp, sp, -64
; RV64VLA-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64VLA-NEXT:    vle64.v v8, (a0)
; RV64VLA-NEXT:    addi a0, sp, 128
; RV64VLA-NEXT:    vse64.v v8, (a0)
; RV64VLA-NEXT:    csrr a0, vlenb
; RV64VLA-NEXT:    slli a0, a0, 3
; RV64VLA-NEXT:    addi a2, sp, 64
; RV64VLA-NEXT:    add a3, a2, a0
; RV64VLA-NEXT:    vl8re64.v v8, (a3)
; RV64VLA-NEXT:    vl8re64.v v16, (a2)
; RV64VLA-NEXT:    add a0, a1, a0
; RV64VLA-NEXT:    vs8r.v v8, (a0)
; RV64VLA-NEXT:    vs8r.v v16, (a1)
; RV64VLA-NEXT:    addi sp, s0, -80
; RV64VLA-NEXT:    ld ra, 72(sp) # 8-byte Folded Reload
; RV64VLA-NEXT:    ld s0, 64(sp) # 8-byte Folded Reload
; RV64VLA-NEXT:    addi sp, sp, 80
; RV64VLA-NEXT:    ret
;
; RV32VLS-LABEL: insert_v2i64_nxv16i64_hi:
; RV32VLS:       # %bb.0:
; RV32VLS-NEXT:    addi sp, sp, -80
; RV32VLS-NEXT:    .cfi_def_cfa_offset 80
; RV32VLS-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; RV32VLS-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; RV32VLS-NEXT:    .cfi_offset ra, -4
; RV32VLS-NEXT:    .cfi_offset s0, -8
; RV32VLS-NEXT:    addi s0, sp, 80
; RV32VLS-NEXT:    .cfi_def_cfa s0, 0
; RV32VLS-NEXT:    addi sp, sp, -256
; RV32VLS-NEXT:    andi sp, sp, -64
; RV32VLS-NEXT:    vl1re64.v v8, (a0)
; RV32VLS-NEXT:    addi a0, sp, 128
; RV32VLS-NEXT:    vs1r.v v8, (a0)
; RV32VLS-NEXT:    addi a0, sp, 64
; RV32VLS-NEXT:    addi a2, sp, 192
; RV32VLS-NEXT:    vl8re64.v v8, (a2)
; RV32VLS-NEXT:    vl8re64.v v16, (a0)
; RV32VLS-NEXT:    addi a0, a1, 128
; RV32VLS-NEXT:    vs8r.v v8, (a0)
; RV32VLS-NEXT:    vs8r.v v16, (a1)
; RV32VLS-NEXT:    addi sp, s0, -80
; RV32VLS-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; RV32VLS-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; RV32VLS-NEXT:    addi sp, sp, 80
; RV32VLS-NEXT:    ret
;
; RV64VLS-LABEL: insert_v2i64_nxv16i64_hi:
; RV64VLS:       # %bb.0:
; RV64VLS-NEXT:    addi sp, sp, -80
; RV64VLS-NEXT:    .cfi_def_cfa_offset 80
; RV64VLS-NEXT:    sd ra, 72(sp) # 8-byte Folded Spill
; RV64VLS-NEXT:    sd s0, 64(sp) # 8-byte Folded Spill
; RV64VLS-NEXT:    .cfi_offset ra, -8
; RV64VLS-NEXT:    .cfi_offset s0, -16
; RV64VLS-NEXT:    addi s0, sp, 80
; RV64VLS-NEXT:    .cfi_def_cfa s0, 0
; RV64VLS-NEXT:    addi sp, sp, -256
; RV64VLS-NEXT:    andi sp, sp, -64
; RV64VLS-NEXT:    vl1re64.v v8, (a0)
; RV64VLS-NEXT:    addi a0, sp, 128
; RV64VLS-NEXT:    vs1r.v v8, (a0)
; RV64VLS-NEXT:    addi a0, sp, 64
; RV64VLS-NEXT:    addi a2, sp, 192
; RV64VLS-NEXT:    vl8re64.v v8, (a2)
; RV64VLS-NEXT:    vl8re64.v v16, (a0)
; RV64VLS-NEXT:    addi a0, a1, 128
; RV64VLS-NEXT:    vs8r.v v8, (a0)
; RV64VLS-NEXT:    vs8r.v v16, (a1)
; RV64VLS-NEXT:    addi sp, s0, -80
; RV64VLS-NEXT:    ld ra, 72(sp) # 8-byte Folded Reload
; RV64VLS-NEXT:    ld s0, 64(sp) # 8-byte Folded Reload
; RV64VLS-NEXT:    addi sp, sp, 80
; RV64VLS-NEXT:    ret
  %sv = load <2 x i64>, ptr %psv
  %v = call <vscale x 16 x i64> @llvm.vector.insert.v2i64.nxv16i64(<vscale x 16 x i64> undef, <2 x i64> %sv, i64 8)
  store <vscale x 16 x i64> %v, ptr %out
  ret void
}

declare <8 x i1> @llvm.vector.insert.v4i1.v8i1(<8 x i1>, <4 x i1>, i64)
declare <32 x i1> @llvm.vector.insert.v8i1.v32i1(<32 x i1>, <8 x i1>, i64)

declare <4 x i16> @llvm.vector.insert.v2i16.v4i16(<4 x i16>, <2 x i16>, i64)

declare <4 x i32> @llvm.vector.insert.v2i32.v4i32(<4 x i32>, <2 x i32>, i64)
declare <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32>, <2 x i32>, i64)

declare <vscale x 2 x i1> @llvm.vector.insert.v4i1.nxv2i1(<vscale x 2 x i1>, <4 x i1>, i64)
declare <vscale x 8 x i1> @llvm.vector.insert.v8i1.nxv8i1(<vscale x 8 x i1>, <8 x i1>, i64)

declare <vscale x 2 x i16> @llvm.vector.insert.v2i16.nxv2i16(<vscale x 2 x i16>, <2 x i16>, i64)

declare <vscale x 8 x i32> @llvm.vector.insert.v2i32.nxv8i32(<vscale x 8 x i32>, <2 x i32>, i64)
declare <vscale x 8 x i32> @llvm.vector.insert.v4i32.nxv8i32(<vscale x 8 x i32>, <4 x i32>, i64)
declare <vscale x 8 x i32> @llvm.vector.insert.v8i32.nxv8i32(<vscale x 8 x i32>, <8 x i32>, i64)

; We emit insert_subvectors of fixed vectors at index 0 into undefs as a
; copy_to_regclass or insert_subreg, depending on the register classes of the
; vector types. Make sure that we use the correct type and not the shrunken
; LMUL=1 type, otherwise we will end up with an invalid extract_subvector when
; converting it from scalable->fixed, e.g. we get this for VLEN=128:
;
;   t14: nxv2i32 = insert_subvector undef:nxv2i32, t4, Constant:i64<0>
; t15: v8i32 = extract_subvector t14, Constant:i64<0>
declare <4 x i32> @llvm.vector.extract.v4i32.v8i32(<8 x i32>, i64)
define <4 x i32> @insert_extract_v8i32_v2i32_0(<2 x i32> %v) {
; CHECK-LABEL: insert_extract_v8i32_v2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ret
  %1 = call <8 x i32> @llvm.vector.insert.v2i32.v8i32(<8 x i32> poison, <2 x i32> %v, i64 0)
  %2 = call <4 x i32> @llvm.vector.extract.v4i32.v8i32(<8 x i32> %1, i64 0)
  ret <4 x i32> %2
}