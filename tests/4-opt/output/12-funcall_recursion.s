	.text
	.globl factorial
	.type factorial, @function
factorial:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
.factorial_label_entry:
# %op1 = icmp eq i32 %arg0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -21
# %op2 = zext i1 %op1 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -25
# %op3 = icmp ne i32 %op2, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -26
# br i1 %op3, label %label4, label %label5
	ld.b $t0, $fp, -26
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .factorial_label4
	b .factorial_label5
.factorial_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b factorial_exit
.factorial_label5:
# %op6 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -30
# %op7 = call i32 @factorial(i32 %op6)
	ld.w $a0, $fp, -30
	bl factorial
	st.w $a0, $fp, -34
# %op8 = mul i32 %arg0, %op7
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -34
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -38
# ret i32 %op8
	ld.w $a0, $fp, -38
	b factorial_exit
factorial_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.main_label_entry:
# %op0 = call i32 @factorial(i32 10)
	addi.w $a0, $zero, 10
	bl factorial
	st.w $a0, $fp, -20
# ret i32 %op0
	ld.w $a0, $fp, -20
	b main_exit
main_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
