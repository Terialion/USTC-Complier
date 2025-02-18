# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl seed
	.type seed, @object
	.size seed, 4
seed:
	.space 4
	.text
	.globl randomLCG
	.type randomLCG, @function
randomLCG:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randomLCG_label_entry:
# %op0 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -20
# %op1 = mul i32 %op0, 1103515245
	ld.w $t0, $fp, -20
	lu12i.w $t1, 269412
	ori $t1, $t1, 3693
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -24
# %op2 = add i32 %op1, 12345
	ld.w $t0, $fp, -24
	lu12i.w $t1, 3
	ori $t1, $t1, 57
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -28
# store i32 %op2, i32* @seed
	la.local $t0, seed
	ld.w $t1, $fp, -28
	st.w $t1, $t0, 0
# %op3 = load i32, i32* @seed
	la.local $t0, seed
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# ret i32 %op3
	ld.w $a0, $fp, -32
	b randomLCG_exit
randomLCG_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl randBin
	.type randBin, @function
randBin:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -32
.randBin_label_entry:
# %op0 = call i32 @randomLCG()
	bl randomLCG
	st.w $a0, $fp, -20
# %op1 = icmp sgt i32 %op0, 0
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 0
	slt $t2, $t1, $t0
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
	bne $t0, $zero, .randBin_label4
	b .randBin_label5
.randBin_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b randBin_exit
.randBin_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
randBin_exit:
	addi.d $sp, $sp, 32
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl returnToZeroSteps
	.type returnToZeroSteps, @function
returnToZeroSteps:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.returnToZeroSteps_label_entry:
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label0
.returnToZeroSteps_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op14, %label21 ]
# %op2 = phi i32 [ 0, %label_entry ], [ %op13, %label21 ]
# %op3 = icmp slt i32 %op1, 20
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 20
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
# br i1 %op5, label %label6, label %label9
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .returnToZeroSteps_label6
	b .returnToZeroSteps_label9
.returnToZeroSteps_label6:
# %op7 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -34
# %op8 = icmp ne i32 %op7, 0
	ld.w $t0, $fp, -34
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -35
# br i1 %op8, label %label10, label %label18
	ld.b $t0, $fp, -35
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .returnToZeroSteps_label10
	b .returnToZeroSteps_label18
.returnToZeroSteps_label9:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label10:
# %op11 = add i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -39
# br label %label12
	ld.w $a0, $fp, -39
	st.w $a0, $fp, -43
	b .returnToZeroSteps_label12
.returnToZeroSteps_label12:
# %op13 = phi i32 [ %op11, %label10 ], [ %op19, %label18 ]
# %op14 = add i32 %op1, 1
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -47
# %op15 = icmp eq i32 %op13, 0
	ld.w $t0, $fp, -43
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -48
# %op16 = zext i1 %op15 to i32
	ld.b $t0, $fp, -48
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -52
# %op17 = icmp ne i32 %op16, 0
	ld.w $t0, $fp, -52
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -53
# br i1 %op17, label %label20, label %label21
	ld.b $t0, $fp, -53
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .returnToZeroSteps_label20
	b .returnToZeroSteps_label21
.returnToZeroSteps_label18:
# %op19 = sub i32 %op2, 1
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -57
# br label %label12
	ld.w $a0, $fp, -57
	st.w $a0, $fp, -43
	b .returnToZeroSteps_label12
.returnToZeroSteps_label20:
# ret i32 %op14
	ld.w $a0, $fp, -47
	b returnToZeroSteps_exit
.returnToZeroSteps_label21:
# br label %label0
	ld.w $a0, $fp, -47
	st.w $a0, $fp, -20
	ld.w $a0, $fp, -43
	st.w $a0, $fp, -24
	b .returnToZeroSteps_label0
returnToZeroSteps_exit:
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
# store i32 3407, i32* @seed
	la.local $t0, seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	st.w $t1, $t0, 0
# br label %label0
	addi.w $a0, $zero, 0
	st.w $a0, $fp, -20
	b .main_label0
.main_label0:
# %op1 = phi i32 [ 0, %label_entry ], [ %op7, %label5 ]
# %op2 = icmp slt i32 %op1, 20
	ld.w $t0, $fp, -20
	addi.w $t1, $zero, 20
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
# %op6 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
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
