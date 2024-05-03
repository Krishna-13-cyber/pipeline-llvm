; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+avx2 | FileCheck %s

define <8 x i16> @commute_fold_vpblendw_128(<8 x i16> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vpblendw_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],mem[1,2,3],xmm0[4],mem[5,6,7]
; CHECK-NEXT:    retq
  %1 = load <8 x i16>, ptr %b
  %2 = call <8 x i16> @llvm.x86.sse41.pblendw(<8 x i16> %1, <8 x i16> %a, i8 17)
  ret <8 x i16> %2
}
declare <8 x i16> @llvm.x86.sse41.pblendw(<8 x i16>, <8 x i16>, i8) nounwind readnone

define <16 x i16> @commute_fold_vpblendw_256(<16 x i16> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vpblendw_256:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpblendw {{.*#+}} ymm0 = ymm0[0],mem[1,2,3],ymm0[4],mem[5,6,7],ymm0[8],mem[9,10,11],ymm0[12],mem[13,14,15]
; CHECK-NEXT:    retq
  %1 = load <16 x i16>, ptr %b
  %2 = call <16 x i16> @llvm.x86.avx2.pblendw(<16 x i16> %1, <16 x i16> %a, i8 17)
  ret <16 x i16> %2
}
declare <16 x i16> @llvm.x86.avx2.pblendw(<16 x i16>, <16 x i16>, i8) nounwind readnone

define <4 x i32> @commute_fold_vpblendd_128(<4 x i32> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vpblendd_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0],mem[1,2,3]
; CHECK-NEXT:    retq
  %1 = load <4 x i32>, ptr %b
  %2 = call <4 x i32> @llvm.x86.avx2.pblendd.128(<4 x i32> %1, <4 x i32> %a, i8 1)
  ret <4 x i32> %2
}
declare <4 x i32> @llvm.x86.avx2.pblendd.128(<4 x i32>, <4 x i32>, i8) nounwind readnone

define <8 x i32> @commute_fold_vpblendd_256(<8 x i32> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vpblendd_256:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0],mem[1,2,3,4,5,6],ymm0[7]
; CHECK-NEXT:    retq
  %1 = load <8 x i32>, ptr %b
  %2 = call <8 x i32> @llvm.x86.avx2.pblendd.256(<8 x i32> %1, <8 x i32> %a, i8 129)
  ret <8 x i32> %2
}
declare <8 x i32> @llvm.x86.avx2.pblendd.256(<8 x i32>, <8 x i32>, i8) nounwind readnone

define <4 x float> @commute_fold_vblendps_128(<4 x float> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vblendps_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0],mem[1],xmm0[2],mem[3]
; CHECK-NEXT:    retq
  %1 = load <4 x float>, ptr %b
  %2 = call <4 x float> @llvm.x86.sse41.blendps(<4 x float> %1, <4 x float> %a, i8 5)
  ret <4 x float> %2
}
declare <4 x float> @llvm.x86.sse41.blendps(<4 x float>, <4 x float>, i8) nounwind readnone

define <8 x float> @commute_fold_vblendps_256(<8 x float> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vblendps_256:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0,1,2],mem[3,4,5,6,7]
; CHECK-NEXT:    retq
  %1 = load <8 x float>, ptr %b
  %2 = call <8 x float> @llvm.x86.avx.blend.ps.256(<8 x float> %1, <8 x float> %a, i8 7)
  ret <8 x float> %2
}
declare <8 x float> @llvm.x86.avx.blend.ps.256(<8 x float>, <8 x float>, i8) nounwind readnone

define <2 x double> @commute_fold_vblendpd_128(<2 x double> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vblendpd_128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} xmm0 = xmm0[0,1],mem[2,3]
; CHECK-NEXT:    retq
  %1 = load <2 x double>, ptr %b
  %2 = call <2 x double> @llvm.x86.sse41.blendpd(<2 x double> %1, <2 x double> %a, i8 1)
  ret <2 x double> %2
}
declare <2 x double> @llvm.x86.sse41.blendpd(<2 x double>, <2 x double>, i8) nounwind readnone

define <4 x double> @commute_fold_vblendpd_256(<4 x double> %a, ptr %b) #0 {
; CHECK-LABEL: commute_fold_vblendpd_256:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0,1,2,3,4,5],mem[6,7]
; CHECK-NEXT:    retq
  %1 = load <4 x double>, ptr %b
  %2 = call <4 x double> @llvm.x86.avx.blend.pd.256(<4 x double> %1, <4 x double> %a, i8 7)
  ret <4 x double> %2
}
declare <4 x double> @llvm.x86.avx.blend.pd.256(<4 x double>, <4 x double>, i8) nounwind readnone

define <4 x float> @commute_vblendpd_128_for_code_size(<4 x float> %a, <4 x float> %b) optsize {
; CHECK-LABEL: commute_vblendpd_128_for_code_size:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0],xmm0[1],xmm1[2,3]
; CHECK-NEXT:    retq
  %r = shufflevector <4 x float> %b, <4 x float> %a, <4 x i32> <i32 0, i32 5, i32 2, i32 3>
  ret <4 x float> %r
}