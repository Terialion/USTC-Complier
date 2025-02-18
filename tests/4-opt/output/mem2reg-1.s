	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -144
.main_label_entry:
# %op0 = call i32 @input()
	bl input
	st.w $a0, $fp, -20
# br label %label1
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label1
.main_label1:
# %op2 = phi i32 [ 0, %label_entry ], [ %op33, %label7 ]
# %op3 = phi i32 [ 0, %label_entry ], [ %op32, %label7 ]
# %op4 = icmp slt i32 %op2, %op0
	ld.w $t0, $fp, -24
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
# br i1 %op6, label %label7, label %label34
	ld.b $t0, $fp, -34
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label7
	b .main_label34
.main_label7:
# %op8 = fmul float 0x3ff3c0c200000000, 0x4016f06a20000000
	lu12i.w $t8, 260576
	ori $t8, $t8, 1552
	movgr2fr.w $ft0, $t8
	lu12i.w $t8, 265080
	ori $t8, $t8, 849
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -38
# %op9 = fmul float %op8, 0x4002aa9940000000
	fld.s $ft0, $fp, -38
	lu12i.w $t8, 262485
	ori $t8, $t8, 1226
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -42
# %op10 = fmul float %op9, 0x4011781d80000000
	fld.s $ft0, $fp, -42
	lu12i.w $t8, 264380
	ori $t8, $t8, 236
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -46
# %op11 = fmul float %op10, 0x401962ac40000000
	fld.s $ft0, $fp, -46
	lu12i.w $t8, 265393
	ori $t8, $t8, 1378
	movgr2fr.w $ft1, $t8
	fmul.s $ft2, $ft0, $ft1
	fst.s $ft2, $fp, -50
# %op12 = fptosi float %op11 to i32
	fld.s $ft0, $fp, -50
	ftintrz.w.s $ft0, $ft0
	movfr2gr.s $t0, $ft0
	st.w $t0, $fp, -54
# %op13 = mul i32 %op12, %op12
	ld.w $t0, $fp, -54
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -58
# %op14 = mul i32 %op13, %op12
	ld.w $t0, $fp, -58
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -62
# %op15 = mul i32 %op14, %op12
	ld.w $t0, $fp, -62
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -66
# %op16 = mul i32 %op15, %op12
	ld.w $t0, $fp, -66
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# %op17 = mul i32 %op16, %op12
	ld.w $t0, $fp, -70
	ld.w $t1, $fp, -54
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -74
# %op18 = mul i32 %op17, %op17
	ld.w $t0, $fp, -74
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -78
# %op19 = mul i32 %op18, %op17
	ld.w $t0, $fp, -78
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -82
# %op20 = mul i32 %op19, %op17
	ld.w $t0, $fp, -82
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -86
# %op21 = mul i32 %op20, %op17
	ld.w $t0, $fp, -86
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -90
# %op22 = mul i32 %op21, %op17
	ld.w $t0, $fp, -90
	ld.w $t1, $fp, -74
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -94
# %op23 = mul i32 %op22, %op22
	ld.w $t0, $fp, -94
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -98
# %op24 = mul i32 %op23, %op22
	ld.w $t0, $fp, -98
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -102
# %op25 = mul i32 %op24, %op22
	ld.w $t0, $fp, -102
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -106
# %op26 = mul i32 %op25, %op22
	ld.w $t0, $fp, -106
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -110
# %op27 = mul i32 %op26, %op22
	ld.w $t0, $fp, -110
	ld.w $t1, $fp, -94
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -114
# %op28 = mul i32 %op27, %op27
	ld.w $t0, $fp, -114
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -118
# %op29 = mul i32 %op28, %op27
	ld.w $t0, $fp, -118
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -122
# %op30 = mul i32 %op29, %op27
	ld.w $t0, $fp, -122
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -126
# %op31 = mul i32 %op30, %op27
	ld.w $t0, $fp, -126
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -130
# %op32 = mul i32 %op31, %op27
	ld.w $t0, $fp, -130
	ld.w $t1, $fp, -114
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -134
# %op33 = add i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -138
# br label %label1
	ld.w $a0, $fp, -138
	st.w $a0, $fp, -24
	ld.w $a0, $fp, -134
	st.w $a0, $fp, -28
	b .main_label1
.main_label34:
# call void @output(i32 %op3)
	ld.w $a0, $fp, -28
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 144
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
