# Global variables
	.text
	.section .bss, "aw", @nobits
	.globl x
	.type x, @object
	.size x, 4
x:
	.space 4
	.globl y
	.type y, @object
	.size y, 4
y:
	.space 4
	.text
	.globl gcd
	.type gcd, @function
gcd:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -48
	st.w $a0, $fp, -20
	st.w $a1, $fp, -24
.gcd_label_entry:
# %op2 = icmp eq i32 %arg1, 0
	ld.w $t0, $fp, -24
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltui $t2, $t2, 1
	st.b $t2, $fp, -25
# %op3 = zext i1 %op2 to i32
	ld.b $t0, $fp, -25
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -29
# %op4 = icmp ne i32 %op3, 0
	ld.w $t0, $fp, -29
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -30
# br i1 %op4, label %label5, label %label6
	ld.b $t0, $fp, -30
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .gcd_label5
	b .gcd_label6
.gcd_label5:
# ret i32 %arg0
	ld.w $a0, $fp, -20
	b gcd_exit
.gcd_label6:
# %op7 = sdiv i32 %arg0, %arg1
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -24
	div.w $t2, $t0, $t1
	st.w $t2, $fp, -34
# %op8 = mul i32 %op7, %arg1
	ld.w $t0, $fp, -34
	ld.w $t1, $fp, -24
	mul.w $t2, $t0, $t1
	st.w $t2, $fp, -38
# %op9 = sub i32 %arg0, %op8
	ld.w $t0, $fp, -20
	ld.w $t1, $fp, -38
	sub.w $t2, $t0, $t1
	st.w $t2, $fp, -42
# %op10 = call i32 @gcd(i32 %arg1, i32 %op9)
	ld.w $a0, $fp, -24
	ld.w $a1, $fp, -42
	bl gcd
	st.w $a0, $fp, -46
# ret i32 %op10
	ld.w $a0, $fp, -46
	b gcd_exit
gcd_exit:
	addi.d $sp, $sp, 48
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
	.globl funArray
	.type funArray, @function
funArray:
	st.d $ra, $sp, -8
	st.d $fp, $sp, -16
	addi.d $fp, $sp, 0
	addi.d $sp, $sp, -80
	st.d $a0, $fp, -24
	st.d $a1, $fp, -32
.funArray_label_entry:
# %op2 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -33
# br i1 %op2, label %label3, label %label4
	ld.b $t0, $fp, -33
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .funArray_label3
	b .funArray_label4
.funArray_label3:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b funArray_exit
.funArray_label4:
# %op5 = getelementptr i32, i32* %arg0, i32 0
	ld.d $t0, $fp, -24
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -41
# %op6 = load i32, i32* %op5
	ld.d $t0, $fp, -41
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -45
# %op7 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -46
# br i1 %op7, label %label8, label %label9
	ld.b $t0, $fp, -46
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .funArray_label8
	b .funArray_label9
.funArray_label8:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b funArray_exit
.funArray_label9:
# %op10 = getelementptr i32, i32* %arg1, i32 0
	ld.d $t0, $fp, -32
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -54
# %op11 = load i32, i32* %op10
	ld.d $t0, $fp, -54
	ld.w $t0, $t0, 0
	st.w $t0, $fp, -58
# %op12 = icmp slt i32 %op6, %op11
	ld.w $t0, $fp, -45
	ld.w $t1, $fp, -58
	slt $t2, $t0, $t1
	st.b $t2, $fp, -59
# %op13 = zext i1 %op12 to i32
	ld.b $t0, $fp, -59
	bstrpick.w $t0, $t0, 0, 0
	st.w $t0, $fp, -63
# %op14 = icmp ne i32 %op13, 0
	ld.w $t0, $fp, -63
	addi.w $t1, $zero, 0
	xor $t2, $t0, $t1
	sltu $t2, $zero, $t2
	st.b $t2, $fp, -64
# br i1 %op14, label %label15, label %label16
	ld.w $a0, $fp, -58
	st.w $a0, $fp, -68
	ld.w $a0, $fp, -45
	st.w $a0, $fp, -72
	ld.b $t0, $fp, -64
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .funArray_label15
	b .funArray_label16
.funArray_label15:
# br label %label16
	ld.w $a0, $fp, -45
	st.w $a0, $fp, -68
	ld.w $a0, $fp, -58
	st.w $a0, $fp, -72
	b .funArray_label16
.funArray_label16:
# %op17 = phi i32 [ %op11, %label9 ], [ %op6, %label15 ]
# %op18 = phi i32 [ %op6, %label9 ], [ %op11, %label15 ]
# %op19 = call i32 @gcd(i32 %op18, i32 %op17)
	ld.w $a0, $fp, -72
	ld.w $a1, $fp, -68
	bl gcd
	st.w $a0, $fp, -76
# ret i32 %op19
	ld.w $a0, $fp, -76
	b funArray_exit
funArray_exit:
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
	addi.d $sp, $sp, -64
.main_label_entry:
# %op0 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -17
# br i1 %op0, label %label1, label %label2
	ld.b $t0, $fp, -17
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label1
	b .main_label2
.main_label1:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label2:
# %op3 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t0, x
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -25
# store i32 90, i32* %op3
	ld.d $t0, $fp, -25
	addi.w $t1, $zero, 90
	st.w $t1, $t0, 0
# %op4 = icmp slt i32 0, 0
	addi.w $t0, $zero, 0
	addi.w $t1, $zero, 0
	slt $t2, $t0, $t1
	st.b $t2, $fp, -26
# br i1 %op4, label %label5, label %label6
	ld.b $t0, $fp, -26
	bstrpick.d $t0, $t0, 0, 0
	bne $t0, $zero, .main_label5
	b .main_label6
.main_label5:
# call void @neg_idx_except()
	bl neg_idx_except
# ret i32 0
	addi.w $a0, $zero, 0
	b main_exit
.main_label6:
# %op7 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t0, y
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -34
# store i32 18, i32* %op7
	ld.d $t0, $fp, -34
	addi.w $t1, $zero, 18
	st.w $t1, $t0, 0
# %op8 = getelementptr [1 x i32], [1 x i32]* @x, i32 0, i32 0
	la.local $t0, x
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -42
# %op9 = getelementptr [1 x i32], [1 x i32]* @y, i32 0, i32 0
	la.local $t0, y
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	addi.w $t1, $zero, 0
	addi.d $t2, $zero, 4
	mul.d $t1, $t1, $t2
	add.d $t0, $t0, $t1
	st.d $t0, $fp, -50
# %op10 = call i32 @funArray(i32* %op8, i32* %op9)
	ld.d $a0, $fp, -42
	ld.d $a1, $fp, -50
	bl funArray
	st.w $a0, $fp, -54
# ret i32 %op10
	ld.w $a0, $fp, -54
	b main_exit
main_exit:
	addi.d $sp, $sp, 64
	ld.d $ra, $sp, -8
	ld.d $fp, $sp, -16
	jr $ra
