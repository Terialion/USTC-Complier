	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.w $a0, $fp, -20
.fibonacci_label_entry:
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
	bnez $t0, .fibonacci_label6
	b .fibonacci_label8
.fibonacci_label6:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label7:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label8:
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -46
# %op10 = icmp eq i32 %op9, 1
	ld.w $t0, $fp, -46
	addi.w $t1, $zero, 1
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -47
# %op11 = zext i1 %op10 to i32
	ld.b $t0, $fp, -47
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -51
# %op12 = icmp ne i32 %op11, 0
	ld.w $t0, $fp, -51
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -52
# br i1 %op12, label %label13, label %label15
	ld.b $t0, $fp, -52
	bnez $t0, .fibonacci_label13
	b .fibonacci_label15
.fibonacci_label13:
# ret i32 1
	addi.w $a0, $zero, 1
	b fibonacci_exit
.fibonacci_label14:
# br label %label7
	b .fibonacci_label7
.fibonacci_label15:
# %op16 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -56
# %op17 = sub i32 %op16, 1
	ld.w $t0, $fp, -56
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -60
# %op18 = call i32 @fibonacci(i32 %op17)
	ld.w $a0, $fp, -60
	bl fibonacci
	st.w $a0, $fp, -64
# %op19 = load i32, i32* %op1
	ld.d $t0, $fp, -28
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -68
# %op20 = sub i32 %op19, 2
	ld.w $t0, $fp, -68
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -72
# %op21 = call i32 @fibonacci(i32 %op20)
	ld.w $a0, $fp, -72
	bl fibonacci
	st.w $a0, $fp, -76
# %op22 = add i32 %op18, %op21
	ld.w $t0, $fp, -64
	ld.w $t1, $fp, -76
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -80
# ret i32 %op22
	ld.w $a0, $fp, -80
	b fibonacci_exit
fibonacci_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# store i32 10, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 10
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label2:
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -44
# %op4 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -48
# %op5 = icmp slt i32 %op3, %op4
	ld.w $t0, $fp, -44
	ld.w $t1, $fp, -48
	slt $t2, $t0, $t1
	st.b $t2, $fp, -49
# %op6 = zext i1 %op5 to i32
	ld.b $t0, $fp, -49
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -53
# %op7 = icmp ne i32 %op6, 0
	ld.w $t0, $fp, -53
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -54
# br i1 %op7, label %label8, label %label13
	ld.b $t0, $fp, -54
	bnez $t0, .main_label8
	b .main_label13
.main_label8:
# %op9 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -58
# %op10 = call i32 @fibonacci(i32 %op9)
	ld.w $a0, $fp, -58
	bl fibonacci
	st.w $a0, $fp, -62
# call void @output(i32 %op10)
	ld.w $a0, $fp, -62
	bl output
# %op11 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -66
# %op12 = add i32 %op11, 1
	ld.w $t0, $fp, -66
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -70
# store i32 %op12, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -70
	st.w $t1, $t0, 0
# br label %label2
	b .main_label2
.main_label13:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 80
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
