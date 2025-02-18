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
	addi.d $sp, $sp, -80
.readarray_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label1
	b .readarray_label1
.readarray_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# %op3 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# %op4 = icmp slt i32 %op2, %op3
	ld.w $t0, $fp, -32
	ld.w $t1, $fp, -36
	slt $t2, $t0, $t1
	st.b $t2, $fp, -37
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -37
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -41
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -41
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -42
# br i1 %op6, label %label7, label %label11
	ld.b $t0, $fp, -42
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .readarray_label7
	b .readarray_label11
.readarray_label7:
# %op8 = call i32 @input()
	bl input
	st.w $a0, $fp, -46
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -50
# %op10 = icmp slt i32 %op9, 0
	ld.w $t0, $fp, -50
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -51
# br i1 %op10, label %label12, label %label13
	ld.b $t0, $fp, -51
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .readarray_label12
	b .readarray_label13
.readarray_label11:
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label12:
# call void @neg_idx_except()
	bl neg_idx_except
# ret void
	addi.w $a0, $zero, 0
	b readarray_exit
.readarray_label13:
# %op14 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op9
	la.local $t0, ad
	addi.w $t1, $zero, 0
	lu12i.w $t2, 97
	ori $t2, $t2, 2688
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -50
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -59
# store i32 %op8, i32* %op14
	ld.d $t0, $fp, -59
	ld.w $t1, $fp, -46
	st.w $t1, $t0, 0
# %op15 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -63
# %op16 = add i32 %op15, 1
	ld.w $t0, $fp, -63
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -67
# store i32 %op16, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -67
	st.w $t1, $t0, 0
# br label %label1
	b .readarray_label1
readarray_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl transpose
	.type transpose, @function
transpose:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -368
	st.w $a0, $fp, -20
	st.d $a1, $fp, -28
	st.w $a2, $fp, -32
.transpose_label_entry:
# %op3 = alloca i32
	addi.d $t0, $fp, -44
	st.d $t0, $fp, -40
# store i32 %arg0, i32* %op3
	ld.d $t0, $fp, -40
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op4 = alloca i32*
	addi.d $t0, $fp, -60
	st.d $t0, $fp, -52
# store i32* %arg1, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t1, $fp, -28
	st.d $t1, $t0, 0
# %op5 = alloca i32
	addi.d $t0, $fp, -72
	st.d $t0, $fp, -68
# store i32 %arg2, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# %op6 = alloca i32
	addi.d $t0, $fp, -84
	st.d $t0, $fp, -80
# %op7 = alloca i32
	addi.d $t0, $fp, -96
	st.d $t0, $fp, -92
# %op8 = alloca i32
	addi.d $t0, $fp, -108
	st.d $t0, $fp, -104
# %op9 = alloca i32
	addi.d $t0, $fp, -120
	st.d $t0, $fp, -116
# %op10 = load i32, i32* %op3
	ld.d $t0, $fp, -40
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -124
# %op11 = load i32, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -128
# %op12 = sdiv i32 %op10, %op11
	ld.w $t0, $fp, -124
	ld.w $t1, $fp, -128
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# store i32 %op12, i32* %op6
	ld.d $t0, $fp, -80
	ld.w $t1, $fp, -132
	st.w $t1, $t0, 0
# store i32 0, i32* %op7
	ld.d $t0, $fp, -92
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op8
	ld.d $t0, $fp, -104
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label13
	b .transpose_label13
.transpose_label13:
# %op14 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -136
# %op15 = load i32, i32* %op6
	ld.d $t0, $fp, -80
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -140
# %op16 = icmp slt i32 %op14, %op15
	ld.w $t0, $fp, -136
	ld.w $t1, $fp, -140
	slt $t2, $t0, $t1
	st.b $t2, $fp, -141
# %op17 = zext i1 %op16 to i32
	ld.b $t0, $fp, -141
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -145
# %op18 = icmp ne i32 %op17, 0
	ld.w $t0, $fp, -145
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -146
# br i1 %op18, label %label19, label %label20
	ld.b $t0, $fp, -146
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label19
	b .transpose_label20
.transpose_label19:
# store i32 0, i32* %op8
	ld.d $t0, $fp, -104
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label22
	b .transpose_label22
.transpose_label20:
# %op21 = sub i32 0, 1
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -150
# ret i32 %op21
	ld.w $a0, $fp, -150
	b transpose_exit
.transpose_label22:
# %op23 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -154
# %op24 = load i32, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -158
# %op25 = icmp slt i32 %op23, %op24
	ld.w $t0, $fp, -154
	ld.w $t1, $fp, -158
	slt $t2, $t0, $t1
	st.b $t2, $fp, -159
# %op26 = zext i1 %op25 to i32
	ld.b $t0, $fp, -159
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -163
# %op27 = icmp ne i32 %op26, 0
	ld.w $t0, $fp, -163
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -164
# br i1 %op27, label %label28, label %label34
	ld.b $t0, $fp, -164
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label28
	b .transpose_label34
.transpose_label28:
# %op29 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -168
# %op30 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -172
# %op31 = icmp slt i32 %op29, %op30
	ld.w $t0, $fp, -168
	ld.w $t1, $fp, -172
	slt $t2, $t0, $t1
	st.b $t2, $fp, -173
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -173
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -177
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -177
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -178
# br i1 %op33, label %label37, label %label41
	ld.b $t0, $fp, -178
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label37
	b .transpose_label41
.transpose_label34:
# %op35 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -182
# %op36 = add i32 %op35, 1
	ld.w $t0, $fp, -182
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# store i32 %op36, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t1, $fp, -186
	st.w $t1, $t0, 0
# br label %label13
	b .transpose_label13
.transpose_label37:
# %op38 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -190
# %op39 = add i32 %op38, 1
	ld.w $t0, $fp, -190
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -194
# store i32 %op39, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t1, $fp, -194
	st.w $t1, $t0, 0
# br label %label40
	b .transpose_label40
.transpose_label40:
# br label %label22
	b .transpose_label22
.transpose_label41:
# %op42 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -198
# %op43 = load i32, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -202
# %op44 = mul i32 %op42, %op43
	ld.w $t0, $fp, -198
	ld.w $t1, $fp, -202
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -206
# %op45 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -210
# %op46 = add i32 %op44, %op45
	ld.w $t0, $fp, -206
	ld.w $t1, $fp, -210
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -214
# %op47 = icmp slt i32 %op46, 0
	ld.w $t0, $fp, -214
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -215
# br i1 %op47, label %label48, label %label49
	ld.b $t0, $fp, -215
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label48
	b .transpose_label49
.transpose_label48:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label49:
# %op50 = load i32*, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -223
# %op51 = getelementptr i32, i32* %op50, i32 %op46
	ld.d $t0, $fp, -223
	ld.w $t1, $fp, -214
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -231
# %op52 = load i32, i32* %op51
	ld.d $t0, $fp, -231
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -235
# store i32 %op52, i32* %op9
	ld.d $t0, $fp, -116
	ld.w $t1, $fp, -235
	st.w $t1, $t0, 0
# %op53 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -239
# %op54 = load i32, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -243
# %op55 = mul i32 %op53, %op54
	ld.w $t0, $fp, -239
	ld.w $t1, $fp, -243
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -247
# %op56 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -251
# %op57 = add i32 %op55, %op56
	ld.w $t0, $fp, -247
	ld.w $t1, $fp, -251
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -255
# %op58 = icmp slt i32 %op57, 0
	ld.w $t0, $fp, -255
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -256
# br i1 %op58, label %label59, label %label60
	ld.b $t0, $fp, -256
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label59
	b .transpose_label60
.transpose_label59:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label60:
# %op61 = load i32*, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -264
# %op62 = getelementptr i32, i32* %op61, i32 %op57
	ld.d $t0, $fp, -264
	ld.w $t1, $fp, -255
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -272
# %op63 = load i32, i32* %op62
	ld.d $t0, $fp, -272
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -276
# %op64 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -280
# %op65 = load i32, i32* %op6
	ld.d $t0, $fp, -80
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -284
# %op66 = mul i32 %op64, %op65
	ld.w $t0, $fp, -280
	ld.w $t1, $fp, -284
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -288
# %op67 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -292
# %op68 = add i32 %op66, %op67
	ld.w $t0, $fp, -288
	ld.w $t1, $fp, -292
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -296
# %op69 = icmp slt i32 %op68, 0
	ld.w $t0, $fp, -296
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -297
# br i1 %op69, label %label70, label %label71
	ld.b $t0, $fp, -297
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label70
	b .transpose_label71
.transpose_label70:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label71:
# %op72 = load i32*, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -305
# %op73 = getelementptr i32, i32* %op72, i32 %op68
	ld.d $t0, $fp, -305
	ld.w $t1, $fp, -296
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -313
# store i32 %op63, i32* %op73
	ld.d $t0, $fp, -313
	ld.w $t1, $fp, -276
	st.w $t1, $t0, 0
# %op74 = load i32, i32* %op9
	ld.d $t0, $fp, -116
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -317
# %op75 = load i32, i32* %op7
	ld.d $t0, $fp, -92
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -321
# %op76 = load i32, i32* %op5
	ld.d $t0, $fp, -68
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -325
# %op77 = mul i32 %op75, %op76
	ld.w $t0, $fp, -321
	ld.w $t1, $fp, -325
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -329
# %op78 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -333
# %op79 = add i32 %op77, %op78
	ld.w $t0, $fp, -329
	ld.w $t1, $fp, -333
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -337
# %op80 = icmp slt i32 %op79, 0
	ld.w $t0, $fp, -337
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -338
# br i1 %op80, label %label81, label %label82
	ld.b $t0, $fp, -338
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .transpose_label81
	b .transpose_label82
.transpose_label81:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b transpose_exit
.transpose_label82:
# %op83 = load i32*, i32** %op4
	ld.d $t0, $fp, -52
	ld.d $t0, $t0, 0
	st.d $t0, $fp, -346
# %op84 = getelementptr i32, i32* %op83, i32 %op79
	ld.d $t0, $fp, -346
	ld.w $t1, $fp, -337
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -354
# store i32 %op74, i32* %op84
	ld.d $t0, $fp, -354
	ld.w $t1, $fp, -317
	st.w $t1, $t0, 0
# %op85 = load i32, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -358
# %op86 = add i32 %op85, 1
	ld.w $t0, $fp, -358
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -362
# store i32 %op86, i32* %op8
	ld.d $t0, $fp, -104
	ld.w $t1, $fp, -362
	st.w $t1, $t0, 0
# br label %label40
	b .transpose_label40
transpose_exit:
	addi.d $sp, $sp, 368
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -240
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# %op2 = alloca i32
	addi.d $t0, $fp, -52
	st.d $t0, $fp, -48
# %op3 = call i32 @input()
	bl input
	st.w $a0, $fp, -56
# store i32 %op3, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -56
	st.w $t1, $t0, 0
# %op4 = call i32 @input()
	bl input
	st.w $a0, $fp, -60
# store i32 %op4, i32* @len
	la.local $t0, len
	ld.w $t1, $fp, -60
	st.w $t1, $t0, 0
# call void @readarray()
	bl readarray
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label5
	b .main_label5
.main_label5:
# %op6 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -64
# %op7 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op8 = icmp slt i32 %op6, %op7
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -68
	slt $t2, $t0, $t1
	st.b $t2, $fp, -69
# %op9 = zext i1 %op8 to i32
	ld.b $t0, $fp, -69
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -73
# %op10 = icmp ne i32 %op9, 0
	ld.w $t0, $fp, -73
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -74
# br i1 %op10, label %label11, label %label15
	ld.b $t0, $fp, -74
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label11
	b .main_label15
.main_label11:
# %op12 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -78
# %op13 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -82
# %op14 = icmp slt i32 %op13, 0
	ld.w $t0, $fp, -82
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -83
# br i1 %op14, label %label16, label %label17
	ld.b $t0, $fp, -83
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label16
	b .main_label17
.main_label15:
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
.main_label16:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label17:
# %op18 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op13
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	lu12i.w $t2, 19531
	ori $t2, $t2, 1024
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -82
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -91
# store i32 %op12, i32* %op18
	ld.d $t0, $fp, -91
	ld.w $t1, $fp, -78
	st.w $t1, $t0, 0
# %op19 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -95
# %op20 = add i32 %op19, 1
	ld.w $t0, $fp, -95
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -99
# store i32 %op20, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -99
	st.w $t1, $t0, 0
# br label %label5
	b .main_label5
.main_label21:
# %op22 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -103
# %op23 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -107
# %op24 = icmp slt i32 %op22, %op23
	ld.w $t0, $fp, -103
	ld.w $t1, $fp, -107
	slt $t2, $t0, $t1
	st.b $t2, $fp, -108
# %op25 = zext i1 %op24 to i32
	ld.b $t0, $fp, -108
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -112
# %op26 = icmp ne i32 %op25, 0
	ld.w $t0, $fp, -112
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -113
# br i1 %op26, label %label27, label %label32
	ld.b $t0, $fp, -113
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label27
	b .main_label32
.main_label27:
# %op28 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -117
# %op29 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 0
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
	st.d $t0, $fp, -125
# %op30 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -129
# %op31 = icmp slt i32 %op30, 0
	ld.w $t0, $fp, -129
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -130
# br i1 %op31, label %label33, label %label34
	ld.b $t0, $fp, -130
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label33
	b .main_label34
.main_label32:
# store i32 0, i32* %op2
	ld.d $t0, $fp, -48
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label40
	b .main_label40
.main_label33:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label34:
# %op35 = getelementptr [100000 x i32], [100000 x i32]* @ad, i32 0, i32 %op30
	la.local $t0, ad
	addi.w $t1, $zero, 0
	lu12i.w $t2, 97
	ori $t2, $t2, 2688
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -129
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -138
# %op36 = load i32, i32* %op35
	ld.d $t0, $fp, -138
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -142
# %op37 = call i32 @transpose(i32 %op28, i32* %op29, i32 %op36)
	ld.w $a0, $fp, -117
	ld.d $a1, $fp, -125
	ld.w $a2, $fp, -142
	bl transpose
	st.w $a0, $fp, -146
# %op38 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -150
# %op39 = add i32 %op38, 1
	ld.w $t0, $fp, -150
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -154
# store i32 %op39, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -154
	st.w $t1, $t0, 0
# br label %label21
	b .main_label21
.main_label40:
# %op41 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -158
# %op42 = load i32, i32* @len
	la.local $t0, len
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -162
# %op43 = icmp slt i32 %op41, %op42
	ld.w $t0, $fp, -158
	ld.w $t1, $fp, -162
	slt $t2, $t0, $t1
	st.b $t2, $fp, -163
# %op44 = zext i1 %op43 to i32
	ld.b $t0, $fp, -163
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -167
# %op45 = icmp ne i32 %op44, 0
	ld.w $t0, $fp, -167
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -168
# br i1 %op45, label %label46, label %label53
	ld.b $t0, $fp, -168
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label46
	b .main_label53
.main_label46:
# %op47 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -172
# %op48 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -176
# %op49 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -180
# %op50 = mul i32 %op48, %op49
	ld.w $t0, $fp, -176
	ld.w $t1, $fp, -180
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# %op51 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -188
# %op52 = icmp slt i32 %op51, 0
	ld.w $t0, $fp, -188
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -189
# br i1 %op52, label %label58, label %label59
	ld.b $t0, $fp, -189
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label58
	b .main_label59
.main_label53:
# %op54 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -193
# %op55 = icmp slt i32 %op54, 0
	ld.w $t0, $fp, -193
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -194
# %op56 = zext i1 %op55 to i32
	ld.b $t0, $fp, -194
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -198
# %op57 = icmp ne i32 %op56, 0
	ld.w $t0, $fp, -198
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -199
# br i1 %op57, label %label66, label %label69
	ld.b $t0, $fp, -199
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label66
	b .main_label69
.main_label58:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label59:
# %op60 = getelementptr [20000000 x i32], [20000000 x i32]* @matrix, i32 0, i32 %op51
	la.local $t0, matrix
	addi.w $t1, $zero, 0
	lu12i.w $t2, 19531
	ori $t2, $t2, 1024
	lu32i.d $t2, 0
	lu52i.d $t2, $t2, 0
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	ld.w $t1, $fp, -188
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -207
# %op61 = load i32, i32* %op60
	ld.d $t0, $fp, -207
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -211
# %op62 = mul i32 %op50, %op61
	ld.w $t0, $fp, -184
	ld.w $t1, $fp, -211
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -215
# %op63 = add i32 %op47, %op62
	ld.w $t0, $fp, -172
	ld.w $t1, $fp, -215
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -219
# store i32 %op63, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -219
	st.w $t1, $t0, 0
# %op64 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -223
# %op65 = add i32 %op64, 1
	ld.w $t0, $fp, -223
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -227
# store i32 %op65, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -227
	st.w $t1, $t0, 0
# br label %label40
	b .main_label40
.main_label66:
# %op67 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -231
# %op68 = sub i32 0, %op67
	addi.w $t0, $zero, 0
	ld.w $t1, $fp, -231
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -235
# store i32 %op68, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t1, $fp, -235
	st.w $t1, $t0, 0
# br label %label69
	b .main_label69
.main_label69:
# %op70 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -239
# call void @output(i32 %op70)
	ld.w $a0, $fp, -239
	bl output
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 240
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
