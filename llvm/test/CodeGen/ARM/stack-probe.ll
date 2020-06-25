; This tests that the probe-stack attribute properly calls the probe-stack
; function.
;
; RUN: llc < %s -mtriple=arm-none  | FileCheck %s

define void @_test1() "probe-stack"="__probestack" {
    %array = alloca [4096 x i8], align 16
    ret void

; CHECK-LABEL:      test1:
; CHECK:            movw r4, #1024
; CHECK-NEXT:       bl __probestack
; CHECK-NEXT:       sub.w sp, sp, r4
}
