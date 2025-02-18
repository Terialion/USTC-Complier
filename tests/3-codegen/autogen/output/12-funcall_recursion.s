	.text
	.globl factorial
	.type factorial, @function
factorial:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
.factorial_label_entry:
# %op1 = alloca i32
	addi.d $t0, $fp, -32
	st.d $t0, $fp, -28
# store i32 %arg0, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t1, $fp, -20
	st.w $t1, $t0, 0
# %op2 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# %op3 = icmp eq i32 %op2, 0
	ld.w $t0, $fp, -36
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -37
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -37
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -41
# %op5 = icmp ne i32 %op4, 0
	ld.w $t0, $fp, -41
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -42
# br i1 %op5, label %label6, label %label8
	ld.b $t0, $fp, -42
	bnez $t0, .factorial_label6
	b .factorial_label8
.factorial_label6:
# ret i32 1
	addi.w $a0, $zero, 1
	b factorial_exit
.factorial_label7:
# ret i32 0
	addi.w $a0, $zero, 0
	b factorial_exit
.factorial_label8:
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -46
# %op10 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -50
# %op11 = sub i32 %op10, 1
	ld.w $t0, $fp, -50
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -54
# %op12 = call i32 @factorial(i32 %op11)
	ld.w $a0, $fp, -54
	bl factorial
	st.w $a0, $fp, -58
# %op13 = mul i32 %op9, %op12
	ld.w $t0, $fp, -46
	ld.w $t1, $fp, -58
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -62
# ret i32 %op13
	ld.w $a0, $fp, -62
	b factorial_exit
factorial_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = call i32 @factorial(i32 10)
	addi.w $a0, $zero, 10
	bl factorial
	st.w $a0, $fp, -32
# store i32 %op1, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -32
	st.w $t1, $t0, 0
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -36
# ret i32 %op2
	ld.w $a0, $fp, -36
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
