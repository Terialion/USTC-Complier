; ModuleID = '../c_cases/assign.c'
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [10 x i32], align 16
  store i32 0, i32* %1, align 4
  %3 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 0
  store i32 10, i32* %3, align 16
  %4 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 0
  %5 = load i32, i32* %4, align 16
  %6 = mul nsw i32 %5, 2
  %7 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 1
  store i32 %6, i32* %7, align 4
  %8 = getelementptr inbounds [10 x i32], [10 x i32]* %2, i64 0, i64 1
  %9 = load i32, i32* %8, align 4
  ret i32 %9
}