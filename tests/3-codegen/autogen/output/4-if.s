	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -112
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
# store i32 11, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 11
	st.w $t1, $t0, 0
# store i32 22, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 22
	st.w $t1, $t0, 0
# store i32 33, i32* %op2
	ld.d $t0, $fp, -48
	addi.w $t1, $zero, 33
	st.w $t1, $t0, 0
# %op3 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op4 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -60
# %op5 = icmp sgt i32 %op3, %op4
	ld.w $t0, $fp, -56
	ld.w $t1, $fp, -60
	slt $t2, $t1, $t0
	st.b $t2, $fp, -61
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -61
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -65
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -65
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -66
# br i1 %op7, label %label8, label %label15
	ld.b $t0, $fp, -66
	bnez $t0, .main_label8
	b .main_label15
.main_label8:
# %op9 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -70
# %op10 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -74
# %op11 = icmp sgt i32 %op9, %op10
	ld.w $t0, $fp, -70
	ld.w $t1, $fp, -74
	slt $t2, $t1, $t0
	st.b $t2, $fp, -75
# %op12 = zext i1 %op11 to i32
	ld.b $t0, $fp, -75
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -79
# %op13 = icmp ne i32 %op12, 0
	ld.w $t0, $fp, -79
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -80
# br i1 %op13, label %label21, label %label24
	ld.b $t0, $fp, -80
	bnez $t0, .main_label21
	b .main_label24
.main_label14:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label15:
# %op16 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -84
# %op17 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -88
# %op18 = icmp slt i32 %op16, %op17
	ld.w $t0, $fp, -84
	ld.w $t1, $fp, -88
	slt $t2, $t0, $t1
	st.b $t2, $fp, -89
# %op19 = zext i1 %op18 to i32
	ld.b $t0, $fp, -89
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -93
# %op20 = icmp ne i32 %op19, 0
	ld.w $t0, $fp, -93
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -94
# br i1 %op20, label %label26, label %label29
	ld.b $t0, $fp, -94
	bnez $t0, .main_label26
	b .main_label29
.main_label21:
# %op22 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -98
# call void @output(i32 %op22)
	ld.w $a0, $fp, -98
	bl output
# br label %label23
	b .main_label23
.main_label23:
# br label %label14
	b .main_label14
.main_label24:
# %op25 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -102
# call void @output(i32 %op25)
	ld.w $a0, $fp, -102
	bl output
# br label %label23
	b .main_label23
.main_label26:
# %op27 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -106
# call void @output(i32 %op27)
	ld.w $a0, $fp, -106
	bl output
# br label %label28
	b .main_label28
.main_label28:
# br label %label14
	b .main_label14
.main_label29:
# %op30 = load i32, i32* %op2
	ld.d $t0, $fp, -48
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -110
# call void @output(i32 %op30)
	ld.w $a0, $fp, -110
	bl output
# br label %label28
	b .main_label28
main_exit:
	addi.d $sp, $sp, 112
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
