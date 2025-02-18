	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -208
.main_label_entry:
# br label %label78
	b .main_label78
.main_label0:
# %op1 = phi i32 [ %op9, %label15 ], [ undef, %label78 ]
# %op2 = phi i32 [ %op16, %label15 ], [ 0, %label78 ]
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
# br label %label77
	b .main_label77
.main_label7:
# call void @output(i32 %op1)
	ld.w $a0, $fp, -20
	bl output
# ret void
	addi.w $a0, $zero, 0
	b main_exit
.main_label8:
# %op9 = phi i32 [ %op18, %label24 ], [ %op1, %label77 ]
# %op10 = phi i32 [ %op25, %label24 ], [ 0, %label77 ]
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
# br label %label76
	b .main_label76
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
# %op18 = phi i32 [ %op27, %label33 ], [ %op9, %label76 ]
# %op19 = phi i32 [ %op34, %label33 ], [ 0, %label76 ]
# %op20 = icmp slt i32 %op19, 2
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -57
# %op21 = zext i1 %op20 to i32
	ld.b $t0, $fp, -57
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -61
# %op22 = icmp ne i32 %op21, 0
	ld.w $t0, $fp, -61
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -62
# br i1 %op22, label %label23, label %label24
	ld.b $t0, $fp, -62
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label23
	b .main_label24
.main_label23:
# br label %label75
	b .main_label75
.main_label24:
# %op25 = add i32 %op10, 1
	ld.w $t0, $fp, -38
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -66
# br label %label8
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -34
	ld.w $a0, $fp, -66
	st.w $a0, $fp, -38
	b .main_label8
.main_label26:
# %op27 = phi i32 [ %op36, %label42 ], [ %op18, %label75 ]
# %op28 = phi i32 [ %op43, %label42 ], [ 0, %label75 ]
# %op29 = icmp slt i32 %op28, 2
	ld.w $t0, $fp, -74
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -75
# %op30 = zext i1 %op29 to i32
	ld.b $t0, $fp, -75
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -79
# %op31 = icmp ne i32 %op30, 0
	ld.w $t0, $fp, -79
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -80
# br i1 %op31, label %label32, label %label33
	ld.b $t0, $fp, -80
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label32
	b .main_label33
.main_label32:
# br label %label74
	b .main_label74
.main_label33:
# %op34 = add i32 %op19, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -84
# br label %label17
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -52
	ld.w $a0, $fp, -84
	st.w $a0, $fp, -56
	b .main_label17
.main_label35:
# %op36 = phi i32 [ %op45, %label71 ], [ %op27, %label74 ]
# %op37 = phi i32 [ %op72, %label71 ], [ 0, %label74 ]
# %op38 = icmp slt i32 %op37, 2
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -93
# %op39 = zext i1 %op38 to i32
	ld.b $t0, $fp, -93
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -97
# %op40 = icmp ne i32 %op39, 0
	ld.w $t0, $fp, -97
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -98
# br i1 %op40, label %label41, label %label42
	ld.b $t0, $fp, -98
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label41
	b .main_label42
.main_label41:
# br label %label73
	b .main_label73
.main_label42:
# %op43 = add i32 %op28, 1
	ld.w $t0, $fp, -74
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -102
# br label %label26
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -70
	ld.w $a0, $fp, -102
	st.w $a0, $fp, -74
	b .main_label26
.main_label44:
# %op45 = phi i32 [ %op69, %label50 ], [ %op36, %label73 ]
# %op46 = phi i32 [ %op70, %label50 ], [ 0, %label73 ]
# %op47 = icmp slt i32 %op46, 2
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 2
	slt $t2, $t0, $t1
	st.b $t2, $fp, -111
# %op48 = zext i1 %op47 to i32
	ld.b $t0, $fp, -111
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -115
# %op49 = icmp ne i32 %op48, 0
	ld.w $t0, $fp, -115
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -116
# br i1 %op49, label %label50, label %label71
	ld.b $t0, $fp, -116
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label50
	b .main_label71
.main_label50:
# %op70 = add i32 %op46, 1
	ld.w $t0, $fp, -110
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -120
# br label %label44
	ld.w $a0, $fp, -200
	st.w $a0, $fp, -106
	ld.w $a0, $fp, -120
	st.w $a0, $fp, -110
	b .main_label44
.main_label71:
# %op72 = add i32 %op37, 1
	ld.w $t0, $fp, -92
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -124
# br label %label35
	ld.w $a0, $fp, -106
	st.w $a0, $fp, -88
	ld.w $a0, $fp, -124
	st.w $a0, $fp, -92
	b .main_label35
.main_label73:
# br label %label44
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -106
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	ld.w $a0, $fp, -88
	st.w $a0, $fp, -106
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -110
	b .main_label44
.main_label74:
# br label %label35
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -88
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -92
	ld.w $a0, $fp, -70
	st.w $a0, $fp, -88
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -92
	b .main_label35
.main_label75:
# br label %label26
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -70
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -74
	ld.w $a0, $fp, -52
	st.w $a0, $fp, -70
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -74
	b .main_label26
.main_label76:
# br label %label17
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -52
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -56
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -52
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -56
	b .main_label17
.main_label77:
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
.main_label78:
# %op51 = mul i32 2, 2
	addi.w $t0, $zero, 2
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -128
# %op52 = mul i32 %op51, 2
	ld.w $t0, $fp, -128
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -132
# %op53 = mul i32 %op52, 2
	ld.w $t0, $fp, -132
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -136
# %op54 = mul i32 %op53, 2
	ld.w $t0, $fp, -136
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -140
# %op55 = mul i32 %op54, 2
	ld.w $t0, $fp, -140
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -144
# %op56 = mul i32 %op55, 2
	ld.w $t0, $fp, -144
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -148
# %op57 = mul i32 %op56, 2
	ld.w $t0, $fp, -148
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -152
# %op58 = mul i32 %op57, 2
	ld.w $t0, $fp, -152
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -156
# %op59 = mul i32 %op58, 2
	ld.w $t0, $fp, -156
	addi.w $t1, $zero, 2
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -160
# %op60 = sdiv i32 %op59, 2
	ld.w $t0, $fp, -160
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -164
# %op61 = sdiv i32 %op60, 2
	ld.w $t0, $fp, -164
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -168
# %op62 = sdiv i32 %op61, 2
	ld.w $t0, $fp, -168
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -172
# %op63 = sdiv i32 %op62, 2
	ld.w $t0, $fp, -172
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -176
# %op64 = sdiv i32 %op63, 2
	ld.w $t0, $fp, -176
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -180
# %op65 = sdiv i32 %op64, 2
	ld.w $t0, $fp, -180
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -184
# %op66 = sdiv i32 %op65, 2
	ld.w $t0, $fp, -184
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -188
# %op67 = sdiv i32 %op66, 2
	ld.w $t0, $fp, -188
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -192
# %op68 = sdiv i32 %op67, 2
	ld.w $t0, $fp, -192
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -196
# %op69 = sdiv i32 %op68, 2
	ld.w $t0, $fp, -196
	addi.w $t1, $zero, 2
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -200
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	b .main_label0
main_exit:
	addi.d $sp, $sp, 208
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
