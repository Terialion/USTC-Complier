; ModuleID = 'cminus'
source_filename = "/home/wyh/2024ustc-jianmu-compiler/tests/testcases_general/lv2/funcall_int_array.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @test(i32* %arg0) {
label_entry:
  %op1 = alloca i32*
  store i32* %arg0, i32** %op1
  %op2 = icmp slt i32 3, 0
  br i1 %op2, label %label3, label %label4
label3:                                                ; preds = %label_entry
  call void @neg_idx_except()
  br label %label4
label4:                                                ; preds = %label_entry, %label3
  %op5 = load i32*, i32** %op1
  %op6 = getelementptr i32, i32* %op5, i32 3
  %op7 = load i32, i32* %op6
  call void @output(i32 %op7)
  ret void
}
define void @main() {
label_entry:
  %op0 = alloca [10 x i32]
  %op1 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 3
  store i32 10, i32* %op1
  %op2 = getelementptr [10 x i32], [10 x i32]* %op0, i32 0, i32 0
  call void @test(i32* %op2)
  ret void
}
