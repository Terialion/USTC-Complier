; ModuleID = '../c_cases/if.c'

define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca float, align 4
  store i32 0, i32* %1, align 4
  store float 0x40163851E0000000, float* %2, align 4
  %3 = load float, float* %2, align 4
  %4 = fcmp ogt float %3, 1.000000e+00
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 233, i32* %1, align 4
  br label %7

6:                                                ; preds = %0
  store i32 0, i32* %1, align 4
  br label %7

7:                                                ; preds = %6, %5
  %8 = load i32, i32* %1, align 4
  ret i32 %8
}