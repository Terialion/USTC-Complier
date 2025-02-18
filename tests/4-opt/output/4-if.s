	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = icmp sgt i32 11, 22
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 22
	slt $t2, $t1, $t0
	st.b $t2, $fp, -17
# %op1 = zext i1 %op0 to i32
	ld.b $t0, $fp, -17
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -21
# %op2 = icmp ne i32 %op1, 0
	ld.w $t0, $fp, -21
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -22
# br i1 %op2, label %label3, label %label8
	ld.b $t0, $fp, -22
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label3
	b .main_label8
.main_label3:
# %op4 = icmp sgt i32 11, 33
	addi.w $t0, $zero, 11
	addi.w $t1, $zero, 33
	slt $t2, $t1, $t0
	st.b $t2, $fp, -23
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -23
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -27
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -27
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -28
# br i1 %op6, label %label12, label %label14
	ld.b $t0, $fp, -28
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label12
	b .main_label14
.main_label7:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label8:
# %op9 = icmp slt i32 33, 22
	addi.w $t0, $zero, 33
	addi.w $t1, $zero, 22
	slt $t2, $t0, $t1
	st.b $t2, $fp, -29
# %op10 = zext i1 %op9 to i32
	ld.b $t0, $fp, -29
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -33
# %op11 = icmp ne i32 %op10, 0
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -34
# br i1 %op11, label %label15, label %label17
	ld.b $t0, $fp, -34
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label15
	b .main_label17
.main_label12:
# call void @output(i32 11)
	addi.w $a0, $zero, 11
	bl output
# br label %label13
	b .main_label13
.main_label13:
# br label %label7
	b .main_label7
.main_label14:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label13
	b .main_label13
.main_label15:
# call void @output(i32 22)
	addi.w $a0, $zero, 22
	bl output
# br label %label16
	b .main_label16
.main_label16:
# br label %label7
	b .main_label7
.main_label17:
# call void @output(i32 33)
	addi.w $a0, $zero, 33
	bl output
# br label %label16
	b .main_label16
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
