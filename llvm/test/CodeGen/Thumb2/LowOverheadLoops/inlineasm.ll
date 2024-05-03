; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs -o - %s | FileCheck %s

define i32 @test(ptr nocapture readonly %x, ptr nocapture readonly %y, i32 %n) {
; CHECK-LABEL: test:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    cmp r2, #1
; CHECK-NEXT:    itt lt
; CHECK-NEXT:    movlt r0, #0
; CHECK-NEXT:    bxlt lr
; CHECK-NEXT:  .LBB0_1: @ %for.body.preheader
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov lr, r0
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:  .LBB0_2: @ %for.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh r3, [r1], #2
; CHECK-NEXT:    subs r2, #1
; CHECK-NEXT:    ldrh r12, [lr], #2
; CHECK-NEXT:    @APP
; CHECK-NEXT:    add r3, r12
; CHECK-NEXT:    @NO_APP
; CHECK-NEXT:    add r0, r3
; CHECK-NEXT:    bne .LBB0_2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:    pop {r7, pc}
entry:
  %cmp9 = icmp sgt i32 %n, 0
  br i1 %cmp9, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %s.0.lcssa = phi i32 [ 0, %entry ], [ %add, %for.body ]
  ret i32 %s.0.lcssa

for.body:                                         ; preds = %entry, %for.body
  %s.011 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %i.010 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i16, ptr %x, i32 %i.010
  %0 = load i16, ptr %arrayidx, align 2
  %arrayidx1 = getelementptr inbounds i16, ptr %y, i32 %i.010
  %1 = load i16, ptr %arrayidx1, align 2
  %2 = tail call i32 asm "add $0, $1, $2", "=r,r,r"(i16 %0, i16 %1) #1
  %add = add nsw i32 %2, %s.011
  %inc = add nuw nsw i32 %i.010, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}

define i32 @testlr(ptr nocapture readonly %x, ptr nocapture readonly %y, i32 %n) {
; CHECK-LABEL: testlr:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    cmp r2, #1
; CHECK-NEXT:    itt lt
; CHECK-NEXT:    movlt r0, #0
; CHECK-NEXT:    bxlt lr
; CHECK-NEXT:  .LBB1_1: @ %for.body.preheader
; CHECK-NEXT:    .save {r4, lr}
; CHECK-NEXT:    push {r4, lr}
; CHECK-NEXT:    mov r3, r0
; CHECK-NEXT:    movs r0, #0
; CHECK-NEXT:  .LBB1_2: @ %for.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldrh r4, [r1], #2
; CHECK-NEXT:    subs r2, #1
; CHECK-NEXT:    ldrh r12, [r3], #2
; CHECK-NEXT:    @APP
; CHECK-NEXT:    add r4, r12
; CHECK-NEXT:    @NO_APP
; CHECK-NEXT:    add r0, r4
; CHECK-NEXT:    bne .LBB1_2
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:    pop {r4, pc}
entry:
  %cmp9 = icmp sgt i32 %n, 0
  br i1 %cmp9, label %for.body, label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.body, %entry
  %s.0.lcssa = phi i32 [ 0, %entry ], [ %add, %for.body ]
  ret i32 %s.0.lcssa

for.body:                                         ; preds = %entry, %for.body
  %s.011 = phi i32 [ %add, %for.body ], [ 0, %entry ]
  %i.010 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i16, ptr %x, i32 %i.010
  %0 = load i16, ptr %arrayidx, align 2
  %arrayidx1 = getelementptr inbounds i16, ptr %y, i32 %i.010
  %1 = load i16, ptr %arrayidx1, align 2
  %2 = tail call i32 asm "add $0, $1, $2", "=r,r,r,~{lr}"(i16 %0, i16 %1) #1
  %add = add nsw i32 %2, %s.011
  %inc = add nuw nsw i32 %i.010, 1
  %exitcond.not = icmp eq i32 %inc, %n
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body
}