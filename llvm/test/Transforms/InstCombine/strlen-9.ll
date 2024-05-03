; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
;
; Verify that strlen calls with unterminated constant arrays or with
; just past-the-end pointers to strings are not folded.
;
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare i64 @strlen(ptr)

@a5 = constant [5 x i8] c"12345"
@s5 = constant [6 x i8] c"12345\00"
@z0 = constant [0 x i8] zeroinitializer
@z5 = constant [5 x i8] zeroinitializer


; Verify that all the invalid calls below are folded.  This is safer than
; making the library calls even though it prevents sanitizers from reporting
; the bugs.

define void @fold_strlen_no_nul(ptr %plen, i32 %i) {
; CHECK-LABEL: @fold_strlen_no_nul(
; CHECK-NEXT:    store i64 5, ptr [[PLEN:%.*]], align 4
; CHECK-NEXT:    [[PNA5_P5:%.*]] = getelementptr i8, ptr [[PLEN]], i64 8
; CHECK-NEXT:    store i64 0, ptr [[PNA5_P5]], align 4
; CHECK-NEXT:    [[PNS5_P6:%.*]] = getelementptr i8, ptr [[PLEN]], i64 16
; CHECK-NEXT:    store i64 0, ptr [[PNS5_P6]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = sext i32 [[I:%.*]] to i64
; CHECK-NEXT:    [[PA5_PI:%.*]] = getelementptr [5 x i8], ptr @a5, i64 0, i64 [[TMP1]]
; CHECK-NEXT:    [[NA5_PI:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PA5_PI]])
; CHECK-NEXT:    [[PNA5_PI:%.*]] = getelementptr i8, ptr [[PLEN]], i64 24
; CHECK-NEXT:    store i64 [[NA5_PI]], ptr [[PNA5_PI]], align 4
; CHECK-NEXT:    [[PNZ0_P0:%.*]] = getelementptr i8, ptr [[PLEN]], i64 32
; CHECK-NEXT:    store i64 0, ptr [[PNZ0_P0]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = sext i32 [[I]] to i64
; CHECK-NEXT:    [[PZ0_PI:%.*]] = getelementptr [0 x i8], ptr @z0, i64 0, i64 [[TMP2]]
; CHECK-NEXT:    [[NZ0_PI:%.*]] = call i64 @strlen(ptr noundef nonnull dereferenceable(1) [[PZ0_PI]])
; CHECK-NEXT:    [[PNZ0_PI:%.*]] = getelementptr i8, ptr [[PLEN]], i64 40
; CHECK-NEXT:    store i64 [[NZ0_PI]], ptr [[PNZ0_PI]], align 4
; CHECK-NEXT:    [[PNZ5_P5:%.*]] = getelementptr i8, ptr [[PLEN]], i64 48
; CHECK-NEXT:    store i64 0, ptr [[PNZ5_P5]], align 4
; CHECK-NEXT:    ret void
;
; Verify that strlen(a5) is folded to 5.
  %na5_p0 = call i64 @strlen(ptr @a5)
  store i64 %na5_p0, ptr %plen

; Verify that strlen(a5 + 5) is folded to 0.
  %pa5_p5 = getelementptr [5 x i8], ptr @a5, i32 0, i32 5
  %na5_p5 = call i64 @strlen(ptr %pa5_p5)
  %pna5_p5 = getelementptr i64, ptr %plen, i64 1
  store i64 %na5_p5, ptr %pna5_p5

; Verify that strlen(s5 + 6) is folded to 0.
  %ps5_p6 = getelementptr [6 x i8], ptr @s5, i32 0, i32 6
  %ns5_p6 = call i64 @strlen(ptr %ps5_p6)
  %pns5_p6 = getelementptr i64, ptr %plen, i64 2
  store i64 %ns5_p6, ptr %pns5_p6

; TODO: Verify that strlen(a5 + i) is folded to 5 - i?  It's currently
; not folded because the variable offset makes getConstantDataArrayInfo
; fail.
  %pa5_pi = getelementptr [5 x i8], ptr @a5, i32 0, i32 %i
  %na5_pi = call i64 @strlen(ptr %pa5_pi)
  %pna5_pi = getelementptr i64, ptr %plen, i64 3
  store i64 %na5_pi, ptr %pna5_pi

; Verify that strlen(z0) is folded to 0.
  %nz0_p0 = call i64 @strlen(ptr @z0)
  %pnz0_p0 = getelementptr i64, ptr %plen, i64 4
  store i64 %nz0_p0, ptr %pnz0_p0

; TODO: Verify that strlen(z0 + i) is folded to 0.  As the case above,
; this one is not folded either because the variable offset makes
; getConstantDataArrayInfo fail.

  %pz0_pi = getelementptr [0 x i8], ptr @z0, i32 0, i32 %i
  %nz0_pi = call i64 @strlen(ptr %pz0_pi)
  %pnz0_pi = getelementptr i64, ptr %plen, i64 5
  store i64 %nz0_pi, ptr %pnz0_pi

; Verify that strlen(z5 + 5) is folded to 0.
  %pz5_p5 = getelementptr [5 x i8], ptr @z5, i32 0, i32 5
  %nz5_p5 = call i64 @strlen(ptr %pz5_p5)
  %pnz5_p5 = getelementptr i64, ptr %plen, i64 6
  store i64 %nz5_p5, ptr %pnz5_p5

  ret void
}