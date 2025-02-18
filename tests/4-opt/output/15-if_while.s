	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 10
	st.w $a0, $fp, -24
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -28
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op15, %label14 ]
# %op2 = phi i32 [ 10, %label_entry ], [ %op6, %label14 ]
# %op3 = phi i32 [ 0, %label_entry ], [ %op16, %label14 ]
# %op4 = icmp ne i32 %op2, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -29
# br i1 %op4, label %label5, label %label10
	ld.b $t0, $fp, -29
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label5
	b .main_label10
.main_label5:
# %op6 = sub i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -33
# %op7 = icmp slt i32 %op6, 5
	ld.w $t0, $fp, -33
	addi.w $t1, $zero, 5
	slt $t2, $t0, $t1
	st.b $t2, $fp, -34
# %op8 = zext i1 %op7 to i32
	ld.b $t0, $fp, -34
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -38
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -38
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -39
# br i1 %op9, label %label12, label %label17
	ld.b $t0, $fp, -39
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label12
	b .main_label17
.main_label10:
# %op11 = add i32 %op1, %op3
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -28
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -43
# ret i32 %op11
	ld.w $a0, $fp, -43
	b main_exit
.main_label12:
# %op13 = add i32 %op1, %op6
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -33
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# br label %label14
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -51
	ld.w $a0, $fp, -28
	st.w $a0, $fp, -55
	b .main_label14
.main_label14:
# %op15 = phi i32 [ %op13, %label12 ], [ %op1, %label17 ]
# %op16 = phi i32 [ %op3, %label12 ], [ %op18, %label17 ]
# br label %label0
	ld.w $a0, $fp, -51
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -33
	st.w $a0, $fp, -24
	ld.w $a0, $fp, -55
	st.w $a0, $fp, -28
	b .main_label0
.main_label17:
# %op18 = add i32 %op3, %op6
	ld.w $t0, $fp, -28
	ld.w $t1, $fp, -33
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -59
# br label %label14
	ld.w $a0, $fp, -20
	st.w $a0, $fp, -51
	ld.w $a0, $fp, -59
	st.w $a0, $fp, -55
	b .main_label14
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
