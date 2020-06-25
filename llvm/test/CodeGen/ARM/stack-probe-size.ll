; This tests that the probe-stack attribute properly calls the probe-stack
; function.
;
; RUN: llc < %s -mtriple=arm-none  | FileCheck %s

define void @_test1() "probe-stack"="__probestack" "stack-probe-size"="0" {
    %array = alloca [1024 x i8], align 16
    ret void

; CHECK-LABEL:      test1:
; CHECK:            movw r4, #256
; CHECK-NEXT:       bl __probestack
; CHECK-NEXT:       sub.w sp, sp, r4
}

define void @_test2() "probe-stack"="__probestack" "stack-probe-size"="1024" {
    %array = alloca [1024 x i8], align 16
    ret void

; CHECK-LABEL:      test2:
; CHECK:            movw r4, #256
; CHECK-NEXT:       bl __probestack
; CHECK-NEXT:       sub.w sp, sp, r4
}

define void @_test3() "probe-stack"="__probestack" "stack-probe-size"="8192" {
    %array = alloca [8192 x i8], align 16
    ret void

; CHECK-LABEL:      test3:
; CHECK:            movw r4, #2048
; CHECK-NEXT:       bl __probestack
; CHECK-NEXT:       sub.w sp, sp, r4
}

define void @_test4() "probe-stack"="__probestack" "stack-probe-size"="8192" {
    %array = alloca [4096 x i8], align 16
    ret void

; CHECK-LABEL:      test4:
; CHECK-NOT:        bl __probestack
}
