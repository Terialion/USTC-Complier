	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -240
.main_label_entry:
# br label %label89
	b .main_label89
.main_label0:
# %op1 = phi i32 [ %op9, %label15 ], [ undef, %label89 ]
# %op2 = phi i32 [ %op16, %label15 ], [ 0, %label89 ]
# %op3 = icmp slt i32 %op2, 1000000
	ld.w $t0, $fp, -24
	lu12i.w $t1, 244
	ori $t1, $t1, 576
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
# br label %label88
	b .main_label88
.main_label7:
# call void @output(i32 %op1)
	ld.w $a0, $fp, -20
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label8:
# %op9 = phi i32 [ %op18, %label25 ], [ %op1, %label88 ]
# %op10 = phi i32 [ %op26, %label25 ], [ 0, %label88 ]
# %op11 = icmp slt i32 %op10, 2
	ld.w $t0, $fp, -38
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
# br i1 %op13, label %label14, label %label15
	ld.b $t0, $fp, -44
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label14
	b .main_label15
.main_label14:
# br label %label87
	b .main_label87
.main_label15:
# %op16 = add i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -48
# br label %label0
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -48
	st.w $a0, $fp, -24
	b .main_label0
.main_label17:
# %op18 = phi i32 [ %op28, %label35 ], [ %op9, %label87 ]
# %op19 = phi i32 [ %op29, %label35 ], [ %op10, %label87 ]
# %op20 = phi i32 [ %op36, %label35 ], [ 0, %label87 ]
# %op21 = icmp slt i32 %op20, 2
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -61
# %op22 = zext i1 %op21 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -65
# %op23 = icmp ne i32 %op22, 0
	ld.w $t0, $fp, -65
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -66
# br i1 %op23, label %label24, label %label25
	ld.b $t0, $fp, -66
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label24
	b .main_label25
.main_label24:
# br label %label86
	b .main_label86
.main_label25:
# br label %label8
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -230
	st.w $a0, $fp, -38
	b .main_label8
.main_label27:
# %op28 = phi i32 [ %op38, %label45 ], [ %op18, %label86 ]
# %op29 = phi i32 [ %op39, %label45 ], [ %op19, %label86 ]
# %op30 = phi i32 [ %op46, %label45 ], [ 0, %label86 ]
# %op31 = icmp slt i32 %op30, 2
	ld.w $t0, $fp, -78
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -79
# %op32 = zext i1 %op31 to i32
	ld.b $t0, $fp, -79
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -83
# %op33 = icmp ne i32 %op32, 0
	ld.w $t0, $fp, -83
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -84
# br i1 %op33, label %label34, label %label35
	ld.b $t0, $fp, -84
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label34
	b .main_label35
.main_label34:
# br label %label85
	b .main_label85
.main_label35:
# %op36 = add i32 %op20, 1
	ld.w $t0, $fp, -60
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -88
# br label %label17
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -56
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -60
	b .main_label17
.main_label37:
# %op38 = phi i32 [ %op48, %label58 ], [ %op28, %label85 ]
# %op39 = phi i32 [ %op49, %label58 ], [ %op29, %label85 ]
# %op40 = phi i32 [ %op59, %label58 ], [ 0, %label85 ]
# %op41 = icmp slt i32 %op40, 2
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -101
# %op42 = zext i1 %op41 to i32
	ld.b $t0, $fp, -101
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -105
# %op43 = icmp ne i32 %op42, 0
	ld.w $t0, $fp, -105
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -106
# br i1 %op43, label %label44, label %label45
	ld.b $t0, $fp, -106
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label44
	b .main_label45
.main_label44:
# br label %label84
	b .main_label84
.main_label45:
# %op46 = add i32 %op30, 1
	ld.w $t0, $fp, -78
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -110
# br label %label27
	ld.w $a0, $fp, -92
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -74
	ld.w $a0, $fp, -110
	st.w $a0, $fp, -78
	b .main_label27
.main_label47:
# %op48 = phi i32 [ %op82, %label62 ], [ %op38, %label84 ]
# %op49 = phi i32 [ %op63, %label62 ], [ %op39, %label84 ]
# %op50 = phi i32 [ %op83, %label62 ], [ 0, %label84 ]
# %op51 = icmp slt i32 %op50, 2
	ld.w $t0, $fp, -122
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -123
# %op52 = zext i1 %op51 to i32
	ld.b $t0, $fp, -123
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -127
# %op53 = icmp ne i32 %op52, 0
	ld.w $t0, $fp, -127
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -128
# br i1 %op53, label %label54, label %label58
	ld.b $t0, $fp, -128
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label54
	b .main_label58
.main_label54:
# br i1 %op57, label %label60, label %label62
	ld.w $a0, $fp, -118
	st.w $a0, $fp, -140
	ld.b $t0, $fp, -150
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label60
	b .main_label62
.main_label58:
# %op59 = add i32 %op40, 1
	ld.w $t0, $fp, -100
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# br label %label37
	ld.w $a0, $fp, -114
	st.w $a0, $fp, -92
	ld.w $a0, $fp, -118
	st.w $a0, $fp, -96
	ld.w $a0, $fp, -132
	st.w $a0, $fp, -100
	b .main_label37
.main_label60:
# %op61 = add i32 %op49, 1
	ld.w $t0, $fp, -118
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# br label %label62
	ld.w $a0, $fp, -136
	st.w $a0, $fp, -140
	b .main_label62
.main_label62:
# %op63 = phi i32 [ %op49, %label54 ], [ %op61, %label60 ]
# %op83 = add i32 %op50, 1
	ld.w $t0, $fp, -122
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# br label %label47
	ld.w $a0, $fp, -226
	st.w $a0, $fp, -114
	ld.w $a0, $fp, -140
	st.w $a0, $fp, -118
	ld.w $a0, $fp, -144
	st.w $a0, $fp, -122
	b .main_label47
.main_label84:
# br label %label47
	ld.w $a0, $fp, -92
	st.w $a0, $fp, -114
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -118
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -122
	ld.w $a0, $fp, -92
	st.w $a0, $fp, -114
	ld.w $a0, $fp, -96
	st.w $a0, $fp, -118
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -122
	b .main_label47
.main_label85:
# br label %label37
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -92
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -96
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -100
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -92
	ld.w $a0, $fp, -74
	st.w $a0, $fp, -96
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -100
	b .main_label37
.main_label86:
# br label %label27
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -56
	st.w $a0, $fp, -74
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -78
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -56
	st.w $a0, $fp, -74
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -78
	b .main_label27
.main_label87:
# br label %label17
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -56
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -60
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -38
	st.w $a0, $fp, -56
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -60
	b .main_label17
.main_label88:
# br label %label8
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -34
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -38
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -34
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -38
	b .main_label8
.main_label89:
# %op55 = icmp sgt i32 2, 1
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 1
	slt $t2, $t1, $t0
	st.b $t2, $fp, -145
# %op56 = zext i1 %op55 to i32
	ld.b $t0, $fp, -145
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -149
# %op57 = icmp ne i32 %op56, 0
	ld.w $t0, $fp, -149
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -150
# %op64 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -154
# %op65 = mul i32 %op64, 2
	ld.w $t0, $fp, -154
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -158
# %op66 = mul i32 %op65, 2
	ld.w $t0, $fp, -158
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -162
# %op67 = mul i32 %op66, 2
	ld.w $t0, $fp, -162
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -166
# %op68 = mul i32 %op67, 2
	ld.w $t0, $fp, -166
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -170
# %op69 = mul i32 %op68, 2
	ld.w $t0, $fp, -170
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -174
# %op70 = mul i32 %op69, 2
	ld.w $t0, $fp, -174
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -178
# %op71 = mul i32 %op70, 2
	ld.w $t0, $fp, -178
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -182
# %op72 = mul i32 %op71, 2
	ld.w $t0, $fp, -182
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -186
# %op73 = sdiv i32 %op72, 2
	ld.w $t0, $fp, -186
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -190
# %op74 = sdiv i32 %op73, 2
	ld.w $t0, $fp, -190
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -194
# %op75 = sdiv i32 %op74, 2
	ld.w $t0, $fp, -194
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -198
# %op76 = sdiv i32 %op75, 2
	ld.w $t0, $fp, -198
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -202
# %op77 = sdiv i32 %op76, 2
	ld.w $t0, $fp, -202
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -206
# %op78 = sdiv i32 %op77, 2
	ld.w $t0, $fp, -206
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -210
# %op79 = sdiv i32 %op78, 2
	ld.w $t0, $fp, -210
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -214
# %op80 = sdiv i32 %op79, 2
	ld.w $t0, $fp, -214
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -218
# %op81 = sdiv i32 %op80, 2
	ld.w $t0, $fp, -218
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -222
# %op82 = sdiv i32 %op81, 2
	ld.w $t0, $fp, -222
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -226
# %op26 = add i32 %op19, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -230
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	b .main_label0
main_exit:
	addi.d $sp, $sp, 240
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
