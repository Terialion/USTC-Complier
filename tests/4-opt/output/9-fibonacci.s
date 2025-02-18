	.text
	.globl fibonacci
	.type fibonacci, @function
fibonacci:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
	st.w $a0, $fp, -20
.fibonacci_label_entry:
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
	bne $t0, $zero, .fibonacci_label4
	b .fibonacci_label5
.fibonacci_label4:
# ret i32 0
	addi.w $a0, $zero, 0
	b fibonacci_exit
.fibonacci_label5:
# %op6 = icmp eq i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -27
# %op7 = zext i1 %op6 to i32
	ld.b $t0, $fp, -27
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -31
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -31
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -32
# br i1 %op8, label %label9, label %label10
	ld.b $t0, $fp, -32
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .fibonacci_label9
	b .fibonacci_label10
.fibonacci_label9:
# ret i32 1
	addi.w $a0, $zero, 1
	b fibonacci_exit
.fibonacci_label10:
# %op11 = sub i32 %arg0, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -36
# %op12 = call i32 @fibonacci(i32 %op11)
	ld.w $a0, $fp, -36
	bl fibonacci
	st.w $a0, $fp, -40
# %op13 = sub i32 %arg0, 2
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 2
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -44
# %op14 = call i32 @fibonacci(i32 %op13)
	ld.w $a0, $fp, -44
	bl fibonacci
	st.w $a0, $fp, -48
# %op15 = add i32 %op12, %op14
	ld.w $t0, $fp, -40
	ld.w $t1, $fp, -48
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -52
# ret i32 %op15
	ld.w $a0, $fp, -52
	b fibonacci_exit
fibonacci_exit:
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
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op7, %label5 ]
# %op2 = icmp slt i32 %op1, 10
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 10
	slt $t2, $t0, $t1
	st.b $t2, $fp, -21
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -21
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -25
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -25
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -26
# br i1 %op4, label %label5, label %label8
	ld.b $t0, $fp, -26
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label5
	b .main_label8
.main_label5:
# %op6 = call i32 @fibonacci(i32 %op1)
	ld.w $a0, $fp, -20
	bl fibonacci
	st.w $a0, $fp, -30
# call void @output(i32 %op6)
	ld.w $a0, $fp, -30
	bl output
# %op7 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# br label %label0
	ld.w $a0, $fp, -34
	st.w $a0, $fp, -20
	b .main_label0
.main_label8:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
