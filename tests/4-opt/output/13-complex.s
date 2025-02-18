# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl n
	.type n, @object
	.size n, 4
n:
	.space 4
	.globl m
	.type m, @object
	.size m, 4
m:
	.space 4
	.globl w
	.type w, @object
	.size w, 20
w:
	.space 20
	.globl v
	.type v, @object
	.size v, 20
v:
	.space 20
	.globl dp
	.type dp, @object
	.size dp, 264
dp:
	.space 264
	.text
	.globl max
	.type max, @function
max:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.max_label_entry:
# %op2 = icmp sgt i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t2, $t1, $t0
	st.b $t2, $fp, -25
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -29
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -30
# br i1 %op4, label %label5, label %label6
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .max_label5
	b .max_label6
.max_label5:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	b max_exit
.max_label6:
# ret i32 %arg1
	ld.w $a0, $fp, -24
	b max_exit
max_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl knapsack
	.type knapsack, @function
knapsack:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -208
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.knapsack_label_entry:
# %op2 = icmp sle i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
	xori $t2, $t2, 1
	st.b $t2, $fp, -25
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -29
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -30
# br i1 %op4, label %label5, label %label6
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label5
	b .knapsack_label6
.knapsack_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label6:
# %op7 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -31
# %op8 = zext i1 %op7 to i32
	ld.b $t0, $fp, -31
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -35
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -35
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -36
# br i1 %op9, label %label10, label %label11
	ld.b $t0, $fp, -36
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label10
	b .knapsack_label11
.knapsack_label10:
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label11:
# %op12 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -40
# %op13 = add i32 %op12, %arg1
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# %op14 = icmp slt i32 %op13, 0
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -45
# br i1 %op14, label %label15, label %label16
	ld.b $t0, $fp, -45
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label15
	b .knapsack_label16
.knapsack_label15:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label16:
# %op17 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op13
	la.local $t0, dp
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 264
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -44
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -53
# %op18 = load i32, i32* %op17
	ld.d $t0, $fp, -53
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -57
# %op19 = icmp sge i32 %op18, 0
	ld.w $t0, $fp, -57
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	xori $t2, $t2, 1
	st.b $t2, $fp, -58
# %op20 = zext i1 %op19 to i32
	ld.b $t0, $fp, -58
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -62
# %op21 = icmp ne i32 %op20, 0
	ld.w $t0, $fp, -62
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -63
# br i1 %op21, label %label22, label %label26
	ld.b $t0, $fp, -63
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label22
	b .knapsack_label26
.knapsack_label22:
# %op23 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -67
# %op24 = add i32 %op23, %arg1
	ld.w $t0, $fp, -67
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -71
# %op25 = icmp slt i32 %op24, 0
	ld.w $t0, $fp, -71
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -72
# br i1 %op25, label %label29, label %label30
	ld.b $t0, $fp, -72
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label29
	b .knapsack_label30
.knapsack_label26:
# %op27 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op28 = icmp slt i32 %op27, 0
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -77
# br i1 %op28, label %label33, label %label34
	ld.b $t0, $fp, -77
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label33
	b .knapsack_label34
.knapsack_label29:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label30:
# %op31 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op24
	la.local $t0, dp
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 264
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -71
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -85
# %op32 = load i32, i32* %op31
	ld.d $t0, $fp, -85
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -89
# ret i32 %op32
	ld.w $a0, $fp, -89
	b knapsack_exit
.knapsack_label33:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label34:
# %op35 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op27
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -76
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -97
# %op36 = load i32, i32* %op35
	ld.d $t0, $fp, -97
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -101
# %op37 = icmp slt i32 %arg1, %op36
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -101
	slt $t2, $t0, $t1
	st.b $t2, $fp, -102
# %op38 = zext i1 %op37 to i32
	ld.b $t0, $fp, -102
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -106
# %op39 = icmp ne i32 %op38, 0
	ld.w $t0, $fp, -106
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -107
# br i1 %op39, label %label40, label %label48
	ld.b $t0, $fp, -107
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label40
	b .knapsack_label48
.knapsack_label40:
# %op41 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -111
# %op42 = call i32 @knapsack(i32 %op41, i32 %arg1)
	ld.w $a0, $fp, -111
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -115
# br label %label43
	ld.w $a0, $fp, -115
	st.w $a0, $fp, -119
	b .knapsack_label43
.knapsack_label43:
# %op44 = phi i32 [ %op42, %label40 ], [ %op67, %label63 ]
# %op45 = mul i32 %arg0, 11
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 11
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -123
# %op46 = add i32 %op45, %arg1
	ld.w $t0, $fp, -123
	ld.w $t1, $fp, -24
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -127
# %op47 = icmp slt i32 %op46, 0
	ld.w $t0, $fp, -127
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -128
# br i1 %op47, label %label68, label %label69
	ld.b $t0, $fp, -128
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label68
	b .knapsack_label69
.knapsack_label48:
# %op49 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op50 = call i32 @knapsack(i32 %op49, i32 %arg1)
	ld.w $a0, $fp, -132
	ld.w $a1, $fp, -24
	bl knapsack
	st.w $a0, $fp, -136
# %op51 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op52 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# %op53 = icmp slt i32 %op52, 0
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -145
# br i1 %op53, label %label54, label %label55
	ld.b $t0, $fp, -145
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label54
	b .knapsack_label55
.knapsack_label54:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label55:
# %op56 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 %op52
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -144
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -153
# %op57 = load i32, i32* %op56
	ld.d $t0, $fp, -153
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -157
# %op58 = sub i32 %arg1, %op57
	ld.w $t0, $fp, -24
	ld.w $t1, $fp, -157
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -161
# %op59 = call i32 @knapsack(i32 %op51, i32 %op58)
	ld.w $a0, $fp, -140
	ld.w $a1, $fp, -161
	bl knapsack
	st.w $a0, $fp, -165
# %op60 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -169
# %op61 = icmp slt i32 %op60, 0
	ld.w $t0, $fp, -169
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -170
# br i1 %op61, label %label62, label %label63
	ld.b $t0, $fp, -170
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .knapsack_label62
	b .knapsack_label63
.knapsack_label62:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label63:
# %op64 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 %op60
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -169
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -178
# %op65 = load i32, i32* %op64
	ld.d $t0, $fp, -178
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# %op66 = add i32 %op59, %op65
	ld.w $t0, $fp, -165
	ld.w $t1, $fp, -182
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# %op67 = call i32 @max(i32 %op50, i32 %op66)
	ld.w $a0, $fp, -136
	ld.w $a1, $fp, -186
	bl max
	st.w $a0, $fp, -190
# br label %label43
	ld.w $a0, $fp, -190
	st.w $a0, $fp, -119
	b .knapsack_label43
.knapsack_label68:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b knapsack_exit
.knapsack_label69:
# %op70 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op46
	la.local $t0, dp
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 264
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -127
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -198
# store i32 %op44, i32* %op70
	ld.d $t0, $fp, -198
	ld.w $t1, $fp, -119
	st.w $t1, $t0, 0
# ret i32 %op44
	ld.w $a0, $fp, -119
	b knapsack_exit
knapsack_exit:
	addi.d $sp, $sp, 208
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
.main_label_entry:
# store i32 5, i32* @n
	la.local $t0, n
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# store i32 10, i32* @m
	la.local $t0, m
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# %op0 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -17
# br i1 %op0, label %label1, label %label2
	ld.b $t0, $fp, -17
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label1
	b .main_label2
.main_label1:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label2:
# %op3 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 0
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -25
# store i32 2, i32* %op3
	ld.d $t0, $fp, -25
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op4 = icmp slt i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -26
# br i1 %op4, label %label5, label %label6
	ld.b $t0, $fp, -26
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label5
	b .main_label6
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label6:
# %op7 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 1
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 1
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -34
# store i32 2, i32* %op7
	ld.d $t0, $fp, -34
	addi.w $t1, $zero, 2
	st.w $t1, $t0, 0
# %op8 = icmp slt i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -35
# br i1 %op8, label %label9, label %label10
	ld.b $t0, $fp, -35
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label9
	b .main_label10
.main_label9:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label10:
# %op11 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 2
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 2
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -43
# store i32 6, i32* %op11
	ld.d $t0, $fp, -43
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op12 = icmp slt i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -44
# br i1 %op12, label %label13, label %label14
	ld.b $t0, $fp, -44
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label13
	b .main_label14
.main_label13:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label14:
# %op15 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 3
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -52
# store i32 5, i32* %op15
	ld.d $t0, $fp, -52
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op16 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -53
# br i1 %op16, label %label17, label %label18
	ld.b $t0, $fp, -53
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label17
	b .main_label18
.main_label17:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label18:
# %op19 = getelementptr [5 x i32], [5 x i32]* @w, i32 0, i32 4
	la.local $t0, w
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -61
# store i32 4, i32* %op19
	ld.d $t0, $fp, -61
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op20 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -62
# br i1 %op20, label %label21, label %label22
	ld.b $t0, $fp, -62
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label21
	b .main_label22
.main_label21:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label22:
# %op23 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 0
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -70
# store i32 6, i32* %op23
	ld.d $t0, $fp, -70
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# %op24 = icmp slt i32 1, 0
	addi.w $t0, $zero, 1
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -71
# br i1 %op24, label %label25, label %label26
	ld.b $t0, $fp, -71
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label25
	b .main_label26
.main_label25:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label26:
# %op27 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 1
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 1
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -79
# store i32 3, i32* %op27
	ld.d $t0, $fp, -79
	addi.w $t1, $zero, 3
	st.w $t1, $t0, 0
# %op28 = icmp slt i32 2, 0
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -80
# br i1 %op28, label %label29, label %label30
	ld.b $t0, $fp, -80
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label29
	b .main_label30
.main_label29:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label30:
# %op31 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 2
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 2
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -88
# store i32 5, i32* %op31
	ld.d $t0, $fp, -88
	addi.w $t1, $zero, 5
	st.w $t1, $t0, 0
# %op32 = icmp slt i32 3, 0
	addi.w $t0, $zero, 3
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -89
# br i1 %op32, label %label33, label %label34
	ld.b $t0, $fp, -89
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label33
	b .main_label34
.main_label33:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label34:
# %op35 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 3
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 3
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -97
# store i32 4, i32* %op35
	ld.d $t0, $fp, -97
	addi.w $t1, $zero, 4
	st.w $t1, $t0, 0
# %op36 = icmp slt i32 4, 0
	addi.w $t0, $zero, 4
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -98
# br i1 %op36, label %label37, label %label38
	ld.b $t0, $fp, -98
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label37
	b .main_label38
.main_label37:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label38:
# %op39 = getelementptr [5 x i32], [5 x i32]* @v, i32 0, i32 4
	la.local $t0, v
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 20
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 4
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -106
# store i32 6, i32* %op39
	ld.d $t0, $fp, -106
	addi.w $t1, $zero, 6
	st.w $t1, $t0, 0
# br label %label56
	b .main_label56
.main_label40:
# %op41 = phi i32 [ %op55, %label53 ], [ 0, %label56 ]
# %op42 = icmp slt i32 %op41, 66
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 66
	slt $t2, $t0, $t1
	st.b $t2, $fp, -111
# %op43 = zext i1 %op42 to i32
	ld.b $t0, $fp, -111
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -115
# %op44 = icmp ne i32 %op43, 0
	ld.w $t0, $fp, -115
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -116
# br i1 %op44, label %label45, label %label48
	ld.b $t0, $fp, -116
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label45
	b .main_label48
.main_label45:
# %op47 = icmp slt i32 %op41, 0
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -117
# br i1 %op47, label %label52, label %label53
	ld.b $t0, $fp, -117
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label52
	b .main_label53
.main_label48:
# %op49 = load i32, i32* @n
	la.local $t0, n
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -121
# %op50 = load i32, i32* @m
	la.local $t0, m
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -125
# %op51 = call i32 @knapsack(i32 %op49, i32 %op50)
	ld.w $a0, $fp, -121
	ld.w $a1, $fp, -125
	bl knapsack
	st.w $a0, $fp, -129
# call void @output(i32 %op51)
	ld.w $a0, $fp, -129
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label52:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label53:
# %op54 = getelementptr [66 x i32], [66 x i32]* @dp, i32 0, i32 %op41
	la.local $t0, dp
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 264
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -110
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -137
# store i32 %op46, i32* %op54
	ld.d $t0, $fp, -137
	ld.w $t1, $fp, -145
	st.w $t1, $t0, 0
# %op55 = add i32 %op41, 1
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -141
# br label %label40
	ld.w $a0, $fp, -141
	st.w $a0, $fp, -110
	b .main_label40
.main_label56:
# %op46 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -145
# br label %label40
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	b .main_label40
main_exit:
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
