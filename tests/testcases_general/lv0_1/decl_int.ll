; ModuleID = 'cminus'
source_filename = "/home/wyh/2024ustc-jianmu-compiler/tests/testcases_general/lv0_1/decl_int.cminus"

declare i32 @input()

declare void @output(i32)

declare void @outputFloat(float)

declare void @neg_idx_except()

define void @main() {
label_entry:
  %op0 = alloca i32
  ret void
}
