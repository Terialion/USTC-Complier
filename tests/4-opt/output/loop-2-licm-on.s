	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -128
.main_label_entry:
# br label %label38
	b .main_label38
.main_label0:
# %op1 = phi i32 [ %op36, %label35 ], [ 0, %label38 ]
# %op2 = phi i32 [ %op10, %label35 ], [ undef, %label38 ]
# %op3 = icmp slt i32 %op1, 10000000
	ld.w $t0, $fp, -20
	lu12i.w $t1, 2441
	ori $t1, $t1, 1664
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
# br label %label37
	b .main_label37
.main_label7:
# call void @output(i32 %op2)
	ld.w $a0, $fp, -24
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label8:
# %op9 = phi i32 [ %op34, %label14 ], [ 0, %label37 ]
# %op10 = phi i32 [ %op33, %label14 ], [ %op2, %label37 ]
# %op11 = icmp slt i32 %op9, 2
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 2
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
# %op34 = add i32 %op9, 1
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# br label %label8
	ld.w $a0, $fp, -48
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -128
	st.w $a0, $fp, -38
	b .main_label8
.main_label35:
# %op36 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# br label %label0
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -24
	b .main_label0
.main_label37:
# br label %label8
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -38
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -24
	st.w $a0, $fp, -38
	b .main_label8
.main_label38:
# %op15 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -56
# %op16 = mul i32 %op15, 2
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op17 = mul i32 %op16, 2
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -64
# %op18 = mul i32 %op17, 2
	ld.w $t0, $fp, -64
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -68
# %op19 = mul i32 %op18, 2
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op20 = mul i32 %op19, 2
	ld.w $t0, $fp, -72
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -76
# %op21 = mul i32 %op20, 2
	ld.w $t0, $fp, -76
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# %op22 = mul i32 %op21, 2
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# %op23 = mul i32 %op22, 2
	ld.w $t0, $fp, -84
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# %op24 = sdiv i32 %op23, 2
	ld.w $t0, $fp, -88
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -92
# %op25 = sdiv i32 %op24, 2
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -96
# %op26 = sdiv i32 %op25, 2
	ld.w $t0, $fp, -96
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -100
# %op27 = sdiv i32 %op26, 2
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -104
# %op28 = sdiv i32 %op27, 2
	ld.w $t0, $fp, -104
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -108
# %op29 = sdiv i32 %op28, 2
	ld.w $t0, $fp, -108
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -112
# %op30 = sdiv i32 %op29, 2
	ld.w $t0, $fp, -112
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -116
# %op31 = sdiv i32 %op30, 2
	ld.w $t0, $fp, -116
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# %op32 = sdiv i32 %op31, 2
	ld.w $t0, $fp, -120
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# %op33 = sdiv i32 %op32, 2
	ld.w $t0, $fp, -124
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label0
main_exit:
	addi.d $sp, $sp, 128
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
