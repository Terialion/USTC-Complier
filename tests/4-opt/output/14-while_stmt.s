	.text
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# br label %label0
	addi.w $a0, $zero, 10
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 10, %label_entry ], [ %op4, %label3 ]
# %op2 = icmp ne i32 %op1, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -21
# br i1 %op2, label %label3, label %label5
	ld.b $t0, $fp, -21
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label3
	b .main_label5
.main_label3:
# %op4 = sub i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -25
# br label %label0
	ld.w $a0, $fp, -25
	st.w $a0, $fp, -20
	b .main_label0
.main_label5:
# ret void
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
