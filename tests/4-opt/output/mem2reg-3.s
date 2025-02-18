# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl matrix
	.type matrix, @object
	.size matrix, 80000000
matrix:
	.space 80000000
	.globl ad
	.type ad, @object
	.size ad, 400000
ad:
	.space 400000
	.globl len
	.type len, @object
	.size len, 4
len:
	.space 4
	.text
	.globl readarray
	.type readarray, @function
readarray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.readarray_label_entry:
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .readarray_label0
.readarray_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op13, %label11 ]
# %op2 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -24
# %op3 = icmp slt i32 %op1, %op2
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	slt $t2, $t0, $t1
	st.b $t2, $fp, -25
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -29
# %op5 = icmp ne i32 %op4, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -30
# br i1 %op5, label %label6, label %label9
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .readarray_label6
	b .readarray_label9
.readarray_label6:
# %op7 = call i32 @input()
	bl input
	st.w $a0, $fp, -34
# %op8 = icmp slt i32 %op1, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -35
# br i1 %op8, label %label10, label %label11
	ld.b $t0, $fp, -35
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .readarray_label10
	b .readarray_label11
.readarray_label9:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label11:
# %op12 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op1
	la.local $t0, ad
	addi.w $t1, $zero, 0
	lu12i.w $t2, 97
	ori $t2, $t2, 2688
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -20
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -43
# store i32 %op7, i32* %op12
	ld.d $t0, $fp, -43
	ld.w $t1, $fp, -34
	st.w $t1, $t0, 0
# %op13 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label0
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -20
	b .readarray_label0
readarray_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -160
	st.w $a0, $fp, -20
	st.d $a1, $fp, -28
	st.w $a2, $fp, -32
.transpose_label_entry:
# %op3 = sdiv i32 %arg0, %arg2
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -32
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -36
# br label %label4
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -40
	b .transpose_label4
.transpose_label4:
# %op5 = phi i32 [ 0, %label_entry ], [ %op22, %label21 ]
# %op6 = icmp slt i32 %op5, %op3
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -36
	slt $t2, $t0, $t1
	st.b $t2, $fp, -41
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -41
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -45
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -45
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -46
# br i1 %op8, label %label9, label %label10
	ld.b $t0, $fp, -46
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label9
	b .transpose_label10
.transpose_label9:
# br label %label12
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -54
	b .transpose_label12
.transpose_label10:
# %op11 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -50
# ret i32 %op11
	ld.w $a0, $fp, -50
	b transpose_exit
.transpose_label12:
# %op13 = phi i32 [ 0, %label9 ], [ %op26, %label25 ]
# %op14 = icmp slt i32 %op13, %arg2
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -32
	slt $t2, $t0, $t1
	st.b $t2, $fp, -55
# %op15 = zext i1 %op14 to i32
	ld.b $t0, $fp, -55
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -59
# %op16 = icmp ne i32 %op15, 0
	ld.w $t0, $fp, -59
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -60
# br i1 %op16, label %label17, label %label21
	ld.b $t0, $fp, -60
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label17
	b .transpose_label21
.transpose_label17:
# %op18 = icmp slt i32 %op5, %op13
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -54
	slt $t2, $t0, $t1
	st.b $t2, $fp, -61
# %op19 = zext i1 %op18 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -65
# %op20 = icmp ne i32 %op19, 0
	ld.w $t0, $fp, -65
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -66
# br i1 %op20, label %label23, label %label27
	ld.b $t0, $fp, -66
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label23
	b .transpose_label27
.transpose_label21:
# %op22 = add i32 %op5, 1
	ld.w $t0, $fp, -40
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# br label %label4
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -40
	b .transpose_label4
.transpose_label23:
# %op24 = add i32 %op13, 1
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -74
# br label %label25
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -78
	b .transpose_label25
.transpose_label25:
# %op26 = phi i32 [ %op24, %label23 ], [ %op54, %label52 ]
# br label %label12
	ld.w $a0, $fp, -78
	st.w $a0, $fp, -54
	b .transpose_label12
.transpose_label27:
# %op28 = mul i32 %op5, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -82
# %op29 = add i32 %op28, %op13
	ld.w $t0, $fp, -82
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# %op30 = icmp slt i32 %op29, 0
	ld.w $t0, $fp, -86
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -87
# br i1 %op30, label %label31, label %label32
	ld.b $t0, $fp, -87
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label31
	b .transpose_label32
.transpose_label31:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label32:
# %op33 = getelementptr i32, i32* %arg1, i32 %op29
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -86
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -95
# %op34 = load i32, i32* %op33
	ld.d $t0, $fp, -95
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -99
# %op35 = mul i32 %op5, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -103
# %op36 = add i32 %op35, %op13
	ld.w $t0, $fp, -103
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -107
# %op37 = icmp slt i32 %op36, 0
	ld.w $t0, $fp, -107
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -108
# br i1 %op37, label %label38, label %label39
	ld.b $t0, $fp, -108
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label38
	b .transpose_label39
.transpose_label38:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label39:
# %op40 = getelementptr i32, i32* %arg1, i32 %op36
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -107
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -116
# %op41 = load i32, i32* %op40
	ld.d $t0, $fp, -116
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -120
# %op42 = mul i32 %op13, %op3
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -36
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op43 = add i32 %op42, %op5
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -40
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op44 = icmp slt i32 %op43, 0
	ld.w $t0, $fp, -128
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -129
# br i1 %op44, label %label45, label %label46
	ld.b $t0, $fp, -129
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label45
	b .transpose_label46
.transpose_label45:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label46:
# %op47 = getelementptr i32, i32* %arg1, i32 %op43
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -128
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -137
# store i32 %op41, i32* %op47
	ld.d $t0, $fp, -137
	ld.w $t1, $fp, -120
	st.w $t1, $t0, 0
# %op48 = mul i32 %op5, %arg2
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -32
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -141
# %op49 = add i32 %op48, %op13
	ld.w $t0, $fp, -141
	ld.w $t1, $fp, -54
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -145
# %op50 = icmp slt i32 %op49, 0
	ld.w $t0, $fp, -145
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -146
# br i1 %op50, label %label51, label %label52
	ld.b $t0, $fp, -146
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label51
	b .transpose_label52
.transpose_label51:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label52:
# %op53 = getelementptr i32, i32* %arg1, i32 %op49
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -145
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -154
# store i32 %op34, i32* %op53
	ld.d $t0, $fp, -154
	ld.w $t1, $fp, -99
	st.w $t1, $t0, 0
# %op54 = add i32 %op13, 1
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -158
# br label %label25
	ld.w $a0, $fp, -158
	st.w $a0, $fp, -78
	b .transpose_label25
transpose_exit:
	addi.d $sp, $sp, 160
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
# %op0 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# %op1 = call i32 @input()
	bl input
	st.w $a0, $fp, -24
# store i32 %op1, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -24
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# br label %label2
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label2
.main_label2:
# %op3 = phi i32 [ 0, %label_entry ], [ %op13, %label11 ]
# %op4 = icmp slt i32 %op3, %op0
	ld.w $t0, $fp, -28
	ld.w $t1, $fp, -20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -29
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -33
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -34
# br i1 %op6, label %label7, label %label9
	ld.b $t0, $fp, -34
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label7
	b .main_label9
.main_label7:
# %op8 = icmp slt i32 %op3, 0
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -35
# br i1 %op8, label %label10, label %label11
	ld.b $t0, $fp, -35
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label10
	b .main_label11
.main_label9:
# br label %label14
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -51
	b .main_label14
.main_label10:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label11:
# %op12 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op3
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	lu12i.w $t2, 19531
	ori $t2, $t2, 1024
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -28
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -43
# store i32 %op3, i32* %op12
	ld.d $t0, $fp, -43
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op13 = add i32 %op3, 1
	ld.w $t0, $fp, -28
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label2
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -28
	b .main_label2
.main_label14:
# %op15 = phi i32 [ 0, %label9 ], [ %op29, %label25 ]
# %op16 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -55
# %op17 = icmp slt i32 %op15, %op16
	ld.w $t0, $fp, -51
	ld.w $t1, $fp, -55
	slt $t2, $t0, $t1
	st.b $t2, $fp, -56
# %op18 = zext i1 %op17 to i32
	ld.b $t0, $fp, -56
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -60
# %op19 = icmp ne i32 %op18, 0
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -61
# br i1 %op19, label %label20, label %label23
	ld.b $t0, $fp, -61
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label20
	b .main_label23
.main_label20:
# %op21 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	lu12i.w $t2, 19531
	ori $t2, $t2, 1024
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -69
# %op22 = icmp slt i32 %op15, 0
	ld.w $t0, $fp, -51
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -70
# br i1 %op22, label %label24, label %label25
	ld.b $t0, $fp, -70
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label24
	b .main_label25
.main_label23:
# br label %label30
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -94
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -98
	b .main_label30
.main_label24:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label25:
# %op26 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op15
	la.local $t0, ad
	addi.w $t1, $zero, 0
	lu12i.w $t2, 97
	ori $t2, $t2, 2688
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -51
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -78
# %op27 = load i32, i32* %op26
	ld.d $t0, $fp, -78
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -82
# %op28 = call i32 @transpose(i32 %op0, i32* %op21, i32 %op27)
	ld.w $a0, $fp, -20
	ld.d $a1, $fp, -69
	ld.w $a2, $fp, -82
	bl transpose
	st.w $a0, $fp, -86
# %op29 = add i32 %op15, 1
	ld.w $t0, $fp, -51
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -90
# br label %label14
	ld.w $a0, $fp, -90
	st.w $a0, $fp, -51
	b .main_label14
.main_label30:
# %op31 = phi i32 [ 0, %label23 ], [ %op49, %label45 ]
# %op32 = phi i32 [ 0, %label23 ], [ %op50, %label45 ]
# %op33 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -102
# %op34 = icmp slt i32 %op32, %op33
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -102
	slt $t2, $t0, $t1
	st.b $t2, $fp, -103
# %op35 = zext i1 %op34 to i32
	ld.b $t0, $fp, -103
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -107
# %op36 = icmp ne i32 %op35, 0
	ld.w $t0, $fp, -107
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -108
# br i1 %op36, label %label37, label %label40
	ld.b $t0, $fp, -108
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label37
	b .main_label40
.main_label37:
# %op38 = mul i32 %op32, %op32
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -98
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op39 = icmp slt i32 %op32, 0
	ld.w $t0, $fp, -98
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -113
# br i1 %op39, label %label44, label %label45
	ld.b $t0, $fp, -113
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label44
	b .main_label45
.main_label40:
# %op41 = icmp slt i32 %op31, 0
	ld.w $t0, $fp, -94
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -114
# %op42 = zext i1 %op41 to i32
	ld.b $t0, $fp, -114
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -118
# %op43 = icmp ne i32 %op42, 0
	ld.w $t0, $fp, -118
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -119
# br i1 %op43, label %label51, label %label53
	ld.w $a0, $fp, -94
	st.w $a0, $fp, -151
	ld.b $t0, $fp, -119
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label51
	b .main_label53
.main_label44:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label45:
# %op46 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op32
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	lu12i.w $t2, 19531
	ori $t2, $t2, 1024
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -98
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -127
# %op47 = load i32, i32* %op46
	ld.d $t0, $fp, -127
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -131
# %op48 = mul i32 %op38, %op47
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -131
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -135
# %op49 = add i32 %op31, %op48
	ld.w $t0, $fp, -94
	ld.w $t1, $fp, -135
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -139
# %op50 = add i32 %op32, 1
	ld.w $t0, $fp, -98
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -143
# br label %label30
	ld.w $a0, $fp, -139
	st.w $a0, $fp, -94
	ld.w $a0, $fp, -143
	st.w $a0, $fp, -98
	b .main_label30
.main_label51:
# %op52 = sub i32 0, %op31
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -94
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -147
# br label %label53
	ld.w $a0, $fp, -147
	st.w $a0, $fp, -151
	b .main_label53
.main_label53:
# %op54 = phi i32 [ %op31, %label40 ], [ %op52, %label51 ]
# call void @output(i32 %op54)
	ld.w $a0, $fp, -151
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 160
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
