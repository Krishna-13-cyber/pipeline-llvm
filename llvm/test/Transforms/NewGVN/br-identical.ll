; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=newgvn -S -o - %s | FileCheck %s

; If a branch has two identical successors, we cannot declare either dead.

define void @widget(i1 %p) {
; CHECK-LABEL: define void @widget(
; CHECK-SAME: i1 [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[T1:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[T2:%.*]], [[BB7:%.*]] ]
; CHECK-NEXT:    [[T2]] = add i64 [[T1]], 1
; CHECK-NEXT:    [[T3:%.*]] = icmp ult i64 0, [[T2]]
; CHECK-NEXT:    br i1 [[T3]], label [[BB3:%.*]], label [[BB4:%.*]]
; CHECK:       bb3:
; CHECK-NEXT:    [[T4:%.*]] = call i64 @f()
; CHECK-NEXT:    br label [[BB4]]
; CHECK:       bb4:
; CHECK-NEXT:    br i1 [[P]], label [[BB5:%.*]], label [[BB6:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    br i1 true, label [[BB7]], label [[BB7]]
; CHECK:       bb6:
; CHECK-NEXT:    br i1 true, label [[BB7]], label [[BB7]]
; CHECK:       bb7:
; CHECK-NEXT:    br i1 [[P]], label [[BB2]], label [[BB8:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    ret void
;
entry:
  br label %bb2

bb2:
  %t1 = phi i64 [ 0, %entry ], [ %t5, %bb7 ]
  %t2 = add i64 %t1, 1
  %t3 = icmp ult i64 0, %t2
  br i1 %t3, label %bb3, label %bb4

bb3:
  %t4 = call i64 @f()
  br label %bb4

bb4:
  %foo = phi i64 [ %t4, %bb3 ], [ 0, %bb2 ]
  br i1 %p, label %bb5, label %bb6

bb5:
  br i1 true, label %bb7, label %bb7

bb6:
  br i1 true, label %bb7, label %bb7

bb7:
  %t5 = add i64 %t1, 1
  br i1 %p, label %bb2, label %bb8

bb8:
  ret void
}

declare i64 @f()