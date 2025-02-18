	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -128
.main_label_entry:
# br label %label0
	addi.w $a0, $zero, 1
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 1, %label_entry ], [ %op36, %label35 ]
# %op2 = phi i32 [ %op10, %label35 ], [ undef, %label_entry ]
# %op3 = icmp slt i32 %op1, 10000
	ld.w $t0, $fp, -20
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
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
# br i1 %op5, label %label6, label %label7
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label6
	b .main_label7
.main_label6:
# br label %label8
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -38
	b .main_label8
.main_label7:
# call void @output(i32 %op2)
	ld.w $a0, $fp, -24
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label8:
# %op9 = phi i32 [ 0, %label6 ], [ %op34, %label14 ]
# %op10 = phi i32 [ %op2, %label6 ], [ %op33, %label14 ]
# %op11 = icmp slt i32 %op9, 10000
	ld.w $t0, $fp, -34
	lu12i.w $t1, 2
	ori $t1, $t1, 1808
	slt $t2, $t0, $t1
	st.b $t2, $fp, -39
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -39
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -43
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -44
# br i1 %op13, label %label14, label %label35
	ld.b $t0, $fp, -44
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label14
	b .main_label35
.main_label14:
# %op15 = mul i32 %op1, %op1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# %op16 = mul i32 %op15, %op1
	ld.w $t0, $fp, -48
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# %op17 = mul i32 %op16, %op1
	ld.w $t0, $fp, -52
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -56
# %op18 = mul i32 %op17, %op1
	ld.w $t0, $fp, -56
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op19 = mul i32 %op18, %op1
	ld.w $t0, $fp, -60
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# %op20 = mul i32 %op19, %op1
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op21 = mul i32 %op20, %op1
	ld.w $t0, $fp, -68
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op22 = mul i32 %op21, %op1
	ld.w $t0, $fp, -72
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op23 = mul i32 %op22, %op1
	ld.w $t0, $fp, -76
	ld.w $t1, $fp, -20
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# %op24 = sdiv i32 %op23, %op1
	ld.w $t0, $fp, -80
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op25 = sdiv i32 %op24, %op1
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op26 = sdiv i32 %op25, %op1
	ld.w $t0, $fp, -88
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op27 = sdiv i32 %op26, %op1
	ld.w $t0, $fp, -92
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op28 = sdiv i32 %op27, %op1
	ld.w $t0, $fp, -96
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op29 = sdiv i32 %op28, %op1
	ld.w $t0, $fp, -100
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op30 = sdiv i32 %op29, %op1
	ld.w $t0, $fp, -104
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op31 = sdiv i32 %op30, %op1
	ld.w $t0, $fp, -108
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op32 = sdiv i32 %op31, %op1
	ld.w $t0, $fp, -112
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op33 = sdiv i32 %op32, %op1
	ld.w $t0, $fp, -116
	ld.w $t1, $fp, -20
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op34 = add i32 %op9, 1
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# br label %label8
	ld.w $a0, $fp, -124
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -120
	st.w $a0, $fp, -38
	b .main_label8
.main_label35:
# %op36 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# br label %label0
	ld.w $a0, $fp, -128
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -24
	b .main_label0
main_exit:
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
