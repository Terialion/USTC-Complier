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
# br i1 %op3, label %label4, label %label6
	ld.b $t0, $fp, -26
	bnez $t0, .randBin_label4
	b .randBin_label6
.randBin_label4:
# ret i32 1
	addi.w $a0, $zero, 1
	b randBin_exit
.randBin_label5:
# ret i32 0
	addi.w $a0, $zero, 0
	b randBin_exit
.randBin_label6:
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
	addi.d $sp, $sp, -96
.returnToZeroSteps_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# %op1 = alloca i32
	addi.d $t0, $fp, -40
	st.d $t0, $fp, -36
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 0, i32* %op1
	ld.d $t0, $fp, -36
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# br label %label2
	b .returnToZeroSteps_label2
.returnToZeroSteps_label2:
# %op3 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -44
# %op4 = icmp slt i32 %op3, 20
	ld.w $t0, $fp, -44
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -45
# %op5 = zext i1 %op4 to i32
	ld.b $t0, $fp, -45
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -49
# %op6 = icmp ne i32 %op5, 0
	ld.w $t0, $fp, -49
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -50
# br i1 %op6, label %label7, label %label10
	ld.b $t0, $fp, -50
	bnez $t0, .returnToZeroSteps_label7
	b .returnToZeroSteps_label10
.returnToZeroSteps_label7:
# %op8 = call i32 @randBin()
	bl randBin
	st.w $a0, $fp, -54
# %op9 = icmp ne i32 %op8, 0
	ld.w $t0, $fp, -54
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -55
# br i1 %op9, label %label11, label %label21
	ld.b $t0, $fp, -55
	bnez $t0, .returnToZeroSteps_label11
	b .returnToZeroSteps_label21
.returnToZeroSteps_label10:
# ret i32 20
	addi.w $a0, $zero, 20
	b returnToZeroSteps_exit
.returnToZeroSteps_label11:
# %op12 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -59
# %op13 = add i32 %op12, 1
	ld.w $t0, $fp, -59
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -63
# store i32 %op13, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -63
	st.w $t1, $t0, 0
# br label %label14
	b .returnToZeroSteps_label14
.returnToZeroSteps_label14:
# %op15 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -67
# %op16 = add i32 %op15, 1
	ld.w $t0, $fp, -67
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -71
# store i32 %op16, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t1, $fp, -71
	st.w $t1, $t0, 0
# %op17 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -75
# %op18 = icmp eq i32 %op17, 0
	ld.w $t0, $fp, -75
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -76
# %op19 = zext i1 %op18 to i32
	ld.b $t0, $fp, -76
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -80
# %op20 = icmp ne i32 %op19, 0
	ld.w $t0, $fp, -80
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -81
# br i1 %op20, label %label24, label %label26
	ld.b $t0, $fp, -81
	bnez $t0, .returnToZeroSteps_label24
	b .returnToZeroSteps_label26
.returnToZeroSteps_label21:
# %op22 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -85
# %op23 = sub i32 %op22, 1
	ld.w $t0, $fp, -85
	addi.w $t1, $zero, 1
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -89
# store i32 %op23, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -89
	st.w $t1, $t0, 0
# br label %label14
	b .returnToZeroSteps_label14
.returnToZeroSteps_label24:
# %op25 = load i32, i32* %op1
	ld.d $t0, $fp, -36
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -93
# ret i32 %op25
	ld.w $a0, $fp, -93
	b returnToZeroSteps_exit
.returnToZeroSteps_label26:
# br label %label2
	b .returnToZeroSteps_label2
returnToZeroSteps_exit:
	addi.d $sp, $sp, 96
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl main
	.type main, @function
main:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = alloca i32
	addi.d $t0, $fp, -28
	st.d $t0, $fp, -24
# store i32 0, i32* %op0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	st.w $t1, $t0, 0
# store i32 3407, i32* @seed
	la.local $t0, seed
	lu12i.w $t1, 0
	ori $t1, $t1, 3407
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label1:
# %op2 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -32
# %op3 = icmp slt i32 %op2, 20
	ld.w $t0, $fp, -32
	addi.w $t1, $zero, 20
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# %op4 = zext i1 %op3 to i32
	ld.b $t0, $fp, -33
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -37
# %op5 = icmp ne i32 %op4, 0
	ld.w $t0, $fp, -37
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -38
# br i1 %op5, label %label6, label %label10
	ld.b $t0, $fp, -38
	bnez $t0, .main_label6
	b .main_label10
.main_label6:
# %op7 = call i32 @returnToZeroSteps()
	bl returnToZeroSteps
	st.w $a0, $fp, -42
# call void @output(i32 %op7)
	ld.w $a0, $fp, -42
	bl output
# %op8 = load i32, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -46
# %op9 = add i32 %op8, 1
	ld.w $t0, $fp, -46
	addi.w $t1, $zero, 1
	add.w $t2, $t0, $t1
	st.w $t2, $fp, -50
# store i32 %op9, i32* %op0
	ld.d $t0, $fp, -24
	ld.w $t1, $fp, -50
	st.w $t1, $t0, 0
# br label %label1
	b .main_label1
.main_label10:
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
